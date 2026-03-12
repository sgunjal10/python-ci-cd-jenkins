# Python CI/CD with Jenkins & Docker

## Project Overview

This project demonstrates a complete **CI/CD pipeline** using **Jenkins** and **Docker** for a Python application. It shows:

- Running automated tests on both the host VM and inside a Docker container
- Building a Docker image of the application
- Pushing Docker images to Docker Hub
- Using **Jenkins Pipelines** for automation
- Modular project structure with scripts and Docker configuration

---

## Features

- **Multi-environment Testing:** ensures consistency across host and container environments
- **Automated Docker Builds:** builds and tags Docker images automatically
- **Docker Hub Integration:** pushes Docker images securely using Jenkins credentials
- **Clear Project Structure:** separates app, tests, scripts, Docker, and pipeline

---

## Repository Structure
```text
python-ci-cd-jenkins/
├── app/ # Python application code
│ └── main.py
├── docker/ # Docker configuration
│ └── Dockerfile
├── scripts/ # Reusable scripts
│ ├── build_image.sh
│ └── run_tests.sh
├── tests/ # Pytest test cases
│ └── test_app.py
├── .gitignore # Ignored files
├── Jenkinsfile   # Jenkins pipeline
├── README.md # Project documentation
└── requirements.txt # Python dependencies
```

---

## Getting Started

### Prerequisites

- Python 3.10+
- Docker
- Jenkins (running locally inside Docker container)
- Docker Hub account (optional, for pushing images)

### Project Overview:

```text
GitHub Push  →  Jenkins Pipeline   →  Run Tests  
                                   →  Build Docker Image  
                                   →  Push Docker Image to Docker Hub

```

### Running Locally

1. Install dependencies:

```bash
  pip install -r requirements.txt
```

2. Run tests:

```bash
  ./scripts/run_tests.sh
```

3. Build Docker image:

```bash
  ./scripts/build_image.sh
```
---

## Jenkins Pipeline

The Jenkins pipeline is defined in Jenkinsfile and performs the following stages:

- Checkout – Pulls the repo from GitHub

- Run Tests – Executes unit tests with pytest

- Build Docker Image – Builds a Docker image of the app using docker/Dockerfile

- Push Docker Image – Pushes Docker image to Docker Hub (requires Jenkins credentials)

### Jenkins Credentials

Store Docker Hub credentials in Jenkins as Username with password

- ID in Jenkins credentials must match credentialsId in Jenkinsfile

- Username → Docker Hub username

- Password → Docker Hub password

---

## Docker Image

- Built using docker/Dockerfile

- Default command runs tests inside the container (pytest tests/)

- Tagged with latest and optional Jenkins build number

