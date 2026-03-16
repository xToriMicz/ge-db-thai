#!/usr/bin/env node
// Automated 1:1 character verification
// Compares our scraped data (data/full/) against live source (ge-db.site)
// Reports mismatches in stance count, skill count, lv25 bonus completeness

import { readFileSync, readdirSync, writeFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const FULL_DIR = resolve(__dirname, "../data/full");
const BASE = "https://ge-db.site/andromida";

// ── HTML Parsing (same as scraper) ──

function extractTextLines(html) {
  return html.split(/<[^>]*>/)
    .map(s => s.replace(/&nbsp;/g, " ").trim())
    .filter(t => t.length > 0);
}

function stripTags(html) {
  return html.replace(/<[^>]+>/g, " ").replace(/&nbsp;/g, " ").replace(/\s+/g, " ").trim();
}

// Count stances from overview table
function countSourceStances(html) {
  const tableStart = html.indexOf('class="stances full');
  if (tableStart === -1) return { stanceNames: [], count: 0 };
  const tableEnd = html.indexOf("</table>", tableStart);
  const table = html.substring(tableStart, tableEnd + 8);

  const stanceNames = [];
  const rows = [...table.matchAll(/<tr[^>]*>(.*?)<\/tr>/gs)];
  for (const row of rows.slice(1)) {
    const cells = [...row[1].matchAll(/<td[^>]*>(.*?)<\/td>/gs)];
    if (cells.length >= 3) {
      const names = stripTags(cells[2][1]).split(",").map(s => s.trim()).filter(Boolean);
      stanceNames.push(...names);
    }
  }
  return { stanceNames, count: stanceNames.length };
}

// Count h3 stance detail sections
function countSourceStanceDetails(html) {
  const headers = [...html.matchAll(/<h3\s+id="([^"]+)">([^<]+)<\/h3>/gi)];
  return headers.map(h => h[2].trim());
}

// Count skills per stance detail
function countSourceSkills(html) {
  const skills = [...html.matchAll(/class="skills_als"[^>]*alt="([^"]+)"/g)];
  return skills.map(s => s[1].trim()).filter(n => n !== "None");
}

// Count lv25 bonus entries per stance
function getSourceLv25(html, stanceName) {
  // Find stance section
  const pattern = new RegExp(`<h3[^>]*>${stanceName.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}</h3>`, 'i');
  const match = html.match(pattern);
  if (!match) return 0;

  const startIdx = match.index;
  const nextH3 = html.indexOf('<h3', startIdx + 10);
  const section = html.substring(startIdx, nextH3 > 0 ? nextH3 : startIdx + 15000);

  // Find StanceBonus cell
  const bonusMatch = section.match(/<td[^>]*id="StanceBonus\d*"[^>]*>(.*?)<\/td>/s);
  if (!bonusMatch) {
    // Try 3rd cell of dark2 table
    const tableMatch = section.match(/<table[^>]*class="dark2"[^>]*>(.*?)<\/table>/s);
    if (!tableMatch) return 0;
    const rows = [...tableMatch[1].matchAll(/<tr[^>]*>(.*?)<\/tr>/gs)];
    if (rows.length < 2) return 0;
    const cells = [...rows[rows.length - 1][1].matchAll(/<td[^>]*>(.*?)<\/td>/gs)];
    if (!cells[2]) return 0;
    const lines = extractTextLines(cells[2][1]);
    return lines.filter(l => l.match(/^[A-Za-z\s\[\]:]+.*[:].*/)).length;
  }

  const lines = extractTextLines(bonusMatch[1]);
  return lines.filter(l => l.length > 2).length;
}

// ── Main ──

async function main() {
  const files = readdirSync(FULL_DIR).filter(f => f.endsWith(".json") && f[0] !== "_");
  console.log(`\n🔍 Verifying ${files.length} characters against source...\n`);

  const issues = [];
  let checked = 0;
  let perfect = 0;

  for (let i = 0; i < files.length; i++) {
    const slug = files[i].replace(".json", "");
    const local = JSON.parse(readFileSync(resolve(FULL_DIR, files[i]), "utf8"));

    // Fetch source
    let html;
    try {
      const res = await fetch(`${BASE}/${encodeURIComponent(slug)}.php`);
      if (!res.ok) {
        issues.push({ slug, type: "HTTP_ERROR", detail: `${res.status}` });
        continue;
      }
      html = await res.text();
    } catch (err) {
      issues.push({ slug, type: "FETCH_ERROR", detail: err.message });
      continue;
    }

    const charIssues = [];

    // 1. Compare stance count (overview)
    const source = countSourceStances(html);
    const localOverview = local.stance_overview?.length || 0;
    if (source.count !== localOverview) {
      charIssues.push(`stances: source=${source.count} local=${localOverview}`);
    }

    // 2. Compare stance detail count (h3 sections)
    const sourceDetails = countSourceStanceDetails(html);
    const localDetails = local.stances?.length || 0;
    if (sourceDetails.length !== localDetails) {
      charIssues.push(`stance_details: source=${sourceDetails.length} local=${localDetails}`);
    }

    // 3. Compare skill count
    const sourceSkills = countSourceSkills(html);
    const localSkills = local.stances?.reduce((sum, s) => sum + (s.skills?.length || 0), 0) || 0;
    if (sourceSkills.length !== localSkills) {
      charIssues.push(`skills: source=${sourceSkills.length} local=${localSkills}`);
    }

    // 4. Check lv25 bonus completeness for first 3 stances
    for (const stance of (local.stances || []).slice(0, 3)) {
      const localBonusKeys = Object.keys(stance.lv25_bonus || {}).length;
      const sourceBonusCount = getSourceLv25(html, stance.name);
      if (sourceBonusCount > 0 && localBonusKeys === 0) {
        charIssues.push(`lv25_missing: ${stance.name} source=${sourceBonusCount} local=0`);
      }
    }

    if (charIssues.length > 0) {
      issues.push({ slug, type: "MISMATCH", details: charIssues });
    } else {
      perfect++;
    }

    checked++;
    const pct = ((checked / files.length) * 100).toFixed(1);
    process.stdout.write(`\r  ${checked}/${files.length} (${pct}%) — ${perfect} perfect, ${issues.length} issues`);

    // Polite delay
    if (i < files.length - 1) await new Promise(r => setTimeout(r, 300));
  }

  console.log(`\n\n📊 Verification Results:`);
  console.log(`  Total checked: ${checked}`);
  console.log(`  Perfect match: ${perfect}`);
  console.log(`  With issues: ${issues.length}`);

  if (issues.length > 0) {
    console.log(`\n❌ Issues found:\n`);
    for (const issue of issues) {
      if (issue.type === "MISMATCH") {
        console.log(`  ${issue.slug}:`);
        issue.details.forEach(d => console.log(`    - ${d}`));
      } else {
        console.log(`  ${issue.slug}: ${issue.type} — ${issue.detail}`);
      }
    }
  }

  // Save report
  const report = {
    timestamp: new Date().toISOString(),
    total: checked,
    perfect,
    issues: issues.length,
    details: issues,
  };
  writeFileSync(resolve(FULL_DIR, "_verification.json"), JSON.stringify(report, null, 2));
  console.log(`\n✅ Report saved to data/full/_verification.json`);
}

main().catch(err => { console.error(err); process.exit(1); });
