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
    file="${2:?Usage: ge-admin.sh migrate <file.sql>}"
    echo "🔄 Running migration: $file"
    npx wrangler d1 execute $DB_NAME --remote --file="$file"
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

  # ── Info ──
  help|*)
    cat << 'EOF'
GE Database Thai — Admin CLI

Database:
  stats             Show character/stance/feedback counts
  feedback [n]      Show recent feedback (default: 20)
  migrate <file>    Run a SQL migration file
  query "SQL..."    Execute raw SQL query

Tier:
  set-tier <slug> <pve> <pvp> <bossing> <support> <farming> <versatility> [support_type] [notes]
  show-tiers        Show all character tiers

Deploy:
  deploy            Deploy worker + assets to Cloudflare

Maintenance:
  check-new         Check ge-db.site for new characters we don't have

Examples:
  ./scripts/ge-admin.sh stats
  ./scripts/ge-admin.sh feedback 5
  ./scripts/ge-admin.sh check-new
  ./scripts/ge-admin.sh set-tier Emilia 8 3 7 9 6 5 heal "Best healer in game"
  ./scripts/ge-admin.sh show-tiers
  ./scripts/ge-admin.sh query "SELECT slug, name_th FROM characters WHERE name_th IS NULL"
  ./scripts/ge-admin.sh migrate sql/migrations/009_new-feature.sql
EOF
    ;;
esac
