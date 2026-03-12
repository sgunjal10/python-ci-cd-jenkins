pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "srgunjal/python-ci-jenkins-demo"
    }

    stages {

        stage('Checkout') {
            steps { git 'https://github.com/sgunjal10/python-ci-cd-jenkins.git' }
        }

        stage('Run Tests') {
            steps { sh 'scripts/run_tests.sh' }
        }

        stage('Build Docker Image') {
            steps { sh 'scripts/build_image.sh' }
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