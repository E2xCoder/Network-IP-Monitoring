#!/bin/bash

log_base_dir="./logs"
current_month=$(date +%Y-%m)
log_dir="$log_base_dir/$current_month"
mkdir -p "$log_dir"

current_date=$(date +%F)
log_file="$log_dir/network_log_$current_date.txt"
interval=60

last_ipv4=""
last_ipv6=""

# Telegram bot token and chat_id
TELEGRAM_BOT_TOKEN="TELEGRAM_BOT_TOKEN_IN_HERE"
TELEGRAM_CHAT_ID="TELEGRAM_CHAT_ID_IN_HERE"

send_telegram() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
    -d chat_id="$TELEGRAM_CHAT_ID" -d text="$message" > /dev/null
}

cleanup() {
    message="[ $(date) ] Network Monitor Ended"
    echo "$message" >> "$log_file"
    send_telegram "$message"
    exit 0
}

trap cleanup SIGINT

echo "[ $(date) ] Checking IP. Every $interval seconds." >> "$log_file"

while true
do
    current_ipv4=$(hostname -I | awk '{print $1}')
    current_ipv6=$(hostname -I | awk '{for(i=1;i<=NF;i++) if ($i ~ /:/ && $i !~ /^fe80:/) {print $i; exit}}')

    if [ "$current_ipv4" != "$last_ipv4" ]; then
        message="[ $(date) ] IPv4 Changed: $last_ipv4 → $current_ipv4"
        echo "$message" >> "$log_file"
        send_telegram "$message"
        last_ipv4="$current_ipv4"
    fi

    if [ "$current_ipv6" != "$last_ipv6" ]; then
        message="[ $(date) ] IPv6 Changed: $last_ipv6 → $current_ipv6"
        echo "$message" >> "$log_file"
        send_telegram "$message"
        last_ipv6="$current_ipv6"
    fi

    sleep $interval
done
