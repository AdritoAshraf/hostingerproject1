# WorkHR — HR & Payroll Management (Demo)

A self-hostable workforce-management demo: worker directory, application
pipeline, attendance with geofenced check-in, payroll, daily assignments,
contractor portal, e-signature document flows, incidents, and an admin
dashboard.

> [!IMPORTANT]
> **This is a frontend-only demo build.** There is no backend and no database.
> All data is fictional and lives only in the visitor's browser
> (`localStorage`). Data is **not shared** between users or devices and is
> **lost** when browser data is cleared. Do not enter real personal data.

## Features

- **Admin dashboard** — overview, approvals, action history, reports, charts
- **Worker directory** — profiles with documents, compliance checklist, payroll history
- **Applications pipeline** — multi-step public registration form, review & approval
- **Attendance** — geofenced check-in/out, live map (OpenStreetMap), timesheets
- **Payroll** — hourly/salary pay generation, payslip PDF export
- **Assignments** — daily site/location assignments with tasks
- **Documents** — e-signature request flow (worker signs, admin countersigns)
- **Contractor portal** — client login with documents and worker visibility
- **Incidents & notifications**, global search, CSV/Excel/PDF exports

<!-- Screenshots: add images here, e.g. docs/screenshots/dashboard.png -->

## Deploy to Hostinger

<!-- DEPLOY_BUTTON: paste the generated Hostinger button + referral link here -->

Hostinger can deploy this repository directly from GitHub:

1. Fork or clone this repo to your own GitHub account.
2. In Hostinger, create a new web app / VPS deployment and connect the repo.
3. When asked for the build/start commands, point it at the included
   `Dockerfile` / `docker-compose.yml` — no other setup is needed.
4. Set environment variables from `.env.example` if you want a non-default port.

## Environment variables

All variables are optional — the app runs with defaults. Copy
`.env.example` to `.env` to override. No secrets are required.

| Variable   | Default                 | Description                                   |
| ---------- | ----------------------- | --------------------------------------------- |
| `PORT`     | `3000`                  | Port the app listens on and is published on   |
| `APP_URL`  | `http://localhost:3000` | Public URL of the deployment (documentation)  |
| `NODE_ENV` | `production`            | Node environment — keep `production` deployed |

## Quick start (Docker)

Requirements: Docker with the Compose plugin.

```bash
cp .env.example .env     # optional — defaults work out of the box
docker compose up -d --build
```

The app is then available at `http://localhost:3000`.

- Health check: `GET /health` returns `200` (also used by the Docker `HEALTHCHECK`)
- Stop: `docker compose down`
- Logs: `docker compose logs -f app`

### First login

There is no setup wizard — the demo ships with three fictional accounts,
also shown on the login page (click to fill):

| Role              | Credential        | Password    |
| ----------------- | ----------------- | ----------- |
| Admin             | `admin@demo.io`   | `admin123`  |
| Worker            | `WRK-10241` (code)| `worker123` |
| Contractor portal | `client@demo.io`  | `client123` |

These are hardcoded demo accounts. They cannot be changed — to "reset"
any account or data, clear the site's `localStorage` in your browser and
reload; the demo re-seeds itself.

### Things to try

Approve a pending application (Admin → Applications), assign a worker to a
site (Daily Assignments), generate payroll (Payroll → Generate), send/sign
documents (Documents → Signature requests — the worker signs in their
dashboard, the admin countersigns), live map, action log.

## Local development

```bash
npm install
npm run dev       # vite dev server
npm run build     # production build (nitro preset via NITRO_PRESET / VERCEL)
npm run preview   # preview the production build
npm run lint
```

Node.js >= 22 is required.

## Data, backup & restore

There is nothing server-side to back up: **all demo data lives in each
visitor's browser** (`localStorage`) and the container is fully stateless.

- "Backup": export data from the app's built-in CSV/Excel export features,
  or copy `localStorage` entries via browser devtools.
- "Restore / reset": clear site data in the browser — the demo re-seeds
  fictional data on next load.
- There are no uploads, no database volume, and no persistent container state.

## Updating

```bash
git pull
docker compose up -d --build
```

Browser `localStorage` data survives redeploys; clearing it resets the demo.

## Security notes

- This is a **demo** — authentication is simulated in the browser. Do not
  deploy it as a real HR system and do not enter real personal data.
- The app sends `noindex` robots headers and ships a `Disallow: /`
  `robots.txt` so deployed demos are not indexed by search engines.
- Serve behind HTTPS (reverse proxy or Hostinger TLS) for any public deployment.
- Never commit `.env` — it is gitignored; `.env.example` is the template.
- `GET /health` exposes only a static `{"status":"ok"}` payload.

## How it works

`src/lib/api-client.ts` dispatches every `/api/*` call to the in-browser demo
backend in `src/lib/demo-api.ts`, which reproduces the API surface of a real
HR backend (auth sessions, workers, applications, attendance, payroll,
locations, settings, clients, documents, incidents, admins, action log,
client portal) against fictional seeds in `src/lib/mock-data.ts`. Mutations
persist to `localStorage`.

## Contributing & license

See [CONTRIBUTING.md](CONTRIBUTING.md) and [SECURITY.md](SECURITY.md).
Released under the [MIT License](LICENSE).
