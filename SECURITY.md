# Security Policy

## Scope

WorkHR is a **frontend-only demo**: there is no backend, no database, and no
server-side authentication. Login sessions are simulated in the browser and
all data lives in `localStorage`. It is not suitable for storing real
personal or HR data.

## Reporting a vulnerability

If you find a security issue (e.g. a real secret or personal data
accidentally committed to the repository, or a vulnerability in the demo
code), please report it privately:

- Open a GitHub **private vulnerability report** on this repository
  (Security → Advisories → "Report a vulnerability"), or
- Contact the repository owner directly via GitHub.

Please do not open public issues for security reports. We will acknowledge
reports as soon as possible and aim to resolve confirmed issues promptly.

## Deployment hardening notes

- Serve behind HTTPS in any public deployment.
- Keep `NODE_ENV=production`.
- Never commit `.env` or any real credentials — `.env.example` documents
  the only variables, none of which are secrets.
- The app sends `noindex` headers and a `Disallow: /` robots.txt; keep them
  so demo deployments are not indexed.
