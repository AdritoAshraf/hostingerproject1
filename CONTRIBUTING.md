# Contributing

Thanks for your interest in contributing!

## Getting started

1. Fork the repository and clone your fork.
2. Install dependencies: `npm install` (Node.js >= 22 required).
3. Start the dev server: `npm run dev`.
4. Make your changes and verify them with `npm run lint` and `npm run build`.

## Guidelines

- **This is a demo build.** All data must remain fictional — never commit
  real names, emails, phone numbers, ID numbers, company names, or
  credentials. Seed/demo data uses fake names, `example.com`/`demo.io`
  emails and the `+44 7700 9xx` fictional phone range.
- Keep the code style consistent; run `npm run format` before committing.
- Keep changes focused — one feature or fix per pull request.
- Do not commit `.env`, build output (`.output/`, `dist/`), `node_modules`,
  or any data exports (csv/xlsx).

## Pull requests

- Describe what the change does and why.
- Verify `npm run build` completes and `docker compose up -d --build`
  still works from a clean checkout.
- Reference related issues where applicable.
