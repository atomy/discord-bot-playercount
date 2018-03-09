const request = require('request');
const Discord = require('discord.js');
const client = new Discord.Client();
require('console-stamp')(console, 'HH:MM:ss.l');

if (!process.env.DISCORD_API_KEY || process.env.DISCORD_API_KEY.length <= 0) {
    console.log('ERROR: Env variable DISCORD_API_KEY does not exists or is empty!');
    process.exit(1);
}

if (!process.env.STEAM_API_KEY || process.env.STEAM_API_KEY.length <= 0) {
    console.log('ERROR: Env variable STEAM_API_KEY does not exists or is empty!');
    process.exit(1);
}

if (!process.env.STEAM_APPID || process.env.STEAM_APPID.length <= 0) {
    console.log('ERROR: Env variable STEAM_APPID does not exists or is empty!');
    process.exit(1);
}

const discordApiKey = process.env.DISCORD_API_KEY;
const steamApiKey = process.env.STEAM_API_KEY;
const steamAppId = process.env.STEAM_APPID;

client.on('ready', () => {
    console.log(`Logged in as ${client.user.tag}!`);
    client.user.setActivity('? playerz playing.', { url: 'http://www.dystopia-game.com', type: 'WATCHING' } );
    request(options, callback);
});

const options = {
    url: 'https://partner.steam-api.com/ISteamUserStats/GetNumberOfCurrentPlayers/v1/?key=' + steamApiKey + '&appid=' + steamAppId
};

function callback(error, response, body) {
    console.log("Got response with http-code: " + response.statusCode);

    if (response.statusCode === 200) {
        const jsonObject = JSON.parse(body);
        var playerCount = jsonObject.response.player_count;
        console.log("retrieved player count is: " + playerCount);
    }

    if (!error && response.statusCode == 200 && playerCount > 0) {
        client.user.setActivity(playerCount + ' playerz playing', { url: 'http://www.dystopia-game.com', type: 'WATCHING' } );
    } else {
        client.user.setActivity('? players playing', { url: 'http://www.dystopia-game.com', type: 'WATCHING' } );
    }
}

setInterval(function() {
    console.log("Requesting...");
    request(options, callback);
}, 1000*300);

client.login(discordApiKey);