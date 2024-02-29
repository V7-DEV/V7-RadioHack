fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'V7 Developers Team || https://discord.gg/7xeJj9Akf6'
author 'V7 Developers Team '

-- What to run
client_scripts {
    'C/client.lua',
}

shared_script{
    'CFG/config.lua',

    '@ox_lib/init.lua'

}