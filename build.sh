#!/bin/bash
#

REGISTRY_URL="chiral.sakuracr.jp"

function build_and_push_docker_image() {
    if [ -z "$1" ]; then
        echo "Error: No directory provided. Usage: build_and_push_docker_image <directory_path>"
        return 1
    fi

    local DIR="$1"

    echo "Entering $DIR"
    cd "$DIR" || {
        echo "Failed to enter $DIR"
        continue
    }

    fullname=$(basename "$PWD")
    app_name=$(echo "$fullname" | cut -d'_' -f1)
    date=$(echo "$fullname" | cut -d'_' -f2-)

    echo "Build container image for app $app_name, version: $date"
    image_name=${app_name}_${date}
    image_name_remote=${REGISTRY_URL}/${app_name}:${date}

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
        docker push ${image_name_remote}
    fi

    cd - >/dev/null
}

if [ -n "$1" ]; then
    echo "Build the image for folder: $1"
    build_and_push_docker_image "$1"
else
    echo "Build all the images"

    SUBFOLDERS=$(find . -mindepth 2 -maxdepth 2 -type d ! -path "*/.git*")

    for DIR in $SUBFOLDERS; do
        build_and_push_docker_image "$DIR"
    done
fi
