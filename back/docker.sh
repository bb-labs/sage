#!/bin/bash

yaml() {
    pipenv run python -c "import yaml;print(yaml.safe_load(open('$1'))$2)"
}

TAG=$(yaml "$1/hub.yml" "['tag']")
REPO=$(yaml "$1/hub.yml" "['repo']")
REGISTRY=$(yaml "$1/hub.yml" "['registry']")

docker build -t "$TAG" -f "$1/Dockerfile.stage" "$1"
docker tag "$TAG" "$REGISTRY/$REPO:$TAG"
docker push "$REGISTRY/$REPO:$TAG"
docker image rm "$TAG"
