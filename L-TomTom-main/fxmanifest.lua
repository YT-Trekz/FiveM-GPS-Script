fx_version 'cerulean'
game 'gta5'

description 'L-Gps in html'
author 'MadeByLommel'
version '1.0.0'

ui_page 'html/index.html'

file {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/*.png'
}

client_scripts {
    'src/client.lua',
    'config.lua'
}
server_scripts {
    'src/server.lua',
    'config.lua'
}