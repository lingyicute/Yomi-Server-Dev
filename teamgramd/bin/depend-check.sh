#!/bin/bash

echo "正在检查依赖项状态..."
echo "------------------------------"

# 检查 MySQL 服务
if systemctl is-active --quiet mysqld; then
    echo "Mysql 正在运行。"
else
    echo "（警告！）Mysql 服务未运行！（警告！）"
fi

echo "------------------------------"

# 检查 MinIO 服务
if screen -list | grep -q "minio_session"; then
    echo "MinIO 正在运行。"
else
    echo "（警告！）MinIO 服务未运行！（警告！）"
fi

echo "------------------------------"

# 检查 etcd 服务
if screen -list | grep -q "etcd_session"; then
    echo "etcd 正在运行。"
else
    echo "（警告！）etcd 服务未运行！（警告！）"
fi

echo "------------------------------"

# 检查 Redis 服务
if valkey-cli ping | grep -q "PONG"; then
    echo "Redis 正在运行。"
else
    echo "（警告！）Redis 服务未运行！（警告！）"
fi

echo "------------------------------"

# 检查 Kafka 服务
running_processes=$(ps aux | grep -c "[k]afka_2.13-3.9.0")
if [ "$running_processes" -ge 2 ]; then
    echo "Kafka 正在运行。"
else
    echo "（警告！）Kafka 服务未运行！（警告！）"
fi

echo "------------------------------"
echo "所有服务状态检查完成。"
