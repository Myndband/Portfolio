# Stage 1: Build the Angular app
FROM node:14 as build

WORKDIR /app
COPY package*.json ./

RUN npm install
COPY . .

# Build the Angular app with production configuration
RUN npm run build

# Stage 2: Create a lightweight web server to serve the Angular app
FROM nginx:alpine

# Remove the default nginx configuration
RUN rm -rf /usr/share/nginx/html/*

# Copy the built Angular app from the previous stage
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start the nginx web server
CMD ["nginx", "-g", "daemon off;"]
