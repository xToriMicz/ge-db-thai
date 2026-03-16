# GE Database Thai — Roadmap

> ge.makeloops.xyz | Updated: 2026-03-13

## Current State (v1 — Day 1 Complete)

| Data | Records | Thai | Images | Status |
|------|---------|------|--------|--------|
| Characters | 292 | 292 name + 292 bio | Portrait sprites | Done |
| Stances | 1,295 | — | Stance icon sprites | Done |
| Skills | 4,700 | — | R2 lazy cache | Done |
| Items | 10,490 | 0 | R2 lazy cache | Done (no Thai) |
| Maps | 123 | 123 | — | Done |
| Monsters | 630 | 630 | — (no images on source) | Done |
| Raids | 130 | 130 | — (no images on source) | Done |
| Feedback | user-submitted | — | — | Done |

**Infrastructure**: Cloudflare Worker + D1 + R2 + Assets | PWA | SEO | Anti-spam

## Phase 2: Cross-linking & Search

### 2A. Global Search
- `GET /api/search?q=` — search across characters, items, maps, monsters, raids
- Frontend: unified search bar at top, results grouped by type
- Thai + English search in one query

### 2B. Item Detail Page
- `GET /api/items/:id` — single item with full stats
- Click item card → modal with stats, description, where to find
- Link items ↔ monsters (drop tables), items ↔ maps

### 2C. Monster Detail
- Click monster → modal with stats, drop items, map location
- Link monster → map (clickable)

### 2D. URL Deep Linking
- `/?tab=items&category=Sword` — shareable URLs
- `/?char=Fighter` — direct link to character
- Browser back/forward support

## Phase 3: Community & Content

### 3A. Enchantments & Recipes
- Scrape enchantment data from ge-db.site
- Recipe crafting trees

### 3B. Guides (User-Generated)
- Simple guide system: title + markdown body
- Community tips per character/map/raid

### 3C. Item Comparison
- Select 2-3 weapons/armors to compare side by side
- Stat diff highlighting

## Phase 4: Thai Content Depth

### 4A. Item Thai Names
- 10,490 items — most are proper nouns
- Strategy: translate category/type labels first, then common items
- Low priority: most players know English item names

### 4B. Skill Descriptions
- Scrape skill descriptions + stats (damage, cooldown, range)
- Thai translation of skill effects

### 4C. Map Guides (Thai)
- เขียน guide แนะนำแผนที่ เช่น "แผนที่เหมาะฟาร์ม Lv.50-70"
- Monster spawn rates, recommended parties

## Phase 5: Performance & Polish

### 5A. Image Optimization
- Convert item/skill images to WebP
- Generate thumbnails for grid view
- Preload critical images

### 5B. Offline Mode
- Cache character/map/monster data for offline browsing
- SW smart prefetch: cache next page of items

### 5C. Analytics
- Simple view counter per character/item (D1)
- Popular searches log
- Use data to prioritize Thai translations

## Migration Log

| # | File | Description |
|---|------|-------------|
| 001 | seed-characters | 274 characters initial |
| 002-003 | thai-names | Thai name translations |
| 004 | thai-names-combined | Combined Thai names |
| 005 | bio-thai | Thai bios |
| 006 | portrait-sheet | Portrait sprite mapping |
| 007 | andromida-18-chars | 18 new characters |
| 008 | andromida-names-th | Thai names for 18 |
| 009-010 | maps | Schema + 123 maps |
| 011-012 | monsters | Schema + 630 monsters |
| 013-014 | items | Schema + 10,583 items |
| 015 | thai-maps | 123 Thai map names |
| 016 | thai-monsters | Thai monster names |
| 017-018 | raids | Schema + 130 raids |
| 019 | cleanup-junk-items | Remove placeholder items |
| 020 | item-images | Item image filenames |
| 021-022 | skills | Schema + 4,700 skills |
| 023 | thai-raids | 130 Thai raid names |
| 024 | thai-bios-missing | 18 missing Thai bios |

## Principles

1. **One migration per change** — never modify old migrations
2. **Scrape → SQL → Review → Import** — always generate SQL files
3. **Thai translation separate** — data first, translation second
4. **Images always** — ดึงข้อมูลอะไร ต้องดึงรูปมาด้วย (R2 lazy cache)
5. **Self-hosted** — ไม่ hotlink, cache ผ่าน R2 เพื่อความยั่งยืน
