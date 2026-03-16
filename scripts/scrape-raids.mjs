#!/usr/bin/env node
// GE Database Thai — Raids Scraper
import { writeFileSync, readFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const OUT_PATH = resolve(__dirname, "../data/raids.json");

async function main() {
  const res = await fetch("https://ge-db.site/andromida/Raids.php");
  const html = await res.text();

  const raids = [];
  const rowRegex = /<tr[^>]*>([\s\S]*?)<\/tr>/gi;
  let match;
  while ((match = rowRegex.exec(html)) !== null) {
    const row = match[1];
    const linkMatch = row.match(/href="Raids-([^"]+)\.php([^"]*)"/);
    if (!linkMatch) continue;

    const cells = [];
    const tdRegex = /<td[^>]*>([\s\S]*?)<\/td>/gi;
    let td;
    while ((td = tdRegex.exec(row)) !== null) {
      cells.push(td[1].replace(/<[^>]+>/g, "").trim());
    }

    if (cells.length >= 3) {
      raids.push({
        name: cells[0],
        slug: "raid-" + linkMatch[1],
        race: cells[1] || null,
        level: parseInt(cells[2]) || null,
        location: cells[3] || null,
      });
    }
  }

  console.log(`Raids found: ${raids.length}`);
  console.log("Sample:", JSON.stringify(raids.slice(0, 3), null, 2));
  writeFileSync(OUT_PATH, JSON.stringify(raids, null, 2));
  console.log(`Saved to data/raids.json`);
}

main().catch(err => { console.error(err); process.exit(1); });
