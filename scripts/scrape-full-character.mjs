#!/usr/bin/env node
// Full character scraper — extracts ALL data from each character page
// Runs 1 character at a time for accuracy. ~5 min for 292 characters.

import { writeFileSync, readFileSync, existsSync, mkdirSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const BASE = "https://ge-db.site/andromida";
const OUT_DIR = resolve(__dirname, "../data/full");
if (!existsSync(OUT_DIR)) mkdirSync(OUT_DIR, { recursive: true });

// Load character slugs from DB export or existing data
const chars = JSON.parse(readFileSync(resolve(__dirname, "../data/characters-list.json"), "utf8"));
const slugs = chars.map(c => c.slug || c.name);

// ── HTML Parsing Helpers ──

function stripTags(html) {
  return html.replace(/<[^>]+>/g, " ").replace(/&nbsp;/g, " ").replace(/\s+/g, " ").trim();
}

function extractTextLines(html) {
  // Split on HTML tags, keep text segments between them
  const texts = html.split(/<[^>]*>/)
    .map(s => s.replace(/&nbsp;/g, " ").trim())
    .filter(t => t.length > 0);
  return texts;
}

// ── Parse Equipment Info ──

function parseEquipment(html) {
  const basicStart = html.indexOf("Basic Character Information");
  if (basicStart === -1) return {};
  const basicEnd = html.indexOf("</table>", basicStart);
  const section = html.substring(basicStart, basicEnd + 8);

  const equipment = {};
  const rows = [...section.matchAll(/<tr[^>]*>(.*?)<\/tr>/gs)];
  for (const row of rows) {
    const cells = [...row[1].matchAll(/<t[dh][^>]*>(.*?)<\/t[dh]>/gs)];
    if (cells.length >= 2) {
      const key = stripTags(cells[0][1]).toLowerCase().replace(/\s+/g, "_");
      const value = stripTags(cells[1][1]);
      if (key && value) equipment[key] = value;
    }
  }
  return equipment;
}

// ── Parse Stance Overview (weapon requirements) ──

function parseStanceOverview(html) {
  const tableStart = html.indexOf('class="stances full');
  if (tableStart === -1) return [];
  const tableEnd = html.indexOf("</table>", tableStart);
  const table = html.substring(tableStart, tableEnd + 8);

  const overview = [];
  const rows = [...table.matchAll(/<tr[^>]*>(.*?)<\/tr>/gs)];
  for (const row of rows.slice(1)) { // skip header
    const cells = [...row[1].matchAll(/<td[^>]*>(.*?)<\/td>/gs)];
    if (cells.length >= 3) {
      const equipped = stripTags(cells[0][1]);
      const stanceNames = stripTags(cells[2][1]).split(",").map(s => s.trim()).filter(Boolean);
      // Get stance icon positions from this row
      const iconPositions = [...row[1].matchAll(/background-position:\s*(-?\d+)px\s+(-?\d+)px/g)];

      for (let i = 0; i < stanceNames.length; i++) {
        const iconPos = iconPositions[i] ? { x: parseInt(iconPositions[i][1]), y: parseInt(iconPositions[i][2]) } : null;
        overview.push({
          stance_name: stanceNames[i],
          equipped_items: equipped || "None",
          icon_position: iconPos,
        });
      }
    }
  }
  return overview;
}

// ── Parse Stance Details ──

function parseStanceDetail(sectionHtml, stanceName) {
  const result = {
    name: stanceName,
    info: {},
    stats: {},
    lv25_bonus: {},
    consume: "",
    skills: [],
  };

  // Parse the stats table (first table in section)
  const tableMatch = sectionHtml.match(/<table[^>]*class="dark2"[^>]*>(.*?)<\/table>/s);
  if (tableMatch) {
    const rows = [...tableMatch[1].matchAll(/<tr[^>]*>(.*?)<\/tr>/gs)];
    if (rows.length >= 2) {
      const dataCells = [...rows[rows.length - 1][1].matchAll(/<td[^>]*>(.*?)<\/td>/gs)];

      // Cell 0: Information
      if (dataCells[0]) {
        const infoLines = extractTextLines(dataCells[0][1]);
        for (const line of infoLines) {
          // Consume items (e.g. "Consumes Metal Shell Ammo x 2")
          const consumeMatch = line.match(/^Consumes?\s+(.+)$/i);
          if (consumeMatch) {
            result.consume = consumeMatch[1].trim();
            continue;
          }
          // Handle "Targets: 1 enemy" style and "Regenerate SP: Yes"
          const match = line.match(/^([A-Z][A-Za-z\s]+?):\s*(.+)$/);
          if (match) result.info[match[1].trim()] = match[2].trim();
        }
      }

      // Cell 1: Stats
      if (dataCells[1]) {
        const statLines = extractTextLines(dataCells[1][1]);
        for (const line of statLines) {
          const match = line.match(/^([A-Z][A-Za-z\s]+?):\s*(.+)$/);
          if (match) result.stats[match[1].trim()] = match[2].trim();
        }
      }

      // Cell 2: Level 25 Bonus
      if (dataCells[2]) {
        const bonusLines = extractTextLines(dataCells[2][1]);
        const parsed = {};
        const rawLines = [];
        for (const line of bonusLines) {
          const match = line.match(/^([A-Za-z\s]+?):\s*(.+)$/);
          if (match && !line.startsWith("[")) {
            parsed[match[1].trim()] = match[2].trim();
          } else if (line.length > 3) {
            rawLines.push(line);
          }
        }
        result.lv25_bonus = parsed;
        if (rawLines.length > 0) result.lv25_bonus_extra = rawLines;
      }
    }
  }

  // Parse skills
  const skillMatches = [...sectionHtml.matchAll(/class="skills_als"[^>]*alt="([^"]+)"/g)];
  const skillImgMatches = [...sectionHtml.matchAll(/src="\.\/(images\/Skills\/[^"]+)"/g)];

  for (let i = 0; i < skillMatches.length; i++) {
    const skillName = skillMatches[i][1].trim();
    const skillImage = skillImgMatches[i] ? skillImgMatches[i][1].replace("images/Skills/", "") : null;

    // Find skill detail block: from this skill to next skill (or end)
    const startIdx = skillMatches[i].index;
    const endIdx = i + 1 < skillMatches.length ? skillMatches[i + 1].index : sectionHtml.length;
    const skillBlock = sectionHtml.substring(startIdx, endIdx);

    const texts = extractTextLines(skillBlock);
    const skill = {
      name: skillName,
      image: skillImage,
      description: "",
      target: "",
      casting_time: "",
      cooldown: "",
      duration: "",
      hits_flying: "",
      knock_down: "",
      sp_cost: "",
      aggro: "",
      skill_type: "",
      consume_item: "",
      soft_armor_atk: "",
      heavy_armor_atk: "",
      light_armor_atk: "",
      levels: [],
      special: [],
    };

    // Parse structured fields from text
    let foundName = false;
    for (const text of texts) {
      if (text === skillName && !foundName) { foundName = true; continue; }
      if (!foundName) continue;

      if (text.startsWith("Casting Time:")) skill.casting_time = text.replace("Casting Time:", "").trim();
      else if (text.startsWith("Cool down:")) skill.cooldown = text.replace("Cool down:", "").trim();
      else if (text.startsWith("Duration:")) skill.duration = text.replace("Duration:", "").trim();
      else if (text.startsWith("Hits flying:")) skill.hits_flying = text.replace("Hits flying:", "").trim();
      else if (text.startsWith("Knock down:")) skill.knock_down = text.replace("Knock down:", "").trim();
      else if (text.startsWith("SP:")) skill.sp_cost = text.replace("SP:", "").trim();
      else if (text.startsWith("Aggro:")) skill.aggro = text.replace("Aggro:", "").trim();
      else if (text.startsWith("Skill Type:")) skill.skill_type = text.replace("Skill Type:", "").trim();
      else if (text.match(/^Consumes?\s+/i)) skill.consume_item = text.replace(/^Consumes?\s+/i, "").trim();
      else if (text.startsWith("Soft Armor ATK:")) skill.soft_armor_atk = text.replace("Soft Armor ATK:", "").trim();
      else if (text.startsWith("Heavy Armor ATK:")) skill.heavy_armor_atk = text.replace("Heavy Armor ATK:", "").trim();
      else if (text.startsWith("Light Armor ATK:")) skill.light_armor_atk = text.replace("Light Armor ATK:", "").trim();
      else if (text.match(/^Level \d+$/)) {
        // Skip — levels are parsed from HTML blocks below
      }
      else if (text.match(/^(АТК|ATK):/)) {
        // Captured in level effects below
      }
      else if (text.match(/^\d+ (adjacent|enemies|enemy)/i) || text.match(/^Up to \d+/) || text.match(/^Max Range/)) {
        skill.target = text;
      }
      else if (text.startsWith("Double Damage") || text.startsWith("Additional") || text.match(/^[A-Z].*bonus/i)) {
        skill.special.push(text);
      }
      else if (!skill.description && text.length > 20 && !text.match(/^(None|Level|\d)/) && !text.includes(":")) {
        skill.description = text;
      }
    }

    // Parse skill levels with full effects from HTML blocks
    // Format: <strong>Level N</strong><br>ATK: X%<br>effect1<br>effect2...
    const levelBlocks = [...skillBlock.matchAll(/<strong>(Level \d+)<\/strong><br\s*\/?>([\s\S]*?)(?=<strong>Level|<\/p>|<\/div>)/gi)];
    if (levelBlocks.length > 0) {
      skill.levels = [];
      for (const block of levelBlocks) {
        const levelName = block[1].trim();
        const content = block[2];
        const effectLines = content.split(/<br\s*\/?>/)
          .map(s => s.replace(/<[^>]*>/g, "").replace(/&nbsp;/g, " ").trim())
          .filter(s => s.length > 0);

        // First line is usually ATK value
        const atkLine = effectLines.find(l => l.match(/^(АТК|ATK):/));
        const effects = effectLines.filter(l => !l.match(/^(АТК|ATK):/));

        skill.levels.push({
          level: levelName,
          value: atkLine || "",
          effects: effects,
        });
      }
    }

    if (skill.name && skill.name !== "None") {
      result.skills.push(skill);
    }
  }

  return result;
}

// ── Parse Character Buff (Job Skill) ──

function parseCharacterBuff(html) {
  const nameMatch = html.match(/id="JobSkillName">([^<]+)</);
  if (!nameMatch) return null;

  const buff = {
    name: nameMatch[1].trim(),
    image: null,
    description: null,
    target: null,
    casting_time: null,
    cooldown: null,
    duration: null,
    sp_cost: null,
    consume_item: null,
    levels: [],
  };

  // Image (src appears before class in the tag)
  const imgMatch = html.match(/src="\.\/images\/Skills\/([^"]+)"[^>]*class="skills_job"/);
  if (imgMatch) buff.image = imgMatch[1];

  // Description
  const descMatch = html.match(/id="JobSkillDesc">([^<]+)</);
  if (descMatch) buff.description = descMatch[1].trim();

  // Target
  const targetMatch = html.match(/id="JobSkillTargets">([^<]+)</);
  if (targetMatch) buff.target = targetMatch[1].trim();

  // Cast time, cooldown, duration, SP
  const castMatch = html.match(/id="JobSkillCastTime">([^<]+)</);
  if (castMatch) buff.casting_time = castMatch[1].trim();

  const cdMatch = html.match(/id="JobSkillCooldown">([^<]+)</);
  if (cdMatch) buff.cooldown = cdMatch[1].trim();

  const durMatch = html.match(/id="JobSkillAnimDuration">([^<]+)</);
  if (durMatch) buff.duration = durMatch[1].trim();

  const spMatch = html.match(/id="JobSkillConsume">([^<]+)</);
  if (spMatch) buff.sp_cost = spMatch[1].trim();

  const consumeMatch = html.match(/id="JobSkillConsume2">([^<]+)</);
  if (consumeMatch) buff.consume_item = consumeMatch[1].trim();

  // Level descriptions
  const levelsSection = html.match(/id="JobSkillDescs">([\s\S]*?)<\/div>/);
  if (levelsSection) {
    const levelBlocks = [...levelsSection[1].matchAll(/<strong>(Level \d+)<\/strong><br>([\s\S]*?)(?=<strong>|<\/p>)/g)];
    for (const block of levelBlocks) {
      const levelName = block[1].trim();
      const effects = block[2].split(/<br\s*\/?>/)
        .map(s => s.replace(/<[^>]*>/g, "").trim())
        .filter(s => s.length > 0);
      buff.levels.push({ level: levelName, effects });
    }
  }

  return buff;
}

// ── Parse Full Character Page ──

function parseCharacterPage(html, slug) {
  const character = {
    slug,
    equipment: parseEquipment(html),
    character_buff: parseCharacterBuff(html),
    stance_overview: parseStanceOverview(html),
    stances: [],
  };

  // Find all stance detail sections
  const stanceHeaders = [...html.matchAll(/<h3\s+id="([^"]+)">([^<]+)<\/h3>/gi)];

  for (let i = 0; i < stanceHeaders.length; i++) {
    const stanceName = stanceHeaders[i][2].trim();
    const startIdx = stanceHeaders[i].index;
    const endIdx = i + 1 < stanceHeaders.length ? stanceHeaders[i + 1].index : startIdx + 20000;
    const sectionHtml = html.substring(startIdx, Math.min(endIdx, startIdx + 20000));

    const stanceDetail = parseStanceDetail(sectionHtml, stanceName);

    // Attach equipment requirement from overview
    const overviewMatch = character.stance_overview.find(o => o.stance_name === stanceName);
    if (overviewMatch) {
      stanceDetail.equipped_items = overviewMatch.equipped_items;
      stanceDetail.icon_position = overviewMatch.icon_position;
    }

    character.stances.push(stanceDetail);
  }

  return character;
}

// ── Scrape One Character ──

async function scrapeCharacter(slug, retries = 2) {
  const url = `${BASE}/${encodeURIComponent(slug)}.php`;
  for (let attempt = 0; attempt <= retries; attempt++) {
    try {
      const res = await fetch(url);
      if (!res.ok) return { slug, error: `HTTP ${res.status}`, stances: [] };
      const html = await res.text();
      return parseCharacterPage(html, slug);
    } catch (err) {
      if (attempt < retries) await new Promise(r => setTimeout(r, 1500));
      else return { slug, error: err.message, stances: [] };
    }
  }
}

// ── Main ──

async function main() {
  const startFrom = process.argv[2] ? parseInt(process.argv[2]) : 0;
  const limit = process.argv[3] ? parseInt(process.argv[3]) : slugs.length;
  const subset = slugs.slice(startFrom, startFrom + limit);

  console.log(`\n🔍 Full character scrape: ${subset.length} characters (from #${startFrom})\n`);

  const allResults = [];
  let totalStances = 0;
  let totalSkills = 0;
  let errors = 0;

  for (let i = 0; i < subset.length; i++) {
    const slug = subset[i];
    const data = await scrapeCharacter(slug);

    if (data.error) {
      errors++;
      console.log(`  ❌ ${slug}: ${data.error}`);
    } else {
      const stanceCount = data.stances.length;
      const skillCount = data.stances.reduce((sum, s) => sum + s.skills.length, 0);
      totalStances += stanceCount;
      totalSkills += skillCount;

      // Save individual character file
      writeFileSync(resolve(OUT_DIR, `${slug}.json`), JSON.stringify(data, null, 2));
    }

    allResults.push(data);

    // Progress
    const pct = ((i + 1) / subset.length * 100).toFixed(1);
    process.stdout.write(`\r  ${i + 1}/${subset.length} (${pct}%) — ${totalStances} stances, ${totalSkills} skills, ${errors} errors`);

    // Polite delay
    if (i < subset.length - 1) await new Promise(r => setTimeout(r, 500));
  }

  console.log(`\n\n📊 Summary:`);
  console.log(`  Characters: ${allResults.length}`);
  console.log(`  Stances: ${totalStances}`);
  console.log(`  Skills: ${totalSkills}`);
  console.log(`  Errors: ${errors}`);

  // Save combined summary
  const summary = allResults.map(c => ({
    slug: c.slug,
    error: c.error || null,
    stances: c.stances?.length || 0,
    skills: c.stances?.reduce((sum, s) => sum + s.skills.length, 0) || 0,
  }));
  writeFileSync(resolve(OUT_DIR, "_summary.json"), JSON.stringify(summary, null, 2));
  console.log(`\n✅ Saved to data/full/ (individual files + _summary.json)`);
}

main().catch(err => { console.error(err); process.exit(1); });
