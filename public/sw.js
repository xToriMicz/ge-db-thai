// GE Database Thai — Service Worker
// Phase 5B: Offline mode with smart prefetch
const CACHE_VERSION = 26;
const CACHE_NAME = 'ge-db-thai-v' + CACHE_VERSION;

const STATIC_ASSETS = [
  '/',
  '/style.css',
  '/app.js',
  '/manifest.json',
  '/favicon.png',
  '/favicon.svg',
  '/images/portrait.webp',
  '/images/portrait02.webp',
  '/images/stanceicon.webp',
  '/images/stanceicon2.webp',
  '/images/stanceiconcustom.webp',
  '/images/icon-192.png',
];

// API endpoints to prefetch in background after page load
const PREFETCH_APIS = [
  '/api/characters',
  '/api/stats',
  '/api/items?limit=50',
  '/api/maps',
];

// Install: cache static assets
self.addEventListener('install', (e) => {
  e.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(STATIC_ASSETS))
  );
  self.skipWaiting();
});

// Activate: clean old caches
self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(keys.filter((k) => k !== CACHE_NAME).map((k) => caches.delete(k)))
    )
  );
  self.clients.claim();
});

// Fetch: network-first for API, cache-first for static
self.addEventListener('fetch', (e) => {
  const url = new URL(e.request.url);

  // Only handle GET requests
  if (e.request.method !== 'GET') return;

  // API calls: network first, fallback to cache
  if (url.pathname.startsWith('/api/')) {
    e.respondWith(
      fetch(e.request)
        .then((res) => {
          if (res.ok) {
            const clone = res.clone();
            caches.open(CACHE_NAME).then((cache) => cache.put(e.request, clone));
          }
          return res;
        })
        .catch(() => caches.match(e.request))
    );
    return;
  }

  // Static: cache first, fallback to network
  e.respondWith(
    caches.match(e.request).then((cached) => {
      if (cached) return cached;
      return fetch(e.request).then((res) => {
        if (res.ok) {
          const clone = res.clone();
          caches.open(CACHE_NAME).then((cache) => cache.put(e.request, clone));
        }
        return res;
      });
    })
  );
});

// Smart prefetch: triggered by message from main thread
self.addEventListener('message', (e) => {
  if (e.data && e.data.type === 'PREFETCH') {
    e.waitUntil(prefetchApis());
  }
});

async function prefetchApis() {
  const cache = await caches.open(CACHE_NAME);
  for (const url of PREFETCH_APIS) {
    try {
      const res = await fetch(url);
      if (res.ok) {
        await cache.put(new Request(url), res);
      }
    } catch (_) {
      // Silently skip — prefetch is best-effort
    }
  }
}
