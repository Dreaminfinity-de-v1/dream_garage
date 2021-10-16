fx_version 'adamant'

game 'gta5'

description 'Garage von Grewo - Dreaminfinity.de'

version '1.0.0 A002'

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
	'@NativeUILua/NativeUI.lua',
	'locales/en.lua',

	'configs/config.lua',
	'configs/garage.lua',
	'configs/towyard.lua',

	'client/cl.lua',
	'client/blips_npcs.lua',
	'client/interactions.lua',

	'client/functions/utils.lua',
	'client/functions/garagemanager.lua',
	'client/functions/towyardmanager.lua',

	'client/garagemanger_menu/garagemanager_menu.lua',
	'client/garagemanger_menu/parkingin_menu.lua',
	'client/garagemanger_menu/parkingout_menu.lua',
	'client/garagemanger_menu/parkinglist_menu.lua',

	'client/towyardmanager_menu/towyardmanager_menu.lua',

}

dependencies {
	'es_extended',
	'NativeUILua',
	'mysql-async',
}
