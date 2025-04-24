#Base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files first for caching
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the app
COPY . .

# Copy environment variables if needed
COPY .env .env

# Build the app (if needed)
RUN npm run build

# Expose default Strapi port
EXPOSE 1337

# Start the app
CMD ["npm", "run", "start"]
