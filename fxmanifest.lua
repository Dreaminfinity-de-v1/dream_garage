fx_version 'adamant'

game 'gta5'

description 'Garage von Grewo - Dreaminfinity.de'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'config_garage.lua',
	'server/sv.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'@NativeUI/NativeUI.lua',
	'locales/en.lua',
	'config.lua',
	'config_garage.lua',
	'client/cl.lua',

}

dependencies {
	'es_extended',
}
