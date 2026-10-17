## Demo build
- This copy is a **standalone portfolio demo** — there is no Express/MySQL backend.
  `src/lib/api-client.ts` dispatches all `/api/*` calls to the in-browser demo API in
  `src/lib/demo-api.ts` (fictional seeds, localStorage persistence).
- Demo logins: `admin@demo.io`/`admin123`, worker `WRK-10241`/`worker123`,
  contractor `client@demo.io`/`client123`.
- Do NOT add a root `server.js` — it collides with the TanStack `server: { entry: "server" }` setting and breaks `vite build`.
- Private internal tool: keep robots.txt `Disallow: /`, the noindex meta in `src/routes/__root.tsx` and the `X-Robots-Tag` header.

## Deployment
- Vercel: plain `vite build` — `vite.config.ts` emits the Vercel nitro preset automatically when `VERCEL=1` is set.
- Docker / VPS: `docker compose up -d --build`. The Dockerfile builds with
  `NITRO_PRESET=node-server` and serves `.output/server/index.mjs` on `PORT`
  (default 3000). `GET /health` returns 200 for the Docker HEALTHCHECK.
