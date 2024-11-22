# Project README

## Overview

This project involves creating a Docker container for a **Streamlit** web application. The container runs a **Streamlit app** that is accessible locally and remotely via a browser. The goal is to build the application, test it locally, make any code modifications, and push the Docker image to **Docker Hub** for sharing and deployment.

## Steps Completed Today

### 1. **Dockerfile Creation**
   - Created a Dockerfile to set up the Streamlit web app.
   - The Dockerfile includes:
     - Using the Python 3.9 slim image as the base image.
     - Installing necessary dependencies such as `curl`, `git`, and `build-essential`.
     - Cloning the **Streamlit example** repository from GitHub.
     - Installing Python dependencies from the `requirements.txt`.
     - Exposing port `8501` for Streamlit to run on.
     - Health check to ensure the Streamlit server is running correctly.
     - Using the `ENTRYPOINT` to run the Streamlit app with the appropriate configuration.

### 2. **Local Changes to Streamlit Code**
   - Made local code changes to the Streamlit app (`streamlit_app.py`).
   - Used volume mounting to mount the local directory into the Docker container, so changes made to the code reflect instantly in the container.

### 3. **Running the Docker Container**
   - Built and ran the Docker container locally, ensuring the Streamlit app was accessible at `http://localhost:8501`.
   - Made changes to the app code and verified the immediate updates without needing to rebuild the image.

### 4. **Pushing Image to Docker Hub**
   - Tagged the Docker image with my Docker Hub username and repository name.
   - Pushed the Docker image to Docker Hub for easy sharing and deployment.
   - The image was successfully uploaded to the Docker Hub repository: `yourusername/streamlit-app`.

### 5. **Stopping and Cleaning Up Docker Containers**
   - Stopped and removed multiple containers using Docker commands.
   - Ensured the local environment was clean and ready for further development.

## Running the App

To run the Streamlit app on your local machine using Docker, follow these steps:

1. Clone this repository and navigate to the project directory.
2. Build the Docker image with the following command:
   ```bash
   docker build -t yourusername/streamlit-app:latest .
   ```
3. Run the Docker container:
   ```bash
   docker run -d -p 8501:8501 yourusername/streamlit-app:latest
   ```
4. Access the Streamlit app via your browser:
   - **Local**: `http://localhost:8501`
   - **Global (if running on cloud)**: `http://<Elastic_IP>:8501`

## Conclusion

Today, I successfully:
- Created a Dockerfile to containerize a Streamlit app.
- Made local changes to the app code and tested it in the Docker container.
- Pushed the Docker image to Docker Hub for easy access.
- Cleaned up the Docker environment.
