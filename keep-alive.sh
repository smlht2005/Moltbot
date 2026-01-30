#!/bin/bash
# Moltbot Gateway Keep-Alive Script
# 自動監控並重啟 Gateway

LOGFILE="/tmp/keep-alive.log"
CHECK_INTERVAL=60  # 每 60 秒檢查一次

echo "$(date): Keep-alive script started" >> "$LOGFILE"

while true; do
    # 檢查 Gateway 是否在運行
    if ! pgrep -f "clawdbot-gateway" > /dev/null; then
        echo "$(date): Gateway not running, restarting..." >> "$LOGFILE"
        nohup clawdbot gateway --bind lan > /tmp/gateway.log 2>&1 &
        sleep 10
    fi
    
    # 檢查 HTTP 回應
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:18789/ 2>/dev/null)
    if [ "$HTTP_CODE" != "200" ]; then
        echo "$(date): Gateway not responding (HTTP: $HTTP_CODE), restarting..." >> "$LOGFILE"
        pkill -f "clawdbot-gateway"
        sleep 2
        nohup clawdbot gateway --bind lan > /tmp/gateway.log 2>&1 &
        sleep 10
    fi
    
    # 等待下一次檢查
    sleep $CHECK_INTERVAL
done
