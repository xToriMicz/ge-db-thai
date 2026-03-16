#!/usr/bin/env node
// Scrape item image filenames from ge-db.site
// Maps item_id → image filename
import { writeFileSync, readFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const OUT_PATH = resolve(__dirname, "../data/item-images.json");

const BASE = "https://ge-db.site/andromida";

// Same category list as scrape-items.mjs
const CATEGORIES = [
  "Items-Sword.php", "Items-Dagger.php", "Items-Blunt.php", "Items-THSword.php",
  "Items-Polearm.php", "Items-Rapier.php", "Items-Sabre.php", "Items-Knuckle.php",
  "Items-Tonfa.php", "Items-Javelin.php", "Items-Crescent.php", "Items-Shield.php",
  "Items-MainG.php", "Items-Leguard.php",
  "Items-Pistol.php", "Items-Rifle.php", "Items-Cannon.php", "Items-CrossBow.php",
  "Items-Shotgun.php", "Items-HeavyRifle.php", "Items-ArmShield.php",
  "Items-Controller.php", "Items-Tool.php", "Items-Pendant.php",
  "Items-Rod.php", "Items-Staff.php", "Items-FireBrc.php", "Items-IceBrc.php",
  "Items-LghtBrc.php", "Items-ElemBrc.php", "Items-Cube.php", "Items-Lute.php",
  "Items-Book.php", "Items-Rosario.php",
  "Items-Coat.php", "Items-Leather.php", "Items-Metal.php", "Items-Robe.php",
  "Items-Artifact.php", "Items-Belt.php", "Items-Ear.php", "Items-Glove.php",
  "Items-Necklace.php", "Items-Boots.php", "Items-Runestone.php", "Items-PetSpirit.php",
  "Items-Back.php", "Items-Face.php", "Items-Achieve.php", "Items-Hat.php",
  "Items-Costume.php", "Items-WepCostume.php",
  "Items-Ring.php", "Items-VRing.php", "Items-URing.php", "Items-SRing.php",
  "Items-Alchemy.php", "Items-Cook.php", "Items-CraftA.php", "Items-CraftD.php",
  "Items-Quest.php", "Items-Rumin.php", "Items-Summon.php",
];

async function scrapePage(file) {
  const res = await fetch(`${BASE}/${file}`);
  if (!res.ok) return [];
  const html = await res.text();

  // Pattern: <a id="NNNNN" href="..."><img src="images/items/FILENAME.jpg" ...>
  const results = [];
  const regex = /<a\s+id="(\d+)"[^>]*>\s*<img\s+src="images\/items\/([^"]+)"/gi;
  let m;
  while ((m = regex.exec(html)) !== null) {
    results.push({ item_id: parseInt(m[1]), image: m[2] });
  }
  return results;
}

async function main() {
  console.log("🖼️  Scraping item images...\n");
  const allImages = [];
  const batchSize = 5;

  for (let i = 0; i < CATEGORIES.length; i += batchSize) {
    const batch = CATEGORIES.slice(i, i + batchSize);
    const results = await Promise.all(batch.map(f => scrapePage(f)));
    for (const imgs of results) allImages.push(...imgs);
    if (i + batchSize < CATEGORIES.length) await new Promise(r => setTimeout(r, 300));
    process.stdout.write(`  ${Math.min(i + batchSize, CATEGORIES.length)}/${CATEGORIES.length} pages\r`);
  }

  console.log(`\n📊 Total images: ${allImages.length}`);
  writeFileSync(OUT_PATH, JSON.stringify(allImages, null, 2));
  console.log(`✅ Saved to data/item-images.json`);
}

main().catch(err => { console.error(err); process.exit(1); });
