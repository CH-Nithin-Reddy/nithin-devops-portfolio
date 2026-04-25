pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "nithin-portfolio"
        CONTAINER_NAME = "nithin-portfolio-app"
        PORT = "3000"
    }

    stages {

        stage('Clone') {
            steps {
                echo 'Cloning repository...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'docker run --rm ${DOCKER_IMAGE} npm test'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying container...'
                sh '''
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    docker run -d \
                        --name ${CONTAINER_NAME} \
                        -p ${PORT}:3000 \
                        --restart always \
                        ${DOCKER_IMAGE}
                '''
            }
        }

    }

    post {
        success {
            echo '✅ Pipeline SUCCESS - Portfolio is LIVE at port 3000'
        }
        failure {
            echo '❌ Pipeline FAILED - Check logs above'
        }
    }
}