fx_version "cerulean"
game "gta5"
lua54 'yes'
name "ra-blackmarket"
author "radhwane07"
version "1.2.2"
description "Ra-Blackmarket script by Discord for free support : radhwane07"

shared_scripts {
    'config.lua',
	'functions.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
	'locales/*.lua',
}

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
	'client.lua'
}

server_scripts { 
	'server.lua',
	'versionChecker.lua'
}

escrow_ignore {
  'config.lua',
  'server.lua',
  'locales/*.lua'
}
