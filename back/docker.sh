#!/bin/bash

SERVICE=$1

# Set your image details
DOCKERFILE_PATH="$SERVICE/Dockerfile.dev"
IMAGE_TAG=$1
REGISTRY="trumanpurnell"
REPO="sage"

# Build the Docker image
docker build -t "$IMAGE_TAG" -f "$DOCKERFILE_PATH" "$SERVICE"

# Tag the Docker image
docker tag "$IMAGE_TAG" "$REGISTRY/$REPO:$IMAGE_TAG"

# Push the Docker image
docker push "$REGISTRY/$REPO:$IMAGE_TAG"

# Clean up the local image (optional)
docker image rm "$IMAGE_TAG"
