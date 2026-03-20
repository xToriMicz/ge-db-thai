// GE Database Thai — Worker API + Static Site
// Serves both the API and the frontend from a single Worker

export interface Env {
  DB: D1Database;
  ASSETS: R2Bucket;
}

const CORS_HEADERS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type",
};

// Rate limiter: IP → timestamps (in-memory, resets on cold start)
const feedbackLog = new Map<string, number[]>();
const commentLog = new Map<string, number[]>();
const ratingLog = new Map<string, number[]>();
const RATE_LIMIT = 3; // max per window
const RATE_WINDOW = 60 * 60 * 1000; // 1 hour
const COMMENT_RATE_LIMIT = 5;
const COMMENT_RATE_WINDOW = 60 * 60 * 1000;
const RATING_RATE_LIMIT = 10;
const RATING_RATE_WINDOW = 60 * 60 * 1000;

function isRateLimited(ip: string): boolean {
  const now = Date.now();
  const timestamps = (feedbackLog.get(ip) || []).filter(t => now - t < RATE_WINDOW);
  if (timestamps.length >= RATE_LIMIT) return true;
  timestamps.push(now);
  feedbackLog.set(ip, timestamps);
  return false;
}

function isCommentLimited(ip: string): boolean {
  const now = Date.now();
  const timestamps = (commentLog.get(ip) || []).filter(t => now - t < COMMENT_RATE_WINDOW);
  if (timestamps.length >= COMMENT_RATE_LIMIT) return true;
  timestamps.push(now);
  commentLog.set(ip, timestamps);
  return false;
}

function isRatingLimited(ip: string): boolean {
  const now = Date.now();
  const timestamps = (ratingLog.get(ip) || []).filter(t => now - t < RATING_RATE_WINDOW);
  if (timestamps.length >= RATING_RATE_LIMIT) return true;
  timestamps.push(now);
  ratingLog.set(ip, timestamps);
  return false;
}

function sanitizeHtml(str: string): string {
  return str.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#x27;");
}

async function hashIP(ip: string): Promise<string> {
  const data = new TextEncoder().encode(ip + "ge-db-salt-2026");
  const hash = await crypto.subtle.digest("SHA-256", data);
  return Array.from(new Uint8Array(hash)).map(b => b.toString(16).padStart(2, "0")).join("").slice(0, 16);
}

function json(data: unknown, status = 200, cacheSeconds = 0): Response {
  const headers: Record<string, string> = {
    "Content-Type": "application/json",
    ...CORS_HEADERS,
  };
  if (cacheSeconds > 0) {
    headers["Cache-Control"] = `public, max-age=${cacheSeconds}`;
  }
  return new Response(JSON.stringify(data), { status, headers });
}

// API Router
async function handleAPI(request: Request, env: Env): Promise<Response> {
  const url = new URL(request.url);
  const path = url.pathname;

  // GET /api/characters — list all characters (cache 5 min)
  if (path === "/api/characters") {
    const type = url.searchParams.get("type");
    const armor = url.searchParams.get("armor");
    const weapon = url.searchParams.get("weapon");
    const search = url.searchParams.get("q");

    let query = "SELECT * FROM characters";
    const conditions: string[] = [];
    const params: string[] = [];

    if (type && type !== "all") {
      conditions.push("type = ?");
      params.push(type);
    }
    if (armor && armor !== "all") {
      conditions.push("armor_types LIKE ?");
      params.push(`%"${armor}"%`);
    }
    if (weapon && weapon !== "all") {
      conditions.push("weapons LIKE ?");
      params.push(`%"${weapon}"%`);
    }
    if (search) {
      conditions.push("(display_name LIKE ? OR name LIKE ? OR name_th LIKE ?)");
      params.push(`%${search}%`, `%${search}%`, `%${search}%`);
    }

    if (conditions.length > 0) {
      query += " WHERE " + conditions.join(" AND ");
    }
    query += " ORDER BY display_name ASC";

    const result = await env.DB.prepare(query).bind(...params).all();
    return json({ characters: result.results, total: result.results.length }, 200, 300);
  }

  // GET /api/characters/:slug — single character with stances (cache 5 min)
  const charMatch = path.match(/^\/api\/characters\/([a-zA-Z0-9_-]+)$/);
  if (charMatch) {
    const slug = charMatch[1];
    const char = await env.DB.prepare("SELECT * FROM characters WHERE slug = ?").bind(slug).first();
    if (!char) return json({ error: "Character not found" }, 404);

    const stances = await env.DB.prepare("SELECT name, name_th FROM stances WHERE character_id = ?").bind(char.id).all();

    // Get stance details (stats, info, lv25 bonus)
    const stanceNames = stances.results.map((s: any) => s.name);
    const stanceDetailsMap: Record<string, any> = {};
    if (stanceNames.length > 0) {
      const placeholders = stanceNames.map(() => "?").join(",");
      const details = await env.DB.prepare(
        `SELECT * FROM stance_details WHERE stance_name IN (${placeholders})`
      ).bind(...stanceNames).all();
      for (const d of details.results as any[]) {
        stanceDetailsMap[d.stance_name] = d;
      }
    }

    // Get skill details (per-character)
    const skillDetails = await env.DB.prepare(
      `SELECT sd.skill_name, sd.stance_name, sd.skill_image, sd.description, sd.target,
              sd.casting_time, sd.cooldown, sd.duration, sd.sp_cost, sd.aggro, sd.skill_type,
              sd.hits_flying, sd.knock_down, sd.levels, sd.special
       FROM skill_details sd
       WHERE sd.character_slug = ?`
    ).bind(slug).all();

    // Group skills by stance
    const skillsByStance: Record<string, any[]> = {};
    for (const s of skillDetails.results as any[]) {
      if (!skillsByStance[s.stance_name]) skillsByStance[s.stance_name] = [];
      skillsByStance[s.stance_name].push({
        skill_name: s.skill_name,
        skill_image: s.skill_image,
        description: s.description,
        target: s.target,
        casting_time: s.casting_time,
        cooldown: s.cooldown,
        duration: s.duration,
        sp_cost: s.sp_cost,
        aggro: s.aggro,
        skill_type: s.skill_type,
        hits_flying: s.hits_flying,
        knock_down: s.knock_down,
        levels: JSON.parse(s.levels || "[]"),
        special: JSON.parse(s.special || "[]"),
      });
    }

    // Get character buff (job skill)
    const buff = await env.DB.prepare(
      "SELECT * FROM character_buffs WHERE character_slug = ?"
    ).bind(slug).first();

    // Attach details + skills to stances
    const stancesWithDetails = stances.results.map((st: any) => {
      const detail = stanceDetailsMap[st.name];
      return {
        ...st,
        equipped_items: detail?.equipped_items || null,
        icon_x: detail?.icon_x ?? null,
        icon_y: detail?.icon_y ?? null,
        info: {
          targets: detail?.targets,
          range: detail?.attack_range,
          splash: detail?.splash,
          hits_per_attack: detail?.hits_per_attack,
          hits_flying: detail?.hits_flying,
          flying: detail?.flying,
          regenerate_sp: detail?.regenerate_sp,
        },
        stats: {
          aspd: detail?.aspd,
          bonus_atk: detail?.bonus_atk,
          mspd: detail?.mspd,
          mspd_limit: detail?.mspd_limit,
          acc: detail?.acc,
          eva: detail?.eva,
          blk: detail?.blk,
        },
        resistances: {
          fire: detail?.fire_res,
          ice: detail?.ice_res,
          lightning: detail?.lightning_res,
          abnormal: detail?.abnormal_res,
        },
        lv25_bonus: detail?.lv25_bonus ? JSON.parse(detail.lv25_bonus) : {},
        lv25_bonus_extra: detail?.lv25_bonus_extra ? JSON.parse(detail.lv25_bonus_extra) : [],
        skills: skillsByStance[st.name] || [],
      };
    });

    const characterBuff = buff ? {
      name: buff.buff_name,
      image: buff.buff_image,
      description: buff.description,
      target: buff.target,
      casting_time: buff.casting_time,
      cooldown: buff.cooldown,
      duration: buff.duration,
      sp_cost: buff.sp_cost,
      consume_item: buff.consume_item,
      levels: JSON.parse(buff.levels as string || "[]"),
    } : null;

    // Get tier data
    const tier = await env.DB.prepare(
      "SELECT pve, pvp, bossing, support, support_type, farming, versatility, tier, notes FROM character_tiers WHERE character_slug = ?"
    ).bind(slug).first();

    return json({ ...char, character_buff: characterBuff, tier_data: tier || null, stances: stancesWithDetails }, 200, 300);
  }

  // GET /api/tiers — all character tiers (for homepage + tier list page)
  if (path === "/api/tiers") {
    const result = await env.DB.prepare(
      "SELECT character_slug, pve, pvp, bossing, support, support_type, farming, versatility, tier FROM character_tiers"
    ).all();
    const tiers: Record<string, any> = {};
    for (const r of result.results as any[]) {
      tiers[r.character_slug] = r;
    }
    return json({ tiers }, 200, 120);
  }

  // POST /api/admin/tiers — set tier data for a character (editor-curated)
  const tierSetMatch = path.match(/^\/api\/admin\/tiers\/([a-zA-Z0-9_-]+)$/);
  if (tierSetMatch && request.method === "POST") {
    const slug = tierSetMatch[1];
    const body = await request.json() as any;

    // Validate scores 0-10
    const fields = ["pve", "pvp", "bossing", "support", "farming", "versatility"];
    for (const f of fields) {
      if (body[f] !== undefined && (body[f] < 0 || body[f] > 10)) {
        return json({ error: `${f} ต้องอยู่ระหว่าง 0-10` }, 400);
      }
    }

    // Calculate tier from average
    const scores = fields.map(f => body[f] || 0);
    const avg = scores.reduce((a: number, b: number) => a + b, 0) / 6;
    let tier = "D";
    if (avg >= 9) tier = "SS";
    else if (avg >= 7.5) tier = "S";
    else if (avg >= 6) tier = "A";
    else if (avg >= 4.5) tier = "B";
    else if (avg >= 3) tier = "C";

    await env.DB.prepare(
      `INSERT INTO character_tiers (character_slug, pve, pvp, bossing, support, support_type, farming, versatility, tier, notes, updated_at)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
       ON CONFLICT(character_slug) DO UPDATE SET
         pve=excluded.pve, pvp=excluded.pvp, bossing=excluded.bossing,
         support=excluded.support, support_type=excluded.support_type,
         farming=excluded.farming, versatility=excluded.versatility,
         tier=excluded.tier, notes=excluded.notes, updated_at=CURRENT_TIMESTAMP`
    ).bind(slug, body.pve||0, body.pvp||0, body.bossing||0, body.support||0, body.support_type||null, body.farming||0, body.versatility||0, tier, body.notes||null).run();

    return json({ ok: true, slug, tier, avg: Math.round(avg * 10) / 10 });
  }

  // GET /api/search — global search across all tables
  if (path === "/api/search") {
    const q = url.searchParams.get("q")?.trim();
    if (!q || q.length < 2) return json({ error: "ค้นหาอย่างน้อย 2 ตัวอักษร" }, 400);

    const like = `%${q}%`;

    const [chars, items, maps, monsters, raids] = await Promise.all([
      env.DB.prepare("SELECT slug, display_name, name_th, type, portrait_x, portrait_y, portrait_class, portrait_sheet FROM characters WHERE display_name LIKE ? OR name LIKE ? OR name_th LIKE ? LIMIT 10")
        .bind(like, like, like).all(),
      env.DB.prepare("SELECT name, name_th, slug, category, category_group, level, image FROM items WHERE name LIKE ? OR name_th LIKE ? LIMIT 10")
        .bind(like, like).all(),
      env.DB.prepare("SELECT slug, name, name_th, level_range, map_type FROM maps WHERE name LIKE ? OR name_th LIKE ? LIMIT 10")
        .bind(like, like).all(),
      env.DB.prepare("SELECT m.name, m.name_th, m.level, m.race, m.is_boss, m.map_slug, m.location, maps.name as map_name, maps.name_th as map_name_th FROM monsters m LEFT JOIN maps ON m.map_slug = maps.slug WHERE m.name LIKE ? OR m.name_th LIKE ? ORDER BY m.name, m.level LIMIT 30")
        .bind(like, like).all(),
      env.DB.prepare("SELECT name, name_th, slug, level, race, location, map_slug FROM raids WHERE name LIKE ? OR name_th LIKE ? OR location LIKE ? LIMIT 10")
        .bind(like, like, like).all(),
    ]);

    return json({
      characters: chars.results,
      items: items.results,
      maps: maps.results,
      monsters: monsters.results,
      raids: raids.results,
    }, 200, 60);
  }

  // GET /api/stats — database stats (cache 10 min)
  if (path === "/api/stats") {
    const chars = await env.DB.prepare("SELECT COUNT(*) as count FROM characters").first();
    const stances = await env.DB.prepare("SELECT COUNT(*) as count FROM stances").first();
    const mapsCount = await env.DB.prepare("SELECT COUNT(*) as count FROM maps").first();
    const monstersCount = await env.DB.prepare("SELECT COUNT(*) as count FROM monsters").first();
    const bossCount = await env.DB.prepare("SELECT COUNT(*) as count FROM monsters WHERE is_boss = 1").first();
    const itemsCount = await env.DB.prepare("SELECT COUNT(*) as count FROM items").first();
    const raidsCount = await env.DB.prepare("SELECT COUNT(*) as count FROM raids").first();
    const skillsCount = await env.DB.prepare("SELECT COUNT(*) as count FROM skills").first();
    const types = await env.DB.prepare("SELECT type, COUNT(*) as count FROM characters GROUP BY type").all();
    const mapTypes = await env.DB.prepare("SELECT map_type, COUNT(*) as count FROM maps GROUP BY map_type").all();
    const itemGroups = await env.DB.prepare("SELECT category_group, COUNT(*) as count FROM items GROUP BY category_group").all();
    return json({
      characters: chars?.count,
      stances: stances?.count,
      maps: mapsCount?.count,
      monsters: monstersCount?.count,
      bosses: bossCount?.count,
      items: itemsCount?.count,
      raids: raidsCount?.count,
      skills: skillsCount?.count,
      types: types.results,
      map_types: mapTypes.results,
      item_groups: itemGroups.results,
    }, 200, 600);
  }

  // GET /api/maps — list all maps (cache 5 min)
  if (path === "/api/maps") {
    const mapType = url.searchParams.get("type");
    const search = url.searchParams.get("q");

    let query = "SELECT * FROM maps";
    const conditions: string[] = [];
    const params: string[] = [];

    if (mapType && mapType !== "all") {
      conditions.push("map_type = ?");
      params.push(mapType);
    }
    if (search) {
      conditions.push("(name LIKE ? OR name_th LIKE ?)");
      params.push(`%${search}%`, `%${search}%`);
    }
    if (conditions.length > 0) {
      query += " WHERE " + conditions.join(" AND ");
    }
    query += " ORDER BY name ASC";

    const result = await env.DB.prepare(query).bind(...params).all();
    return json({ maps: result.results, total: result.results.length }, 200, 300);
  }

  // GET /api/maps/:slug — single map with drops + connections (cache 5 min)
  const mapMatch = path.match(/^\/api\/maps\/([a-zA-Z0-9_-]+)$/);
  if (mapMatch) {
    const slug = mapMatch[1];
    const map = await env.DB.prepare("SELECT * FROM maps WHERE slug = ?").bind(slug).first();
    if (!map) return json({ error: "Map not found" }, 404);

    const drops = await env.DB.prepare("SELECT item_category, item_ref_id, item_name, item_slug FROM map_drops WHERE map_id = ?").bind(map.id).all();
    const connections = await env.DB.prepare(
      "SELECT mc.to_map_slug, COALESCE(m.name, mc.to_map_slug) as to_map_name, m.level_range FROM map_connections mc LEFT JOIN maps m ON m.slug = mc.to_map_slug WHERE mc.from_map_id = ?"
    ).bind(map.id).all();
    const monsters = await env.DB.prepare(
      "SELECT name, name_th, level, race, is_boss FROM monsters WHERE map_slug = ? ORDER BY level ASC"
    ).bind(slug).all();

    return json({ ...map, drops: drops.results, connections: connections.results, monsters: monsters.results }, 200, 300);
  }

  // GET /api/monsters — list monsters (cache 5 min)
  if (path === "/api/monsters") {
    const race = url.searchParams.get("race");
    const boss = url.searchParams.get("boss");
    const search = url.searchParams.get("q");
    const mapSlug = url.searchParams.get("map");

    let query = "SELECT * FROM monsters";
    const conditions: string[] = [];
    const params: string[] = [];

    if (race && race !== "all") {
      conditions.push("race = ?");
      params.push(race);
    }
    if (boss === "yes") {
      conditions.push("is_boss = 1");
    }
    if (mapSlug) {
      conditions.push("map_slug = ?");
      params.push(mapSlug);
    }
    if (search) {
      conditions.push("(name LIKE ? OR name_th LIKE ? OR location LIKE ?)");
      params.push(`%${search}%`, `%${search}%`, `%${search}%`);
    }
    if (conditions.length > 0) {
      query += " WHERE " + conditions.join(" AND ");
    }
    query += " ORDER BY level ASC, name ASC";

    const result = await env.DB.prepare(query).bind(...params).all();
    return json({ monsters: result.results, total: result.results.length }, 200, 300);
  }

  // GET /api/raids — list raids (cache 5 min)
  if (path === "/api/raids") {
    const race = url.searchParams.get("race");
    const search = url.searchParams.get("q");

    let query = "SELECT * FROM raids";
    const conditions: string[] = [];
    const params: string[] = [];

    if (race && race !== "all") {
      conditions.push("race = ?");
      params.push(race);
    }
    if (search) {
      conditions.push("(name LIKE ? OR name_th LIKE ? OR location LIKE ?)");
      params.push(`%${search}%`, `%${search}%`, `%${search}%`);
    }
    if (conditions.length > 0) {
      query += " WHERE " + conditions.join(" AND ");
    }
    query += " ORDER BY level ASC, name ASC";

    const result = await env.DB.prepare(query).bind(...params).all();
    return json({ raids: result.results, total: result.results.length }, 200, 300);
  }

  // GET /api/items — list items with pagination (cache 5 min)
  if (path === "/api/items") {
    const category = url.searchParams.get("category");
    const group = url.searchParams.get("group");
    const search = url.searchParams.get("q");
    const page = Math.max(1, parseInt(url.searchParams.get("page") || "1"));
    const limit = Math.min(100, Math.max(10, parseInt(url.searchParams.get("limit") || "50")));
    const offset = (page - 1) * limit;

    let countQuery = "SELECT COUNT(*) as count FROM items";
    let query = "SELECT * FROM items";
    const conditions: string[] = [];
    const params: string[] = [];

    if (category && category !== "all") {
      conditions.push("category = ?");
      params.push(category);
    }
    if (group && group !== "all") {
      conditions.push("category_group = ?");
      params.push(group);
    }
    if (search) {
      conditions.push("(name LIKE ? OR name_th LIKE ?)");
      params.push(`%${search}%`, `%${search}%`);
    }
    if (conditions.length > 0) {
      const where = " WHERE " + conditions.join(" AND ");
      countQuery += where;
      query += where;
    }
    query += " ORDER BY name ASC, level ASC LIMIT ? OFFSET ?";

    const total = await env.DB.prepare(countQuery).bind(...params).first();
    const result = await env.DB.prepare(query).bind(...params, limit, offset).all();
    return json({
      items: result.results,
      total: total?.count || 0,
      page,
      limit,
      pages: Math.ceil((total?.count as number || 0) / limit),
    }, 200, 300);
  }

  // GET /api/items/categories — list all categories with counts (cache 10 min)
  if (path === "/api/items/categories") {
    const result = await env.DB.prepare(
      "SELECT category, category_group, COUNT(*) as count FROM items GROUP BY category, category_group ORDER BY category_group, category"
    ).all();
    return json({ categories: result.results }, 200, 600);
  }

  // GET /api/items/:slug — single item with drop locations (cache 5 min)
  const itemMatch = path.match(/^\/api\/items\/([a-zA-Z0-9_-]+)$/);
  if (itemMatch && itemMatch[1] !== "categories") {
    const slug = itemMatch[1];
    const item = await env.DB.prepare("SELECT * FROM items WHERE slug = ?").bind(slug).first();
    if (!item) return json({ error: "Item not found" }, 404);

    // Find maps that drop this item (via map_drops)
    const dropMaps = await env.DB.prepare(
      `SELECT md.item_category, m.slug as map_slug, m.name as map_name, m.name_th as map_name_th, m.level_range, m.map_type
       FROM map_drops md
       JOIN maps m ON md.map_id = m.id
       WHERE md.item_slug = ? OR md.item_name = ?
       ORDER BY m.name`
    ).bind(slug, item.name).all();

    // For each drop map, find monsters in that map
    const mapSlugs = [...new Set(dropMaps.results.map((d: any) => d.map_slug))];
    let monstersInMaps: any[] = [];
    if (mapSlugs.length > 0 && mapSlugs.length <= 20) {
      const placeholders = mapSlugs.map(() => "?").join(",");
      const mobResult = await env.DB.prepare(
        `SELECT name, name_th, level, race, is_boss, map_slug FROM monsters WHERE map_slug IN (${placeholders}) ORDER BY map_slug, level`
      ).bind(...mapSlugs).all();
      monstersInMaps = mobResult.results as any[];
    }

    return json({ ...item, drop_maps: dropMaps.results, monsters_in_maps: monstersInMaps }, 200, 300);
  }

  // GET /api/ratings — all character ratings (for homepage cards, overall only)
  if (path === "/api/ratings" && request.method === "GET") {
    const result = await env.DB.prepare(
      "SELECT character_slug, COUNT(*) as count, ROUND(AVG(rating), 1) as avg FROM character_category_ratings WHERE category = 'overall' GROUP BY character_slug"
    ).all();
    const ratings: Record<string, { avg: number; count: number }> = {};
    for (const r of result.results as any[]) {
      ratings[r.character_slug] = { avg: r.avg, count: r.count };
    }
    return json({ ratings }, 200, 120);
  }

  // POST /api/characters/:slug/rate — rate a character (1-5 stars, with category)
  const rateMatch = path.match(/^\/api\/characters\/([a-zA-Z0-9_-]+)\/rate$/);
  if (rateMatch && request.method === "POST") {
    const slug = rateMatch[1];
    const ip = request.headers.get("CF-Connecting-IP") || "unknown";
    const ipHash = await hashIP(ip);
    const body = await request.json() as { rating?: number; category?: string };
    const category = body.category || "overall";
    const validCats = ["overall", "pve", "pvp", "bossing", "support", "farming", "versatility"];

    if (!validCats.includes(category)) {
      return json({ error: "หมวดไม่ถูกต้อง" }, 400);
    }
    if (!body.rating || body.rating < 1 || body.rating > 5 || !Number.isInteger(body.rating)) {
      return json({ error: "ให้ดาว 1-5 เท่านั้น" }, 400);
    }

    await env.DB.prepare(
      "INSERT INTO character_category_ratings (character_slug, category, rating, ip_hash) VALUES (?, ?, ?, ?) ON CONFLICT(character_slug, category, ip_hash) DO UPDATE SET rating = excluded.rating"
    ).bind(slug, category, body.rating, ipHash).run();

    const stats = await env.DB.prepare(
      "SELECT COUNT(*) as count, ROUND(AVG(rating), 1) as avg FROM character_category_ratings WHERE character_slug = ? AND category = ?"
    ).bind(slug, category).first();

    return json({ ok: true, category, avg: stats?.avg || 0, count: stats?.count || 0 });
  }

  // GET /api/characters/:slug/rating — get all category ratings
  const ratingMatch = path.match(/^\/api\/characters\/([a-zA-Z0-9_-]+)\/rating$/);
  if (ratingMatch && request.method === "GET") {
    const slug = ratingMatch[1];
    const ip = request.headers.get("CF-Connecting-IP") || "unknown";
    const ipHash = await hashIP(ip);

    // Get averages per category
    const allStats = await env.DB.prepare(
      "SELECT category, COUNT(*) as count, ROUND(AVG(rating), 1) as avg FROM character_category_ratings WHERE character_slug = ? GROUP BY category"
    ).bind(slug).all();

    // Get user's own ratings
    const myRatings = await env.DB.prepare(
      "SELECT category, rating FROM character_category_ratings WHERE character_slug = ? AND ip_hash = ?"
    ).bind(slug, ipHash).all();

    const categories: Record<string, { avg: number; count: number; my_rating: number }> = {};
    for (const cat of ["overall", "pve", "pvp", "bossing", "support", "farming", "versatility"]) {
      categories[cat] = { avg: 0, count: 0, my_rating: 0 };
    }
    for (const r of allStats.results as any[]) {
      if (categories[r.category]) {
        categories[r.category].avg = r.avg;
        categories[r.category].count = r.count;
      }
    }
    for (const r of myRatings.results as any[]) {
      if (categories[r.category]) {
        categories[r.category].my_rating = r.rating;
      }
    }

    return json({ categories }, 200, 60);
  }

  // POST /api/characters/:slug/comments — add a comment (anti-spam)
  const commentPostMatch = path.match(/^\/api\/characters\/([a-zA-Z0-9_-]+)\/comments$/);
  if (commentPostMatch && request.method === "POST") {
    const slug = commentPostMatch[1];
    const ip = request.headers.get("CF-Connecting-IP") || "unknown";
    const ipHash = await hashIP(ip);

    if (isCommentLimited(ip)) {
      return json({ error: "คอมเมนต์ได้สูงสุด 5 ครั้งต่อชั่วโมง" }, 429);
    }

    const body = await request.json() as { nickname?: string; message?: string; website?: string; ts?: number };

    // Honeypot
    if (body.website) {
      return json({ ok: true, message: "ขอบคุณสำหรับคอมเมนต์!" });
    }

    // Time gate: form must be open at least 3 seconds
    if (body.ts && Date.now() - body.ts < 3000) {
      return json({ ok: true, message: "ขอบคุณสำหรับคอมเมนต์!" });
    }

    const nickname = (body.nickname || "").trim().slice(0, 30) || "นักผจญภัย";
    const message = (body.message || "").trim();

    if (!message || message.length === 0) {
      return json({ error: "กรุณาระบุข้อความ" }, 400);
    }
    if (message.length > 300) {
      return json({ error: "ข้อความยาวเกินไป (สูงสุด 300 ตัวอักษร)" }, 400);
    }

    await env.DB.prepare(
      "INSERT INTO character_comments (character_slug, nickname, message, ip_hash) VALUES (?, ?, ?, ?)"
    ).bind(slug, nickname, message, ipHash).run();

    return json({ ok: true, message: "ขอบคุณสำหรับคอมเมนต์!" });
  }

  // GET /api/characters/:slug/comments — get comments
  const commentGetMatch = path.match(/^\/api\/characters\/([a-zA-Z0-9_-]+)\/comments$/);
  if (commentGetMatch && request.method === "GET") {
    const slug = commentGetMatch[1];
    const result = await env.DB.prepare(
      "SELECT id, nickname, message, created_at FROM character_comments WHERE character_slug = ? AND is_visible = 1 ORDER BY created_at DESC LIMIT 50"
    ).bind(slug).all();
    return json({ comments: result.results }, 200, 30);
  }

  // POST /api/feedback — submit user feedback (anti-spam protected)
  if (path === "/api/feedback" && request.method === "POST") {
    const ip = request.headers.get("CF-Connecting-IP") || "unknown";

    // Rate limit: 3 per hour per IP
    if (isRateLimited(ip)) {
      return json({ error: "ส่งได้สูงสุด 3 ครั้งต่อชั่วโมง กรุณารอสักครู่" }, 429);
    }

    const body = await request.json() as { slug?: string; message?: string; website?: string; ts?: number };

    // Honeypot: bots fill hidden "website" field
    if (body.website) {
      return json({ ok: true, message: "ขอบคุณสำหรับ feedback!" }); // fake success
    }

    // Time check: modal must be open at least 3 seconds
    if (body.ts && Date.now() - body.ts < 3000) {
      return json({ ok: true, message: "ขอบคุณสำหรับ feedback!" }); // fake success
    }

    if (!body.message || body.message.trim().length === 0) {
      return json({ error: "กรุณาระบุข้อความ" }, 400);
    }
    if (body.message.length > 500) {
      return json({ error: "ข้อความยาวเกินไป (สูงสุด 500 ตัวอักษร)" }, 400);
    }

    await env.DB.prepare("INSERT INTO feedback (character_slug, message) VALUES (?, ?)")
      .bind(body.slug || null, body.message.trim())
      .run();
    return json({ ok: true, message: "ขอบคุณสำหรับ feedback!" });
  }

  // GET /api/feedback — list feedback (admin)
  if (path === "/api/feedback" && request.method === "GET") {
    const result = await env.DB.prepare("SELECT * FROM feedback ORDER BY created_at DESC LIMIT 100").all();
    return json({ feedback: result.results });
  }

  // GET /api/news — list news (cache 5 min)
  if (path === "/api/news") {
    const category = url.searchParams.get("category");
    let query = "SELECT id, title, title_th, category, summary_th, thumbnail, published_at, source_url FROM news";
    const params: string[] = [];
    if (category) {
      query += " WHERE category = ?";
      params.push(category);
    }
    query += " ORDER BY published_at DESC";
    const limit = parseInt(url.searchParams.get("limit") || "50");
    query += ` LIMIT ${Math.min(limit, 100)}`;
    const result = await env.DB.prepare(query).bind(...params).all();
    return json({ news: result.results, total: result.results.length }, 200, 300);
  }

  // GET /api/news/:id — single news detail (cache 5 min)
  const newsMatch = path.match(/^\/api\/news\/(\d+)$/);
  if (newsMatch) {
    const newsId = Number(newsMatch[1]);
    const news = await env.DB.prepare("SELECT * FROM news WHERE id = ?").bind(newsId).first();
    if (!news) return json({ error: "News not found" }, 404);
    return json(news, 200, 300);
  }

  // GET /api/quests — list all quests (cache 5 min)
  if (path === "/api/quests") {
    const search = url.searchParams.get("q");
    let query = "SELECT * FROM quests";
    const params: string[] = [];

    if (search) {
      query += " WHERE name_th LIKE ? OR character_name LIKE ?";
      params.push(`%${search}%`, `%${search}%`);
    }
    query += " ORDER BY character_name ASC";

    const result = await env.DB.prepare(query).bind(...params).all();
    return json({ quests: result.results, total: result.results.length }, 200, 300);
  }

  // GET /api/quests/:idOrSlug — single quest with stages (cache 5 min)
  const questMatch = path.match(/^\/api\/quests\/([a-zA-Z0-9_-]+)$/);
  if (questMatch) {
    const idOrSlug = questMatch[1];
    const isNumeric = /^\d+$/.test(idOrSlug);
    const quest = isNumeric
      ? await env.DB.prepare("SELECT * FROM quests WHERE id = ?").bind(Number(idOrSlug)).first()
      : await env.DB.prepare("SELECT * FROM quests WHERE slug = ?").bind(idOrSlug).first();
    if (!quest) return json({ error: "Quest not found" }, 404);

    const stages = await env.DB.prepare(
      "SELECT * FROM quest_stages WHERE quest_id = ? ORDER BY stage_num ASC"
    ).bind(quest.id).all();

    // Get items and rewards for each stage
    const stageIds = stages.results.map((s: any) => s.id);
    let items: any[] = [];
    let rewards: any[] = [];

    if (stageIds.length > 0) {
      const ph = stageIds.map(() => "?").join(",");
      const itemsResult = await env.DB.prepare(
        `SELECT * FROM quest_stage_items WHERE stage_id IN (${ph})`
      ).bind(...stageIds).all();
      items = itemsResult.results as any[];

      const rewardsResult = await env.DB.prepare(
        `SELECT * FROM quest_stage_rewards WHERE stage_id IN (${ph})`
      ).bind(...stageIds).all();
      rewards = rewardsResult.results as any[];
    }

    const stagesWithDetails = stages.results.map((s: any) => ({
      ...s,
      full_content: s.full_content || null,
      required_items: items.filter((i: any) => i.stage_id === s.id),
      rewards: rewards.filter((r: any) => r.stage_id === s.id),
    }));

    return json({ ...quest, prerequisites: JSON.parse(quest.prerequisites as string || "[]"), stages: stagesWithDetails }, 200, 300);
  }

  // ── Engagement API: Ratings ──

  // POST /api/ratings — submit a rating
  if (path === "/api/ratings" && request.method === "POST") {
    const ip = request.headers.get("CF-Connecting-IP") || "unknown";
    if (isRatingLimited(ip)) {
      return json({ error: "ให้ดาวได้สูงสุด 10 ครั้งต่อชั่วโมง" }, 429);
    }
    const ipHash = await hashIP(ip);
    const body = await request.json() as { content_type?: string; content_id?: string; rating?: number };
    const validTypes = ["news", "quest"];
    if (!body.content_type || !validTypes.includes(body.content_type)) {
      return json({ error: "content_type ต้องเป็น news หรือ quest" }, 400);
    }
    if (!body.content_id) {
      return json({ error: "กรุณาระบุ content_id" }, 400);
    }
    if (!body.rating || body.rating < 1 || body.rating > 5 || !Number.isInteger(body.rating)) {
      return json({ error: "ให้ดาว 1-5 เท่านั้น" }, 400);
    }
    await env.DB.prepare(
      "INSERT INTO content_ratings (content_type, content_id, rating, ip_hash) VALUES (?, ?, ?, ?) ON CONFLICT(content_type, content_id, ip_hash) DO UPDATE SET rating = excluded.rating"
    ).bind(body.content_type, String(body.content_id), body.rating, ipHash).run();

    const stats = await env.DB.prepare(
      "SELECT COUNT(*) as count, ROUND(AVG(rating), 1) as avg FROM content_ratings WHERE content_type = ? AND content_id = ?"
    ).bind(body.content_type, String(body.content_id)).first();

    return json({ ok: true, avg: stats?.avg || 0, count: stats?.count || 0 });
  }

  // GET /api/ratings/:type/:id — get rating stats
  const ratingGetMatch = path.match(/^\/api\/ratings\/(news|quest)\/([a-zA-Z0-9_-]+)$/);
  if (ratingGetMatch && request.method === "GET") {
    const [, contentType, contentId] = ratingGetMatch;
    const ip = request.headers.get("CF-Connecting-IP") || "unknown";
    const ipHash = await hashIP(ip);

    const stats = await env.DB.prepare(
      "SELECT COUNT(*) as count, ROUND(AVG(rating), 1) as avg FROM content_ratings WHERE content_type = ? AND content_id = ?"
    ).bind(contentType, contentId).first();

    const myRating = await env.DB.prepare(
      "SELECT rating FROM content_ratings WHERE content_type = ? AND content_id = ? AND ip_hash = ?"
    ).bind(contentType, contentId, ipHash).first();

    return json({
      avg: stats?.avg || 0,
      count: stats?.count || 0,
      my_rating: myRating?.rating || 0,
    }, 200, 30);
  }

  // ── Engagement API: Comments ──

  // POST /api/comments — submit a comment
  if (path === "/api/comments" && request.method === "POST") {
    const ip = request.headers.get("CF-Connecting-IP") || "unknown";
    if (isCommentLimited(ip)) {
      return json({ error: "คอมเมนต์ได้สูงสุด 5 ครั้งต่อชั่วโมง" }, 429);
    }
    const ipHash = await hashIP(ip);
    const body = await request.json() as { content_type?: string; content_id?: string; nickname?: string; message?: string; website?: string; ts?: number };

    // Honeypot
    if (body.website) {
      return json({ ok: true, message: "ขอบคุณสำหรับคอมเมนต์!" });
    }
    // Time gate
    if (body.ts && Date.now() - body.ts < 3000) {
      return json({ ok: true, message: "ขอบคุณสำหรับคอมเมนต์!" });
    }

    const validTypes = ["news", "quest"];
    if (!body.content_type || !validTypes.includes(body.content_type)) {
      return json({ error: "content_type ต้องเป็น news หรือ quest" }, 400);
    }
    if (!body.content_id) {
      return json({ error: "กรุณาระบุ content_id" }, 400);
    }

    const nickname = sanitizeHtml((body.nickname || "").trim().slice(0, 30) || "นักผจญภัย");
    const message = sanitizeHtml((body.message || "").trim());

    if (!message || message.length === 0) {
      return json({ error: "กรุณาระบุข้อความ" }, 400);
    }
    if (message.length > 500) {
      return json({ error: "ข้อความยาวเกินไป (สูงสุด 500 ตัวอักษร)" }, 400);
    }

    await env.DB.prepare(
      "INSERT INTO content_comments (content_type, content_id, nickname, message, ip_hash) VALUES (?, ?, ?, ?, ?)"
    ).bind(body.content_type, String(body.content_id), nickname, message, ipHash).run();

    return json({ ok: true, message: "ขอบคุณสำหรับคอมเมนต์!" });
  }

  // GET /api/comments/:type/:id — get comments
  const commentEngGetMatch = path.match(/^\/api\/comments\/(news|quest)\/([a-zA-Z0-9_-]+)$/);
  if (commentEngGetMatch && request.method === "GET") {
    const [, contentType, contentId] = commentEngGetMatch;
    const result = await env.DB.prepare(
      "SELECT id, nickname, message, created_at FROM content_comments WHERE content_type = ? AND content_id = ? AND is_visible = 1 ORDER BY created_at DESC LIMIT 50"
    ).bind(contentType, contentId).all();

    const countResult = await env.DB.prepare(
      "SELECT COUNT(*) as total FROM content_comments WHERE content_type = ? AND content_id = ? AND is_visible = 1"
    ).bind(contentType, contentId).first();

    return json({ comments: result.results, total: countResult?.total || 0 }, 200, 30);
  }

  return json({ error: "Not found" }, 404);
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    if (request.method === "OPTIONS") {
      return new Response(null, { headers: CORS_HEADERS });
    }

    const url = new URL(request.url);

    // API routes
    if (url.pathname.startsWith("/api/")) {
      return handleAPI(request, env);
    }

    // Image proxy: /img/items/{filename} → R2 (lazy cache from ge-db.site)
    const imgMatch = url.pathname.match(/^\/img\/items\/(.+)$/);
    if (imgMatch) {
      const filename = imgMatch[1];
      const r2Key = `items/${filename}`;

      // Try R2 first
      const cached = await env.ASSETS.get(r2Key);
      if (cached) {
        return new Response(cached.body, {
          headers: {
            "Content-Type": cached.httpMetadata?.contentType || "image/jpeg",
            "Cache-Control": "public, max-age=31536000, immutable",
          },
        });
      }

      // Not in R2 — fetch from source, cache in R2, serve
      try {
        const sourceRes = await fetch(`https://ge-db.site/andromida/images/items/${filename}`);
        if (!sourceRes.ok) {
          return new Response(null, { status: 404 });
        }
        const imageData = await sourceRes.arrayBuffer();
        // Store in R2 (non-blocking)
        env.ASSETS.put(r2Key, imageData, {
          httpMetadata: { contentType: sourceRes.headers.get("content-type") || "image/jpeg" },
        });
        return new Response(imageData, {
          headers: {
            "Content-Type": sourceRes.headers.get("content-type") || "image/jpeg",
            "Cache-Control": "public, max-age=31536000, immutable",
          },
        });
      } catch {
        return new Response(null, { status: 502 });
      }
    }

    // Image proxy: /img/skills/{filename} → R2 (lazy cache from ge-db.site)
    const skillImgMatch = url.pathname.match(/^\/img\/skills\/(.+)$/);
    if (skillImgMatch) {
      const filename = skillImgMatch[1];
      const r2Key = `skills/${filename}`;

      const cached = await env.ASSETS.get(r2Key);
      if (cached) {
        return new Response(cached.body, {
          headers: {
            "Content-Type": cached.httpMetadata?.contentType || "image/jpeg",
            "Cache-Control": "public, max-age=31536000, immutable",
          },
        });
      }

      try {
        const sourceRes = await fetch(`https://ge-db.site/andromida/images/Skills/${filename}`);
        if (!sourceRes.ok) {
          return new Response(null, { status: 404 });
        }
        const imageData = await sourceRes.arrayBuffer();
        env.ASSETS.put(r2Key, imageData, {
          httpMetadata: { contentType: sourceRes.headers.get("content-type") || "image/jpeg" },
        });
        return new Response(imageData, {
          headers: {
            "Content-Type": sourceRes.headers.get("content-type") || "image/jpeg",
            "Cache-Control": "public, max-age=31536000, immutable",
          },
        });
      } catch {
        return new Response(null, { status: 502 });
      }
    }

    // Image proxy: /img/news/{path} → R2 news assets
    const newsImgMatch = url.pathname.match(/^\/img\/news\/(.+)$/);
    if (newsImgMatch) {
      const filePath = newsImgMatch[1];
      const r2Key = `news/${filePath}`;
      const cached = await env.ASSETS.get(r2Key);
      if (cached) {
        const ext = filePath.split(".").pop()?.toLowerCase();
        const contentTypes: Record<string, string> = {
          jpg: "image/jpeg", jpeg: "image/jpeg", png: "image/png", gif: "image/gif", webp: "image/webp",
        };
        return new Response(cached.body, {
          headers: {
            "Content-Type": cached.httpMetadata?.contentType || contentTypes[ext || ""] || "image/jpeg",
            "Cache-Control": "public, max-age=31536000, immutable",
          },
        });
      }
      return new Response(null, { status: 404 });
    }

    // Static files served by Cloudflare assets binding
    return new Response(null, { status: 404 });
  },
};
