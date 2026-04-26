pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "nithin-portfolio"
        BLUE_CONTAINER = "nithin-portfolio-blue"
        GREEN_CONTAINER = "nithin-portfolio-green"
        BLUE_PORT = "3000"
        GREEN_PORT = "3001"
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
                echo 'Building new Docker image...'
                retry(3) {
                    sh 'docker build -t ${DOCKER_IMAGE}:new .'
                }
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'docker run --rm ${DOCKER_IMAGE}:new npm test'
            }
        }

        stage('Deploy Green') {
            steps {
                echo 'Deploying GREEN container...'
                sh '''
                    docker stop ${GREEN_CONTAINER} || true
                    docker rm ${GREEN_CONTAINER} || true
                    docker run -d \
                        --name ${GREEN_CONTAINER} \
                        -p ${GREEN_PORT}:3000 \
                        --restart always \
                        ${DOCKER_IMAGE}:new
                '''
            }
        }

        stage('Health Check Green') {
            steps {
                echo 'Checking GREEN container health...'
                retry(5) {
                    sleep(time: 5, unit: 'SECONDS')
                    sh 'curl -f http://localhost:3001 || exit 1'
                }
            }
        }

        stage('Switch Traffic') {
            steps {
                echo 'GREEN is healthy - Switching traffic...'
                sh '''
                    docker stop ${BLUE_CONTAINER} || true
                    docker rm ${BLUE_CONTAINER} || true
                    docker stop ${GREEN_CONTAINER} || true
                    docker rm ${GREEN_CONTAINER} || true
                    docker run -d \
                        --name ${BLUE_CONTAINER} \
                        -p ${BLUE_PORT}:3000 \
                        --restart always \
                        ${DOCKER_IMAGE}:new
                    docker tag ${DOCKER_IMAGE}:new ${DOCKER_IMAGE}:previous
                '''
            }
        }

        stage('Health Check Final') {
            steps {
                echo 'Final health check on port 3000...'
                retry(5) {
                    sleep(time: 5, unit: 'SECONDS')
                    sh 'curl -f http://localhost:3000 || exit 1'
                }
            }
        }

    }

    post {
        success {
            echo '✅ Blue/Green Deployment SUCCESS - Portfolio LIVE at port 3000'
        }
        failure {
            echo '❌ Deployment FAILED - Rolling back...'
            sh '''
                docker stop ${GREEN_CONTAINER} || true
                docker rm ${GREEN_CONTAINER} || true
                docker run -d \
                    --name ${BLUE_CONTAINER} \
                    -p ${BLUE_PORT}:3000 \
                    --restart always \
                    ${DOCKER_IMAGE}:previous || echo "No previous version to rollback"
            '''
        }
        always {
            echo '🧹 Cleaning up...'
            sh 'docker image prune -f'
        }
    }
}