# Introduction 
Discord bot that includes the current playercount of a steam game in its presence.

# Requirements
- API key for Steam (get one here: https://steamcommunity.com/dev/apikey)
- API key for Discord-Bot (create a bot and acquire a bot-token: https://discordapp.com/developers/applications/)

# Install
- Create and add bot to your Discord-Server (https://www.howtogeek.com/364225/how-to-make-your-own-discord-bot/)
- edit `docker-compose.yml` and put in your api keys and the steam-appid you want to watch playercount for (sites like https://steamdb.info/apps/ help to find the right appid)
- `docker-compose up`

# How it looks
![Image of Discord-Bot-Presence](https://github.com/atomy/discord-bot/blob/master/doc/screenshot.png)
