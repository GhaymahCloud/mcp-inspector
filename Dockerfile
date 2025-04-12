# Stage 1: Build
FROM node:20-alpine as builder

WORKDIR /app

# 1. Copy root files
COPY package.json package-lock.json .npmrc ./

# 2. Copy client files (ignore missing lock files)
COPY client/package.json ./client/
COPY server/package.json ./server/

# 3. Install root dependencies
RUN npm install

# 4. Copy all other files
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
