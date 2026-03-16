// GE Database Scraper v2 — ดึงข้อมูลตัวละครจาก ge-db.site
// Strategy:
//   1. Parse CharacterJobs.php for ALL character metadata (type, armor, weapons, portrait)
//   2. Scrape individual pages for stats, bio, stances
import { writeFileSync, existsSync, readFileSync } from "fs";
import { mkdirSync } from "fs";

const BASE = "https://ge-db.site";
const DATA_DIR = "/Users/angkana/Jingjing-oracle/ψ/lab/ge-db/data";
const OUT_LIST = `${DATA_DIR}/characters-list.json`;
const OUT_DETAIL = `${DATA_DIR}/characters-detail.json`;

// Ensure data dir exists
mkdirSync(DATA_DIR, { recursive: true });

// Known character types
const CHAR_TYPES = ["basic", "recruit", "cash", "accomplish"];
const ARMOR_TYPES = ["coat", "leather", "metal", "robe"];
const WEAPON_TYPES = [
  "sword", "dag", "blunt", "staff", "rod", "rifle", "pistol",
  "cannon", "xbow", "shotgun", "gs", "pole", "rap", "sabre",
  "shield", "knuckle", "tonfa", "jav", "crescent", "ibr", "leg", "mg",
  "firebrac", "icebrac", "lightbrac", "elebrac", "magscroll", "cube",
  "rosario", "instrument", "tool", "book", "bracelet", "lute",
  "hammer", "pendant", "armshield", "controller",
];

interface CharMeta {
  slug: string;
  displayName: string;
  type: string;
  armorTypes: string[];
  weapons: string[];
  portraitX: number;
  portraitY: number;
  portraitClass: string;
  isNew: boolean;
}

interface CharDetail extends CharMeta {
  name: string; // from <title>
  stats: Record<string, number>;
  bio: string;
  stances: string[];
  startingArmor: string;
  startingWeapon: string;
  buff: string;
  buffLevel: number;
  startingLevel: number;
}

// ── Step 1: Parse character list page ──
async function getCharacterList(): Promise<CharMeta[]> {
  console.log("📋 Fetching character list from CharacterJobs.php...");
  const r = await fetch(`${BASE}/CharacterJobs.php`);
  const html = await r.text();

  const characters: CharMeta[] = [];

  // Match each <li> entry: <a href="Slug.php#Nav"><img ...><span class="name ...">DisplayName</span></a>
  const pattern = /<a href="([^"]+)\.php#Nav"><img src="none\.gif" class="(portrait\d*)" style="background-position:(-?\d+)px (-?\d+)px"[^>]*><span class="name ([^"]*)">(.*?)<\/span><\/a>/g;

  let match;
  while ((match = pattern.exec(html)) !== null) {
    const slug = match[1];
    const portraitClass = match[2];
    const portraitX = parseInt(match[3]);
    const portraitY = parseInt(match[4]);
    const classes = match[5].split(/\s+/);
    // Display name may contain <span class="new"> inside, strip it
    const displayName = match[6].replace(/<span[^>]*>.*?<\/span>/g, "").trim();

    const type = classes.find(c => CHAR_TYPES.includes(c)) || "unknown";
    const armorTypes = classes.filter(c => ARMOR_TYPES.includes(c));
    const weapons = classes.filter(c => WEAPON_TYPES.includes(c));
    const isNew = match[6].includes('class="new"');

    characters.push({
      slug,
      displayName,
      type,
      armorTypes,
      weapons,
      portraitX,
      portraitY,
      portraitClass,
      isNew,
    });
  }

  // Deduplicate by slug (some appear in multiple rows)
  const seen = new Set<string>();
  const unique = characters.filter(c => {
    if (seen.has(c.slug)) return false;
    seen.add(c.slug);
    return true;
  });

  console.log(`✅ Found ${unique.length} unique characters (${characters.length} total entries)`);
  return unique;
}

// ── Step 2: Parse individual character page ──
function parseCharacterPage(html: string, meta: CharMeta): CharDetail {
  const detail: CharDetail = {
    ...meta,
    name: meta.displayName,
    stats: {},
    bio: "",
    stances: [],
    startingArmor: "",
    startingWeapon: "",
    buff: "",
    buffLevel: 0,
    startingLevel: 1,
  };

  // Name from <title>
  const titleMatch = html.match(/<title>([^<]+)<\/title>/);
  if (titleMatch) {
    detail.name = titleMatch[1].replace(/ - Granado Espada.*/, "").trim();
  }

  // Section after id="Nav" — character-specific content
  const navSection = html.split(/id="Nav"/)[1] || "";

  // Stats from id="STR", id="AGI", id="CON", id="DEX", id="INT", id="SEN"
  const statMap = { STR: "str", AGI: "agi", CON: "hp", DEX: "dex", INT: "int", SEN: "sen" };
  for (const [id, key] of Object.entries(statMap)) {
    const m = navSection.match(new RegExp(`id="${id}">(\\d+)<`));
    if (m) detail.stats[key] = parseInt(m[1]);
  }

  // Starting level
  const lvMatch = navSection.match(/id="initLv">(\d+)</);
  if (lvMatch) detail.startingLevel = parseInt(lvMatch[1]);

  // Bio
  const bioMatch = navSection.match(/id="CharBio">([^<]+)</);
  if (bioMatch) detail.bio = bioMatch[1].trim();

  // Starting equipment
  const armorMatch = navSection.match(/id="StartingArmor">([^<]*(?:<a[^>]*>[^<]*<\/a>[^<]*)*)/);
  if (armorMatch) detail.startingArmor = armorMatch[1].replace(/<[^>]+>/g, "").trim();

  const weapMatch = navSection.match(/id="StartingWeap">([^<]*(?:<a[^>]*>[^<]*<\/a>[^<]*)*)/);
  if (weapMatch) detail.startingWeapon = weapMatch[1].replace(/<[^>]+>/g, "").trim();

  // Character buff
  const buffMatch = navSection.match(/id="ChaBuff">([^<]+)/);
  if (buffMatch) detail.buff = buffMatch[1].trim();
  const buffLvMatch = navSection.match(/id="ChaBuff2">(\d+)/);
  if (buffLvMatch) detail.buffLevel = parseInt(buffLvMatch[1]);

  // Stances — extract unique stance names from links like <a href="Slug.php#StanceName">Stance Name</a>
  // These appear in the StanceConditions section
  const stanceSection = navSection.split(/id="StanceConditions"/)[1] || "";
  const stanceLinks = [...stanceSection.matchAll(new RegExp(`<a href="${meta.slug}\\.php#([^"]+)">([^<]+)</a>`, "g"))];
  const stanceSet = new Set<string>();
  for (const m of stanceLinks) {
    stanceSet.add(m[2].trim());
  }
  detail.stances = [...stanceSet];

  return detail;
}

// ── Step 3: Scrape with rate limiting ──
async function scrapeCharacterDetail(meta: CharMeta): Promise<CharDetail | null> {
  try {
    const r = await fetch(`${BASE}/${meta.slug}.php`, {
      headers: { "User-Agent": "Mozilla/5.0 GE-DB-TH Research Bot" }
    });
    if (!r.ok) {
      console.log(`  ❌ ${meta.slug}: HTTP ${r.status}`);
      return null;
    }
    const html = await r.text();
    return parseCharacterPage(html, meta);
  } catch (e: any) {
    console.log(`  ❌ ${meta.slug}: ${e.message}`);
    return null;
  }
}

// ── Main ──
(async () => {
  console.log("╔═══════════════════════════════════════╗");
  console.log("║  GE Database Scraper v2 — Characters  ║");
  console.log("╚═══════════════════════════════════════╝\n");

  // Step 1: Get list with metadata
  const metaList = await getCharacterList();
  writeFileSync(OUT_LIST, JSON.stringify(metaList, null, 2));
  console.log(`📁 Saved ${metaList.length} characters to ${OUT_LIST}\n`);

  // Step 2: Scrape details (resume from existing data)
  let existing: CharDetail[] = [];
  if (existsSync(OUT_DETAIL)) {
    try {
      const raw = JSON.parse(readFileSync(OUT_DETAIL, "utf-8"));
      // Only keep entries that have proper stats (skip old broken data)
      existing = raw.filter((c: any) => c.stats && Object.keys(c.stats).length > 0 && c.stances?.length > 0);
      if (existing.length < raw.length) {
        console.log(`⚠️  Filtered ${raw.length - existing.length} broken entries from existing data`);
      }
    } catch {
      existing = [];
    }
  }

  // For v2, rescrape everything since old data was wrong
  const rescrape = process.argv.includes("--rescrape");
  if (rescrape) {
    console.log("🔄 Rescrape mode: ignoring existing data\n");
    existing = [];
  }

  const scraped = new Set(existing.map(c => c.slug));
  const remaining = metaList.filter(m => !scraped.has(m.slug));
  console.log(`📂 Existing: ${existing.length} | Remaining: ${remaining.length}\n`);

  if (remaining.length === 0) {
    console.log("✅ All characters already scraped!");
  } else {
    console.log(`🎯 Scraping ${remaining.length} characters...\n`);
  }

  let count = 0;
  for (const meta of remaining) {
    count++;
    process.stdout.write(`  [${count}/${remaining.length}] ${meta.displayName} (${meta.slug})...`);

    const data = await scrapeCharacterDetail(meta);
    if (data) {
      existing.push(data);
      console.log(` ✅ ${data.stances.length} stances, ${Object.keys(data.stats).length} stats`);
    }

    // Save every 20 characters
    if (count % 20 === 0) {
      writeFileSync(OUT_DETAIL, JSON.stringify(existing, null, 2));
      console.log(`  💾 Saved (${existing.length} total)`);
    }

    // Rate limit: 300ms between requests
    await new Promise(r => setTimeout(r, 300));
  }

  // Final save
  writeFileSync(OUT_DETAIL, JSON.stringify(existing, null, 2));

  // Summary
  const withStats = existing.filter(c => Object.keys(c.stats).length > 0);
  const withStances = existing.filter(c => c.stances.length > 0);
  const totalStances = existing.reduce((sum, c) => sum + c.stances.length, 0);
  const types = existing.reduce((acc: Record<string, number>, c) => {
    acc[c.type] = (acc[c.type] || 0) + 1;
    return acc;
  }, {});

  console.log(`\n${"═".repeat(45)}`);
  console.log(`  SCRAPE COMPLETE`);
  console.log(`${"═".repeat(45)}`);
  console.log(`  📊 Characters: ${existing.length}`);
  console.log(`  📊 With Stats: ${withStats.length}`);
  console.log(`  📊 With Stances: ${withStances.length}`);
  console.log(`  📊 Total Unique Stances: ${totalStances}`);
  console.log(`  📊 Types: ${JSON.stringify(types)}`);
  console.log(`  📁 ${OUT_DETAIL}`);
})();
