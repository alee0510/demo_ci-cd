# Build Stage
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json package-lock.json ./

RUN npm ci

COPY . .

RUN npm run build

# Production Stage
FROM node:20-alpine

WORKDIR /app

COPY --from=build /app/dist /app/dist
COPY --from=build /app/package*.json /app/

RUN npm ci --omit=dev

RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

RUN chown -R nodejs:nodejs /app

USER nodejs

ENV NODE_ENV=production

EXPOSE 3000

CMD ["node", "-r", "module-alias/register", "dist/index.js"]