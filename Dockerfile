# Stage 1: Builder
FROM node:20-alpine AS builder

WORKDIR /app

# 1. Copy root package files
COPY package.json package-lock.json .npmrc ./

# 2. Copy workspace package files
COPY client/package.json ./client/
COPY server/package.json ./server/

# 3. Install all dependencies (root + workspaces)
RUN npm install --workspaces --include-workspace-root

# 4. Copy all source files
COPY . .

# 5. Build both client and server
RUN npm run build

# Stage 2: Runtime
FROM node:20-alpine

WORKDIR /app

# Copy production files
COPY --from=builder /app/package.json /app/package-lock.json ./
COPY --from=builder /app/bin ./bin
COPY --from=builder /app/client/dist ./client/dist
COPY --from=builder /app/server/build ./server/build
COPY --from=builder /app/node_modules ./node_modules

EXPOSE 3000
CMD ["node", "./bin/cli.js"]
