#!/bin/bash

# 定义要关闭的服务列表
services=("gnetway" "session" "biz" "authsession" "status" "idgen" "media" "dfs" "msg" "sync" "bff")

# 关闭所有服务
for service in "${services[@]}"; do
    if pgrep -x "$service" > /dev/null; then
        killall "$service"
        if [ $? -eq 0 ]; then
            echo "$service has been successfully stopped."
        else
            echo "Failed to stop $service."
        fi
    else
        echo "$service is not running, no action taken."
    fi
done
