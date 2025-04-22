# Use official Node.js image as base
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Copy only the package files first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the code
COPY . .

# Build the Strapi admin panel
RUN npm run build

# Expose the port Strapi runs on
EXPOSE 1337

# Start the Strapi app
CMD ["npm", "start"]
