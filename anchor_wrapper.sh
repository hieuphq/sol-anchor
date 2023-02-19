#!/bin/bash

PROJECT_NAME=$1
DOCKER_IMAGE=$2

if [ -z "$PROJECT_NAME" ]; then
  echo "Please specify a project name"
  exit 1
fi

if [ -z "$DOCKER_IMAGE" ]; then
  DOCKER_IMAGE="solana-anchor:latest"
fi

# Check if the Docker image is available locally, and pull it if it's not
if ! docker inspect "$DOCKER_IMAGE" > /dev/null 2>&1; then
  echo "Pulling Docker image $DOCKER_IMAGE ..."
  docker pull "$DOCKER_IMAGE"
fi

# Launch the Docker container, and execute the Anchor init command inside it
echo "Initializing new Solana project '$PROJECT_NAME' using Docker image $DOCKER_IMAGE ..."
docker run -it --rm -v $(pwd):/app "$DOCKER_IMAGE" sh -c "cd /app && anchor init $PROJECT_NAME"