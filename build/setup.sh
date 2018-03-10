#!/bin/bash

set -e

function validateEnv() {
    if [ -z "${CONTAINER_NAME}" ] ; then
        echo "ENV variable CONTAINER_NAME is not set!"
        exit 1
    fi

    if [ -z "${REGISTRY_ADDRESS}" ] ; then
        echo "ENV variable REGISTRY_ADDRESS is not set!"
        exit 1
    fi
}

# build container
function buildContainer() {
    echo "Building Container..."
    docker build -t atomy/discord-bot:latest .
    echo "Building PHP Container... DONE"
}

validateEnv
buildContainer

echo "ALL DONE"
