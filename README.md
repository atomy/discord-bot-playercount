# Introduction 
Discord bot that includes the current playercount of a steam game in its presence.

![Image of Discord-Bot-Presence](https://github.com/atomy/discord-bot-playercount/blob/master/doc/screenshot.png)

# Requirements
- API key for Steam (get one here: https://steamcommunity.com/dev/apikey)
- API key for Discord-Bot (create a bot and acquire a bot-token: https://discordapp.com/developers/applications/)

# Install (Docker)
1) Create and add bot to your Discord-Server (https://www.howtogeek.com/364225/how-to-make-your-own-discord-bot/)
2) edit `docker-compose.yml` and put in your api keys and the steam-appid you want to watch playercount for (sites like https://steamdb.info/apps/ help to find the right appid)
3) `docker-compose up -d`

# Install (without docker, local npm)

```
    npm install
    export DISCORD_API_KEY=kl23j4j234 && export STEAM_API_KEY=lkjasdfjklasdf && export STEAM_APPID=123456 && node bot.js
```

You may want to use programs like `screen` to keep it running in the background.
