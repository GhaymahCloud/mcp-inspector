# Stage 1: Build
FROM node:20-alpine as builder

WORKDIR /app
COPY package.json package-lock.json ./
COPY client/package.json client/package-lock.json ./client/
COPY server/package.json server/package-lock.json ./server/
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Runtime
FROM node:20-alpine

WORKDIR /app
COPY --from=builder /app/package.json /app/package-lock.json ./
COPY --from=builder /app/bin ./bin
COPY --from=builder /app/client/dist ./client/dist
COPY --from=builder /app/server/build ./server/build

RUN npm install --production

EXPOSE 3000
CMD ["npm", "start"]
