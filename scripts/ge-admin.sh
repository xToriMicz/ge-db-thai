#!/bin/bash
# GE Database Thai — Admin CLI
# Usage: ./scripts/ge-admin.sh <command>
set -euo pipefail

DB_NAME="ge-db-thai"
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

case "${1:-help}" in

  # ── Database ──
  stats)
    echo "📊 Database Stats:"
    npx wrangler d1 execute $DB_NAME --remote --command \
      "SELECT 'characters' as table_name, COUNT(*) as count FROM characters UNION ALL SELECT 'stances', COUNT(*) FROM stances UNION ALL SELECT 'items', COUNT(*) FROM items UNION ALL SELECT 'maps', COUNT(*) FROM maps UNION ALL SELECT 'monsters', COUNT(*) FROM monsters UNION ALL SELECT 'raids', COUNT(*) FROM raids UNION ALL SELECT 'feedback', COUNT(*) FROM feedback;" \
      --json 2>/dev/null | python3 -c "
import sys,json
d=json.load(sys.stdin)
for r in d[0]['results']:
    print(f\"  {r['table_name']}: {r['count']}\")
"
    ;;

  feedback)
    echo "💬 Recent Feedback:"
    npx wrangler d1 execute $DB_NAME --remote --command \
      "SELECT character_slug, message, created_at FROM feedback ORDER BY created_at DESC LIMIT ${2:-20};" \
      --json 2>/dev/null | python3 -c "
import sys,json
d=json.load(sys.stdin)
for r in d[0]['results']:
    slug = r['character_slug'] or '(general)'
    print(f\"  [{r['created_at']}] {slug}: {r['message']}\")
if not d[0]['results']:
    print('  (no feedback yet)')
"
    ;;

  migrate)
    file="${2:?Usage: ge-admin.sh migrate <file.sql> OR ge-admin.sh migrate all}"
    if [[ "$file" == "all" ]]; then
      # Find unapplied migrations (compare files vs applied log)
      echo "🔄 Applying all pending migrations..."
      for f in sql/migrations/*.sql; do
        echo -n "  $(basename $f)... "
        sql=$(grep '^UPDATE\|^INSERT\|^ALTER\|^CREATE\|^DELETE' "$f" | tr '\n' ' ')
        if [[ -z "$sql" ]]; then
          echo "skip (no statements)"
          continue
        fi
        result=$(npx wrangler d1 execute $DB_NAME --remote --command "$sql" --json 2>&1)
        if echo "$result" | python3 -c "import sys,json; json.load(sys.stdin)" 2>/dev/null; then
          echo "ok"
        else
          echo "FAIL"
          echo "    $result" | head -3
        fi
      done
    else
      echo "🔄 Running migration: $file"
      sql=$(grep '^UPDATE\|^INSERT\|^ALTER\|^CREATE\|^DELETE' "$file" | tr '\n' ' ')
      if [[ -z "$sql" ]]; then
        echo "  No SQL statements found"
        exit 1
      fi
      npx wrangler d1 execute $DB_NAME --remote --command "$sql" --json 2>/dev/null | \
        python3 -c "import sys,json; print('✅ Done')"
    fi
    ;;

  query)
    sql="${2:?Usage: ge-admin.sh query \"SQL...\"}"
    npx wrangler d1 execute $DB_NAME --remote --command "$sql" --json 2>/dev/null | python3 -m json.tool
    ;;

  # ── Deploy ──
  deploy)
    echo "🚀 Deploying..."
    npx wrangler deploy
    ;;

  # ── Scrape ──
  check-new)
    echo "🔍 Checking for new characters on ge-db.site/andromida..."
    curl -s 'https://ge-db.site/andromida/CharacterJobs.php' | \
      grep -oE 'href="[^"]*\.php#Nav"' | sed 's|href="||;s|.php#Nav||;s|"||' | sort > /tmp/ge-remote.txt
    npx wrangler d1 execute $DB_NAME --remote --command \
      "SELECT slug FROM characters ORDER BY slug;" \
      --json 2>/dev/null | python3 -c "
import sys,json
d=json.load(sys.stdin)
for r in d[0]['results']:
    print(r['slug'])
" | sort > /tmp/ge-local.txt
    new=$(comm -23 /tmp/ge-remote.txt /tmp/ge-local.txt)
    if [[ -z "$new" ]]; then
      echo "  ✅ All characters up to date!"
    else
      echo "  ⚠️  New characters found:"
      echo "$new" | sed 's/^/    /'
      echo "  Total: $(echo "$new" | wc -l | tr -d ' ') new"
    fi
    ;;

  # ── Tier ──
  set-tier)
    slug="${2:?Usage: ge-admin.sh set-tier <slug> <pve> <pvp> <bossing> <support> <farming> <versatility> [support_type] [notes]}"
    pve="${3:?missing pve score 0-10}"; pvp="${4:?missing pvp}"; bossing="${5:?missing bossing}"
    support="${6:?missing support}"; farming="${7:?missing farming}"; versatility="${8:?missing versatility}"
    support_type="${9:-}"; notes="${10:-}"
    echo "🎯 Setting tier for $slug: PVE=$pve PVP=$pvp Boss=$bossing Sup=$support Farm=$farming Ver=$versatility"
    curl -s -X POST "https://ge.makeloops.xyz/api/admin/tiers/$slug" \
      -H "Content-Type: application/json" \
      -d "{\"pve\":$pve,\"pvp\":$pvp,\"bossing\":$bossing,\"support\":$support,\"farming\":$farming,\"versatility\":$versatility,\"support_type\":$([ -n "$support_type" ] && echo "\"$support_type\"" || echo null),\"notes\":$([ -n "$notes" ] && echo "\"$notes\"" || echo null)}" | python3 -m json.tool
    ;;

  show-tiers)
    echo "📊 Character Tiers:"
    npx wrangler d1 execute $DB_NAME --remote --command \
      "SELECT character_slug, tier, pve, pvp, bossing, support, support_type, farming, versatility FROM character_tiers ORDER BY tier, character_slug;" \
      --json 2>/dev/null | python3 -c "
import sys,json
d=json.load(sys.stdin)
for r in d[0]['results']:
    st = f' ({r[\"support_type\"]})' if r['support_type'] else ''
    avg = (r['pve']+r['pvp']+r['bossing']+r['support']+r['farming']+r['versatility'])/6
    print(f'  [{r[\"tier\"]}] {r[\"character_slug\"]:20s} PVE={r[\"pve\"]} PVP={r[\"pvp\"]} Boss={r[\"bossing\"]} Sup={r[\"support\"]}{st} Farm={r[\"farming\"]} Ver={r[\"versatility\"]} avg={avg:.1f}')
if not d[0]['results']:
    print('  (no tiers set yet)')
"
    ;;

  # ── Verify ──
  verify)
    target="${2:-all}"
    echo "🔍 Verifying data accuracy..."

    if [[ "$target" == "all" || "$target" == "images" ]]; then
      echo ""
      echo "── Item Images (random sample) ──"
      npx wrangler d1 execute $DB_NAME --remote --command \
        "SELECT name, slug, image, category FROM items ORDER BY RANDOM() LIMIT 5" \
        --json 2>/dev/null | python3 -c "
import sys, json, subprocess
items = json.load(sys.stdin)[0]['results']
for item in items:
    img = item['image']
    url = f'https://ge.makeloops.xyz/img/items/{img}'
    r = subprocess.run(['curl', '-sS', '-o', '/dev/null', '-w', '%{http_code} %{size_download}', url],
                       capture_output=True, text=True, timeout=10)
    parts = r.stdout.strip().split()
    code, size = parts[0], int(parts[1]) if len(parts) > 1 else 0
    ok = '✅' if code == '200' and size > 100 else '❌'
    print(f'  {ok} {item[\"name\"]:35s} {img:35s} ({code}, {size:,}b)')
"
    fi

    if [[ "$target" == "all" || "$target" == "thai" ]]; then
      echo ""
      echo "── Thai Name Coverage ──"
      npx wrangler d1 execute $DB_NAME --remote --command \
        "SELECT 'characters' as t, COUNT(*) as total, SUM(CASE WHEN name_th IS NOT NULL THEN 1 ELSE 0 END) as has_th FROM characters
         UNION ALL SELECT 'items', COUNT(*), SUM(CASE WHEN name_th IS NOT NULL THEN 1 ELSE 0 END) FROM items
         UNION ALL SELECT 'maps', COUNT(*), SUM(CASE WHEN name_th IS NOT NULL THEN 1 ELSE 0 END) FROM maps
         UNION ALL SELECT 'monsters', COUNT(*), SUM(CASE WHEN name_th IS NOT NULL THEN 1 ELSE 0 END) FROM monsters
         UNION ALL SELECT 'raids', COUNT(*), SUM(CASE WHEN name_th IS NOT NULL THEN 1 ELSE 0 END) FROM raids" \
        --json 2>/dev/null | python3 -c "
import sys,json
for r in json.load(sys.stdin)[0]['results']:
    pct = round(r['has_th']*100/r['total']) if r['total'] > 0 else 0
    ok = '✅' if pct == 100 else '⚠️'
    print(f'  {ok} {r[\"t\"]:15s} {r[\"has_th\"]:5d}/{r[\"total\"]:5d} ({pct}%)')
"
    fi

    if [[ "$target" == "all" || "$target" == "preview" ]]; then
      echo ""
      echo "── Preview Videos (random sample) ──"
      npx wrangler d1 execute $DB_NAME --remote --command \
        "SELECT name, preview_video FROM characters WHERE preview_video IS NOT NULL ORDER BY RANDOM() LIMIT 5" \
        --json 2>/dev/null | python3 -c "
import sys, json, urllib.request
chars = json.load(sys.stdin)[0]['results']
for c in chars:
    vid = c['preview_video']
    url = f'https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v={vid}&format=json'
    try:
        resp = urllib.request.urlopen(url, timeout=5)
        title = json.loads(resp.read()).get('title', '?')
        name_lower = c['name'].replace(' [Character]','').lower()
        found = any(n in title.lower() for n in [name_lower] if len(n) > 2)
        ok = '✅' if found else '⚠️'
    except:
        title = '(error)'; ok = '❌'
    print(f'  {ok} {c[\"name\"]:25s} → {title[:60]}')
"
    fi
    ;;

  # ── Scrape ──
  scrape)
    target="${2:?Usage: ge-admin.sh scrape <items|images|all>}"
    case "$target" in
      items)
        echo "🔍 Scraping items..."
        node scripts/scrape-items.mjs
        ;;
      all)
        echo "🔍 Scraping items..."
        node scripts/scrape-items.mjs
        ;;
      *)
        echo "Unknown scrape target: $target (use: items, all)"
        exit 1
        ;;
    esac
    ;;

  # ── Info ──
  help|*)
    cat << 'EOF'
GE Database Thai — Admin CLI

Database:
  stats             Show table counts
  feedback [n]      Show recent feedback (default: 20)
  migrate <file>    Run a SQL migration (handles --command workaround)
  migrate all       Apply all migration files in sql/migrations/
  query "SQL..."    Execute raw SQL query

Verify:
  verify            Run all verification checks
  verify images     Spot-check item images load correctly
  verify thai       Check Thai name coverage
  verify preview    Spot-check preview video assignments

Scrape:
  scrape items      Re-scrape all items from ge-db.site

Tier:
  set-tier <slug> <pve> <pvp> <bossing> <support> <farming> <versatility> [support_type] [notes]
  show-tiers        Show all character tiers

Deploy:
  deploy            Deploy worker + assets to Cloudflare

Maintenance:
  check-new         Check ge-db.site for new characters

Examples:
  ./scripts/ge-admin.sh stats
  ./scripts/ge-admin.sh verify
  ./scripts/ge-admin.sh migrate sql/migrations/074_fix-images.sql
  ./scripts/ge-admin.sh migrate all
  ./scripts/ge-admin.sh scrape items
  ./scripts/ge-admin.sh check-new
EOF
    ;;
esac
