# Use official Node.js LTS image
FROM node:lts

# Set working directory
WORKDIR /app

# Switch to non-root user for security
RUN chown -R node:node /app
USER node

# Expose the inspector UI port
EXPOSE 6274

# Run the inspector with explicit host binding
CMD ["npx", "@modelcontextprotocol/inspector", "--host", "0.0.0.0"]
