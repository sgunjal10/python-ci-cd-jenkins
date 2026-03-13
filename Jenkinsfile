pipeline {
    agent {
        dockerContainer {
            image 'python:3.10-slim'
            args '-v /var/run/docker.sock:/var/run/docker.sock'  // Access host Docker
        }
    }

    environment {
        DOCKER_IMAGE = "srgunjal/python-ci-jenkins-demo"
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh 'pip install --upgrade pip'
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'scripts/run_tests.sh'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t $DOCKER_IMAGE:${BUILD_NUMBER:-latest} -f docker/Dockerfile .
                docker tag $DOCKER_IMAGE:${BUILD_NUMBER:-latest} $DOCKER_IMAGE:latest
                '''
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