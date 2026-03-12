#!/bin/bash
set -e

IMAGE_NAME="srgunjal/python-ci-demo"
TAG=${BUILD_NUMBER:-latest}

echo "Building Docker image..."
docker build -t $IMAGE_NAME:$TAG -f docker/Dockerfile .
docker tag $IMAGE_NAME:$TAG $IMAGE_NAME:latest

echo "Docker image built: $IMAGE_NAME:$TAG"