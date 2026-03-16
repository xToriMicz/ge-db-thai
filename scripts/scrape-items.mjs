#!/usr/bin/env node
// GE Database Thai — Items Scraper v2
// Scrapes all item categories from ge-db.site/andromida
// Output: data/items.json

import { writeFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const OUT_PATH = resolve(__dirname, "../data/items.json");

const BASE = "https://ge-db.site/andromida";

// All 63 categories with CORRECT filenames from the site
const CATEGORIES = [
  // Melee weapons
  { file: "Items-Sword.php", category: "sword", group: "weapon-melee" },
  { file: "Items-Dagger.php", category: "dagger", group: "weapon-melee" },
  { file: "Items-Blunt.php", category: "blunt", group: "weapon-melee" },
  { file: "Items-THSword.php", category: "great_sword", group: "weapon-melee" },
  { file: "Items-Polearm.php", category: "polearm", group: "weapon-melee" },
  { file: "Items-Rapier.php", category: "rapier", group: "weapon-melee" },
  { file: "Items-Sabre.php", category: "sabre", group: "weapon-melee" },
  { file: "Items-Knuckle.php", category: "knuckle", group: "weapon-melee" },
  { file: "Items-Tonfa.php", category: "tonfa", group: "weapon-melee" },
  { file: "Items-Javelin.php", category: "javelin", group: "weapon-melee" },
  { file: "Items-Crescent.php", category: "crescent", group: "weapon-melee" },
  { file: "Items-Shield.php", category: "shield", group: "weapon-melee" },
  { file: "Items-MainG.php", category: "main_gauche", group: "weapon-melee" },
  { file: "Items-Leguard.php", category: "leg_guards", group: "weapon-melee" },
  // Ranged weapons
  { file: "Items-Pistol.php", category: "pistol", group: "weapon-ranged" },
  { file: "Items-Rifle.php", category: "rifle", group: "weapon-ranged" },
  { file: "Items-Cannon.php", category: "cannon", group: "weapon-ranged" },
  { file: "Items-CrossBow.php", category: "crossbow", group: "weapon-ranged" },
  { file: "Items-Shotgun.php", category: "shotgun", group: "weapon-ranged" },
  { file: "Items-HeavyRifle.php", category: "heavy_rifle", group: "weapon-ranged" },
  { file: "Items-ArmShield.php", category: "arm_shield", group: "weapon-ranged" },
  { file: "Items-Controller.php", category: "controller", group: "weapon-ranged" },
  { file: "Items-Tool.php", category: "hammer", group: "weapon-ranged" },
  { file: "Items-Pendant.php", category: "pendant", group: "weapon-ranged" },
  // Magic weapons
  { file: "Items-Rod.php", category: "rod", group: "weapon-magic" },
  { file: "Items-Staff.php", category: "staff", group: "weapon-magic" },
  { file: "Items-FireBrc.php", category: "fire_bracelet", group: "weapon-magic" },
  { file: "Items-IceBrc.php", category: "ice_bracelet", group: "weapon-magic" },
  { file: "Items-LghtBrc.php", category: "lightning_bracelet", group: "weapon-magic" },
  { file: "Items-ElemBrc.php", category: "special_bracelet", group: "weapon-magic" },
  { file: "Items-Cube.php", category: "cube", group: "weapon-magic" },
  { file: "Items-Lute.php", category: "lute", group: "weapon-magic" },
  { file: "Items-Book.php", category: "magic_scroll", group: "weapon-magic" },
  { file: "Items-Rosario.php", category: "rosario", group: "weapon-magic" },
  // Armor
  { file: "Items-Coat.php", category: "coat", group: "armor" },
  { file: "Items-Leather.php", category: "leather", group: "armor" },
  { file: "Items-Metal.php", category: "metal", group: "armor" },
  { file: "Items-Robe.php", category: "robe", group: "armor" },
  // Accessories
  { file: "Items-Artifact.php", category: "artifact", group: "accessory" },
  { file: "Items-Belt.php", category: "belt", group: "accessory" },
  { file: "Items-Ear.php", category: "earring", group: "accessory" },
  { file: "Items-Glove.php", category: "glove", group: "accessory" },
  { file: "Items-Necklace.php", category: "necklace", group: "accessory" },
  { file: "Items-Boots.php", category: "shoes", group: "accessory" },
  { file: "Items-Runestone.php", category: "runestone", group: "accessory" },
  { file: "Items-PetSpirit.php", category: "pet_spirit", group: "accessory" },
  // Costume
  { file: "Items-Back.php", category: "back", group: "costume" },
  { file: "Items-Face.php", category: "face", group: "costume" },
  { file: "Items-Achieve.php", category: "medal", group: "costume" },
  { file: "Items-Hat.php", category: "hat", group: "costume" },
  { file: "Items-Costume.php", category: "body_costume", group: "costume" },
  { file: "Items-WepCostume.php", category: "weapon_costume", group: "costume" },
  // Rings
  { file: "Items-Ring.php", category: "skill_ring", group: "ring" },
  { file: "Items-VRing.php", category: "veteran_ring", group: "ring" },
  { file: "Items-URing.php", category: "upgraded_ring", group: "ring" },
  { file: "Items-SRing.php", category: "stat_ring", group: "ring" },
  // Misc
  { file: "Items-Alchemy.php", category: "alchemy", group: "misc" },
  { file: "Items-Cook.php", category: "cooking", group: "misc" },
  { file: "Items-CraftA.php", category: "craftable", group: "misc" },
  { file: "Items-CraftD.php", category: "crafting", group: "misc" },
  { file: "Items-Quest.php", category: "quest", group: "misc" },
  { file: "Items-Rumin.php", category: "lumin", group: "misc" },
  { file: "Items-Summon.php", category: "summon", group: "misc" },
];

function slugify(name) {
  return name
    .toLowerCase()
    .replace(/['']/g, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
}

// Named level mapping
const NAMED_LEVELS = {
  "expert": 100, "veteran": 110, "master": 120,
  "high master": 130, "grand master": 132,
};

function parseLevel(text) {
  if (!text) return null;
  const m = text.match(/Lv\.?\s*(\d+)/i);
  if (m) return parseInt(m[1]);
  const lower = text.toLowerCase();
  for (const [k, v] of Object.entries(NAMED_LEVELS)) {
    if (lower.includes(k)) return v;
  }
  return null;
}

function parseItemPage(html, category, group) {
  const items = [];
  const seen = new Set();

  // Strategy: Split HTML by <div class="item"> blocks
  // Each block contains BOTH the name and the anchor+image
  // Structure: <div class="item..."><div class="desc"><h5><span class="name">NAME</span></h5>...</div>
  //            <a id="ID" class="flimg"><img src="images/items/IMAGE.jpg"></a>...</div>

  // Track current level from <h3> headers
  let currentLevel = null;

  // Split by item div blocks
  const blockStarts = [];
  const blockRegex = /<div\s+class="item\s/gi;
  let bm;
  while ((bm = blockRegex.exec(html)) !== null) {
    blockStarts.push(bm.index);
  }

  if (blockStarts.length === 0) {
    console.log(`    (no item blocks found)`);
    return items;
  }

  for (let i = 0; i < blockStarts.length; i++) {
    const startIdx = blockStarts[i];
    const endIdx = i + 1 < blockStarts.length ? blockStarts[i + 1] : startIdx + 10000;
    const block = html.substring(startIdx, Math.min(endIdx, startIdx + 10000));

    // Check for <h3>Level X</h3> before this block
    const beforeText = html.substring(Math.max(0, startIdx - 500), startIdx);
    const h3Match = beforeText.match(/<h3>(?:Level\s+)?(\d+|Expert|Veteran|Master|High Master|Grand Master)[^<]*<\/h3>/i);
    if (h3Match) {
      currentLevel = parseLevel(h3Match[1]) || parseLevel(h3Match[0]);
    }

    // Extract item name from <span class="name">
    const nameMatch = block.match(/<span class="name">([^<]+)<\/span>/);
    if (!nameMatch) continue;

    const name = nameMatch[1].trim();
    if (!name || seen.has(name)) continue;
    seen.add(name);

    // Extract item_id and image from <a id="ID" ...><img src="images/items/IMAGE.jpg">
    // Some pages (summon, etc.) use src="none.gif" with alt="IMAGE_NAME" instead
    const anchorMatch = block.match(/<a\s+id="(\d+)"[^>]*class="flimg"[^>]*>\s*<img\s+src="images\/items\/([^"]+)"/i);
    const anchorAlt = !anchorMatch ? block.match(/<a\s+id="(\d+)"[^>]*class="flimg"[^>]*>\s*<img\s+[^>]*alt="([^"]+)"/i) : null;
    const anchor = anchorMatch || anchorAlt;
    if (!anchor) continue;

    const itemId = anchor[1];
    const image = anchorMatch ? anchor[2] : anchor[2] + '.jpg';

    // Extract level from "Available to equip above Lv. X" or current h3 level
    const lvMatch = block.match(/(?:equip above|above)\s+Lv\.?\s*(\d+)/i);
    let level = lvMatch ? parseInt(lvMatch[1]) : currentLevel;

    // Also check for named levels in the block
    if (!level) {
      for (const [k, v] of Object.entries(NAMED_LEVELS)) {
        if (block.toLowerCase().includes(`above ${k}`) || block.toLowerCase().includes(`- ${k}`)) {
          level = v;
          break;
        }
      }
    }

    // Extract stats from the table
    const statsSection = block.match(/<td>([\s\S]*?)<\/td>/);
    const statsText = statsSection ? statsSection[1].replace(/<[^>]+>/g, " ") : "";

    const arMatch = statsText.match(/A\.?R\.?\s*(\d+)/);
    const atkMatch = statsText.match(/ATK\s*(\d+)/);
    const drMatch = statsText.match(/D\.?R\.?\s*(\d+)/);
    const defMatch = statsText.match(/DEF\s*(\d+)/);
    const socketsMatch = statsText.match(/Sockets?:?\s*(\d+)/i);

    items.push({
      item_id: parseInt(itemId),
      name,
      slug: slugify(name),
      category,
      group,
      level: level || null,
      image,
      atk: atkMatch ? parseInt(atkMatch[1]) : null,
      def: defMatch ? parseInt(defMatch[1]) : null,
      ar: arMatch ? parseInt(arMatch[1]) : null,
      dr: drMatch ? parseInt(drMatch[1]) : null,
      sockets: socketsMatch ? parseInt(socketsMatch[1]) : null,
    });
  }

  return items;
}

async function scrapeCategory(cat, retries = 2) {
  const url = `${BASE}/${cat.file}`;
  for (let attempt = 0; attempt <= retries; attempt++) {
    try {
      const res = await fetch(url, {
        headers: { "User-Agent": "GE-DB-Thai-Scraper/1.0" },
      });
      if (!res.ok) {
        console.error(`  ✗ ${cat.file}: HTTP ${res.status}`);
        return [];
      }
      const html = await res.text();
      const items = parseItemPage(html, cat.category, cat.group);
      console.log(`  ✓ ${cat.category}: ${items.length} items`);
      return items;
    } catch (err) {
      if (attempt < retries) {
        console.log(`  ⟳ ${cat.file}: retry ${attempt + 1}...`);
        await new Promise(r => setTimeout(r, 1000));
      } else {
        console.error(`  ✗ ${cat.file}: ${err.message}`);
        return [];
      }
    }
  }
  return [];
}

async function main() {
  console.log("🔍 GE Items Scraper v2 — 63 categories\n");

  const allItems = [];
  const batchSize = 5;

  for (let i = 0; i < CATEGORIES.length; i += batchSize) {
    const batch = CATEGORIES.slice(i, i + batchSize);
    const results = await Promise.all(batch.map(cat => scrapeCategory(cat)));
    for (const items of results) {
      allItems.push(...items);
    }
    if (i + batchSize < CATEGORIES.length) {
      await new Promise(r => setTimeout(r, 300));
    }
  }

  // Deduplicate by category+name
  const unique = new Map();
  for (const item of allItems) {
    const key = `${item.category}:${item.name}`;
    if (!unique.has(key)) {
      unique.set(key, item);
    }
  }

  const finalItems = [...unique.values()];
  console.log(`\n📊 Total: ${finalItems.length} unique items across ${CATEGORIES.length} categories`);

  // Stats by group
  const groups = {};
  for (const item of finalItems) {
    groups[item.group] = (groups[item.group] || 0) + 1;
  }
  for (const [group, count] of Object.entries(groups).sort()) {
    console.log(`  ${group}: ${count}`);
  }

  // Write output
  writeFileSync(OUT_PATH, JSON.stringify(finalItems, null, 2));
  console.log(`\n✅ Saved to data/items.json (${finalItems.length} items)`);
}

main().catch(err => {
  console.error("Fatal:", err);
  process.exit(1);
});
