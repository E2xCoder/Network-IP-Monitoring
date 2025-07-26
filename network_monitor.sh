#!/bin/bash 

log_base_dir="./logs"  # Base folder for all logs
current_month=$(date +%Y-%m)  # Get current month (its like 2025-07)
log_dir="$log_base_dir/$current_month"  # Create folder like ./logs/2025-07
mkdir -p "$log_dir"  # Make the folder if it doesn't exist in file

current_date=$(date +%F)  # Get current date for ex: 2025-07-26
log_file="$log_dir/network_log_$current_date.txt"  # Full log file path
interval=60  # Time to wait between checks, it can be adjust

last_ipv4=""  # Stores previous IPv4 address
last_ipv6=""  # Stores previous IPv6 address

# Telegram bot token and chat ID (replace with your own after getting one, you can check on telegram_bot_setup.md if you need help)
TELEGRAM_BOT_TOKEN="TELEGRAM_BOT_TOKEN_IN_HERE"
TELEGRAM_CHAT_ID="TELEGRAM_CHAT_ID_IN_HERE"

send_telegram() {
    local message="$1"  # Get the message as input
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
    -d chat_id="$TELEGRAM_CHAT_ID" -d text="$message" > /dev/null  # Send the message
}

cleanup() {
    message="[ $(date) ] Network Monitor Ended"  # Message to send on exit
    echo "$message" >> "$log_file"  # Save to log file
    send_telegram "$message"  # Send Telegram alert
    exit 0  # Exit the script
}

trap cleanup SIGINT  # If Ctrl+C is pressed, run cleanup()

echo "[ $(date) ] Checking IP. Every $interval seconds." >> "$log_file"  # Start log

while true  # Infinite loop
do
    current_ipv4=$(hostname -I | awk '{print $1}')  # Get current IPv4 address
    current_ipv6=$(hostname -I | awk '{for(i=1;i<=NF;i++) if ($i ~ /:/ && $i !~ /^fe80:/) {print $i; exit}}')  # Get current IPv6 address (not local)

    if [ "$current_ipv4" != "$last_ipv4" ]; then  # Check if IPv4 changed
        message="[ $(date) ] IPv4 Changed: $last_ipv4 → $current_ipv4"
        echo "$message" >> "$log_file"  # Save to log
        send_telegram "$message"  # Send alert
        last_ipv4="$current_ipv4"  # Update stored IPv4
    fi

    if [ "$current_ipv6" != "$last_ipv6" ]; then  # Check if IPv6 changed
        message="[ $(date) ] IPv6 Changed: $last_ipv6 → $current_ipv6"
        echo "$message" >> "$log_file"
        send_telegram "$message"
        last_ipv6="$current_ipv6"
    fi

    sleep $interval  # Wait before next check
done
