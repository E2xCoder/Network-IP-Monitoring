# How to Get Your Telegram Bot Token

I'm sharing this so you won’t waste time and can do it quickly. This guide explains how to create a Telegram bot and get your bot token. You will need this token to send messages from your network monitor script.

## Step 1: Open Telegram App

Use your phone or desktop Telegram app.

Search for **BotFather** (official Telegram bot management bot).

## Step 2: Start Chat with BotFather

Click **Start** or send `/start` command.

## Step 3: Create a New Bot

Send the command: `/newbot`

BotFather will ask for a name for your bot (example: `MyNetworkMonitorBot`).

Then it will ask for a username ending with **bot** (example: `mynetworkmonitorbot`).

## Step 4: Get Your Bot Token

After creating the bot, BotFather sends you a message with the bot token.

It looks like this:

```plaintext
123456789:ABCDefGhIjKlMnOpQrStUvWxYz1234567890

```
## Step 5: Save Your Token Securely
Keep this token private.

Do not share your token publicly or commit it to public repositories.

## Step 6: Find Your Chat ID
To send messages, you need your chat ID.

You can get your chat ID by sending a message to your bot and then using a service or script that reads updates from the bot.

For example, visit this URL (replace YOUR_BOT_TOKEN):

https://api.telegram.org/botYOUR_BOT_TOKEN/getUpdates
Look for "chat":{"id":123456789} in the JSON response.

Use that number as your chat ID.

## Step 7: Add Token and Chat ID to Script
Edit the script variables:

TELEGRAM_BOT_TOKEN="your_bot_token_here"
TELEGRAM_CHAT_ID="your_chat_id_here"
