#!/usr/bin/env node
/**
 * Migrate quest images from cdn.exe.in.th to Cloudflare R2
 * - Downloads banners + stage images
 * - Optimizes with cwebp (WebP q80)
 * - Resizes with sips if >1200px wide
 * - Uploads original + WebP to R2 (--remote)
 */
import { execSync, exec } from "child_process";
import { mkdirSync, existsSync, writeFileSync, statSync, unlinkSync } from "fs";
import { join } from "path";

const WORKDIR = "/tmp/ge-quest-images";
const GE_DB_DIR = "/Users/angkana/ghq/github.com/xToriMicz/ge-db-thai";
const R2_BUCKET = "ge-db-assets";
const CONCURRENCY = 5;

const BANNERS = {
  beatrice: "https://cdn.exe.in.th/marketing/granado/images/guide/0523/beatrice/granado_beatrice_banner.jpg",
  sharon: "https://cdn.exe.in.th/marketing/granado/images/guide/0623/sharon/granadoespada-sharon-banner.jpg",
  "dark-emilia": "https://cdn.exe.in.th/marketing/granado/images/guide/0623/darkemilia/granadoespada_darkemilia_banner.jpg",
  "nar-2": "https://cdn.exe.in.th/marketing/granado/images/guide/0623/nar/granadoespada_nar_banner.jpg",
  "mboma-ll": "https://cdn.exe.in.th/marketing/granado/images/guide/0523/mboma/granado_mboma_banner.jpg",
  "jose-cortasar": "https://cdn.exe.in.th/marketing/granado/images/guide/0523/jose/granado_jose_banner.jpg",
  gurtrude: "https://cdn.exe.in.th/marketing/granado/images/2023/05/gurtrude/gurtrude_banner.jpg",
  gracielo: "https://cdn.exe.in.th/marketing/granado/images/guide/0523/gracielo/gracielo_banner.jpg",
  selva: "https://cdn.exe.in.th/marketing/granado/images/guide/0523/selva/selva_banner.jpg",
  irawan: "https://cdn.exe.in.th/marketing/granado/images/guide/0323/irawan_banner.jpg",
  ania: "https://cdn.exe.in.th/marketing/granado/images/guide/12/ania/ania_700x365.jpg",
  vincent: "https://cdn.exe.in.th/marketing/granado/images/guide/12/vincent/vincent_700x365.jpg",
  soso: "https://cdn.exe.in.th/marketing/granado/images/guide/12/soso/soso_700x365.jpg",
  marie: "https://cdn.exe.in.th/marketing/granado/images/guide/12/marie/marie_700x365.jpg",
  catherine: "https://cdn.exe.in.th/marketing/granado/images/guide/12/catherine/catherine_700x365.jpg",
  catherinetorsche: "https://cdn.exe.in.th/marketing/granado/images/guide/11/catherinetorsche/catherinetorsche_700x365.jpg",
  hellena: "https://cdn.exe.in.th/marketing/granado/images/guide/11/hellena/hellena_700x365.jpg",
  calyce: "https://cdn.exe.in.th/marketing/granado/images/guide/11/calyce/calyce_700x365.jpg",
  mboma: "https://cdn.exe.in.th/marketing/granado/images/guide/11/mboma/mboma_700x365.jpg",
  emilia: "https://cdn.exe.in.th/marketing/granado/images/guide/11/emilia/emilia_700x365.jpg",
  andre: "https://cdn.exe.in.th/marketing/granado/images/guide/11/andre/andre_700.jpg",
  panfilo: "https://cdn.exe.in.th/marketing/granado/images/guide/11/panfilo/panfilo_700.jpg",
  "najib-sharif": "https://cdn.exe.in.th/marketing/granado/images/guide/11/najibsharif/najib_700.jpg",
};

const STAGES = {
  beatrice: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/0523/beatrice/", count: 37 },
  sharon: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/0623/sharon/", count: 47 },
  "dark-emilia": { base: "https://cdn.exe.in.th/marketing/granado/images/guide/0623/darkemilia/", count: 18 },
  "nar-2": { base: "https://cdn.exe.in.th/marketing/granado/images/guide/0623/nar/", count: 18 },
  "mboma-ll": { base: "https://cdn.exe.in.th/marketing/granado/images/guide/0523/mboma/", count: 21 },
  "jose-cortasar": { base: "https://cdn.exe.in.th/marketing/granado/images/guide/0523/jose/", count: 5 },
  gurtrude: { base: "https://cdn.exe.in.th/marketing/granado/images/2023/05/gurtrude/", count: 11 },
  gracielo: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/0523/gracielo/", count: 20 },
  selva: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/0523/selva/", count: 35 },
  irawan: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/0323/", count: 5 },
  ania: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/12/ania/", count: 10 },
  vincent: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/12/vincent/", count: 13 },
  soso: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/12/soso/", count: 10 },
  marie: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/12/marie/", count: 58 },
  catherine: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/12/catherine/", count: 32 },
  catherinetorsche: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/11/catherinetorsche/", count: 22 },
  hellena: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/11/hellena/", count: 11 },
  calyce: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/11/calyce/", count: 31 },
  mboma: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/11/mboma/", count: 12 },
  emilia: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/11/emilia/", count: 13 },
  andre: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/11/andre/", count: 17 },
  panfilo: { base: "https://cdn.exe.in.th/marketing/granado/images/guide/11/panfilo/", count: 20 },
  "najib-sharif": { base: "https://cdn.exe.in.th/marketing/granado/images/guide/11/najibsharif/", count: 31 },
};

let stats = { downloaded: 0, failed: 0, uploaded: 0, skipped: 0 };

async function downloadFile(url, dest) {
  if (existsSync(dest) && statSync(dest).size > 0) {
    stats.skipped++;
    return true;
  }
  try {
    const res = await fetch(url);
    if (!res.ok) return false;
    const buf = Buffer.from(await res.arrayBuffer());
    writeFileSync(dest, buf);
    stats.downloaded++;
    return true;
  } catch {
    return false;
  }
}

function optimizeImage(src) {
  // Resize if >1200px wide
  try {
    const out = execSync(`sips -g pixelWidth "${src}" 2>/dev/null`, { encoding: "utf8" });
    const w = parseInt(out.split("\n").pop().trim().split(/\s+/).pop());
    if (w > 1200) {
      execSync(`sips --resampleWidth 1200 "${src}" --out "${src}" 2>/dev/null`);
    }
  } catch {}

  // Convert to WebP
  const webpDest = src.replace(/\.[^.]+$/, ".webp");
  try {
    execSync(`cwebp -q 80 -quiet "${src}" -o "${webpDest}" 2>/dev/null`);
    return webpDest;
  } catch {
    return null;
  }
}

function uploadToR2(localPath, r2Key, contentType) {
  try {
    execSync(
      `cd "${GE_DB_DIR}" && npx wrangler r2 object put "${R2_BUCKET}/${r2Key}" --file="${localPath}" --content-type="${contentType}" --remote 2>/dev/null`,
      { timeout: 30000 }
    );
    stats.uploaded++;
    return true;
  } catch (e) {
    console.error(`    R2 upload failed: ${r2Key}`);
    return false;
  }
}

function getContentType(filename) {
  if (filename.endsWith(".jpg") || filename.endsWith(".jpeg")) return "image/jpeg";
  if (filename.endsWith(".png")) return "image/png";
  if (filename.endsWith(".webp")) return "image/webp";
  if (filename.endsWith(".gif")) return "image/gif";
  return "application/octet-stream";
}

async function processInBatches(items, batchSize, fn) {
  for (let i = 0; i < items.length; i += batchSize) {
    const batch = items.slice(i, i + batchSize);
    await Promise.all(batch.map(fn));
  }
}

async function main() {
  console.log("=== Quest Image Migration: cdn.exe.in.th → R2 ===\n");

  // Phase 1: Download
  console.log("--- Phase 1: Download ---");

  // Download banners
  const bannerTasks = Object.entries(BANNERS).map(([slug, url]) => ({
    slug,
    url,
    dest: join(WORKDIR, "banners", slug),
    filename: "banner" + url.substring(url.lastIndexOf(".")),
  }));

  for (const t of bannerTasks) mkdirSync(t.dest, { recursive: true });

  await processInBatches(bannerTasks, CONCURRENCY, async (t) => {
    const ok = await downloadFile(t.url, join(t.dest, t.filename));
    if (!ok) {
      stats.failed++;
      console.log(`  FAIL banner: ${t.slug}`);
    }
  });
  console.log(`  Banners: ${Object.keys(BANNERS).length} done`);

  // Download stage images
  const stageTasks = [];
  for (const [slug, { base, count }] of Object.entries(STAGES)) {
    const dir = join(WORKDIR, "stages", slug);
    mkdirSync(dir, { recursive: true });
    for (let i = 0; i < count; i++) {
      stageTasks.push({
        slug,
        url: `${base}${i}.png`,
        dest: join(dir, `${i}.png`),
      });
    }
  }

  const totalStages = stageTasks.length;
  let stageProgress = 0;

  await processInBatches(stageTasks, CONCURRENCY, async (t) => {
    const ok = await downloadFile(t.url, t.dest);
    if (!ok) {
      stats.failed++;
    }
    stageProgress++;
    if (stageProgress % 50 === 0 || stageProgress === totalStages) {
      process.stdout.write(`\r  Stages: ${stageProgress}/${totalStages}`);
    }
  });
  console.log(`\n  Download complete: ${stats.downloaded} new, ${stats.skipped} cached, ${stats.failed} failed\n`);

  // Phase 2: Optimize + Upload
  console.log("--- Phase 2: Optimize + Upload to R2 ---");

  // Process banners
  for (const t of bannerTasks) {
    const src = join(t.dest, t.filename);
    if (!existsSync(src)) continue;

    process.stdout.write(`  Banner ${t.slug}...`);
    const webpPath = optimizeImage(src);

    const r2Key = `quests/${t.slug}/banner.jpg`;
    uploadToR2(src, r2Key, getContentType(t.filename));

    if (webpPath && existsSync(webpPath)) {
      uploadToR2(webpPath, `${r2Key}.webp`, "image/webp");
    }
    console.log(" OK");
  }

  // Process stages
  let stageUpProgress = 0;
  for (const [slug, { count }] of Object.entries(STAGES)) {
    process.stdout.write(`  Stages ${slug} (${count})...`);
    let ok = 0;
    for (let i = 0; i < count; i++) {
      const src = join(WORKDIR, "stages", slug, `${i}.png`);
      if (!existsSync(src)) continue;

      const webpPath = optimizeImage(src);
      const r2Key = `quests/${slug}/${i}.png`;
      uploadToR2(src, r2Key, "image/png");

      if (webpPath && existsSync(webpPath)) {
        uploadToR2(webpPath, `${r2Key}.webp`, "image/webp");
      }
      ok++;
    }
    stageUpProgress += ok;
    console.log(` ${ok}/${count}`);
  }

  console.log(`\n=== DONE ===`);
  console.log(`Downloaded: ${stats.downloaded} | Cached: ${stats.skipped} | Failed: ${stats.failed}`);
  console.log(`Uploaded to R2: ${stats.uploaded} objects`);
  console.log(`\nR2 paths:`);
  console.log(`  Banners: quests/{slug}/banner.jpg(.webp)`);
  console.log(`  Stages:  quests/{slug}/{n}.png(.webp)`);
}

main().catch(console.error);
