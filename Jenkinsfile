pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "srgunjal/python-ci-jenkins-demo"
    }

    stages {

        stage('Run Tests') {
            steps {
                sh '''
                docker run --rm -v $PWD:/app -w /app python:3.10-slim bash -c "
                    pip install --upgrade pip &&
                    pip install -r requirements.txt &&
                    pytest tests/
                "
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t $DOCKER_IMAGE:${BUILD_NUMBER:-latest} ./docker
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