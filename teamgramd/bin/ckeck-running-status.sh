#!/bin/bash

# 定义要检测的服务列表
services=("gnetway" "session" "biz" "authsession" "status" "idgen" "media" "dfs" "msg" "sync" "bff")

# 检查每个服务的状态
all_running=true

for service in "${services[@]}"; do
    if ! pgrep -x "$service" > /dev/null; then
        echo "$service is not running."
        all_running=false
    fi
done

if $all_running; then
    echo "All services are running."
else
    echo "Some services are not running."
fi
