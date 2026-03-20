/**
 * KGE News Monitor — Auto-detect new Dev Notes, FatSnake videos, ge-db.site updates
 *
 * Flow:
 * 1. Scrape KGE Dev Notes list → detect new posts
 * 2. Check FatSnake YouTube → new character showcase videos
 * 3. Check ge-db.site → new character data updates
 * 4. Create GitHub Issue if new content found
 */

const KGE_DEVNOTE_LIST = 'https://ge.hanbiton.com/Comm/DevNote/List.aspx';
const KGE_DEVNOTE_VIEW = 'https://ge.hanbiton.com/Comm/DevNote/View.aspx?postKey=';
const FATSNAKE_CHANNEL_ID = 'UCD34ZT5VteTcNeUAbVh3KNA';
const FATSNAKE_RSS = `https://www.youtube.com/feeds/videos.xml?channel_id=${FATSNAKE_CHANNEL_ID}`;
const GEDB_CHARACTERS = 'https://ge-db.site/andromida/CharacterJobs.php';
const STATE_FILE = '.github/scripts/monitor-state.json';
const REPO = 'xToriMicz/ge-db-thai';

import { readFileSync, writeFileSync, existsSync } from 'fs';

// --- State Management ---
function loadState() {
  if (existsSync(STATE_FILE)) {
    return JSON.parse(readFileSync(STATE_FILE, 'utf-8'));
  }
  return { lastDevNoteId: null, knownVideoIds: [], knownCharacters: [], lastRun: null };
}

function saveState(state) {
  state.lastRun = new Date().toISOString();
  writeFileSync(STATE_FILE, JSON.stringify(state, null, 2));
}

// --- 1. KGE Dev Notes ---
async function scrapeDevNotes(state) {
  console.log('📰 Checking KGE Dev Notes...');
  const res = await fetch(KGE_DEVNOTE_LIST);
  const html = await res.text();

  // Parse post list: extract postKey and title from table rows
  const posts = [];
  const rowRegex = /postKey=(\d+)["'][^>]*>([^<]+)</g;
  let match;
  while ((match = rowRegex.exec(html)) !== null) {
    posts.push({ id: match[1], title: match[2].trim() });
  }

  if (posts.length === 0) {
    // Try alternative pattern
    const altRegex = /View\.aspx\?postKey=(\d+)/g;
    const titleRegex = /<td[^>]*class="[^"]*subject[^"]*"[^>]*>[\s\S]*?<a[^>]*>([^<]+)</g;
    let altMatch;
    while ((altMatch = altRegex.exec(html)) !== null) {
      posts.push({ id: altMatch[1], title: '' });
    }
  }

  console.log(`  Found ${posts.length} dev notes`);

  // Find new posts since last check
  const newPosts = [];
  if (state.lastDevNoteId) {
    for (const post of posts) {
      if (post.id === state.lastDevNoteId) break;
      newPosts.push(post);
    }
  } else if (posts.length > 0) {
    // First run — just record the latest, don't create issues for all
    console.log('  First run — recording latest post ID');
  }

  // Update state with latest post ID
  if (posts.length > 0) {
    state.lastDevNoteId = posts[0].id;
  }

  // Fetch full content for new posts
  const fullPosts = [];
  for (const post of newPosts) {
    console.log(`  📄 Fetching dev note: ${post.id} — ${post.title}`);
    try {
      const viewRes = await fetch(`${KGE_DEVNOTE_VIEW}${post.id}`);
      const viewHtml = await viewRes.text();

      // Extract content area
      const contentMatch = viewHtml.match(/<div[^>]*class="[^"]*board[_-]?content[^"]*"[^>]*>([\s\S]*?)<\/div>/i)
        || viewHtml.match(/<div[^>]*class="[^"]*view[_-]?content[^"]*"[^>]*>([\s\S]*?)<\/div>/i)
        || viewHtml.match(/<td[^>]*class="[^"]*content[^"]*"[^>]*>([\s\S]*?)<\/td>/i);

      // Extract images
      const images = [];
      const imgRegex = /<img[^>]*src=["']([^"']+)["'][^>]*>/g;
      let imgMatch;
      const searchHtml = contentMatch ? contentMatch[1] : viewHtml;
      while ((imgMatch = imgRegex.exec(searchHtml)) !== null) {
        if (!imgMatch[1].includes('icon') && !imgMatch[1].includes('btn_')) {
          images.push(imgMatch[1]);
        }
      }

      fullPosts.push({
        ...post,
        url: `${KGE_DEVNOTE_VIEW}${post.id}`,
        content: contentMatch ? contentMatch[1].replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ').trim().slice(0, 3000) : '',
        images: images.slice(0, 10),
      });
    } catch (e) {
      console.error(`  ❌ Error fetching ${post.id}:`, e.message);
      fullPosts.push({ ...post, url: `${KGE_DEVNOTE_VIEW}${post.id}`, content: '', images: [] });
    }
  }

  return fullPosts;
}

// --- 2. FatSnake YouTube ---
async function checkFatSnake(state) {
  console.log('🎬 Checking FatSnake YouTube...');

  // Try RSS feed first
  try {
    const res = await fetch(FATSNAKE_RSS);
    if (res.ok) {
      const xml = await res.text();
      const entries = [];
      const entryRegex = /<entry>([\s\S]*?)<\/entry>/g;
      let match;
      while ((match = entryRegex.exec(xml)) !== null) {
        const entry = match[1];
        const videoId = entry.match(/<yt:videoId>([^<]+)/)?.[1] || '';
        const title = entry.match(/<title>([^<]+)/)?.[1] || '';
        const published = entry.match(/<published>([^<]+)/)?.[1] || '';
        const link = entry.match(/<link[^>]*href="([^"]+)"/)?.[1] || '';

        // Only GE-related videos (most of this channel is GE content)
        if (/granado|espada|GE\b|stance|character|skill/i.test(title)) {
          entries.push({ videoId, title, published, link });
        }
      }

      console.log(`  Found ${entries.length} GE-related videos via RSS`);
      const knownSet = new Set(state.knownVideoIds || []);
      const newVideos = entries.filter(e => !knownSet.has(e.videoId));
      state.knownVideoIds = entries.map(e => e.videoId);
      if (newVideos.length > 0) console.log(`  🆕 ${newVideos.length} new GE videos found!`);
      return newVideos;
    }

    // RSS not available — try YouTube Data API if key is set
    const apiKey = process.env.YOUTUBE_API_KEY;
    if (apiKey) {
      console.log('  RSS unavailable, using YouTube Data API...');
      const apiUrl = `https://www.googleapis.com/youtube/v3/search?key=${apiKey}&channelId=${FATSNAKE_CHANNEL_ID}&part=snippet&order=date&maxResults=10&type=video`;
      const apiRes = await fetch(apiUrl);
      if (apiRes.ok) {
        const data = await apiRes.json();
        const entries = (data.items || []).map(item => ({
          videoId: item.id.videoId,
          title: item.snippet.title,
          published: item.snippet.publishedAt,
          link: `https://www.youtube.com/watch?v=${item.id.videoId}`,
        }));

        console.log(`  Found ${entries.length} videos via API`);
        const knownSet = new Set(state.knownVideoIds || []);
        const newVideos = entries.filter(e => !knownSet.has(e.videoId));
        state.knownVideoIds = entries.map(e => e.videoId);
        if (newVideos.length > 0) console.log(`  🆕 ${newVideos.length} new videos found!`);
        return newVideos;
      }
    }

    console.log('  ⚠️ FatSnake RSS unavailable and no YOUTUBE_API_KEY — skipping');
    return [];
  } catch (e) {
    console.error('  ❌ YouTube check error:', e.message);
    return [];
  }
}

// --- 3. ge-db.site Character Updates ---
async function checkGeDbSite(state) {
  console.log('📊 Checking ge-db.site characters...');
  try {
    const res = await fetch(GEDB_CHARACTERS);
    const html = await res.text();

    // Extract NEW characters (marked with newChar class)
    // Actual HTML: <li class="row showFace newChar"><a href="X.php#Nav"><img ...><span class="name ...">CharName<span class="new"...></span></span></a>
    const characters = [];
    const newCharRegex = /<li[^>]*class="[^"]*newChar[^"]*"[^>]*>[\s\S]*?<span class="name[^"]*">([^<]+)/g;
    let match;
    while ((match = newCharRegex.exec(html)) !== null) {
      const name = match[1].trim();
      if (name && name.length > 1) characters.push(name);
    }

    // Extract last update date
    const updateMatch = html.match(/Last update[:\s]*([0-9-]+)/i);
    const lastUpdate = updateMatch ? updateMatch[1] : 'unknown';
    console.log(`  ge-db.site last update: ${lastUpdate}`);
    console.log(`  Total characters found: ${characters.length}`);

    // Compare with known characters
    const knownSet = new Set(state.knownCharacters || []);
    const newCharacters = characters.filter(c => !knownSet.has(c));

    // Update state
    if (characters.length > 0) {
      state.knownCharacters = characters;
    }

    if (newCharacters.length > 0) {
      console.log(`  🆕 New characters: ${newCharacters.join(', ')}`);
    }

    return { newCharacters, lastUpdate };
  } catch (e) {
    console.error('  ❌ ge-db.site error:', e.message);
    return { newCharacters: [], lastUpdate: 'error' };
  }
}

// --- 4. Create GitHub Issue ---
async function createIssue(title, body, labels = []) {
  const token = process.env.GITHUB_TOKEN;
  if (!token) {
    console.log('  ⚠️ No GITHUB_TOKEN — skipping issue creation');
    console.log(`  Would create: "${title}"`);
    return;
  }

  const res = await fetch(`https://api.github.com/repos/${REPO}/issues`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${token}`,
      'Content-Type': 'application/json',
      Accept: 'application/vnd.github.v3+json',
    },
    body: JSON.stringify({
      title,
      body,
      labels: ['auto-monitor', ...labels],
    }),
  });

  if (res.ok) {
    const issue = await res.json();
    console.log(`  ✅ Issue created: #${issue.number} — ${title}`);
  } else {
    console.error(`  ❌ Issue creation failed: ${res.status} ${await res.text()}`);
  }
}

// --- Main ---
async function main() {
  console.log('🔍 KGE News Monitor — Starting...');
  console.log(`  Time: ${new Date().toISOString()}`);
  console.log('');

  const state = loadState();

  // 1. KGE Dev Notes
  const newDevNotes = await scrapeDevNotes(state);

  // 2. FatSnake YouTube
  const newVideos = await checkFatSnake(state);

  // 3. ge-db.site
  const { newCharacters, lastUpdate } = await checkGeDbSite(state);

  console.log('');
  console.log('📋 Summary:');
  console.log(`  New Dev Notes: ${newDevNotes.length}`);
  console.log(`  New FatSnake Videos: ${newVideos.length}`);
  console.log(`  New ge-db.site Characters: ${newCharacters.length}`);

  // --- Issue Type 1: News Tab (KGE Dev Notes) ---
  // KGE Dev Notes = ข่าวที่ต้องแปลและลงหน้า News tab
  for (const post of newDevNotes) {
    const body = `## 📰 KGE Dev Note ใหม่ — News Tab

**Title:** ${post.title}
**URL:** ${post.url}
**PostKey:** ${post.id}

### เนื้อหา (ภาษาเกาหลี)
${post.content || '(ดึงเนื้อหาไม่ได้ — ต้องเปิดลิงก์ดู)'}

### รูปภาพ
${post.images.length > 0 ? post.images.map(img => `- ${img}`).join('\n') : 'ไม่พบรูปภาพ'}

---

## สิ่งที่ต้องทำ (News Tab)
- [ ] แปล Dev Note เกาหลี → ไทย
- [ ] ดาวน์โหลดรูปภาพ + อัปโหลด R2
- [ ] จัดบทความลง News tab
- [ ] ส่ง Sati ตรวจก่อน deploy

> 🤖 สร้างอัตโนมัติโดย KGE News Monitor`;

    await createIssue(`📰 KGE Dev Note: ${post.title || post.id}`, body, ['oracle:jingjing', 'news']);
  }

  // --- Issue Type 2: Characters Tab (FatSnake + ge-db.site) ---
  // FatSnake videos + ge-db.site = อัปเดตหน้าตัวละคร (แยกจากข่าว)
  const hasCharacterUpdates = newVideos.length > 0 || newCharacters.length > 0;
  if (hasCharacterUpdates) {
    const videoSection = newVideos.length > 0
      ? `### FatSnake คลิปใหม่\n${newVideos.map(v => `- **[${v.title}](${v.link})** (${v.published})`).join('\n')}`
      : '### FatSnake YouTube\nยังไม่มีคลิปใหม่';

    const gedbSection = newCharacters.length > 0
      ? `### ge-db.site ตัวละครใหม่\nตัวละคร: **${newCharacters.join(', ')}**\nLast update: ${lastUpdate}`
      : `### ge-db.site\nยังไม่อัปเดต (last update: ${lastUpdate})`;

    const charTitle = newCharacters.length > 0
      ? newCharacters.join(', ')
      : newVideos.map(v => v.title).join(', ');

    const body = `## 🎮 อัปเดตหน้าตัวละคร — Characters Tab

${videoSection}

${gedbSection}

---

## สิ่งที่ต้องทำ (Characters Tab)
- [ ] ดึง stats/skills จาก ge-db.site (ถ้ามี)
- [ ] เพิ่ม FatSnake video embed (ถ้ามีคลิป)
- [ ] อัปเดตหน้า Characters ในเว็บเรา
- [ ] ส่ง Sati ตรวจก่อน deploy

> 🤖 สร้างอัตโนมัติโดย KGE News Monitor`;

    await createIssue(`🎮 Character Update: ${charTitle}`, body, ['oracle:jingjing', 'characters']);
  }

  // Save state
  saveState(state);
  console.log('\n✅ Monitor complete — state saved');
}

main().catch(e => {
  console.error('❌ Monitor failed:', e);
  process.exit(1);
});
