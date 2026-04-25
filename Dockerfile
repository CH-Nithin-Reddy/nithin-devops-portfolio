# Base image
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Copy package.json first
COPY package.json .

# Install dependencies
RUN npm install

# Copy rest of app
COPY . .

# Expose port
EXPOSE 3000

# Start app
CMD ["node", "app.js"]