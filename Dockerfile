# ---- Build stage: install deps and produce the Nitro node-server output ----
FROM node:22-alpine AS build
WORKDIR /app

# Install dependencies first for better layer caching
COPY package.json package-lock.json ./
RUN npm ci

# Build the app. NITRO_PRESET switches Nitro from its default cloudflare
# target to a plain Node.js server (.output/server/index.mjs). NODE_ENV is
# pinned so a dev .env can never leak a development JSX build.
COPY . .
ENV NITRO_PRESET=node-server \
    NODE_ENV=production
RUN npm run build

# ---- Runtime stage: small, non-root, production only ----
FROM node:22-alpine
ENV NODE_ENV=production \
    HOST=0.0.0.0 \
    PORT=3000
WORKDIR /app

RUN addgroup -S app && adduser -S app -G app

# The Nitro output is self-contained (server bundle + public assets)
COPY --from=build --chown=app:app /app/.output ./.output

USER app
EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD node -e "fetch('http://127.0.0.1:'+(process.env.PORT||3000)+'/health').then(r=>process.exit(r.status===200?0:1)).catch(()=>process.exit(1))"

CMD ["node", ".output/server/index.mjs"]
