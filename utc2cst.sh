#!/bin/sh
set -e

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
echo "Asia/Shanghai" > /etc/timezone

echo "[i] change timezone success"
exec date