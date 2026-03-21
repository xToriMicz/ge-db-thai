// GE Database Thai — Frontend App
// Loads data from /api/ endpoints, renders character grid + detail modal

const WEAPON_NAMES = {
  sword: "Sword", dag: "Dagger", blunt: "Blunt", staff: "Staff", rod: "Rod",
  rifle: "Rifle", pistol: "Pistol", cannon: "Cannon", xbow: "Crossbow",
  shotgun: "Shotgun", gs: "Great Sword", pole: "Polearm", rap: "Rapier",
  sabre: "Sabre", shield: "Shield", knuckle: "Knuckle", tonfa: "Tonfa",
  jav: "Javelin", crescent: "Crescent", ibr: "Heavy Rifle", leg: "Leg-Guards",
  mg: "Main-Gauche", firebrac: "Fire Bracelet", icebrac: "Ice Bracelet",
  lightbrac: "Lightning Bracelet", elebrac: "Elemental Bracelet",
  magscroll: "Magic Scroll", cube: "Cube", rosario: "Rosario",
  lute: "Lute", hammer: "Hammer", pendant: "Pendant",
  armshield: "Arm Shield", controller: "Controller", instrument: "Instrument",
  tool: "Tool", book: "Book", bracelet: "Bracelet",
};

const ARMOR_NAMES = { coat: "Coat", leather: "Leather", metal: "Metal", robe: "Robe" };

const TYPE_LABELS = {
  basic: "Basic", recruit: "Recruit", cash: "Cash", accomplish: "Special",
};

let allCharacters = [];
let allMaps = [];
let allMonsters = [];
let allRaids = [];
let itemCategories = [];
let charRatings = {};
let charTiers = {};
let currentTab = "characters";
let itemPage = 1;
let itemTotal = 0;
let suppressPush = false; // prevent pushState during popstate handling
let compareList = []; // items selected for comparison (max 3)

// ── Init ──
async function init() {
  try {
    const [statsRes, charsRes, ratingsRes, tiersRes] = await Promise.all([
      fetch("/api/stats"),
      fetch("/api/characters"),
      fetch("/api/ratings"),
      fetch("/api/tiers"),
    ]);
    const stats = await statsRes.json();
    const data = await charsRes.json();
    const ratingsData = await ratingsRes.json();
    const tiersData = await tiersRes.json();
    allCharacters = data.characters;
    charRatings = ratingsData.ratings || {};
    charTiers = tiersData.tiers || {};

    // Update stats bar
    document.getElementById("stat-chars").textContent = stats.characters;
    document.getElementById("stat-stances").textContent = stats.stances.toLocaleString();
    if (stats.skills) document.getElementById("stat-skills").textContent = stats.skills.toLocaleString();
    if (stats.items) document.getElementById("stat-items").textContent = stats.items.toLocaleString();
    if (stats.raids) document.getElementById("stat-raids").textContent = stats.raids;
    if (stats.maps) document.getElementById("stat-maps").textContent = stats.maps;
    if (stats.monsters) document.getElementById("stat-monsters").textContent = stats.monsters;
    if (stats.bosses) document.getElementById("stat-bosses").textContent = stats.bosses;
    for (const t of stats.types) {
      const el = document.getElementById(`stat-${t.type}`);
      if (el) el.textContent = t.count;
    }

    // Default sort: newest first
    allCharacters.sort((a, b) => (b.id || 0) - (a.id || 0));
    renderGrid(allCharacters);
    setupFilters();
    setupTabs();

    setupGlobalSearch();

    // Deep link: restore full URL state
    suppressPush = true;
    const params = new URLSearchParams(location.search);
    const tabParam = params.get("tab");
    if (tabParam && tabParam !== "characters") switchTab(tabParam);

    const charParam = params.get("char");
    if (charParam) showDetail(charParam);
    const mapParam = params.get("map");
    if (mapParam) { if (!tabParam) switchTab("maps"); showMapDetail(mapParam); }
    const itemParam = params.get("item");
    if (itemParam) { if (!tabParam) switchTab("items"); showItemDetail(itemParam); }
    const monsterParam = params.get("monster");
    if (monsterParam) { if (!tabParam) switchTab("monsters"); showMonsterDetail(monsterParam); }
    const questParam = params.get("quest");
    if (questParam) { if (!tabParam) switchTab("quests"); setTimeout(() => showQuestDetail(questParam), 300); }
    const newsParam = params.get("news");
    if (newsParam) { if (!tabParam) switchTab("news"); setTimeout(() => showNewsDetail(newsParam), 300); }
    // Also support generic ?id= with tab context
    const idParam = params.get("id");
    if (idParam && tabParam === "news") { setTimeout(() => showNewsDetail(idParam), 300); }
    if (idParam && tabParam === "quests") { setTimeout(() => showQuestDetail(idParam), 300); }
    const qParam = params.get("q");
    if (qParam) {
      const gs = document.getElementById("global-search");
      gs.value = qParam;
      gs.dispatchEvent(new Event("input"));
    }
    // Set initial history state
    replaceUrl(Object.fromEntries(params));
    suppressPush = false;
  } catch (err) {
    document.getElementById("character-grid").innerHTML =
      `<div class="loading">โหลดข้อมูลไม่สำเร็จ — ${err.message}</div>`;
  }
}

// ── Tabs ──
function switchTab(tab) {
  document.querySelectorAll(".tab").forEach(b => {
    b.classList.toggle("active", b.dataset.tab === tab);
  });
  currentTab = tab;

  document.getElementById("filters").classList.toggle("hidden", tab !== "characters");
  document.getElementById("main").classList.toggle("hidden", tab !== "characters");
  document.getElementById("items-section").classList.toggle("hidden", tab !== "items");
  document.getElementById("maps-section").classList.toggle("hidden", tab !== "maps");
  document.getElementById("monsters-section").classList.toggle("hidden", tab !== "monsters");
  document.getElementById("raids-section").classList.toggle("hidden", tab !== "raids");
  document.getElementById("quests-section").classList.toggle("hidden", tab !== "quests");
  document.getElementById("news-section").classList.toggle("hidden", tab !== "news");

  if (tab === "items" && itemCategories.length === 0) loadItems();
  if (tab === "maps" && allMaps.length === 0) loadMaps();
  if (tab === "monsters" && allMonsters.length === 0) loadMonsters();
  if (tab === "raids" && allRaids.length === 0) loadRaids();
  if (tab === "quests" && !questsLoaded) loadQuests();
  if (tab === "news" && !newsLoaded) loadNews();

  // Update URL with tab (only when no modal is open)
  const modal = document.getElementById("modal");
  if (modal.classList.contains("hidden")) {
    pushUrl({ tab: tab !== "characters" ? tab : "" });
  }
}

function setupTabs() {
  document.querySelectorAll(".tab").forEach(btn => {
    btn.addEventListener("click", () => switchTab(btn.dataset.tab));
  });
}

// ── Maps ──
async function loadMaps() {
  const grid = document.getElementById("map-grid");
  grid.innerHTML = '<div class="loading">กำลังโหลดแผนที่...</div>';
  try {
    const res = await fetch("/api/maps");
    const data = await res.json();
    allMaps = data.maps;
    renderMapGrid(allMaps);
    setupMapFilters();
  } catch (err) {
    grid.innerHTML = `<div class="loading">โหลดไม่สำเร็จ — ${err.message}</div>`;
  }
}

const MAP_TYPE_CLASS = { "Field": "field", "City": "city", "Mission": "mission", "PK Disabled": "pk" };

function renderMapGrid(maps) {
  const grid = document.getElementById("map-grid");
  document.getElementById("map-result-count").textContent = maps.length;

  if (maps.length === 0) {
    grid.innerHTML = '<div class="loading">ไม่พบแผนที่ที่ตรงกัน</div>';
    return;
  }

  grid.innerHTML = maps.map(m => `
    <div class="map-card" onclick="showMapDetail('${m.slug}')">
      <div>
        <div class="map-name">${m.name}</div>
        ${m.name_th ? `<div class="map-name-th">${m.name_th}</div>` : ''}
      </div>
      <div class="map-meta">
        ${m.level_range ? `<span class="map-level">Lv.${m.level_range}</span>` : ''}
        <span class="map-type-tag map-type-${MAP_TYPE_CLASS[m.map_type] || 'field'}">${m.map_type}</span>
      </div>
    </div>
  `).join("");
}

function setupMapFilters() {
  const search = document.getElementById("map-search");
  const filterType = document.getElementById("filter-map-type");

  let debounceTimer;
  const apply = () => {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => {
      const q = search.value.toLowerCase().trim();
      const type = filterType.value;
      const filtered = allMaps.filter(m => {
        if (type !== "all" && m.map_type !== type) return false;
        if (q && !m.name.toLowerCase().includes(q) && !(m.name_th || "").includes(q)) return false;
        return true;
      });
      renderMapGrid(filtered);
    }, 150);
  };

  search.addEventListener("input", apply);
  filterType.addEventListener("change", apply);
}

async function showMapDetail(slug) {
  const modal = document.getElementById("modal");
  const body = document.getElementById("modal-body");
  modal.classList.remove("hidden");
  pushUrl({ map: slug });
  modal._openedAt = Date.now();
  body.innerHTML = '<div class="loading">กำลังโหลด...</div>';

  try {
    const res = await fetch(`/api/maps/${slug}`);
    const m = await res.json();

    body.innerHTML = `
      <div style="margin-bottom:16px">
        <h2 style="font-size:1.3rem">${m.name}</h2>
        ${m.name_th ? `<div style="color:var(--text-secondary);font-size:0.9rem">${m.name_th}</div>` : ''}
        <div style="margin-top:8px;display:flex;gap:8px">
          ${m.level_range ? `<span class="map-level">Lv.${m.level_range}</span>` : ''}
          <span class="map-type-tag map-type-${MAP_TYPE_CLASS[m.map_type] || 'field'}">${m.map_type}</span>
        </div>
      </div>

      ${m.drops && m.drops.length > 0 ? `
        <div class="detail-section">
          <h3>ดรอปไอเทม (${m.drops.length})</h3>
          <div class="drop-grid">
            ${m.drops.map(d => `<span class="drop-tag${d.item_slug ? ' clickable' : ''}" ${d.item_slug ? `onclick="navigateToItem('${d.item_slug}')" title="ดูไอเทม"` : ''}>${d.item_name}</span>`).join("")}
          </div>
        </div>
      ` : ''}

      ${m.monsters && m.monsters.length > 0 ? `
        <div class="detail-section">
          <h3>มอนสเตอร์ในแผนที่ (${m.monsters.length})</h3>
          <div class="map-mob-list">
            ${m.monsters.map(mon => `
              <div class="map-mob-item${mon.is_boss ? ' boss' : ''}" title="ค้นหามอนสเตอร์นี้" onclick="searchMonster('${(mon.name_th || mon.name).replace(/'/g, "\\'")}')">
                <span class="map-mob-name">${mon.name_th || mon.name}${mon.is_boss ? ' <span class="boss-badge">BOSS</span>' : ''}</span>
                <span class="map-mob-meta">Lv.${mon.level} · ${mon.race}</span>
              </div>
            `).join("")}
          </div>
        </div>
      ` : ''}

      ${m.connections && m.connections.length > 0 ? `
        <div class="detail-section">
          <h3>แผนที่เชื่อมต่อ (${m.connections.length})</h3>
          <div class="conn-list">
            ${m.connections.map(c => `<span class="conn-tag" onclick="showMapDetail('${c.to_map_slug}')">${c.to_map_name || c.to_map_slug}${c.level_range ? ` (Lv.${c.level_range})` : ''}</span>`).join("")}
          </div>
        </div>
      ` : ''}

      <div class="detail-section">
        <h3>แจ้งแก้ไขข้อมูล</h3>
        <div class="feedback-form">
          <textarea id="feedback-msg" placeholder="เช่น ชื่อไทยไม่ถูก, ข้อมูลผิด..." maxlength="500" style="width:100%;padding:8px 12px;background:var(--bg-primary);border:1px solid var(--border);border-radius:var(--radius);color:var(--text-primary);font-family:inherit;font-size:0.85rem;resize:vertical;min-height:60px;outline:none"></textarea>
          <input id="feedback-hp" type="text" name="website" autocomplete="off" tabindex="-1" style="position:absolute;left:-9999px;opacity:0;height:0">
          <div style="display:flex;justify-content:space-between;align-items:center;margin-top:8px">
            <span id="feedback-status" style="font-size:0.75rem;color:var(--text-muted)"></span>
            <button onclick="submitFeedback('map:${m.slug}')" style="padding:6px 16px;background:var(--accent);color:#000;border:none;border-radius:var(--radius);font-size:0.8rem;font-weight:600;cursor:pointer;font-family:inherit">ส่ง</button>
          </div>
        </div>
      </div>
    `;
  } catch (err) {
    body.innerHTML = `<div class="loading">โหลดไม่สำเร็จ: ${err.message}</div>`;
  }
}

// ── Render Character Grid ──
function renderGrid(characters) {
  const grid = document.getElementById("character-grid");
  document.getElementById("result-count").textContent = characters.length;

  if (characters.length === 0) {
    grid.innerHTML = '<div class="loading">ไม่พบตัวละครที่ตรงกัน</div>';
    return;
  }

  grid.innerHTML = characters.map(c => {
    const weapons = JSON.parse(c.weapons || "[]");
    const armors = JSON.parse(c.armor_types || "[]");
    const weaponText = weapons.slice(0, 3).map(w => WEAPON_NAMES[w] || w).join(", ");
    const moreWeapons = weapons.length > 3 ? ` +${weapons.length - 3}` : "";

    const spriteVar = c.portrait_sheet === 2 ? 'var(--sprite-url-2)' : 'var(--sprite-url)';
    return `
      <div class="char-card" data-slug="${c.slug}" onclick="showDetail('${c.slug}')">
        ${c.on_thai === 0 ? '<span class="server-badge badge-no-thai">ไม่มีในไทย</span>' : c.server_origin === 'unofficial' ? '<span class="server-badge badge-unofficial">Unofficial</span>' : ''}
        <div class="portrait-wrap">
          <div class="portrait" style="background-image:${spriteVar};transform: translate(${c.portrait_x}px, ${c.portrait_y}px)"></div>
        </div>
        <div class="char-name">${c.display_name}</div>
        ${c.name_th ? `<div class="char-name-th">${c.name_th}</div>` : ''}
        <span class="char-type type-${c.type}">${TYPE_LABELS[c.type] || c.type}</span>
        ${charTiers[c.slug] ? `<span class="tier-badge tier-${charTiers[c.slug].tier.toLowerCase()}">${charTiers[c.slug].tier}</span>` : ''}
        ${charRatings[c.slug] ? `<div class="card-rating"><span class="card-stars">${'★'.repeat(Math.round(charRatings[c.slug].avg))}${'☆'.repeat(5-Math.round(charRatings[c.slug].avg))}</span> <span class="card-rating-num">${charRatings[c.slug].avg}</span></div>` : ''}
        <div class="char-weapons">${weaponText}${moreWeapons}</div>
      </div>
    `;
  }).join("");
}

// ── Filters ──
function setupFilters() {
  const search = document.getElementById("search");
  const filterType = document.getElementById("filter-type");
  const filterArmor = document.getElementById("filter-armor");
  const filterWeapon = document.getElementById("filter-weapon");
  const filterServer = document.getElementById("filter-server");
  const sortBy = document.getElementById("sort-by");

  const TYPE_ORDER = { basic: 0, recruit: 1, cash: 2 };

  let debounceTimer;
  const applyFilters = () => {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => {
      const q = search.value.toLowerCase().trim();
      const type = filterType.value;
      const armor = filterArmor.value;
      const weapon = filterWeapon.value;
      const server = filterServer.value;
      const sort = sortBy.value;

      const filtered = allCharacters.filter(c => {
        if (type !== "all" && c.type !== type) return false;
        if (armor !== "all" && !(c.armor_types || "").includes(armor)) return false;
        if (weapon !== "all" && !(c.weapons || "").includes(weapon)) return false;
        if (server === "thai" && c.on_thai === 0) return false;
        if (server === "official" && c.server_origin !== "official") return false;
        if (server === "unofficial" && c.server_origin !== "unofficial") return false;
        if (q && !c.display_name.toLowerCase().includes(q) &&
            !c.name.toLowerCase().includes(q) &&
            !(c.name_th || "").includes(q)) return false;
        return true;
      });

      // Sort
      filtered.sort((a, b) => {
        switch (sort) {
          case "newest": return (b.id || 0) - (a.id || 0);
          case "name-asc": return a.display_name.localeCompare(b.display_name);
          case "name-desc": return b.display_name.localeCompare(a.display_name);
          case "type": return (TYPE_ORDER[a.type] ?? 9) - (TYPE_ORDER[b.type] ?? 9) || a.display_name.localeCompare(b.display_name);
          case "rating": {
            const ra = charRatings[a.slug], rb = charRatings[b.slug];
            const avgA = ra ? ra.avg : 0, avgB = rb ? rb.avg : 0;
            if (avgB !== avgA) return avgB - avgA;
            const cntA = ra ? ra.count : 0, cntB = rb ? rb.count : 0;
            return cntB - cntA;
          }
          case "tier": {
            const TIER_ORDER = { SS: 0, S: 1, A: 2, B: 3, C: 4, D: 5 };
            const ta = charTiers[a.slug], tb = charTiers[b.slug];
            const oa = ta ? (TIER_ORDER[ta.tier] ?? 6) : 7;
            const ob = tb ? (TIER_ORDER[tb.tier] ?? 6) : 7;
            if (oa !== ob) return oa - ob;
            const avgA = ta ? (ta.pve+ta.pvp+ta.bossing+ta.support+ta.farming+ta.versatility)/6 : 0;
            const avgB = tb ? (tb.pve+tb.pvp+tb.bossing+tb.support+tb.farming+tb.versatility)/6 : 0;
            return avgB - avgA;
          }
          default: return 0;
        }
      });

      renderGrid(filtered);
    }, 150);
  };

  search.addEventListener("input", applyFilters);
  filterType.addEventListener("change", applyFilters);
  filterArmor.addEventListener("change", applyFilters);
  filterWeapon.addEventListener("change", applyFilters);
  filterServer.addEventListener("change", applyFilters);
  sortBy.addEventListener("change", applyFilters);
}

// ── Character Detail Modal ──
async function showDetail(slug) {
  const modal = document.getElementById("modal");
  const body = document.getElementById("modal-body");
  modal.classList.remove("hidden");

  pushUrl({ char: slug });

  modal._openedAt = Date.now();
  body.innerHTML = '<div class="loading">กำลังโหลด...</div>';

  try {
    const res = await fetch(`/api/characters/${slug}`);
    const c = await res.json();

    const weapons = JSON.parse(c.weapons || "[]");
    const armors = JSON.parse(c.armor_types || "[]");
    const stances = c.stances || [];

    const statLabels = { str: "STR", agi: "AGI", hp: "CON", dex: "DEX", int_stat: "INT", sen: "SEN" };

    const detailSprite = c.portrait_sheet === 2 ? 'var(--sprite-url-2)' : 'var(--sprite-url)';
    body.innerHTML = `
      <div class="detail-header">
        <div class="detail-portrait">
          <div class="portrait" style="background-image:${detailSprite};transform: translate(${c.portrait_x}px, ${c.portrait_y}px)"></div>
        </div>
        <div class="detail-info">
          <h2>${c.display_name}</h2>
          ${c.name_th ? `<div style="color:var(--text-secondary);font-size:0.9rem">${c.name_th}</div>` : ''}
          <span class="char-type type-${c.type}">${TYPE_LABELS[c.type] || c.type}</span>
          ${c.bio_th ? `<p class="bio">${c.bio_th}</p>` : c.bio ? `<p class="bio">${c.bio}</p>` : ''}
        </div>
      </div>

      <div class="detail-section">
        <h3>สถิติ (Stats)</h3>
        <div class="stats-grid">
          ${Object.entries(statLabels).map(([key, label]) => `
            <div class="stat-item">
              <div class="stat-label">${label}</div>
              <div class="stat-value">${c[key] || 0}</div>
            </div>
          `).join("")}
        </div>
      </div>

      ${c.tier_data ? `
      <div class="detail-section">
        <h3>Tier Rating</h3>
        <div class="tier-detail">
          <div class="tier-overall">
            <span class="tier-badge-lg tier-${c.tier_data.tier.toLowerCase()}">${c.tier_data.tier}</span>
            <span class="tier-avg">${((c.tier_data.pve+c.tier_data.pvp+c.tier_data.bossing+c.tier_data.support+c.tier_data.farming+c.tier_data.versatility)/6).toFixed(1)}/10</span>
          </div>
          <div class="tier-bars">
            ${[
              {key:'pve',label:'PVE',val:c.tier_data.pve},
              {key:'pvp',label:'PVP',val:c.tier_data.pvp},
              {key:'bossing',label:'Bossing',val:c.tier_data.bossing},
              {key:'support',label:c.tier_data.support_type==='heal'?'Support (Heal)':c.tier_data.support_type==='buff'?'Support (Buff)':c.tier_data.support_type==='both'?'Support (Heal+Buff)':'Support',val:c.tier_data.support},
              {key:'farming',label:'Farming',val:c.tier_data.farming},
              {key:'versatility',label:'Versatility',val:c.tier_data.versatility},
            ].map(r => `
              <div class="tier-bar-row">
                <span class="tier-bar-label">${r.label}</span>
                <div class="tier-bar-track"><div class="tier-bar-fill" style="width:${r.val*10}%"></div></div>
                <span class="tier-bar-val">${r.val}</span>
              </div>
            `).join('')}
          </div>
          ${c.tier_data.notes ? `<div class="tier-notes">${c.tier_data.notes}</div>` : ''}
        </div>
      </div>
      ` : ''}

      <div class="detail-section">
        <h3>เกราะ & อาวุธ</h3>
        <div class="equip-row">
          ${armors.map(a => `<span class="equip-tag">${ARMOR_NAMES[a] || a}</span>`).join("")}
          ${weapons.map(w => `<span class="equip-tag">${WEAPON_NAMES[w] || w}</span>`).join("")}
        </div>
        ${c.starting_armor ? `<div style="font-size:0.8rem;color:var(--text-muted);margin-top:4px">เริ่มต้น: ${c.starting_armor}, ${c.starting_weapon}</div>` : ''}
      </div>

      ${c.preview_video ? `
      <div class="detail-section">
        <h3>Skill Preview</h3>
        <div class="video-embed">
          <iframe src="https://www.youtube.com/embed/${c.preview_video}" loading="lazy" allowfullscreen
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            title="${c.display_name} Skill Motion"></iframe>
        </div>
        <div class="video-credit">Video by <a href="https://www.youtube.com/@fatsnake" target="_blank" rel="noopener">fatsnake</a></div>
      </div>
      ` : ''}

      ${c.character_buff ? `
      <div class="detail-section">
        <h3>บัพติดตัว (Character Buff)</h3>
        <div class="buff-card">
          <div class="buff-header">
            ${c.character_buff.image ? `<img class="buff-icon" src="/img/skills/${c.character_buff.image}" loading="lazy" onerror="this.style.display='none'">` : ''}
            <div class="buff-title">
              <div class="buff-name">${c.character_buff.name}</div>
              ${c.character_buff.description ? `<div class="buff-desc">${c.character_buff.description}</div>` : ''}
            </div>
          </div>
          <div class="buff-info-row">
            ${c.character_buff.sp_cost ? `<span class="si-tag si-sp">SP ${c.character_buff.sp_cost}</span>` : ''}
            ${c.character_buff.cooldown ? `<span class="si-tag si-cd">CD ${c.character_buff.cooldown}</span>` : ''}
            ${c.character_buff.casting_time ? `<span class="si-tag">Cast ${c.character_buff.casting_time}</span>` : ''}
            ${c.character_buff.duration ? `<span class="si-tag">Dur. ${c.character_buff.duration}</span>` : ''}
            ${c.character_buff.target ? `<span class="si-tag si-type">${c.character_buff.target}</span>` : ''}
          </div>
          ${c.character_buff.consume_item ? `<div class="buff-consume">ใช้: ${c.character_buff.consume_item}</div>` : ''}
          ${c.character_buff.levels && c.character_buff.levels.length > 0 ? (() => {
            const base = c.character_buff.levels.filter(l => { const n = parseInt(l.level.replace(/\D/g,'')); return n >= 10 && n <= 10; });
            const ring = c.character_buff.levels.filter(l => { const n = parseInt(l.level.replace(/\D/g,'')); return n > 10; });
            return `
            <div class="buff-levels">
              ${base.map(l => `
                <div class="buff-level-block">
                  <div class="buff-level-name">${l.level}</div>
                  <div class="buff-level-effects">${l.effects.map(e => `<div class="buff-effect">${e}</div>`).join("")}</div>
                </div>
              `).join("")}
            </div>
            ${ring.length > 0 ? `
            <div class="buff-levels buff-ring-section">
              <div class="sl-ring-label" style="margin-bottom:4px">💍 แหวนตัวละคร</div>
              ${ring.map(l => `
                <div class="buff-level-block buff-ring-block">
                  <div class="buff-level-name">${l.level}</div>
                  <div class="buff-level-effects">${l.effects.map(e => `<div class="buff-effect">${e}</div>`).join("")}</div>
                </div>
              `).join("")}
            </div>
            ` : ''}`;
          })() : ''}
        </div>
      </div>
      ` : ''}

      <div class="detail-section">
        <h3>สแตนซ์ (${stances.length})</h3>
        ${stances.length === 0 ? '<span style="color:var(--text-muted)">ไม่มีข้อมูล</span>' : stances.map(s => `
          <div class="stance-block">
            <div class="stance-header" onclick="this.parentElement.classList.toggle('open')">
              <div class="stance-tag">${s.name}${s.name_th ? ` <span style="color:var(--text-secondary);font-size:0.8rem">${s.name_th}</span>` : ''}</div>
              <div class="stance-meta">
                ${s.equipped_items ? `<span class="stance-equip">${s.equipped_items}</span>` : ''}
                ${s.stats?.bonus_atk ? `<span class="stance-stat">ATK ${s.stats.bonus_atk}</span>` : ''}
                ${s.info?.range ? `<span class="stance-stat">${s.info.range}</span>` : ''}
                <span class="stance-arrow">▸</span>
              </div>
            </div>
            <div class="stance-detail">
              ${s.stats?.bonus_atk ? `
                <div class="stance-stats-grid">
                  ${s.stats.aspd ? `<div class="ss-item"><span class="ss-label">ASPD</span><span class="ss-val">${s.stats.aspd}</span></div>` : ''}
                  ${s.stats.bonus_atk ? `<div class="ss-item"><span class="ss-label">ATK</span><span class="ss-val">${s.stats.bonus_atk}</span></div>` : ''}
                  ${s.info?.hits_per_attack ? `<div class="ss-item"><span class="ss-label">Hits</span><span class="ss-val">${s.info.hits_per_attack}</span></div>` : ''}
                  ${s.stats.acc ? `<div class="ss-item"><span class="ss-label">ACC</span><span class="ss-val">${s.stats.acc}</span></div>` : ''}
                  ${s.stats.eva && s.stats.eva !== '0' ? `<div class="ss-item"><span class="ss-label">EVA</span><span class="ss-val">${s.stats.eva}</span></div>` : ''}
                  ${s.stats.blk && s.stats.blk !== '0' ? `<div class="ss-item"><span class="ss-label">BLK</span><span class="ss-val">${s.stats.blk}</span></div>` : ''}
                  ${s.stats.mspd_limit ? `<div class="ss-item"><span class="ss-label">MSPD</span><span class="ss-val">${s.stats.mspd_limit}</span></div>` : ''}
                </div>
              ` : ''}
              ${Object.keys(s.lv25_bonus || {}).length > 0 ? `
                <div class="lv25-bonus">
                  <span class="lv25-label">Lv.25</span>
                  ${Object.entries(s.lv25_bonus).map(([k,v]) => `<span class="lv25-item">${k}: ${v}</span>`).join("")}
                </div>
              ` : ''}
              ${s.skills && s.skills.length > 0 ? `
                <div class="skill-list-full">
                  ${s.skills.map(sk => `
                    <div class="skill-card">
                      <div class="skill-header">
                        ${sk.skill_image ? `<img class="skill-icon" src="/img/skills/${sk.skill_image}" loading="lazy" onerror="this.style.display='none'">` : ''}
                        <div class="skill-title">
                          <div class="skill-name">${sk.skill_name}</div>
                          ${sk.description ? `<div class="skill-desc">${sk.description}</div>` : ''}
                        </div>
                      </div>
                      <div class="skill-info-row">
                        ${sk.sp_cost ? `<span class="si-tag si-sp">SP ${sk.sp_cost}</span>` : ''}
                        ${sk.cooldown && sk.cooldown !== '0 sec.' ? `<span class="si-tag si-cd">CD ${sk.cooldown}</span>` : ''}
                        ${sk.casting_time ? `<span class="si-tag">Cast ${sk.casting_time}</span>` : ''}
                        ${sk.skill_type ? `<span class="si-tag si-type">${sk.skill_type}</span>` : ''}
                        ${sk.target ? `<span class="si-tag">${sk.target}</span>` : ''}
                      </div>
                      ${sk.levels && sk.levels.length > 0 ? (() => {
                        const base = sk.levels.filter(l => { const n = parseInt(l.level.replace(/\D/g,'')); return n <= 10; });
                        const ring = sk.levels.filter(l => { const n = parseInt(l.level.replace(/\D/g,'')); return n > 10; });
                        return `
                        <div class="skill-levels">
                          ${base.map(l => `<span class="sl-item">${l.level}: ${l.value}</span>`).join("")}
                        </div>
                        ${ring.length > 0 ? `
                        <div class="skill-ring-levels">
                          <span class="sl-ring-label">💍 แหวนตัวละคร</span>
                          ${ring.map(l => `<span class="sl-item sl-ring">${l.level}: ${l.value}</span>`).join("")}
                        </div>
                        ` : ''}`;
                      })() : ''}
                    </div>
                  `).join("")}
                </div>
              ` : ''}
            </div>
          </div>
        `).join("")}
      </div>

      <div class="detail-section">
        <h3>ให้คะแนน</h3>
        <div class="multi-rating" id="multi-rating">
          ${[
            {cat:'overall',label:'รวม (Overall)'},
            {cat:'pve',label:'PVE'},
            {cat:'pvp',label:'PVP'},
            {cat:'bossing',label:'Bossing'},
            {cat:'support',label:'Support'},
            {cat:'farming',label:'Farming'},
            {cat:'versatility',label:'Versatility'},
          ].map(r => `
            <div class="rating-cat-row">
              <span class="rating-cat-label">${r.label}</span>
              <div class="star-rating" id="stars-${r.cat}" data-cat="${r.cat}">
                ${[1,2,3,4,5].map(n => `<span class="star" data-val="${n}" onclick="rateChar('${c.slug}','${r.cat}',${n})">★</span>`).join("")}
              </div>
              <span class="rating-cat-info" id="info-${r.cat}">—</span>
            </div>
          `).join('')}
        </div>
      </div>

      <div class="detail-section">
        <h3>แชร์</h3>
        <div class="share-row">
          <button class="share-btn" onclick="shareChar('${c.slug}','${(c.display_name || '').replace(/'/g, "\\'")}','copy')">📋 คัดลอกลิงก์</button>
          <button class="share-btn" onclick="shareChar('${c.slug}','${(c.display_name || '').replace(/'/g, "\\'")}','fb')">Facebook</button>
          <button class="share-btn" onclick="shareChar('${c.slug}','${(c.display_name || '').replace(/'/g, "\\'")}','x')">𝕏</button>
        </div>
      </div>

      <div class="detail-section">
        <h3>คอมเมนต์</h3>
        <div class="comment-form">
          <div style="display:flex;gap:8px;margin-bottom:6px">
            <input id="comment-nick" type="text" placeholder="ชื่อ (ไม่ระบุ = นักผจญภัย)" maxlength="30" style="flex:1;padding:6px 10px;background:var(--bg-primary);border:1px solid var(--border);border-radius:var(--radius);color:var(--text-primary);font-family:inherit;font-size:0.8rem;outline:none">
          </div>
          <textarea id="comment-msg" placeholder="แสดงความคิดเห็นเกี่ยวกับตัวละครนี้..." maxlength="300" style="width:100%;padding:8px 10px;background:var(--bg-primary);border:1px solid var(--border);border-radius:var(--radius);color:var(--text-primary);font-family:inherit;font-size:0.8rem;resize:vertical;min-height:50px;outline:none"></textarea>
          <input id="comment-hp" type="text" name="website" autocomplete="off" tabindex="-1" style="position:absolute;left:-9999px;opacity:0;height:0">
          <div style="display:flex;justify-content:space-between;align-items:center;margin-top:6px">
            <span id="comment-status" style="font-size:0.7rem;color:var(--text-muted)"></span>
            <button onclick="submitComment('${c.slug}')" class="comment-submit-btn">ส่งคอมเมนต์</button>
          </div>
        </div>
        <div id="comments-list" class="comments-list">กำลังโหลดคอมเมนต์...</div>
      </div>

      <div class="detail-section">
        <h3>แจ้งแก้ไขข้อมูล</h3>
        <div class="feedback-form" id="feedback-form">
          <textarea id="feedback-msg" placeholder="เช่น ชื่อไทยไม่ถูก, ข้อมูลผิด, แปลไม่ตรง..." maxlength="500" style="width:100%;padding:8px 12px;background:var(--bg-primary);border:1px solid var(--border);border-radius:var(--radius);color:var(--text-primary);font-family:inherit;font-size:0.85rem;resize:vertical;min-height:60px;outline:none"></textarea>
          <input id="feedback-hp" type="text" name="website" autocomplete="off" tabindex="-1" style="position:absolute;left:-9999px;opacity:0;height:0">
          <div style="display:flex;justify-content:space-between;align-items:center;margin-top:8px">
            <span id="feedback-status" style="font-size:0.75rem;color:var(--text-muted)"></span>
            <button onclick="submitFeedback('${c.slug}')" style="padding:6px 16px;background:var(--accent);color:#000;border:none;border-radius:var(--radius);font-size:0.8rem;font-weight:600;cursor:pointer;font-family:inherit">ส่ง</button>
          </div>
        </div>
      </div>

      <div style="margin-top:16px;text-align:center">
        <a href="https://ge-db.site/${slug}.php" target="_blank" style="color:var(--accent);font-size:0.8rem;text-decoration:none">
          ดูใน ge-db.site →
        </a>
      </div>
    `;
    // Load rating + comments async
    loadRating(slug);
    loadComments(slug);
  } catch (err) {
    body.innerHTML = `<div class="loading">โหลดไม่สำเร็จ: ${err.message}</div>`;
  }
}

// ── Items ──
const GROUP_LABELS = {
  "weapon-melee": "อาวุธระยะประชิด", "weapon-ranged": "อาวุธระยะไกล",
  "weapon-magic": "อาวุธเวทมนตร์", "armor": "เกราะ", "accessory": "เครื่องประดับ",
  "ring": "แหวน", "costume": "คอสตูม", "misc": "อื่นๆ",
};

const CATEGORY_LABELS = {
  sword: "Sword", dagger: "Dagger", blunt: "Blunt", great_sword: "Great Sword",
  polearm: "Polearm", rapier: "Rapier", sabre: "Sabre", knuckle: "Knuckle",
  tonfa: "Tonfa", javelin: "Javelin", crescent: "Crescent", shield: "Shield",
  main_gauche: "Main-Gauche", leg_guards: "Leg-Guards",
  pistol: "Pistol", rifle: "Rifle", cannon: "Cannon", crossbow: "Crossbow",
  shotgun: "Shotgun", heavy_rifle: "Heavy Rifle", arm_shield: "Arm Shield",
  controller: "Controller", hammer: "Hammer", pendant: "Pendant",
  rod: "Rod", staff: "Staff", fire_bracelet: "Fire Bracelet",
  ice_bracelet: "Ice Bracelet", lightning_bracelet: "Lightning Bracelet",
  special_bracelet: "Special Bracelet", cube: "Cube", lute: "Lute",
  magic_scroll: "Magic Scroll", rosario: "Rosario",
  coat: "Coat", leather: "Leather", metal: "Metal", robe: "Robe",
  artifact: "Artifact", belt: "Belt", earring: "Earring", glove: "Glove",
  necklace: "Necklace", shoes: "Shoes", runestone: "Runestone", pet_spirit: "Pet Spirit",
  back: "Back", face: "Face", medal: "Medal", hat: "Hat",
  body_costume: "Body Costume", weapon_costume: "Weapon Costume",
  skill_ring: "Skill Ring", veteran_ring: "Veteran Ring",
  upgraded_ring: "Upgraded Ring", stat_ring: "Stat Ring",
  alchemy: "Alchemy", cooking: "Cooking", craftable: "Craftable",
  crafting: "Crafting", quest: "Quest", lumin: "Lumin", summon: "Summon",
};

async function loadItems() {
  const grid = document.getElementById("item-grid");
  grid.innerHTML = '<div class="loading">กำลังโหลดไอเทม...</div>';
  try {
    // Load categories first
    const catRes = await fetch("/api/items/categories");
    const catData = await catRes.json();
    itemCategories = catData.categories;

    // Populate category dropdown
    populateItemCategories();
    setupItemFilters();

    // Load first page
    await fetchItems();
  } catch (err) {
    grid.innerHTML = `<div class="loading">โหลดไม่สำเร็จ — ${err.message}</div>`;
  }
}

function populateItemCategories(group) {
  const select = document.getElementById("filter-item-category");
  select.innerHTML = '<option value="all">ทั้งหมด</option>';
  const filtered = group && group !== "all"
    ? itemCategories.filter(c => c.category_group === group)
    : itemCategories;
  for (const cat of filtered) {
    const opt = document.createElement("option");
    opt.value = cat.category;
    opt.textContent = `${CATEGORY_LABELS[cat.category] || cat.category} (${cat.count})`;
    select.appendChild(opt);
  }
}

async function fetchItems() {
  const grid = document.getElementById("item-grid");
  const search = document.getElementById("item-search").value.trim();
  const group = document.getElementById("filter-item-group").value;
  const category = document.getElementById("filter-item-category").value;

  const params = new URLSearchParams({ page: itemPage, limit: 50 });
  if (search) params.set("q", search);
  if (group !== "all") params.set("group", group);
  if (category !== "all") params.set("category", category);

  grid.innerHTML = '<div class="loading">กำลังโหลด...</div>';

  try {
    const res = await fetch(`/api/items?${params}`);
    const data = await res.json();
    itemTotal = data.total;
    document.getElementById("item-result-count").textContent = data.items.length;
    document.getElementById("item-total-count").textContent = data.total.toLocaleString();
    renderItemGrid(data.items);
    renderItemPagination(data.page, data.pages);
  } catch (err) {
    grid.innerHTML = `<div class="loading">โหลดไม่สำเร็จ — ${err.message}</div>`;
  }
}

function renderItemGrid(items) {
  const grid = document.getElementById("item-grid");
  if (items.length === 0) {
    grid.innerHTML = '<div class="loading">ไม่พบไอเทมที่ตรงกัน</div>';
    return;
  }
  grid.innerHTML = items.map(item => {
    const groupClass = item.category_group.replace("-", "");
    const stats = [];
    if (item.level) stats.push(`Lv.${item.level}`);
    if (item.atk) stats.push(`ATK ${item.atk}`);
    if (item.def) stats.push(`DEF ${item.def}`);
    if (item.ar) stats.push(`AR ${item.ar}`);
    if (item.dr) stats.push(`DR ${item.dr}`);

    const imgSrc = item.image ? `/img/items/${item.image}` : null;

    const inCompare = compareList.some(c => c.slug === item.slug);
    return `
      <div class="item-card clickable" onclick="showItemDetail('${item.slug}')">
        ${imgSrc ? `<img class="item-icon" src="${imgSrc}" alt="" loading="lazy" onerror="this.style.display='none'">` : '<div class="item-icon-empty"></div>'}
        <div class="item-info">
          <div class="item-name">${item.name}</div>
          ${item.name_th ? `<div class="item-name-th">${item.name_th}</div>` : ''}
          <div class="item-stats">${stats.join(' · ') || '—'}</div>
        </div>
        <div class="item-meta">
          ${item.sockets ? `<span class="item-sockets">${item.sockets}S</span>` : ''}
          <span class="item-cat-tag item-group-${groupClass}">${CATEGORY_LABELS[item.category] || item.category}</span>
          <button class="compare-btn${inCompare ? ' active' : ''}" onclick="event.stopPropagation(); toggleCompare(${JSON.stringify(JSON.stringify({slug: item.slug, name: item.name, name_th: item.name_th || '', image: item.image, level: item.level, atk: item.atk, def: item.def, ar: item.ar, dr: item.dr, sockets: item.sockets, category: item.category, category_group: item.category_group}))})" title="เพิ่มเปรียบเทียบ">${inCompare ? '✓' : '⚖'}</button>
        </div>
      </div>
    `;
  }).join("");
}

function renderItemPagination(current, totalPages) {
  const container = document.getElementById("item-pagination");
  if (totalPages <= 1) { container.innerHTML = ""; return; }

  let html = "";
  if (current > 1) html += `<button class="page-btn" onclick="goItemPage(${current - 1})">← ก่อนหน้า</button>`;

  // Show page numbers with ellipsis
  const pages = [];
  pages.push(1);
  if (current > 3) pages.push("...");
  for (let i = Math.max(2, current - 1); i <= Math.min(totalPages - 1, current + 1); i++) {
    pages.push(i);
  }
  if (current < totalPages - 2) pages.push("...");
  if (totalPages > 1) pages.push(totalPages);

  for (const p of pages) {
    if (p === "...") {
      html += `<span class="page-ellipsis">...</span>`;
    } else {
      html += `<button class="page-btn${p === current ? ' active' : ''}" onclick="goItemPage(${p})">${p}</button>`;
    }
  }

  if (current < totalPages) html += `<button class="page-btn" onclick="goItemPage(${current + 1})">ถัดไป →</button>`;
  container.innerHTML = html;
}

function goItemPage(page) {
  itemPage = page;
  fetchItems();
  document.getElementById("items-section").scrollIntoView({ behavior: "smooth" });
}

function setupItemFilters() {
  const search = document.getElementById("item-search");
  const filterGroup = document.getElementById("filter-item-group");
  const filterCategory = document.getElementById("filter-item-category");

  let debounceTimer;
  const apply = () => {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => {
      itemPage = 1;
      fetchItems();
    }, 300);
  };

  search.addEventListener("input", apply);
  filterGroup.addEventListener("change", () => {
    populateItemCategories(filterGroup.value);
    filterCategory.value = "all";
    itemPage = 1;
    fetchItems();
  });
  filterCategory.addEventListener("change", () => {
    itemPage = 1;
    fetchItems();
  });
}

// ── Monsters ──
async function loadMonsters() {
  const grid = document.getElementById("mob-grid");
  grid.innerHTML = '<div class="loading">กำลังโหลดมอนสเตอร์...</div>';
  try {
    const res = await fetch("/api/monsters");
    const data = await res.json();
    allMonsters = data.monsters;
    renderMobGrid(allMonsters);
    setupMobFilters();
  } catch (err) {
    grid.innerHTML = `<div class="loading">โหลดไม่สำเร็จ — ${err.message}</div>`;
  }
}

const RACE_CLASS = { Human: "human", Wildlife: "wildlife", Undead: "undead", Golem: "golem", Demon: "demon", Misc: "misc" };

function renderMobGrid(mobs) {
  const grid = document.getElementById("mob-grid");
  document.getElementById("mob-result-count").textContent = mobs.length;

  if (mobs.length === 0) {
    grid.innerHTML = '<div class="loading">ไม่พบมอนสเตอร์ที่ตรงกัน</div>';
    return;
  }

  grid.innerHTML = mobs.map(m => `
    <div class="mob-card${m.is_boss ? ' boss' : ''} clickable" onclick="showMonsterDetail(${m.id})">
      <div>
        <div class="mob-name">${m.name}${m.is_boss ? ' <span class="boss-badge">BOSS</span>' : ''}</div>
        ${m.name_th ? `<div class="mob-name-th">${m.name_th}</div>` : ''}
        <div class="mob-location">${m.map_slug ? '📍 ' : ''}${m.location}</div>
      </div>
      <div class="mob-meta">
        <span class="mob-level">Lv.${m.level}</span>
        <span class="mob-race race-${RACE_CLASS[m.race] || 'misc'}">${m.race}</span>
      </div>
    </div>
  `).join("");
}

function setupMobFilters() {
  const search = document.getElementById("mob-search");
  const filterRace = document.getElementById("filter-race");
  const filterBoss = document.getElementById("filter-boss");

  let debounceTimer;
  const apply = () => {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => {
      const q = search.value.toLowerCase().trim();
      const race = filterRace.value;
      const boss = filterBoss.value;
      const filtered = allMonsters.filter(m => {
        if (race !== "all" && m.race !== race) return false;
        if (boss === "yes" && !m.is_boss) return false;
        if (q && !m.name.toLowerCase().includes(q) && !(m.name_th || '').includes(q) && !m.location.toLowerCase().includes(q)) return false;
        return true;
      });
      renderMobGrid(filtered);
    }, 150);
  };

  search.addEventListener("input", apply);
  filterRace.addEventListener("change", apply);
  filterBoss.addEventListener("change", apply);
}

// ── Raids ──
async function loadRaids() {
  const grid = document.getElementById("raid-grid");
  grid.innerHTML = '<div class="loading">กำลังโหลดเรด...</div>';
  try {
    const res = await fetch("/api/raids");
    const data = await res.json();
    allRaids = data.raids;
    renderRaidGrid(allRaids);
    setupRaidFilters();
  } catch (err) {
    grid.innerHTML = `<div class="loading">โหลดไม่สำเร็จ — ${err.message}</div>`;
  }
}

function renderRaidGrid(raids) {
  const grid = document.getElementById("raid-grid");
  document.getElementById("raid-result-count").textContent = raids.length;

  if (raids.length === 0) {
    grid.innerHTML = '<div class="loading">ไม่พบเรดที่ตรงกัน</div>';
    return;
  }

  grid.innerHTML = raids.map(r => `
    <div class="raid-card${r.map_slug ? ' clickable' : ''}" ${r.map_slug ? `onclick="showMapDetail('${r.map_slug}')" title="ดูแผนที่: ${r.location}"` : ''}>
      <div>
        <div class="raid-name">${r.name}</div>
        ${r.name_th ? `<div class="raid-name-th">${r.name_th}</div>` : ''}
        <div class="raid-location">${r.map_slug ? '📍 ' : ''}${r.location || '—'}</div>
      </div>
      <div class="raid-meta">
        <span class="raid-level">Lv.${r.level}</span>
        <span class="mob-race race-${RACE_CLASS[r.race] || 'misc'}">${r.race}</span>
      </div>
    </div>
  `).join("");
}

function setupRaidFilters() {
  const search = document.getElementById("raid-search");
  const filterRace = document.getElementById("filter-raid-race");

  let debounceTimer;
  const apply = () => {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(() => {
      const q = search.value.toLowerCase().trim();
      const race = filterRace.value;
      const filtered = allRaids.filter(r => {
        if (race !== "all" && r.race !== race) return false;
        if (q && !r.name.toLowerCase().includes(q) && !(r.location || "").toLowerCase().includes(q)) return false;
        return true;
      });
      renderRaidGrid(filtered);
    }, 150);
  };

  search.addEventListener("input", apply);
  filterRace.addEventListener("change", apply);
}

// ── Global Search ──
function setupGlobalSearch() {
  const input = document.getElementById("global-search");
  const results = document.getElementById("global-results");
  let debounce;

  input.addEventListener("input", () => {
    clearTimeout(debounce);
    const q = input.value.trim();
    if (q.length < 2) { results.classList.add("hidden"); return; }
    debounce = setTimeout(() => doGlobalSearch(q), 250);
  });

  input.addEventListener("focus", () => {
    if (input.value.trim().length >= 2) results.classList.remove("hidden");
  });

  document.addEventListener("click", (e) => {
    if (!e.target.closest(".global-search-wrap")) results.classList.add("hidden");
  });
}

async function doGlobalSearch(q) {
  const results = document.getElementById("global-results");
  results.classList.remove("hidden");
  results.innerHTML = '<div class="gs-no-result">กำลังค้นหา...</div>';

  try {
    const res = await fetch(`/api/search?q=${encodeURIComponent(q)}`);
    const data = await res.json();
    if (data.error) { results.innerHTML = `<div class="gs-no-result">${data.error}</div>`; return; }

    const sections = [];

    if (data.characters.length > 0) {
      sections.push(`<div class="gs-group-title">ตัวละคร (${data.characters.length})</div>`);
      for (const c of data.characters) {
        sections.push(`<div class="gs-item" onclick="document.getElementById('global-results').classList.add('hidden'); showDetail('${c.slug}')">
          <div><span class="gs-item-name">${c.display_name}</span>${c.name_th ? ` <span class="gs-item-th">${c.name_th}</span>` : ''}</div>
          <span class="gs-item-meta">${c.type}</span>
        </div>`);
      }
    }

    if (data.items.length > 0) {
      sections.push(`<div class="gs-group-title">ไอเทม (${data.items.length})</div>`);
      for (const i of data.items) {
        sections.push(`<div class="gs-item" onclick="document.getElementById('global-results').classList.add('hidden'); navigateToItem('${i.slug}')">
          ${i.image ? `<img src="/img/items/${i.image}" style="width:24px;height:24px;object-fit:contain" onerror="this.style.display='none'">` : ''}
          <div><span class="gs-item-name">${i.name}</span>${i.name_th ? ` <span class="gs-item-th">${i.name_th}</span>` : ''}</div>
          <span class="gs-item-meta">${i.category}${i.level ? ` · Lv.${i.level}` : ''}</span>
        </div>`);
      }
    }

    if (data.maps.length > 0) {
      sections.push(`<div class="gs-group-title">แผนที่ (${data.maps.length})</div>`);
      for (const m of data.maps) {
        sections.push(`<div class="gs-item" onclick="document.getElementById('global-results').classList.add('hidden'); showMapDetail('${m.slug}')">
          <div><span class="gs-item-name">${m.name}</span>${m.name_th ? ` <span class="gs-item-th">${m.name_th}</span>` : ''}</div>
          <span class="gs-item-meta">${m.map_type}${m.level_range ? ` · Lv.${m.level_range}` : ''}</span>
        </div>`);
      }
    }

    if (data.monsters.length > 0) {
      // Group monsters by name to show all maps
      const mobGroups = {};
      for (const m of data.monsters) {
        if (!mobGroups[m.name]) mobGroups[m.name] = { ...m, locations: [] };
        mobGroups[m.name].locations.push({ map_slug: m.map_slug, location: m.location, map_name: m.map_name, map_name_th: m.map_name_th, level: m.level });
      }
      const grouped = Object.values(mobGroups);
      sections.push(`<div class="gs-group-title">มอนสเตอร์ (${grouped.length})</div>`);
      for (const m of grouped) {
        const mapLinks = m.locations.map(loc =>
          `<span class="gs-map-link" ${loc.map_slug ? `onclick="event.stopPropagation(); document.getElementById('global-results').classList.add('hidden'); showMapDetail('${loc.map_slug}')"` : ''}>${loc.map_name_th || loc.map_name || loc.location} <span style="color:var(--text-muted)">(Lv.${loc.level})</span></span>`
        ).join("");
        sections.push(`<div class="gs-item gs-item-mob">
          <div>
            <span class="gs-item-name">${m.name}${m.is_boss ? ' <span class="boss-badge">BOSS</span>' : ''}</span>${m.name_th ? ` <span class="gs-item-th">${m.name_th}</span>` : ''}
            <div class="gs-mob-maps">📍 ${mapLinks}</div>
          </div>
          <span class="gs-item-meta">${m.race}</span>
        </div>`);
      }
    }

    if (data.raids.length > 0) {
      sections.push(`<div class="gs-group-title">เรด (${data.raids.length})</div>`);
      for (const r of data.raids) {
        sections.push(`<div class="gs-item" ${r.map_slug ? `onclick="document.getElementById('global-results').classList.add('hidden'); showMapDetail('${r.map_slug}')"` : ''}>
          <div><span class="gs-item-name">${r.name}</span>${r.name_th ? ` <span class="gs-item-th">${r.name_th}</span>` : ''}</div>
          <span class="gs-item-meta">Lv.${r.level} · ${r.location}</span>
        </div>`);
      }
    }

    if (data.stances && data.stances.length > 0) {
      sections.push(`<div class="gs-group-title">สแตนซ์ (${data.stances.length})</div>`);
      for (const s of data.stances) {
        sections.push(`<div class="gs-item" onclick="document.getElementById('global-results').classList.add('hidden'); showDetail('${s.character_slug}')">
          <div><span class="gs-item-name">${s.name}</span>${s.name_th ? ` <span class="gs-item-th">${s.name_th}</span>` : ''}</div>
          <span class="gs-item-meta">${s.character_name}</span>
        </div>`);
      }
    }

    if (data.skills && data.skills.length > 0) {
      sections.push(`<div class="gs-group-title">สกิล (${data.skills.length})</div>`);
      for (const s of data.skills) {
        sections.push(`<div class="gs-item" onclick="document.getElementById('global-results').classList.add('hidden'); showDetail('${s.character_slug}')">
          <div><span class="gs-item-name">${s.skill_name}</span></div>
          <span class="gs-item-meta">${s.stance_name} · ${s.character_slug}</span>
        </div>`);
      }
    }

    if (sections.length === 0) {
      results.innerHTML = '<div class="gs-no-result">ไม่พบผลลัพธ์</div>';
    } else {
      results.innerHTML = sections.join("");
    }
  } catch (err) {
    results.innerHTML = `<div class="gs-no-result">เกิดข้อผิดพลาด: ${err.message}</div>`;
  }
}

// ── Cross-navigation ──
function navigateToItem(nameOrSlug) {
  document.getElementById("global-results")?.classList.add("hidden");
  showItemDetail(nameOrSlug);
}

async function showItemDetail(slug) {
  const modal = document.getElementById("modal");
  const body = document.getElementById("modal-body");
  body.innerHTML = '<div class="loading">กำลังโหลด...</div>';
  modal.classList.remove("hidden");
  pushUrl({ item: slug });

  try {
    const res = await fetch(`/api/items/${slug}`);
    if (!res.ok) throw new Error("not found");
    const item = await res.json();

    const imgSrc = item.image ? `/img/items/${item.image}` : null;
    const stats = [];
    if (item.level) stats.push(`Lv.${item.level}`);
    if (item.atk) stats.push(`ATK ${item.atk}`);
    if (item.def) stats.push(`DEF ${item.def}`);
    if (item.ar) stats.push(`AR ${item.ar}`);
    if (item.dr) stats.push(`DR ${item.dr}`);
    if (item.sockets) stats.push(`${item.sockets} Sockets`);

    // Group monsters by map
    const mobsByMap = {};
    for (const mob of (item.monsters_in_maps || [])) {
      if (!mobsByMap[mob.map_slug]) mobsByMap[mob.map_slug] = [];
      mobsByMap[mob.map_slug].push(mob);
    }

    let dropHtml = "";
    if (item.drop_maps && item.drop_maps.length > 0) {
      dropHtml = `
        <div class="item-detail-section">
          <h3>📍 แมพที่ดรอป (${item.drop_maps.length} แมพ)</h3>
          <div class="item-drop-maps">
            ${item.drop_maps.map(dm => {
              const mobs = mobsByMap[dm.map_slug] || [];
              const bosses = mobs.filter(m => m.is_boss);
              const normals = mobs.filter(m => !m.is_boss);
              return `
                <div class="item-drop-map-card">
                  <div class="item-drop-map-name clickable" onclick="closeModal(); showMapDetail('${dm.map_slug}')">
                    <strong>${dm.map_name}</strong>
                    ${dm.map_name_th ? `<span class="th-name">${dm.map_name_th}</span>` : ''}
                    ${dm.level_range ? `<span class="level-tag">Lv.${dm.level_range}</span>` : ''}
                  </div>
                  ${mobs.length > 0 ? `
                    <div class="item-drop-mobs">
                      ${bosses.length > 0 ? `<div class="mob-row boss-row">${bosses.map(m => `<span class="mob-tag boss" title="Boss Lv.${m.level}">${m.name}${m.name_th ? ` (${m.name_th})` : ''} ⭐ Lv.${m.level}</span>`).join('')}</div>` : ''}
                      ${normals.length > 0 ? `<div class="mob-row">${normals.slice(0, 10).map(m => `<span class="mob-tag">Lv.${m.level} ${m.name}</span>`).join('')}${normals.length > 10 ? `<span class="mob-tag more">+${normals.length - 10} ตัว</span>` : ''}</div>` : ''}
                    </div>
                  ` : ''}
                </div>
              `;
            }).join('')}
          </div>
        </div>
      `;
    } else {
      dropHtml = `
        <div class="item-detail-section">
          <h3>📍 แหล่งที่มา</h3>
          <p class="no-data">ยังไม่มีข้อมูลว่าดรอปจากแมพไหน — อาจเป็นไอเทมจากร้านค้า, คราฟต์, หรือกิจกรรม</p>
        </div>
      `;
    }

    body.innerHTML = `
      <div class="item-detail-header">
        ${imgSrc ? `<img class="item-detail-img" src="${imgSrc}" alt="" onerror="this.style.display='none'">` : ''}
        <div>
          <h2 class="item-detail-name">${item.name}</h2>
          ${item.name_th ? `<div class="item-detail-th">${item.name_th}</div>` : ''}
          <div class="item-detail-cat">${CATEGORY_LABELS[item.category] || item.category} · ${item.category_group}</div>
          ${stats.length ? `<div class="item-detail-stats">${stats.join(' · ')}</div>` : ''}
        </div>
      </div>
      ${dropHtml}
    `;
  } catch (err) {
    body.innerHTML = `<div class="loading">ไม่พบข้อมูลไอเทม</div>`;
  }
}

function searchMonster(name) {
  closeModal();
  switchTab("monsters");
  setTimeout(() => {
    const search = document.getElementById("mob-search");
    if (search) {
      search.value = name;
      search.dispatchEvent(new Event("input"));
    }
  }, 300);
}

async function showMonsterDetail(id) {
  const modal = document.getElementById("modal");
  const body = document.getElementById("modal-body");
  body.innerHTML = '<div class="loading">กำลังโหลด...</div>';
  modal.classList.remove("hidden");
  pushUrl({ monster: id });

  try {
    const res = await fetch(`/api/monsters/${id}`);
    if (!res.ok) throw new Error("not found");
    const mob = await res.json();

    const mapHtml = mob.map ? `
      <div class="item-detail-section">
        <h3>📍 แผนที่</h3>
        <div class="item-drop-map-card">
          <div class="item-drop-map-name clickable" onclick="closeModal(); showMapDetail('${mob.map.slug}')">
            <strong>${mob.map.name}</strong>
            ${mob.map.name_th ? `<span class="th-name">${mob.map.name_th}</span>` : ''}
            ${mob.map.level_range ? `<span class="level-tag">Lv.${mob.map.level_range}</span>` : ''}
          </div>
        </div>
      </div>
    ` : '';

    let dropHtml = '';
    if (mob.drop_items && mob.drop_items.length > 0) {
      dropHtml = `
        <div class="item-detail-section">
          <h3>🎁 ดรอปไอเทม (${mob.drop_items.length} ชิ้น)</h3>
          <div class="item-drop-maps">
            ${mob.drop_items.map(d => `
              <span class="drop-tag${d.item_slug ? ' clickable' : ''}" ${d.item_slug ? `onclick="closeModal(); navigateToItem('${d.item_slug}')"` : ''}>
                ${d.item_name}
                <span style="color:var(--text-muted);font-size:0.8em">${d.item_category}</span>
              </span>
            `).join('')}
          </div>
        </div>
      `;
    }

    body.innerHTML = `
      <div class="item-detail-header">
        <div>
          <h2 class="item-detail-name">${mob.name}${mob.is_boss ? ' <span class="boss-badge">BOSS</span>' : ''}</h2>
          ${mob.name_th ? `<div class="item-detail-th">${mob.name_th}</div>` : ''}
          <div class="item-detail-stats">
            Lv.${mob.level} · ${mob.race}
            ${mob.location ? ` · ${mob.location}` : ''}
          </div>
        </div>
      </div>
      ${mapHtml}
      ${dropHtml}
    `;
  } catch (err) {
    body.innerHTML = '<div class="loading">ไม่พบข้อมูลมอนสเตอร์</div>';
  }
}

// ── Feedback ──
async function submitFeedback(slug) {
  const msg = document.getElementById("feedback-msg");
  const status = document.getElementById("feedback-status");
  if (!msg.value.trim()) { status.textContent = "กรุณาพิมพ์ข้อความ"; return; }
  status.textContent = "กำลังส่ง...";
  try {
    const res = await fetch("/api/feedback", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        slug,
        message: msg.value.trim(),
        website: document.getElementById("feedback-hp").value,
        ts: document.getElementById("modal")._openedAt,
      }),
    });
    const data = await res.json();
    if (data.ok) {
      status.style.color = "var(--type-recruit)";
      status.textContent = "ขอบคุณครับ! ✓";
      msg.value = "";
    } else {
      status.textContent = data.error || "เกิดข้อผิดพลาด";
    }
  } catch {
    status.textContent = "ส่งไม่สำเร็จ ลองใหม่อีกครั้ง";
  }
}

// ── Rating ──
async function loadRating(slug) {
  try {
    const res = await fetch(`/api/characters/${slug}/rating`);
    const data = await res.json();
    const cats = data.categories || {};

    for (const [cat, info] of Object.entries(cats)) {
      const infoEl = document.getElementById(`info-${cat}`);
      if (infoEl) {
        infoEl.textContent = info.count > 0 ? `${info.avg} (${info.count})` : "—";
      }
      if (info.my_rating > 0) {
        highlightStars(cat, info.my_rating);
      }
    }

    // Add hover effects per category
    document.querySelectorAll(".star-rating").forEach(container => {
      const cat = container.dataset.cat;
      container.querySelectorAll(".star").forEach(s => {
        s.addEventListener("mouseenter", () => {
          const val = parseInt(s.dataset.val);
          container.querySelectorAll(".star").forEach(st => {
            st.classList.toggle("hover", parseInt(st.dataset.val) <= val);
          });
        });
      });
      container.addEventListener("mouseleave", () => {
        container.querySelectorAll(".star").forEach(st => st.classList.remove("hover"));
      });
    });
  } catch {}
}

function highlightStars(cat, val) {
  const container = document.getElementById(`stars-${cat}`);
  if (!container) return;
  container.querySelectorAll(".star").forEach(s => {
    s.classList.toggle("active", parseInt(s.dataset.val) <= val);
  });
}

async function rateChar(slug, cat, rating) {
  highlightStars(cat, rating);
  try {
    const res = await fetch(`/api/characters/${slug}/rate`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ rating, category: cat }),
    });
    const data = await res.json();
    const infoEl = document.getElementById(`info-${cat}`);
    if (data.ok && infoEl) {
      infoEl.textContent = `${data.avg} (${data.count})`;
    }
  } catch {}
}

// ── Comments ──
async function loadComments(slug) {
  try {
    const res = await fetch(`/api/characters/${slug}/comments`);
    const data = await res.json();
    const list = document.getElementById("comments-list");
    if (!list) return;
    if (!data.comments || data.comments.length === 0) {
      list.innerHTML = '<div style="color:var(--text-muted);font-size:0.8rem">ยังไม่มีคอมเมนต์ — เป็นคนแรกเลย!</div>';
      return;
    }
    list.innerHTML = data.comments.map(c => {
      const date = new Date(c.created_at + "Z");
      const timeStr = date.toLocaleDateString("th-TH", { day: "numeric", month: "short" }) + " " + date.toLocaleTimeString("th-TH", { hour: "2-digit", minute: "2-digit" });
      return `<div class="comment-item">
        <div class="comment-meta"><span class="comment-nick">${escHtml(c.nickname)}</span><span class="comment-time">${timeStr}</span></div>
        <div class="comment-text">${escHtml(c.message)}</div>
      </div>`;
    }).join("");
  } catch {
    const list = document.getElementById("comments-list");
    if (list) list.innerHTML = '<div style="color:var(--text-muted);font-size:0.8rem">โหลดคอมเมนต์ไม่สำเร็จ</div>';
  }
}

function escHtml(s) {
  return s.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;");
}

async function submitComment(slug) {
  const nick = document.getElementById("comment-nick");
  const msg = document.getElementById("comment-msg");
  const status = document.getElementById("comment-status");
  if (!msg.value.trim()) { status.textContent = "กรุณาพิมพ์ข้อความ"; return; }
  status.textContent = "กำลังส่ง...";
  try {
    const res = await fetch(`/api/characters/${slug}/comments`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        nickname: nick.value.trim(),
        message: msg.value.trim(),
        website: document.getElementById("comment-hp").value,
        ts: document.getElementById("modal")._openedAt,
      }),
    });
    const data = await res.json();
    if (data.ok) {
      status.style.color = "var(--type-recruit)";
      status.textContent = "ส่งแล้ว! ✓";
      msg.value = "";
      loadComments(slug);
    } else {
      status.textContent = data.error || "เกิดข้อผิดพลาด";
    }
  } catch {
    status.textContent = "ส่งไม่สำเร็จ ลองใหม่อีกครั้ง";
  }
}

// ── Share ──
function shareChar(slug, name, method) {
  const url = `${location.origin}/?char=${slug}`;
  const text = `${name} — GE Database Thai`;
  if (method === "copy") {
    navigator.clipboard.writeText(url).then(() => {
      const btn = event.target;
      btn.textContent = "✓ คัดลอกแล้ว!";
      setTimeout(() => btn.textContent = "📋 คัดลอกลิงก์", 2000);
    });
  } else if (method === "fb") {
    window.open(`https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(url)}`, "_blank", "width=600,height=400");
  } else if (method === "x") {
    window.open(`https://x.com/intent/tweet?text=${encodeURIComponent(text)}&url=${encodeURIComponent(url)}`, "_blank", "width=600,height=400");
  }
}

// ── Modal Close ──
function closeModal() {
  const modal = document.getElementById("modal");
  modal.classList.add("hidden");
  // Stop YouTube video
  const iframe = modal.querySelector(".video-embed iframe");
  if (iframe) iframe.src = "";
  // Replace URL to remove modal params (replace, not push, to avoid back-loop)
  if (!suppressPush) {
    const tab = currentTab !== "characters" ? currentTab : "";
    replaceUrl({ tab });
  }
}

document.getElementById("modal").addEventListener("click", (e) => {
  if (e.target.classList.contains("modal-backdrop") || e.target.classList.contains("modal-close")) {
    closeModal();
  }
});

document.addEventListener("keydown", (e) => {
  if (e.key === "Escape") {
    closeModal();
  }
});

// ── URL State Management ──
function buildUrl(params) {
  const url = new URL(location.origin);
  for (const [k, v] of Object.entries(params)) {
    if (v && v !== "all" && v !== "characters") url.searchParams.set(k, v);
  }
  return url.pathname + url.search;
}

function pushUrl(params) {
  if (suppressPush) return;
  const href = buildUrl(params);
  if (location.pathname + location.search !== href) {
    history.pushState(params, "", href);
  }
}

function replaceUrl(params) {
  const href = buildUrl(params);
  history.replaceState(params, "", href);
}

function handlePopState() {
  suppressPush = true;
  const params = new URLSearchParams(location.search);

  // Close any open modal first
  const modal = document.getElementById("modal");
  if (!modal.classList.contains("hidden")) {
    modal.classList.add("hidden");
    const iframe = modal.querySelector(".video-embed iframe");
    if (iframe) iframe.src = "";
  }

  const charParam = params.get("char");
  const mapParam = params.get("map");
  const itemParam = params.get("item");
  const monsterParam = params.get("monster");
  const tabParam = params.get("tab") || "characters";

  if (charParam) {
    switchTab("characters");
    showDetail(charParam);
  } else if (mapParam) {
    switchTab("maps");
    showMapDetail(mapParam);
  } else if (itemParam) {
    switchTab("items");
    showItemDetail(itemParam);
  } else if (monsterParam) {
    switchTab("monsters");
    showMonsterDetail(monsterParam);
  } else {
    switchTab(tabParam);
  }

  suppressPush = false;
}

window.addEventListener("popstate", handlePopState);

// ── Item Comparison ──
function toggleCompare(itemJson) {
  const item = JSON.parse(itemJson);
  const idx = compareList.findIndex(c => c.slug === item.slug);
  if (idx >= 0) {
    compareList.splice(idx, 1);
  } else {
    if (compareList.length >= 3) {
      compareList.shift(); // remove oldest
    }
    compareList.push(item);
  }
  renderCompareTray();
  // Re-render item grid to update button states
  if (currentTab === "items") {
    const grid = document.getElementById("item-grid");
    const cards = grid.querySelectorAll(".compare-btn");
    cards.forEach(btn => {
      const card = btn.closest(".item-card");
      if (!card) return;
      const nameEl = card.querySelector(".item-name");
      if (!nameEl) return;
      const isIn = compareList.some(c => c.name === nameEl.textContent);
      btn.classList.toggle("active", isIn);
      btn.textContent = isIn ? "✓" : "⚖";
    });
  }
}

function renderCompareTray() {
  let tray = document.getElementById("compare-tray");
  if (!tray) {
    tray = document.createElement("div");
    tray.id = "compare-tray";
    tray.className = "compare-tray";
    document.body.appendChild(tray);
  }

  if (compareList.length === 0) {
    tray.classList.add("hidden");
    return;
  }

  tray.classList.remove("hidden");
  tray.innerHTML = `
    <div class="compare-tray-inner">
      <div class="compare-tray-items">
        ${compareList.map((item, i) => `
          <div class="compare-tray-item">
            ${item.image ? `<img src="/img/items/${item.image}" alt="" onerror="this.style.display='none'">` : ''}
            <span class="compare-tray-name">${item.name}</span>
            <button class="compare-tray-remove" onclick="removeCompare(${i})">×</button>
          </div>
        `).join("")}
      </div>
      <div class="compare-tray-actions">
        <span class="compare-tray-count">${compareList.length}/3</span>
        <button class="compare-tray-go${compareList.length < 2 ? ' disabled' : ''}" onclick="${compareList.length >= 2 ? 'showComparison()' : ''}"${compareList.length < 2 ? ' disabled' : ''}>⚖ เปรียบเทียบ</button>
        <button class="compare-tray-clear" onclick="clearCompare()">ล้าง</button>
      </div>
    </div>
  `;
}

function removeCompare(idx) {
  compareList.splice(idx, 1);
  renderCompareTray();
}

function clearCompare() {
  compareList = [];
  renderCompareTray();
}

function showComparison() {
  const modal = document.getElementById("modal");
  const body = document.getElementById("modal-body");
  modal.classList.remove("hidden");
  document.body.style.overflow = "hidden";

  const statKeys = [
    { key: "level", label: "Level", prefix: "Lv." },
    { key: "atk", label: "ATK" },
    { key: "def", label: "DEF" },
    { key: "ar", label: "AR" },
    { key: "dr", label: "DR" },
    { key: "sockets", label: "Sockets" },
  ];

  // Find best values for highlighting
  const bestVals = {};
  for (const s of statKeys) {
    const vals = compareList.map(item => item[s.key] || 0).filter(v => v > 0);
    bestVals[s.key] = vals.length > 0 ? Math.max(...vals) : 0;
  }

  const headerCols = compareList.map(item => {
    const imgSrc = item.image ? `/img/items/${item.image}` : null;
    return `
      <th class="compare-item-col">
        ${imgSrc ? `<img class="compare-item-img" src="${imgSrc}" alt="" onerror="this.style.display='none'">` : ''}
        <div class="compare-item-name">${item.name}</div>
        ${item.name_th ? `<div class="compare-item-th">${item.name_th}</div>` : ''}
        <div class="compare-item-cat">${CATEGORY_LABELS[item.category] || item.category}</div>
      </th>
    `;
  }).join("");

  const statRows = statKeys.map(s => {
    const cells = compareList.map(item => {
      const val = item[s.key];
      if (!val) return `<td class="compare-val empty">—</td>`;
      const isBest = val === bestVals[s.key] && compareList.filter(i => (i[s.key] || 0) === bestVals[s.key]).length < compareList.length;
      return `<td class="compare-val${isBest ? ' best' : ''}">${s.prefix || ''}${val}</td>`;
    }).join("");
    return `<tr><td class="compare-label">${s.label}</td>${cells}</tr>`;
  }).join("");

  body.innerHTML = `
    <div class="compare-modal">
      <h2>⚖ เปรียบเทียบไอเทม</h2>
      <table class="compare-table">
        <thead><tr><th></th>${headerCols}</tr></thead>
        <tbody>${statRows}</tbody>
      </table>
      <div class="compare-actions">
        <button onclick="clearCompare(); closeModal();" class="compare-close-btn">ปิดและล้างรายการ</button>
        <button onclick="closeModal();" class="compare-close-btn secondary">ปิด</button>
      </div>
    </div>
  `;
}

// ── Quests ──
let questsLoaded = false;

const BANNER_MAP = {
  'beatrice': 'https://cdn.exe.in.th/marketing/granado/images/guide/0523/beatrice/granado_beatrice_banner.jpg',
  'sharon': 'https://cdn.exe.in.th/marketing/granado/images/guide/0623/sharon/granadoespada-sharon-banner.jpg',
  'dark-emilia': 'https://cdn.exe.in.th/marketing/granado/images/guide/0623/darkemilia/granadoespada_darkemilia_banner.jpg',
  'nar-2': 'https://cdn.exe.in.th/marketing/granado/images/guide/0623/nar/granadoespada_nar_banner.jpg',
  'mboma-ll': 'https://cdn.exe.in.th/marketing/granado/images/guide/0523/mboma/granado_mboma_banner.jpg',
  'jose-cortasar': 'https://cdn.exe.in.th/marketing/granado/images/guide/0523/jose/granado_jose_banner.jpg',
  'gurtrude': 'https://cdn.exe.in.th/marketing/granado/images/guide/2023/05/gurtrude/gurtrude_banner.jpg',
  'gracielo': 'https://cdn.exe.in.th/marketing/granado/images/guide/0523/gracielo/gracielo_banner.jpg',
  'selva': 'https://cdn.exe.in.th/marketing/granado/images/guide/0523/selva/selva_banner.jpg',
  'irawan': 'https://cdn.exe.in.th/marketing/granado/images/guide/0323/irawan_banner.jpg',
  'ania': 'https://cdn.exe.in.th/marketing/granado/images/guide/12/ania/ania_700x365.jpg',
  'vincent': 'https://cdn.exe.in.th/marketing/granado/images/guide/12/vincent/vincent_700x365.jpg',
  'soso': 'https://cdn.exe.in.th/marketing/granado/images/guide/12/soso/soso_700x365.jpg',
  'marie': 'https://cdn.exe.in.th/marketing/granado/images/guide/12/marie/marie_700x365.jpg',
  'catherine': 'https://cdn.exe.in.th/marketing/granado/images/guide/12/catherine/catherine_700x365.jpg',
  'catherinetorsche': 'https://cdn.exe.in.th/marketing/granado/images/guide/11/catherinetorsche/catherinetorsche_700x365.jpg',
  'hellena': 'https://cdn.exe.in.th/marketing/granado/images/guide/11/hellena/hellena_700x365.jpg',
  'calyce': 'https://cdn.exe.in.th/marketing/granado/images/guide/11/calyce/calyce_700x365.jpg',
  'mboma': 'https://cdn.exe.in.th/marketing/granado/images/guide/11/mboma/mboma_700x365.jpg',
  'emilia': 'https://cdn.exe.in.th/marketing/granado/images/guide/11/emilia/emilia_700x365.jpg',
  'andre': 'https://cdn.exe.in.th/marketing/granado/images/guide/11/andre/andre_700.jpg',
  'panfilo': 'https://cdn.exe.in.th/marketing/granado/images/guide/11/panfilo/panfilo_700.jpg',
  'najib-sharif': 'https://cdn.exe.in.th/marketing/granado/images/guide/11/najibsharif/najib_700.jpg',
};

async function loadQuests() {
  const grid = document.getElementById("quest-grid");
  grid.innerHTML = '<div class="loading"><div class="spinner"></div> กำลังโหลดเควส...</div>';
  try {
    const res = await fetch("/api/quests");
    const data = await res.json();
    questsLoaded = true;
    document.getElementById("quest-result-count").textContent = data.total;
    renderQuestGrid(data.quests);
  } catch (e) {
    grid.innerHTML = '<div class="loading">โหลดข้อมูลไม่สำเร็จ</div>';
  }
}

function renderQuestGrid(quests) {
  const grid = document.getElementById("quest-grid");
  if (!quests.length) { grid.innerHTML = '<div class="loading">ไม่พบเควส</div>'; return; }

  grid.innerHTML = quests.map(q => {
    const banner = BANNER_MAP[q.slug] || '';
    const prereqs = JSON.parse(q.prerequisites || '[]');
    return `
      <div class="quest-card" onclick="showQuestDetail('${q.slug}')">
        ${banner ? `<div class="quest-card-banner"><img src="${banner}" alt="${q.character_name}" loading="lazy"></div>` : ''}
        <div class="quest-card-body">
          <h3>${q.character_name || q.name_th}</h3>
          <p class="quest-card-title">${q.name_th}</p>
          <div class="quest-card-meta">
            <span>📋 ${q.total_stages} ขั้นตอน</span>
            ${q.level_req ? `<span>⚔️ Lv.${q.level_req}</span>` : ''}
          </div>
          ${prereqs.length > 0 ? `<div class="quest-card-prereq">ต้องทำก่อน: ${prereqs.length} เควส</div>` : '<div class="quest-card-prereq" style="color:var(--type-recruit)">ไม่มี prerequisite</div>'}
        </div>
        <div class="quest-card-credit">ภาพจาก <a href="https://ge.exe.in.th/quests/detail/${q.slug}" target="_blank" rel="noopener" onclick="event.stopPropagation()">ge.exe.in.th</a></div>
      </div>`;
  }).join('');
}

const QUEST_IMG_BASE = {
  'beatrice': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/0523/beatrice/', count: 37 },
  'sharon': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/0623/sharon/', count: 47 },
  'dark-emilia': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/0623/darkemilia/', count: 18 },
  'nar-2': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/0623/nar/', count: 18 },
  'mboma-ll': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/0523/mboma/', count: 21 },
  'jose-cortasar': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/0523/jose/', count: 5 },
  'gurtrude': { base: 'https://cdn.exe.in.th/marketing/granado/images/2023/05/gurtrude/', count: 11 },
  'gracielo': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/0523/gracielo/', count: 20 },
  'selva': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/0523/selva/', count: 35 },
  'irawan': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/0323/', count: 5 },
  'ania': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/12/ania/', count: 10 },
  'vincent': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/12/vincent/', count: 13 },
  'soso': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/12/soso/', count: 10 },
  'marie': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/12/marie/', count: 58 },
  'catherine': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/12/catherine/', count: 32 },
  'catherinetorsche': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/11/catherinetorsche/', count: 22 },
  'hellena': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/11/hellena/', count: 11 },
  'calyce': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/11/calyce/', count: 31 },
  'mboma': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/11/mboma/', count: 12 },
  'emilia': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/11/emilia/', count: 13 },
  'andre': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/11/andre/', count: 17 },
  'panfilo': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/11/panfilo/', count: 20 },
  'najib-sharif': { base: 'https://cdn.exe.in.th/marketing/granado/images/guide/11/najibsharif/', count: 31 },
};

function mdToHtml(md) {
  let html = md
    .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
    .replace(/^### (.+)$/gm, '<h5>$1</h5>')
    .replace(/^## (.+)$/gm, '<h4>$1</h4>')
    .replace(/^---$/gm, '<hr>')
    .replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>')
    .replace(/\*(.+?)\*/g, '<em>$1</em>')
    .replace(/\[(.+?)\]\((.+?)\)/g, '<a href="$2" target="_blank" rel="noopener">$1</a>');
  // Tables
  html = html.replace(/^(\|.+\|)\n(\|[-| :]+\|)\n((?:\|.+\|\n?)+)/gm, (_, hdr, sep, rows) => {
    const ths = hdr.split('|').filter(c => c.trim()).map(c => `<th>${c.trim()}</th>`).join('');
    const trs = rows.trim().split('\n').map(r => {
      const tds = r.split('|').filter(c => c.trim()).map(c => `<td>${c.trim()}</td>`).join('');
      return `<tr>${tds}</tr>`;
    }).join('');
    return `<table><thead><tr>${ths}</tr></thead><tbody>${trs}</tbody></table>`;
  });
  // Lists
  html = html.replace(/^(\d+)\. (.+)$/gm, '<li class="md-ol">$2</li>');
  html = html.replace(/^- (.+)$/gm, '<li class="md-ul">$1</li>');
  html = html.replace(/((?:<li class="md-ol">.+<\/li>\n?)+)/g, '<ol>$1</ol>');
  html = html.replace(/((?:<li class="md-ul">.+<\/li>\n?)+)/g, '<ul>$1</ul>');
  html = html.replace(/ class="md-ol"/g, '').replace(/ class="md-ul"/g, '');
  // Sub-list items with indentation
  html = html.replace(/^   - (.+)$/gm, '<li>$1</li>');
  // Paragraphs
  html = html.replace(/\n\n/g, '</p><p>');
  html = '<p>' + html + '</p>';
  html = html.replace(/<p>\s*(<h[45]|<hr|<ol|<ul|<table)/g, '$1');
  html = html.replace(/(<\/h[45]>|<hr>|<\/ol>|<\/ul>|<\/table>)\s*<\/p>/g, '$1');
  html = html.replace(/<p>\s*<\/p>/g, '');
  return html;
}

async function showQuestDetail(slug) {
  const modal = document.getElementById("quest-modal");
  const body = document.getElementById("quest-modal-body");
  modal.classList.remove("hidden");
  document.body.style.overflow = "hidden";
  body.innerHTML = '<div class="loading"><div class="spinner"></div> กำลังโหลด...</div>';

  try {
    const res = await fetch(`/api/quests/${slug}`);
    const q = await res.json();
    const sourceUrl = q.source_url || `https://ge.exe.in.th/quests/detail/${slug}`;
    const imgData = QUEST_IMG_BASE[slug];

    let stagesHtml = '';
    if (q.stages) {
      stagesHtml = q.stages.map((s, i) => {
        let imgHtml = '';
        if (imgData && i < imgData.count) {
          imgHtml = `
            <div class="quest-stage-img">
              <img src="${imgData.base}${i}.png" alt="ขั้นตอน ${s.stage_num}" loading="lazy" onerror="this.parentElement.style.display='none'">
              <div class="quest-img-credit">ภาพจาก <a href="${sourceUrl}" target="_blank" rel="noopener">ge.exe.in.th</a></div>
            </div>`;
        }

        // If full_content exists, render rich content
        if (s.full_content) {
          return `
          <div class="quest-stage">
            <div class="quest-stage-header">
              <span class="quest-stage-num">${s.stage_num}</span>
              <h4>${s.title || 'ขั้นตอน ' + s.stage_num}</h4>
            </div>
            ${imgHtml}
            <div class="quest-stage-details quest-rich-content">${mdToHtml(s.full_content)}</div>
          </div>`;
        }

        const itemsHtml = s.required_items?.length ? `<div class="quest-stage-items">📦 ไอเทมที่ต้องใช้: ${s.required_items.map(it => `${it.item_name} x${it.quantity}`).join(', ')}</div>` : '';
        const rewardsHtml = s.rewards?.length ? `<div class="quest-stage-rewards">🎁 รางวัล: ${s.rewards.map(r => `${r.reward_name}${r.quantity > 1 ? ' x'+r.quantity : ''}`).join(', ')}</div>` : '';
        return `
          <div class="quest-stage">
            <div class="quest-stage-header">
              <span class="quest-stage-num">${s.stage_num}</span>
              <h4>${s.title || 'ขั้นตอน ' + s.stage_num}</h4>
            </div>
            ${imgHtml}
            <div class="quest-stage-details">
              ${s.npc ? `<div>🗣️ NPC: <strong>${s.npc}</strong></div>` : ''}
              ${s.location ? `<div>📍 ${s.location}${s.coordinates ? ' (' + s.coordinates + ')' : ''}</div>` : ''}
              ${s.objective ? `<div>🎯 ${s.objective}</div>` : ''}
              ${s.boss_name ? `<div>⚔️ บอส: <strong>${s.boss_name}</strong></div>` : ''}
              ${itemsHtml}
              ${rewardsHtml}
            </div>
          </div>`;
      }).join('');
    }

    const prereqs = q.prerequisites || [];
    const bannerUrl = BANNER_MAP[slug] || '';

    // Collect main rewards
    const allRewards = (q.stages || []).flatMap(s => s.rewards || []);
    const mainRewards = allRewards.filter(r =>
      r.reward_name?.includes('การ์ดตัวละคร') || r.reward_name?.includes('Character Card') ||
      r.reward_name?.includes('card') || r.reward_name?.includes('Stance') ||
      r.reward_name?.includes('ตำรา') || r.reward_type === 'stance' ||
      r.reward_type === 'costume' || r.reward_type === 'manual' ||
      r.reward_type === 'recipe' || r.reward_type === 'character_card'
    );
    const rewardText = mainRewards.length > 0
      ? mainRewards.map(r => r.reward_name).join(', ')
      : allRewards.length > 0 ? 'EXP Cards + items' : '-';

    const QUEST_SUMMARY = {
      'beatrice': 'เควสเปิดตัว Beatrice น้องสาวของ M\'Boma ที่ค้นพบ Tempest grimoire ตั้งแต่เด็ก — ต้องผ่านมิชชั่น Time Paradox และเรียนรู้ความลับของสายฟ้าสีดำ',
      'sharon': 'เรื่องราวของ Sharon ผู้ตามหา Cortés ที่ถูก Montoro สาปเป็นปีศาจหิน สืบสาวถึงองค์กรลับ Strata Vista และ Rhodolite อัญมณีแห่งไฟ — ต้องปลดล็อก 7 ตัวละครก่อน',
      'dark-emilia': 'ปลดล็อกร่างมืดของ Emilia — บุคลิกที่สองที่เกิดจากการทดลองของ Dr. Lorenzo เมื่อ 20 ปีก่อน เก็บความทรงจำที่ถูกลบไว้ทั้งหมด',
      'nar-2': 'เควสเสริมของ Nar นักรบแห่ง Errac — สร้างความเชื่อใจกับชาวเมือง ค้นหาความจริง และเผชิญหน้ากับ Harman ผู้นำ Errac',
      'mboma-ll': 'เควสเสริมของ M\'Boma — ต่อสู้กับ King of Mildew, ดวลกับ José, สืบสวนคดีฆาตกรรม และหาวัตถุดิบทำอาหารพิเศษ',
      'jose-cortasar': 'เก็บกระสุนปืนใหญ่ หาผงกระดองเต่า แล้วดวลกับ José เอง — เควสสั้น 3 ขั้นตอน ต้อง Level 81+',
      'gurtrude': 'สำรวจคฤหาสน์ Dr. Torsche, เรือนจำ Jacquin และสืบหาหน่วยลับของ Sir Lindon — ต้อง Level 80+',
      'gracielo': 'Gracielo หิวข้าว Fritz รับเป็นศิษย์ ฝึกควบคุมพลัง ท้าสู้ศิษย์ 3 คน — เควสยาว 8 ขั้น',
      'selva': 'ตามหาร่องรอยของ Montoro ข้ามหลายแผนที่ — ปลดล็อก Selva North พร้อม Rabida Espada stance',
      'irawan': 'เควสง่ายสุด! จ่ายเงิน 10,000 Vis พบไอราวัณ ต่อสู้กับอันธพาล แล้วดวลกับ Gracielo',
      'ania': 'ช่วย Ania จัดการกับคณะละครสัตว์อาร์เซ็น — ตั้ง Ania เป็นหัวหน้าทีมไปพบ André เพื่อตัดชุด Dignite',
      'vincent': 'พา André ไปพบ Vincent ที่ Viron แล้วตามหาบันทึก Dilos Latemen 4 ชิ้นใน Al Quelt Moreza',
      'soso': 'เควสสั้น 2 ขั้น — พบโซโซที่ Gigante แล้วกำจัด Jack O\' Lantern ที่เกาะอัคคี ต้อง Level 78',
      'marie': 'เควสยาวสุด 13 ขั้น! ทำงานรับใช้ในคฤหาสน์ Dr. Torsche — ตั้งแต่ทำสวน ปัดฝุ่น ทำอาหาร ล้างจาน จนได้ Swiper Stance',
      'catherine': 'สำรวจคฤหาสน์ Dr. Torsche 9 ขั้น — ปลุก Carmen หุ่นรับใช้, พบ Dr. Torsche, เก็บชิ้นส่วน Catherine ครบ เลือก class ได้',
      'catherinetorsche': 'แอบฟังบทสนทนา Dr. Torsche กับ Montoro แล้วเผชิญหน้ากับ Catherine Torsche ลูกสาวตัวจริง',
      'hellena': 'ตั้ง Ania เป็นหัวหน้าไปพบ Emilia แล้วช่วย Helena ที่ Safe House เมืองอุช — ต้อง Shiny Crystal 300',
      'calyce': 'พบแคลิซทหารตัวน้อยที่ท่าเรือ ต่อสู้กับโจรสลัด แล้วเปิดเผยแผนสมคบ — ไม่ต้อง prerequisite',
      'mboma': 'หาอาหารบ้านเกิดให้ M\'Boma แล้วประลองกับเขา — ต้องทำ Panfilo quest ก่อน',
      'emilia': 'สืบหาบันทึกของพ่อ Dr. Lorenzo ที่ Tetra Ruins แล้วนำไปให้นักวิจัย — เควสเริ่มต้นง่าย',
      'andre': 'กำจัดแมนดราโกร่า หาน้ำมนต์ศักดิ์สิทธิ์ ทำอาหารสีขาว แล้วหาขนนกสีรุ้ง 50 ชิ้น',
      'panfilo': 'ส่งอาหารให้ทหาร หาน้ำมนต์ ทำอาหารให้ André ล่าหนวดออตโตปุส แล้วป้องกันฟาร์มจากหมาป่า',
      'najib-sharif': 'เควสยาว 10 ขั้น — ช่วย Najib ค้าโบราณวัตถุ หา Blazing Ruby เฮมาไทต์ เฟอร์นิเจอร์โรโรโค และไข่มุก 50 ชิ้น',
    };
    const summary = QUEST_SUMMARY[slug] || `เควสปลดล็อกตัวละคร ${q.character_name || ''} — ${q.total_stages} ขั้นตอน`;

    body.innerHTML = `
      <div class="quest-detail">
        ${bannerUrl ? `<div class="quest-detail-banner"><img src="${bannerUrl}" alt="${q.character_name}"><div class="quest-img-credit">ภาพจาก <a href="${sourceUrl}" target="_blank" rel="noopener">ge.exe.in.th</a></div></div>` : ''}
        <div class="quest-detail-header">
          <h2>${q.name_th}</h2>
          <p class="quest-detail-char">ตัวละคร: <strong>${q.character_name || '-'}</strong></p>
        </div>

        <div class="quest-summary-box">
          <div class="quest-summary-grid">
            <div class="quest-summary-item"><span class="quest-summary-label">📋 ขั้นตอน</span><span class="quest-summary-value">${q.total_stages} stages</span></div>
            ${q.level_req ? `<div class="quest-summary-item"><span class="quest-summary-label">⚔️ เลเวลขั้นต่ำ</span><span class="quest-summary-value">${q.level_req}</span></div>` : ''}
            <div class="quest-summary-item"><span class="quest-summary-label">🎁 รางวัลหลัก</span><span class="quest-summary-value">${rewardText}</span></div>
          </div>
          ${prereqs.length > 0
            ? `<div class="quest-summary-prereqs"><strong>📋 ต้องทำก่อน:</strong> ${prereqs.join(', ')}</div>`
            : '<div class="quest-summary-prereqs" style="color:var(--type-recruit)">✅ ไม่มี prerequisite — เริ่มได้เลย!</div>'}
          <p class="quest-summary-desc">${summary}</p>
        </div>

        <button class="quest-expand-btn" onclick="toggleQuestFull(this)">📖 อ่านเนื้อหาเต็ม</button>

        <div id="quest-full-content" class="quest-full-content hidden">
          <div class="quest-stages-list">
          <h3>ขั้นตอนทั้งหมด (${q.total_stages} stages)</h3>
          ${stagesHtml}
        </div>
        <div class="quest-source-credit">
          ข้อมูลและภาพทั้งหมดจาก <a href="${sourceUrl}" target="_blank" rel="noopener">ge.exe.in.th</a>
        </div>
        </div>
        ${engagementHtml('quest', slug, q.name_th || q.character_name)}
      </div>`;

    // Load engagement data
    loadRating('quest', slug);
    loadComments('quest', slug);

    // Set timestamp for honeypot
    const tsInput = body.querySelector('input[name="ts"]');
    if (tsInput) tsInput.value = Date.now();

    // Inject Schema.org JSON-LD
    injectSchemaOrg('quest', slug, q.name_th || q.character_name, summary, null, bannerUrl || null);
  } catch (e) {
    body.innerHTML = '<div class="loading">โหลดข้อมูลไม่สำเร็จ</div>';
  }
}

function toggleQuestFull(btn) {
  const content = document.getElementById("quest-full-content");
  if (!content) return;
  const isHidden = content.classList.toggle("hidden");
  btn.textContent = isHidden ? "📖 อ่านเนื้อหาเต็ม" : "📕 ซ่อนเนื้อหา";
  if (!isHidden) content.scrollIntoView({ behavior: "smooth", block: "start" });
}

function closeQuestModal() {
  document.getElementById("quest-modal").classList.add("hidden");
  document.body.style.overflow = "";
}

// Quest modal close events
document.addEventListener("DOMContentLoaded", () => {
  const qm = document.getElementById("quest-modal");
  if (qm) {
    qm.querySelector(".modal-backdrop")?.addEventListener("click", closeQuestModal);
    qm.querySelector(".modal-close")?.addEventListener("click", closeQuestModal);
  }
});

// ── News ──
let newsLoaded = false;

async function loadNews() {
  const grid = document.getElementById("news-grid");
  grid.innerHTML = '<div class="loading"><div class="spinner"></div> กำลังโหลดข่าว...</div>';
  try {
    const res = await fetch("/api/news");
    const data = await res.json();
    newsLoaded = true;
    document.getElementById("news-result-count").textContent = data.total;
    renderNewsGrid(data.news);
  } catch (e) {
    grid.innerHTML = '<div class="loading">โหลดข้อมูลไม่สำเร็จ</div>';
  }
}

function renderNewsGrid(news) {
  const grid = document.getElementById("news-grid");
  if (!news || !news.length) {
    grid.innerHTML = '<div class="loading">ยังไม่มีข่าวอัพเดต — กำลังเตรียมข้อมูล</div>';
    return;
  }

  grid.innerHTML = news.map(n => `
    <div class="news-card" onclick="showNewsDetail(${n.id})">
      ${n.thumbnail ? `<div class="news-card-banner"><img src="${n.thumbnail}" alt="${n.title_th || n.title}" loading="lazy" onerror="this.parentElement.style.display='none'"></div>` : ''}
      <div class="news-card-body">
        <div class="news-card-meta">
          <span class="news-card-date">${n.published_at ? new Date(n.published_at).toLocaleDateString('th-TH', { year: 'numeric', month: 'short', day: 'numeric' }) : ''}</span>
          ${n.category ? `<span class="news-card-tag">${n.category}</span>` : ''}
        </div>
        <h3>${n.title_th || n.title}</h3>
        ${n.summary_th ? `<p class="news-card-summary">${n.summary_th}</p>` : ''}
      </div>
    </div>
  `).join('');
}

async function showNewsDetail(id) {
  const modal = document.getElementById("news-modal");
  const body = document.getElementById("news-modal-body");
  modal.classList.remove("hidden");
  document.body.style.overflow = "hidden";
  body.innerHTML = '<div class="loading"><div class="spinner"></div> กำลังโหลด...</div>';

  try {
    const res = await fetch(`/api/news/${id}`);
    if (!res.ok) throw new Error("Not found");
    const n = await res.json();

    body.innerHTML = `
      <div class="news-detail-header">
        <div class="news-detail-meta">
          <span class="news-card-date">${n.published_at ? new Date(n.published_at).toLocaleDateString('th-TH', { year: 'numeric', month: 'long', day: 'numeric' }) : ''}</span>
          ${n.category ? `<span class="news-card-tag">${n.category}</span>` : ''}
        </div>
        <h2>${n.title_th || n.title}</h2>
      </div>
      ${n.thumbnail ? `<div class="news-detail-banner"><img src="${n.thumbnail}" alt="${n.title_th || n.title}"></div>` : ''}
      <div class="news-detail-content">
        ${n.content_th || n.content || '<p>เนื้อหากำลังแปล...</p>'}
      </div>
      <div class="news-detail-source">
        ${n.source_url ? `แหล่งที่มา: <a href="${n.source_url}" target="_blank" rel="noopener">${n.source_url}</a>` : ''}
      </div>
      ${engagementHtml('news', id, n.title_th || n.title)}
    `;

    // Load engagement data
    loadRating('news', id);
    loadComments('news', id);

    // Set timestamp for honeypot
    const tsInput = body.querySelector('input[name="ts"]');
    if (tsInput) tsInput.value = Date.now();

    // Inject Schema.org JSON-LD
    injectSchemaOrg('news', id, n.title_th || n.title, n.summary_th || '', n.published_at, n.thumbnail);
  } catch (e) {
    body.innerHTML = '<div class="loading">โหลดข้อมูลไม่สำเร็จ</div>';
  }
}

function closeNewsModal() {
  document.getElementById("news-modal").classList.add("hidden");
  document.body.style.overflow = "";
}

// News modal close events
document.addEventListener("DOMContentLoaded", () => {
  const nm = document.getElementById("news-modal");
  if (nm) {
    nm.querySelector(".modal-backdrop")?.addEventListener("click", closeNewsModal);
    nm.querySelector(".modal-close")?.addEventListener("click", closeNewsModal);
  }
});

// ── Schema.org JSON-LD ──

function injectSchemaOrg(contentType, contentId, title, description, publishedAt, imageUrl) {
  // Remove previous injection
  const prev = document.getElementById('schema-jsonld');
  if (prev) prev.remove();

  const deepLink = `https://ge.makeloops.xyz/?tab=${contentType === 'news' ? 'news' : 'quests'}&id=${contentId}`;

  const schema = {
    "@context": "https://schema.org",
    "@type": contentType === 'news' ? "NewsArticle" : "Article",
    "headline": title,
    "description": description,
    "url": deepLink,
    "author": {
      "@type": "Organization",
      "name": "GE Database Thai"
    },
    "publisher": {
      "@type": "Organization",
      "name": "GE Database Thai",
      "url": "https://ge.makeloops.xyz",
      "logo": {
        "@type": "ImageObject",
        "url": "https://ge.makeloops.xyz/favicon.ico"
      }
    },
    "dateModified": publishedAt || new Date().toISOString().split('T')[0]
  };

  if (publishedAt) {
    schema.datePublished = publishedAt;
  }
  if (imageUrl && imageUrl.length > 0) {
    schema.image = imageUrl.startsWith('http') ? imageUrl : `https://ge.makeloops.xyz${imageUrl}`;
  } else {
    // Fallback: use site logo as image (Schema.org requires image for rich results)
    schema.image = "https://ge.makeloops.xyz/favicon.ico";
  }

  const script = document.createElement('script');
  script.type = 'application/ld+json';
  script.id = 'schema-jsonld';
  script.textContent = JSON.stringify(schema);
  document.head.appendChild(script);

  // Add AggregateRating after loading rating data
  fetch(`/api/ratings/${contentType}/${contentId}`)
    .then(r => r.json())
    .then(data => {
      if (data.count > 0) {
        schema.aggregateRating = {
          "@type": "AggregateRating",
          "ratingValue": String(data.avg),
          "bestRating": "5",
          "worstRating": "1",
          "ratingCount": String(data.count)
        };
        script.textContent = JSON.stringify(schema);
      }
    })
    .catch(() => {});
}

// ── Engagement: Share, Rating, Comments ──

function escapeHtml(str) {
  const div = document.createElement('div');
  div.textContent = str;
  return div.innerHTML;
}

function engagementHtml(contentType, contentId, title) {
  const encodedTitle = encodeURIComponent(title);
  const deepLink = `https://ge.makeloops.xyz/?tab=${contentType === 'news' ? 'news' : 'quests'}&id=${contentId}`;
  const encodedUrl = encodeURIComponent(deepLink);

  return `
    <div class="engagement-section">
      <div class="share-buttons" role="group" aria-label="แชร์บทความ">
        <span class="share-label">แชร์:</span>
        <button class="share-btn share-fb" onclick="window.open('https://www.facebook.com/sharer/sharer.php?u=${encodedUrl}&quote=${encodedTitle}','_blank','width=600,height=400')" title="แชร์ Facebook" aria-label="แชร์ไป Facebook">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/></svg>
        </button>
        <button class="share-btn share-x" onclick="window.open('https://twitter.com/intent/tweet?text=${encodedTitle}&url=${encodedUrl}','_blank','width=600,height=400')" title="แชร์ X" aria-label="แชร์ไป X (Twitter)">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg>
        </button>
        <button class="share-btn share-line" onclick="window.open('https://social-plugins.line.me/lineit/share?url=${encodedUrl}','_blank','width=600,height=400')" title="แชร์ LINE" aria-label="แชร์ไป LINE">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M19.365 9.863c.349 0 .63.285.63.631 0 .345-.281.63-.63.63H17.61v1.125h1.755c.349 0 .63.283.63.63 0 .344-.281.629-.63.629h-2.386c-.345 0-.627-.285-.627-.629V8.108c0-.345.282-.63.627-.63h2.386c.349 0 .63.285.63.63 0 .349-.281.63-.63.63H17.61v1.125h1.755zm-3.855 3.016c0 .27-.174.51-.432.596-.064.021-.133.031-.199.031-.211 0-.391-.09-.51-.25l-2.443-3.317v2.94c0 .344-.279.629-.631.629-.346 0-.626-.285-.626-.629V8.108c0-.27.173-.51.43-.595.06-.023.136-.033.194-.033.195 0 .375.104.495.254l2.462 3.33V8.108c0-.345.282-.63.63-.63.345 0 .63.285.63.63v4.771zm-5.741 0c0 .344-.282.629-.631.629-.345 0-.627-.285-.627-.629V8.108c0-.345.282-.63.627-.63.349 0 .631.285.631.63v4.771zm-2.466.629H4.917c-.345 0-.63-.285-.63-.629V8.108c0-.345.285-.63.63-.63.349 0 .63.285.63.63v4.141h1.756c.348 0 .629.283.629.63 0 .344-.281.629-.629.629M24 10.314C24 4.943 18.615.572 12 .572S0 4.943 0 10.314c0 4.811 4.27 8.842 10.035 9.608.391.082.923.258 1.058.59.12.301.079.766.038 1.08l-.164 1.02c-.045.301-.24 1.186 1.049.645 1.291-.539 6.916-4.078 9.436-6.975C23.176 14.393 24 12.458 24 10.314"/></svg>
        </button>
        <button class="share-btn share-copy" onclick="navigator.clipboard.writeText('${deepLink}').then(()=>this.textContent='Copied!')" title="คัดลอกลิงก์" aria-label="คัดลอกลิงก์">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><rect x="9" y="9" width="13" height="13" rx="2"/><path d="M5 15H4a2 2 0 01-2-2V4a2 2 0 012-2h9a2 2 0 012 2v1"/></svg>
        </button>
      </div>

      <div class="rating-section" id="rating-${contentType}-${contentId}" role="group" aria-label="ให้คะแนน">
        <div class="rating-stars" role="radiogroup" aria-label="ให้ดาว 1 ถึง 5">
          ${[1,2,3,4,5].map(i => `<span class="star" role="radio" aria-checked="false" aria-label="${i} ดาว" tabindex="0" data-value="${i}" onclick="submitRating('${contentType}','${contentId}',${i})" onkeydown="if(event.key==='Enter'||event.key===' ')submitRating('${contentType}','${contentId}',${i})">&#9733;</span>`).join('')}
        </div>
        <div class="rating-info">
          <span class="rating-avg" id="rating-avg-${contentType}-${contentId}" aria-live="polite">-</span>
          <span class="rating-count" id="rating-count-${contentType}-${contentId}" aria-live="polite">(0 คะแนน)</span>
        </div>
      </div>

      <div class="comments-section" id="comments-${contentType}-${contentId}">
        <h3 class="comments-title">ความคิดเห็น <span class="comment-count" id="comment-count-${contentType}-${contentId}"></span></h3>
        <form class="comment-form" onsubmit="submitComment(event,'${contentType}','${contentId}')">
          <label for="comment-nick-${contentType}-${contentId}" class="sr-only">ชื่อของคุณ</label>
          <input type="text" id="comment-nick-${contentType}-${contentId}" name="nickname" placeholder="ชื่อของคุณ (ไม่บังคับ)" maxlength="30" class="comment-input" autocomplete="name" />
          <input type="text" name="website" style="display:none" tabindex="-1" autocomplete="off" aria-hidden="true" />
          <input type="hidden" name="ts" value="" />
          <label for="comment-msg-${contentType}-${contentId}" class="sr-only">ความคิดเห็น</label>
          <textarea id="comment-msg-${contentType}-${contentId}" name="message" placeholder="เขียนความคิดเห็น..." maxlength="500" required class="comment-textarea"></textarea>
          <button type="submit" class="comment-submit">ส่งความคิดเห็น</button>
        </form>
        <div class="comment-list" id="comment-list-${contentType}-${contentId}" role="list" aria-label="รายการความคิดเห็น"></div>
      </div>
    </div>`;
}

async function loadRating(contentType, contentId) {
  try {
    const res = await fetch(`/api/ratings/${contentType}/${contentId}`);
    const data = await res.json();
    const avgEl = document.getElementById(`rating-avg-${contentType}-${contentId}`);
    const countEl = document.getElementById(`rating-count-${contentType}-${contentId}`);
    if (avgEl) avgEl.textContent = data.avg > 0 ? data.avg.toFixed(1) : '-';
    if (countEl) countEl.textContent = `(${data.count} คะแนน)`;

    // Highlight user's own rating
    if (data.my_rating > 0) {
      const stars = document.querySelectorAll(`#rating-${contentType}-${contentId} .star`);
      stars.forEach((s, i) => {
        const isActive = i < data.my_rating;
        if (isActive) s.classList.add('active');
        s.setAttribute('aria-checked', isActive ? 'true' : 'false');
      });
    }
  } catch (e) {}
}

async function submitRating(contentType, contentId, rating) {
  try {
    const res = await fetch('/api/ratings', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ content_type: contentType, content_id: String(contentId), rating }),
    });
    const data = await res.json();
    if (data.ok) {
      const avgEl = document.getElementById(`rating-avg-${contentType}-${contentId}`);
      const countEl = document.getElementById(`rating-count-${contentType}-${contentId}`);
      if (avgEl) avgEl.textContent = data.avg > 0 ? Number(data.avg).toFixed(1) : '-';
      if (countEl) countEl.textContent = `(${data.count} คะแนน)`;

      const stars = document.querySelectorAll(`#rating-${contentType}-${contentId} .star`);
      stars.forEach((s, i) => {
        const isActive = i < rating;
        s.classList.toggle('active', isActive);
        s.setAttribute('aria-checked', isActive ? 'true' : 'false');
      });
    } else if (data.error) {
      alert(data.error);
    }
  } catch (e) {
    alert('เกิดข้อผิดพลาด กรุณาลองใหม่');
  }
}

async function loadComments(contentType, contentId) {
  try {
    const res = await fetch(`/api/comments/${contentType}/${contentId}`);
    const data = await res.json();
    const listEl = document.getElementById(`comment-list-${contentType}-${contentId}`);
    const countEl = document.getElementById(`comment-count-${contentType}-${contentId}`);
    if (countEl) countEl.textContent = data.total > 0 ? `(${data.total})` : '';

    if (listEl) {
      if (!data.comments || data.comments.length === 0) {
        listEl.innerHTML = '<div class="no-comments">ยังไม่มีความคิดเห็น — เป็นคนแรกเลย!</div>';
      } else {
        listEl.innerHTML = data.comments.map(c => `
          <div class="comment-item" role="listitem">
            <div class="comment-header">
              <span class="comment-author">${escapeHtml(c.nickname)}</span>
              <span class="comment-date">${new Date(c.created_at).toLocaleDateString('th-TH', { year: 'numeric', month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' })}</span>
            </div>
            <div class="comment-body">${escapeHtml(c.message)}</div>
          </div>
        `).join('');
      }
    }
  } catch (e) {}
}

async function submitComment(event, contentType, contentId) {
  event.preventDefault();
  const form = event.target;
  const nickname = form.nickname.value.trim();
  const message = form.message.value.trim();
  const website = form.website.value;
  const ts = Date.now() - 5000; // ensure > 3s

  if (!message) return;

  const btn = form.querySelector('.comment-submit');
  btn.disabled = true;
  btn.textContent = 'กำลังส่ง...';

  try {
    const res = await fetch('/api/comments', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ content_type: contentType, content_id: String(contentId), nickname, message, website, ts }),
    });
    const data = await res.json();
    if (data.ok) {
      form.message.value = '';
      form.nickname.value = '';
      loadComments(contentType, contentId);
    } else if (data.error) {
      alert(data.error);
    }
  } catch (e) {
    alert('เกิดข้อผิดพลาด กรุณาลองใหม่');
  }
  btn.disabled = false;
  btn.textContent = 'ส่งความคิดเห็น';
}

// ── Start ──
init();
