pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "kareemgamal/streamlit-app-2"  // Updated image name to 'streamlit-app-2'
        DOCKER_CREDENTIALS_ID = "docker-hub-creds" // Jenkins credentials ID for Docker Hub
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
