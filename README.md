# SSH-Notifier-Telegram
A lightweight and efficient Python bot running in Docker that monitors successful & failed SSH login attempts in real-time and instantly notifies you via Telegram. Perfect for securing home servers, VPS, or Raspberry Pi.

## Features
- **Real-time Monitoring**: Tracks system logs using `journalctl` via Docker volume mapping.
- **Dockerized**: Runs 24/7 in an isolated container with an automatic restart policy.
- **Secure:** Access to host logs is strictly **Read-Only** (`ro`).
- **Clean Formatting:** Notifications are sent in HTML format with monospaced font for log details.
- **IP Whitelisting:** Option to ignore your own IP address to prevent self-notifications.

## Quick Setup
#### 1. Run setup script
Our custom setup script will check for Docker and prepare your configuration
```bash
chmod +x bot_setup.sh
./bot_setup.sh
```
#### 2. Configure Credentials
Edit the generated `.env` file with your bot token and chat ID
```bash
nano .env
```
- `TOKEN`: Telegram Bot Token (You can get it from BotFather)
- `CHAT_ID`: Your Telegram User ID
- `IGNORE_IP`: Your static IP (optional)
#### 3. Configure Timezone
By default, the bot is set to `Europe/Prague` time. If you are in a different timezone, update the `TZ` variable in `docker-compose.yml`
```yaml
    environment:
      - TZ=Europe/Prague
```
You can find a list of available timezones [here](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)
#### 4. Launch the Bot
Build and start the container in detached mode
```bash
docker-compose up -d --build
```

## Requirements
- **Docker** and **Docker Compose** installed on the host.
- **systemd-journald** (standard on most modern Linux distros like Debian, Ubuntu, Raspberry Pi OS).