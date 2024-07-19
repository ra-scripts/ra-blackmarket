fx_version "cerulean"
game "gta5"
lua54 'yes'
name "ra-blackmarket"
author "radhwane07"
version "1.2.5"
description "Ra-Blackmarket script for QBCore /ESX, for free support Discord : radhwane07"

shared_scripts {
	'@ox_lib/init.lua', -- in case you want to use ox library
    'config.lua',
	'sh_functions.lua',
    'locales/en.lua',
	'locales/*.lua',
}

client_scripts {
    '@PolyZone/client.lua', -- comment if you are using target
	'@PolyZone/BoxZone.lua', -- comment if you are using target
    '@PolyZone/ComboZone.lua', -- comment if you are using target
	'client/cl_functions.lua',
	'client/client.lua'
}

server_scripts { 
	'server/sv_functions.lua',
	'server/server.lua',
	'server/versionChecker.lua'
}

escrow_ignore {
    'config.lua',
	'sh_functions.lua',
	'locales/*.lua',
	'client/cl_functions.lua',
	'server/sv_functions.lua',
}
