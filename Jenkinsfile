pipeline {
    agent {
        label 'php'
    }

    options {
        disableConcurrentBuilds()
    }

    environment {
        CONTAINER_NAME = 'atomy/discord-bot'
        REGISTRY_ADDRESS = 'registry124123.azurecr.io'
        DEPLOY_SSH_TARGET = 'discord@127.0.0.1'
        DEPLOY_DIR = 'discord-bot'
        STEAM_APPID = '55555'
        DISCORD_API_KEY = 'supersecretapikey888'
        STEAM_API_KEY = 'steamapikey99234234'
    }

    stages {
        stage('Checkout') {
            steps {
                dir('app') {
                    scm checkout
                    sh 'git reset --hard HEAD'
                    sh 'git clean -x -f -d'
                }
            }
        }

        // build the container to be pushed to registry
        stage('Build Container') {
            steps {
                dir('app') {
                    sh 'build/buildContainer.sh'
                }
            }
        }

        // deploy the previous built container to the app slave
        stage('Deploy Container') {
            steps {
                dir('app') {
                    sshagent (credentials: ['52fa7bdf-0e80-4510-917c-a6ec0ca1e8c4']) {
                        sh 'build/deployContainer.sh'
                    }
                }
            }
        }
    }
}