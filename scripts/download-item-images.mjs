#!/usr/bin/env node
// Download unique item images from ge-db.site
import { writeFileSync, existsSync, mkdirSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const IMAGES_DIR = resolve(__dirname, "../data/item-images");
const BASE = "https://ge-db.site/andromida/images/items";

async function main() {
  const images = JSON.parse(
    (await import("node:fs")).readFileSync(resolve(__dirname, "../data/item-images.json"), "utf8")
  );

  // Deduplicate by filename
  const unique = [...new Set(images.map(i => i.image))];
  console.log(`🖼️  ${unique.length} unique images to download\n`);

  let downloaded = 0;
  let skipped = 0;
  let failed = 0;
  const batchSize = 20;

  for (let i = 0; i < unique.length; i += batchSize) {
    const batch = unique.slice(i, i + batchSize);
    await Promise.all(batch.map(async (filename) => {
      const outPath = resolve(IMAGES_DIR, filename);
      if (existsSync(outPath)) { skipped++; return; }

      try {
        const res = await fetch(`${BASE}/${filename}`);
        if (!res.ok) { failed++; return; }
        const buf = Buffer.from(await res.arrayBuffer());
        writeFileSync(outPath, buf);
        downloaded++;
      } catch {
        failed++;
      }
    }));

    const total = downloaded + skipped + failed;
    process.stdout.write(`  ${total}/${unique.length} (${downloaded} new, ${skipped} cached, ${failed} failed)\r`);

    if (i + batchSize < unique.length) await new Promise(r => setTimeout(r, 200));
  }

  console.log(`\n\n✅ Done: ${downloaded} downloaded, ${skipped} skipped, ${failed} failed`);
}

main().catch(err => { console.error(err); process.exit(1); });
