# Use a lightweight Node 20 image
FROM node:20-slim

# Set working directory inside the container
WORKDIR /app

# Copy only package files first (to leverage Docker caching)
COPY package*.json ./

# Install dependencies (clean install for reproducibility)
RUN npm install --frozen-lockfile || npm install

# Copy the rest of the project files
COPY . .

# Build the app (for Vite/React projects this creates "dist/")
RUN npm run build

# Expose the port your app runs on (Vite dev is 5173, production can be 5000)
EXPOSE 5173

# Install "serve" to serve built files in production
RUN npm install -g serve

# Command to run production build
CMD ["serve", "-s", "dist", "-l", "5173"]
