# Streamlit App with Docker and Jenkins CI/CD Pipeline

This project describes how to create a **Streamlit app**, package it in a **Docker image**, and use **Jenkins** to automate the process of pushing the Docker image to **Docker Hub** from a **GitHub repository**.

## Project Overview

In this project, A **Streamlit** application has been developed and created a **Docker image** for it, and set up a **Jenkins CI/CD pipeline** to automate the process of pushing the Docker image to Docker Hub whenever there is an update in the GitHub repository.

### Steps Taken:

1. **Created Streamlit Application**
2. **Dockerized the Application**
3. **Installed Jenkins**
4. **Created Jenkins Pipeline to Automate the Build and Push Process**

---

## 1. Streamlit Application

The first step was to create a simple **Streamlit application** that will be containerized in the following steps.

### Files in the Project:
- **app.py**: The main application file for Streamlit.
- **requirements.txt**: Contains the dependencies needed to run the app (like Streamlit).
- **Dockerfile**: Describes how to build the Docker image for the app.

---

## 2. Dockerizing the Streamlit Application

To run the Streamlit application in a containerized environment, I created a **Docker image** by following these steps:

### Dockerfile
Here is the **Dockerfile** I used to build the Docker image:

```Dockerfile
# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8501 available to the world outside the container
EXPOSE 8501

# Define environment variable
ENV STREAMLIT_APP=app.py

# Run the Streamlit app
CMD ["streamlit", "run", "app.py"]
```

### Build the Docker Image:
To build the Docker image locally:

```bash
docker build -t kareemgamal/streamlit-app-2:latest .
```

### Run the Docker Container:
Once the image was built, I ran it as a container:

```bash
docker run -p 8501:8501 kareemgamal/streamlit-app-2:latest
```

This makes the application accessible on [http://localhost:8501](http://localhost:8501).

---

## 3. Jenkins Installation

I used **Jenkins** to automate the process of building and pushing the Docker image to **Docker Hub**.

### Steps for Installing Jenkins on an Ubuntu Server:
1. **Update Package List**:

   ```bash
   sudo apt update
   ```

2. **Install Java (Required for Jenkins)**:

   ```bash
   sudo apt install openjdk-11-jdk
   ```

3. **Add Jenkins Repository and Install**:

   ```bash
   wget -q -O - https://pkg.jenkins.io/keys/jenkins.io.key | sudo tee /etc/apt/trusted.gpg.d/jenkins.asc
   sudo sh -c 'echo deb http://pkg.jenkins.io/debian/ stable main > /etc/apt/sources.list.d/jenkins.list'
   sudo apt update
   sudo apt install jenkins
   ```

4. **Start Jenkins Service**:

   ```bash
   sudo systemctl start jenkins
   sudo systemctl enable jenkins
   ```

5. **Access Jenkins Web Interface**:
   - Open Jenkins in the browser: [http://<your-server-ip>:8080](http://<your-server-ip>:8080)
   - You can retrieve the Jenkins password from: `/var/lib/jenkins/secrets/initialAdminPassword`

---

## 4. Jenkins CI/CD Pipeline

Once Jenkins was installed, I created a **Jenkins pipeline** in the `Jenkinsfile` to automate the process of building the Docker image and pushing it to Docker Hub.

### Steps for Creating the Jenkinsfile:

The **Jenkinsfile** consists of the following stages:

1. **Clone Repository**: Clone the GitHub repository where the source code is stored.
2. **Build Docker Image**: Build the Docker image from the Dockerfile.
3. **Push to Docker Hub**: Push the built image to Docker Hub using Docker credentials.

Here is the **Jenkinsfile**:

```groovy
pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "kareemgamal/streamlit-app-2"  // Image name for Docker Hub
        DOCKER_CREDENTIALS_ID = "docker-hub-creds"   // Jenkins credentials ID for Docker Hub
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/k-g-99/project-1.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', DOCKER_CREDENTIALS_ID) {
                        sh "docker push ${DOCKER_IMAGE}:latest"
                    }
                }
            }
        }
    }
}
```

### Steps to Set Up Jenkins:

1. **Install Docker on Jenkins**: Ensure Jenkins has Docker installed and the permissions are set up correctly.
   - Add Jenkins to the Docker group:
     ```bash
     sudo usermod -aG docker jenkins
     sudo systemctl restart jenkins
     ```

2. **Configure Jenkins Credentials for Docker Hub**:
   - Go to **Jenkins Dashboard** > **Manage Jenkins** > **Manage Credentials**.
   - Add your Docker Hub credentials with the ID `docker-hub-creds`.

3. **Create a New Pipeline Job**:
   - In Jenkins, create a new **Pipeline** job.
   - Configure it to point to your GitHub repository and use the `Jenkinsfile` from the repository.

4. **Run the Pipeline**:
   - Trigger the pipeline to test if the Docker image gets built and pushed to Docker Hub.

---

## Conclusion

By following these steps, I was able to:
1. Create and Dockerize a **Streamlit application**.
2. Set up **Jenkins** to automate the process of building and pushing the Docker image to **Docker Hub**.
3. Store the **Docker Hub credentials** securely in Jenkins and configure a **Jenkins pipeline** to pull updates from GitHub, build the image, and push it to Docker Hub.

Now, the application is available as a Docker image on Docker Hub, and any future changes to the GitHub repository will trigger the Jenkins pipeline to rebuild and push the updated image.
