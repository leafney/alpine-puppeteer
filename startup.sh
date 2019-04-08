#!/bin/sh
set -e

WDir=/app

if [ "$(ls -A ${WDir})" ]; then
    echo "[i] ***** dir /app have files,so start init. *****"

    echo "[i] ***** yarn install *****"
    yarn install
    
    echo "[i] ***** pm2 start *****"
    pm2-runtime start ecosystem.config.js
else
    echo "[e] ***** dir /app is empty,so can not run. *****"

    echo "[i] ***** Please copy project files to VOLUME for /app and then restart docker container *****"
    node
fi