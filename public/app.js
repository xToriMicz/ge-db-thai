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

  if (tab === "items" && itemCategories.length === 0) loadItems();
  if (tab === "maps" && allMaps.length === 0) loadMaps();
  if (tab === "monsters" && allMonsters.length === 0) loadMonsters();
  if (tab === "raids" && allRaids.length === 0) loadRaids();

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

    const statLabels = { str: "STR", agi: "AGI", hp: "HP", dex: "DEX", int_stat: "INT", sen: "SEN" };

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
    <div class="mob-card${m.is_boss ? ' boss' : ''}${m.map_slug ? ' clickable' : ''}" ${m.map_slug ? `onclick="showMapDetail('${m.map_slug}')" title="ดูแผนที่: ${m.location}"` : ''}>
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
          <div><span class="gs-item-name">${i.name}</span></div>
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
  } else {
    switchTab(tabParam);
  }

  suppressPush = false;
}

window.addEventListener("popstate", handlePopState);

// ── Start ──
init();
