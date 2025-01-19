#!/bin/bash

# Build and tag images
echo "Building Docker images..."
docker-compose build

echo "Tagging images..."
docker tag backend:latest your-dockerhub-username/backend:latest
docker tag frontend:latest your-dockerhub-username/frontend:latest

echo "Pushing images to Docker Hub..."
docker push your-dockerhub-username/backend:latest
docker push your-dockerhub-username/frontend:latest

echo "Pulling and deploying images..."
docker-compose pull
docker-compose up -d
