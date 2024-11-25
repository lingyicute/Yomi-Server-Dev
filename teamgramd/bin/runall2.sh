#!/usr/bin/env bash

# 获取当前日期
current_date=$(date +"%Y-%m-%d")
log_dir="../logs-$current_date"

# 创建日志目录（如果不存在）
mkdir -p "$log_dir"

# 定义要运行的服务及其配置文件
services=(
    "idgen"
    "status"
    "authsession"
    "dfs"
    "media"
    "biz"
    "msg"
    "sync"
    "bff"
    "session"
    "gnetway"
)

# 检查所有可执行文件是否存在
all_exist=true
for service in "${services[@]}"; do
    if [[ ! -x ./$service ]]; then
        echo "Error: $service executable not found!"
        all_exist=false
    fi
done

# 如果所有可执行文件存在，则开始启动服务
if $all_exist; then
    # 启动服务
    for service in "${services[@]}"; do
        echo "run $service ..."
        nohup ./$service -f=../etc/$service.yaml >> "$log_dir/$service.log" 2>&1 &
        sleep 1
    done

    # 等待五秒钟
    sleep 5

    # 检查所有进程是否成功运行
    all_running=true
    for service in "${services[@]}"; do
        if pgrep -f "$service" > /dev/null; then
            echo "$service 正在运行。"
        else
            echo "Error: $service is not running."
            all_running=false
        fi
    done

    # 提示全部成功运行
    if $all_running; then
        echo "已全部成功运行并测试。"
    fi
else
    echo "启动过程终止，因为某些可执行文件未找到。"
fi
