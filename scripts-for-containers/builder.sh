#!/bin/bash

set -e

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <github_repo> <dockerhub_repo>"
  echo "Example: $0 leovuonnala/material-applications leovuo/material-applications"
  exit 1
fi

if [ -z "$DOCKER_USER" ] || [ -z "$DOCKER_PWD" ]; then
  echo "Error: DOCKER_USER and DOCKER_PWD environment variables must be set"
  exit 1
fi

GITHUB_REPO=$1
DOCKERHUB_REPO=$2

REPO_NAME=$(basename "$GITHUB_REPO")

echo "Cloning https://github.com/$GITHUB_REPO ..."
git clone "https://github.com/$GITHUB_REPO.git"

cd "$REPO_NAME"

if [ ! -f Dockerfile ]; then
  echo "Error: Dockerfile not found in repository root."
  exit 1
fi

IMAGE_TAG="${DOCKERHUB_REPO}:latest"

echo "Building Docker image $IMAGE_TAG ..."
docker build -t "$IMAGE_TAG" .

echo "Logging in to Docker Hub..."
echo "$DOCKER_PWD" | docker login --username "$DOCKER_USER" --password-stdin

echo "Pushing image to Docker Hub..."
docker push "$IMAGE_TAG"

echo "Done: Image pushed to $IMAGE_TAG"