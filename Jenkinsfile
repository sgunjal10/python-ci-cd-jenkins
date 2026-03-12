pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "srgunjal/python-ci-jenkins-demo"
    }

    stages {

        stage('Run Tests in Python Container') {
            agent {
                dockerContainer {
                    image 'python:3.10-slim'
                    // No 'args' needed here; container only runs tests
                }
            }
            steps {
                // Install Python dependencies and run tests
                sh 'pip install --upgrade pip'
                sh 'pip install -r requirements.txt'
                sh 'scripts/run_tests.sh'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Use host Docker directly to build images
                sh 'scripts/build_image.sh'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push $DOCKER_IMAGE:${BUILD_NUMBER:-latest}
                    docker push $DOCKER_IMAGE:latest
                    '''
                }
            }
        }
    }

    post {
        always { echo "Pipeline finished" }
        failure { echo "Pipeline failed!" }
    }
}