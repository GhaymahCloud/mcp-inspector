# Use Node.js 18 base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./
COPY server/package.json ./server/
COPY tsconfig.json ./

# Install dependencies
RUN npm ci

# Copy application files
COPY . .

# Build the application
RUN npm run build

# Install PM2 globally
RUN npm install -g pm2

# Set environment variables
ENV NODE_ENV production
ENV PORT 3000

# Expose necessary ports
EXPOSE ${PORT}

# Command to run both services using PM2
CMD ["pm2", "start", "npm", "--", "run", "start-server", "&&", "npm", "run", "start-client"]
