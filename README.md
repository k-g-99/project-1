### Dockerizing an Angular App and Pushing It to Docker Hub

#### Step 1: Create a `Dockerfile` for Angular App

1. **Navigate to your Angular project directory**.
2. **Create a `Dockerfile`** in the root of your Angular project (the same directory as `package.json`).

Here’s the `Dockerfile` for the `kg-angular` app:

```Dockerfile
# Step 1: Build the Angular app using Node.js
FROM node:18 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./

# Install Angular CLI globally and other dependencies
RUN npm install -g @angular/cli
RUN npm install

# Copy the rest of your application source code
COPY . .

# Build the Angular app in production mode
RUN ng build --prod

# Step 2: Set up Nginx to serve the built Angular app
FROM nginx:alpine

# Copy the Angular build files from the build stage to Nginx
COPY --from=build /app/dist/kg-angular /usr/share/nginx/html

# Expose port 80 to allow access to the app
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
```

- **Explanation**:
  - `FROM node:18 AS build`: Uses the official Node.js image to build the Angular app.
  - `WORKDIR /app`: Sets `/app` as the working directory inside the container.
  - `COPY package*.json ./`: Copies the `package.json` and `package-lock.json` (if any) to install dependencies.
  - `RUN npm install -g @angular/cli` and `RUN npm install`: Installs Angular CLI and project dependencies.
  - `COPY . .`: Copies the rest of your source code into the container.
  - `RUN ng build --prod`: Builds the app for production.
  - `FROM nginx:alpine`: Uses Nginx to serve the built Angular app.
  - `COPY --from=build /app/dist/kg-angular /usr/share/nginx/html`: Copies the build files into the Nginx web root.
  - `EXPOSE 80`: Exposes port 80 for accessing the app.
  - `CMD ["nginx", "-g", "daemon off;"]`: Starts the Nginx server.

#### Step 2: Build the Docker Image

Now, from the root of your Angular app (where the `Dockerfile` is located), run the following command to build your Docker image:

```bash
docker build -t kg-angular/angular-app .
```

- **Explanation**:
  - `-t kg-angular/angular-app`: Tags your image with the name `kg-angular/angular-app`. This uses `kg-angular` as your Docker Hub username and `angular-app` as the image name.
  - `.`: Tells Docker to use the `Dockerfile` in the current directory.

#### Step 3: Run the Docker Container Locally (Optional)

You can run the container locally to make sure everything is working before pushing it to Docker Hub:

```bash
docker run -d -p 8080:80 kg-angular/angular-app
```

- **Explanation**:
  - This runs the container in detached mode (`-d`) and maps port 8080 on your host to port 80 on the container.
  - Open your browser and navigate to `http://localhost:8080` to see the Angular app running.

#### Step 4: Push the Image to Docker Hub

1. **Login to Docker Hub** (if not already logged in):
   ```bash
   docker login
   ```
   You will be prompted for your Docker Hub credentials.

2. **Push the Docker image** to Docker Hub:
   ```bash
   docker push kg-angular/angular-app
   ```

- This uploads your image to Docker Hub, where it can be accessed from anywhere.

#### Step 5: Verify the Image on Docker Hub

1. Go to [Docker Hub](https://hub.docker.com/).
2. Navigate to your account and you should see the `angular-app` repository with the image pushed.

---

### Complete Example

**Dockerfile**:

```Dockerfile
# Step 1: Build the Angular app using Node.js
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install -g @angular/cli
RUN npm install

COPY . .

RUN ng build --prod

# Step 2: Set up Nginx to serve the built Angular app
FROM nginx:alpine

COPY --from=build /app/dist/kg-angular /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

**Build Docker Image**:

```bash
docker build -t kg-angular/angular-app .
```

**Run Docker Image Locally**:

```bash
docker run -d -p 8080:80 kg-angular/angular-app
```

**Push Image to Docker Hub**:

```bash
docker push kg-angular/angular-app
```
