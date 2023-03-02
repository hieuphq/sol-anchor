#!/bin/bash

PROJECT_NAME=$1
DOCKER_IMAGE=$2

if [ -z "$PROJECT_NAME" ]; then
  echo "Please specify a project name"
  exit 1
fi

if [ -z "$DOCKER_IMAGE" ]; then
  DOCKER_IMAGE="hieuphq/sol-anchor:v0.1"
fi

# Check if the Docker image is available locally, and pull it if it's not
if ! docker inspect "$DOCKER_IMAGE" > /dev/null 2>&1; then
  echo "Pulling Docker image $DOCKER_IMAGE ..."
  docker pull "$DOCKER_IMAGE"
fi

# Launch the Docker container, and execute the Anchor init command inside it
echo "Initializing new Solana project '$PROJECT_NAME' using Docker image $DOCKER_IMAGE ..."
docker run -it --rm -v $(pwd):/app "$DOCKER_IMAGE" bash -c "cd /app && anchor init $PROJECT_NAME"

# Create a new file called `anchor.sh` in the initialized project directory
project_dir=$(pwd)/${PROJECT_NAME}
touch ${project_dir}/anchor.sh
cat > "${project_dir}/anchor.sh" <<EOF
#!/bin/bash
DOCKER_IMAGE=$1

if [ -z "$DOCKER_IMAGE" ]; then
  DOCKER_IMAGE="hieuphq/sol-anchor:v0.1"
fi

# Check if the Docker image is available locally, and pull it if it's not
if ! docker inspect "$DOCKER_IMAGE" > /dev/null 2>&1; then
  echo "Pulling Docker image $DOCKER_IMAGE ..."
  docker pull "$DOCKER_IMAGE"
fi

docker run -it --rm -v $(pwd)/app "$DOCKER_IMAGE" bash -c "cd /app && anchor $@"
EOF

# Make the `anchor.sh` file executable
chmod +x "$project_dir/anchor.sh"