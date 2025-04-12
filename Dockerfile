# Stage 1: Builder
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the root package.json and package-lock.json files
COPY package.json package-lock.json ./

# Install project-level dependencies
RUN npm ci

# Copy the entire application to the container
COPY . .


# Expose the necessary ports (Client, Server)
EXPOSE 3000 5000

# Start the application
CMD ["npm", "run", "dev"]


