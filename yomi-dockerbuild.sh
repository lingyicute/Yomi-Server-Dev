#!/bin/bash

# 克隆 GitHub 仓库
git clone https://github.com/lingyicute/Yomi-Server-Dev

# 进入项目目录
cd Yomi-Server-Dev || { echo "目录不存在"; exit 1; }

# 运行 Docker 命令
docker run --rm -v "$PWD":/root/yomibuild -w /root/yomibuild golang:1.20.14 sh ./build.sh
