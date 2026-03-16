#!/usr/bin/env node
// Scrape bios for 18 characters missing bio_th
import { writeFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const BASE = "https://ge-db.site/andromida";

const slugs = [
  "Beretta", "Braise", "Claret", "Dina", "Eunha",
  "Gracielo HD", "Hatir", "Ivelar", "Kevin ICE", "Kurt2",
  "Lilly", "Mifuyu", "Pio Brunie", "Pio Mboma", "Raviel",
  "Rosie ICE", "Stia", "Wiesel"
];

async function scrapeBio(slug) {
  const url = `${BASE}/${encodeURIComponent(slug)}.php`;
  try {
    const res = await fetch(url);
    if (!res.ok) return { slug, bio: null, status: res.status };
    const html = await res.text();

    // Try meta description
    const metaMatch = html.match(/<meta\s+name="description"\s+content="([^"]+)"/i);
    if (metaMatch && metaMatch[1].length > 20) {
      return { slug, bio: metaMatch[1].trim() };
    }

    // Try <p> after bio/description class
    const bioMatch = html.match(/<p[^>]*class="[^"]*(?:bio|desc|lore)[^"]*"[^>]*>([^<]+)/i);
    if (bioMatch) {
      return { slug, bio: bioMatch[1].trim() };
    }

    // Try first substantial <p> in main content
    const pMatch = html.match(/<div[^>]*class="[^"]*(?:content|detail|info)[^"]*"[^>]*>[\s\S]*?<p[^>]*>([^<]{30,})/i);
    if (pMatch) {
      return { slug, bio: pMatch[1].trim() };
    }

    return { slug, bio: null };
  } catch (err) {
    return { slug, bio: null, error: err.message };
  }
}

async function main() {
  console.log(`Scraping bios for ${slugs.length} characters...\n`);
  const results = [];

  for (const slug of slugs) {
    const r = await scrapeBio(slug);
    results.push(r);
    console.log(`  ${slug}: ${r.bio ? r.bio.substring(0, 60) + '...' : 'NO BIO FOUND'}`);
    await new Promise(r => setTimeout(r, 300));
  }

  const found = results.filter(r => r.bio);
  console.log(`\n${found.length}/${slugs.length} bios found`);

  writeFileSync(resolve(__dirname, "../data/missing-bios.json"), JSON.stringify(results, null, 2));
  console.log("Saved to data/missing-bios.json");
}

main().catch(err => { console.error(err); process.exit(1); });
