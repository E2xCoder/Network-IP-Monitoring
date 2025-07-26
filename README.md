# Network Monitor Script

This is a simple Bash script to monitor changes in your IPv4 and IPv6 addresses.

## Features

- Logs IP changes into daily files organized by month in the `logs` folder.
- Sends notifications to Telegram when IP changes are detected.
- Detects both IPv4 and IPv6 changes.
- Logs start and stop events with timestamps.
- Runs continuously, checking every 60 seconds by default.

## How it works

- Checks your current IP addresses using `hostname -I`.
- Compares the current IP with the last recorded IP.
- If changed, writes the change to a daily log file and sends a Telegram alert.
- Supports IPv6 filtering to exclude local link addresses (`fe80::/10`).
- Sends a "Network Monitor Ended" message to Telegram when stopped via Ctrl+C.

## Setup

- Edit the script and insert your Telegram bot token and chat ID.
- Run the script with:
  ```bash
  bash network_monitor.sh

## Author

Created by **Emre Eren**  
This script was mostly built by me while learning Bash and exploring basic network monitoring.
