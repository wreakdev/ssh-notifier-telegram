#!/bin/bash

RED='\033[0;31m'
WHITE='\033[0;37m'
LB='\033[1;30m' 
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${LB}[${WHITE}Info${LB}] ${WHITE}Starting setup for SSH Telegram Bot (Docker version)${NC}"

if ! [ -x "$(command -v docker)" ]; then
  echo -e "${LB}[${WHITE}Error${LB}] ${RED}Docker is not installed.${NC}" >&2
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  echo -e "${LB}[${WHITE}Error${LB}] ${RED}Docker Compose plugin is not installed (command 'docker compose' failed).${NC}" >&2
  exit 1
fi

if [ ! -f .env ]; then
    echo -e "${LB}[${WHITE}Info${LB}] ${WHITE}Creating .env file from template...${NC}"
    if [ -f .env.example ]; then
        cp .env.example .env
    else
        echo "TOKEN=your_token_here" > .env
        echo "CHAT_ID=your_id_here" >> .env
        echo "IGNORE_IP=127.0.0.1" >> .env
    fi
    echo -e "${LB}[${WHITE}Warning${LB}] ${YELLOW}Action required: Edit your .env file!${NC}"
else
    echo -e "${LB}[${WHITE}Info${LB}] ${GREEN}.env file already exists.${NC}"
fi

echo -e "${WHITE}-------------------------------------------------------${NC}"
echo -e "${LB}[${WHITE}Info${LB}] ${GREEN}Setup preparation complete!${NC}"
echo -e "${WHITE}1. Edit your credentials in: ${GREEN}nano .env${NC}"
echo -e "${WHITE}2. Start the bot with: ${GREEN}docker compose up -d --build${NC}"
echo -e "${WHITE}-------------------------------------------------------${NC}"