#!/bin/bash

set -e

function validateEnv() {
    if [ -z "${DEPLOY_SSH_TARGET}" ] ; then
        echo "ENV variable DEPLOY_SSH_TARGET is not set!"
        exit 1
    fi

    if [ -z "${DEPLOY_DIR}" ] ; then
        echo "ENV variable DEPLOY_DIR is not set!"
        exit 1
    fi

    if [ -z "${DISCORD_API_KEY}" ] ; then
        echo "ENV variable DISCORD_API_KEY is not set!"
        exit 1
    fi

    if [ -z "${STEAM_API_KEY}" ] ; then
        echo "ENV variable STEAM_API_KEY is not set!"
        exit 1
    fi

    if [ -z "${STEAM_APPID}" ] ; then
        echo "ENV variable STEAM_APPID is not set!"
        exit 1
    fi

    if [ -z "${REGISTRY_ADDRESS}" ] ; then
        echo "ENV variable REGISTRY_ADDRESS is not set!"
        exit 1
    fi

    if [ -z "${CONTAINER_NAME}" ] ; then
        echo "ENV variable CONTAINER_NAME is not set!"
        exit 1
    fi
}

function prepareCompose() {
    sed -i "s~#DISCORD_API_KEY#~${DISCORD_API_KEY}~" docker-compose-prod.yml
    sed -i "s~#STEAM_API_KEY#~${STEAM_API_KEY}~" docker-compose-prod.yml
    sed -i "s~#STEAM_APPID#~${STEAM_APPID}~" docker-compose-prod.yml
}

function shutdownContainer() {
    echo "Shutting down container on deploy target: *${DEPLOY_SSH_TARGET}*! ..."
    ssh ${DEPLOY_SSH_TARGET} "export USER_ID=`id -u` && export GROUP_ID=`id -g` && cd ${DEPLOY_DIR}/ && docker-compose down -v"
    ssh ${DEPLOY_SSH_TARGET} "rm ${DEPLOY_DIR}/docker-compose.yml"
    echo "Shutting down container on deploy target: *${DEPLOY_SSH_TARGET}*! DONE"
}

function startupContainer() {
    scp docker-compose-prod.yml ${DEPLOY_SSH_TARGET}:~/${DEPLOY_DIR}/docker-compose.yml
    ssh ${DEPLOY_SSH_TARGET} "export USER_ID=`id -u` && export GROUP_ID=`id -g` && cd ${DEPLOY_DIR} && docker-compose pull"
    ssh ${DEPLOY_SSH_TARGET} "export USER_ID=`id -u` && export GROUP_ID=`id -g` && export DOCKER_CLIENT_TIMEOUT=120 && export COMPOSE_HTTP_TIMEOUT=120 && cd ${DEPLOY_DIR}/ && docker-compose up -d"
}

validateEnv
prepareCompose
shutdownContainer
startupContainer

echo "ALL DONE"