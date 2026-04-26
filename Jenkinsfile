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
                retry(3) {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'docker run --rm ${DOCKER_IMAGE} npm test'
            }
        }

        stage('Backup Old Container') {
            steps {
                echo 'Backing up old container...'
                sh '''
                    docker tag ${DOCKER_IMAGE} ${DOCKER_IMAGE}:previous || true
                '''
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

        stage('Health Check') {
            steps {
                echo 'Running health check...'
                retry(5) {
                    sleep(time: 5, unit: 'SECONDS')
                    sh 'curl -f http://localhost:3000 || exit 1'
                }
            }
        }

    }

    post {
        success {
            echo '✅ Pipeline SUCCESS - Portfolio is LIVE at port 3000'
        }
        failure {
            echo '❌ Pipeline FAILED - Rolling back to previous version...'
            sh '''
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                docker run -d \
                    --name ${CONTAINER_NAME} \
                    -p 3000:3000 \
                    --restart always \
                    ${DOCKER_IMAGE}:previous || echo "No previous version found"
            '''
        }
        always {
            echo '🧹 Cleaning up unused Docker images...'
            sh 'docker image prune -f'
        }
    }
}