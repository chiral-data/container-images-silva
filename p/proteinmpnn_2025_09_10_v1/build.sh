#!/bin/bash
#

REGISTRY_URL="chiral.sakuracr.jp"
today=$(date +"%Y_%m_%d")

app_name=$(basename "$PWD")
image_name=${app_name}_${today}
image_name_remote=${REGISTRY_URL}/${app_name}:${today}

if docker manifest inspect "$image_name_remote" >/dev/null 2>&1; then
    echo "Container image $image_name_remote exist ... Skip build"
else
    echo "Building container image $image_name"
    echo ""
    docker build -t ${image_name} --platform linux/amd64 .
    docker run --gpus all ${image_name}

    echo "Tag container image $image_name"
    docker tag ${image_name} ${image_name_remote}

    echo "Push container image $image_name"
    docker push ${REGISTRY_URL}/${app_name}:${today}
fi
