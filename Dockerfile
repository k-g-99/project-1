# Step 1: Build the Angular app using Node.js
FROM node:18 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json, then install dependencies
COPY package*.json ./

# Install Angular CLI globally and other dependencies
RUN npm install -g @angular/cli
RUN npm install --verbose

# Copy the rest of the application source code
COPY angular.json tsconfig*.json ./
COPY src ./src

# Build the Angular app in production mode
RUN ng build --configuration=production

# Step 2: Set up Nginx to serve the built Angular app
FROM nginx:alpine

# Copy the Angular build files from the build stage to Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 to allow access to the app
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
