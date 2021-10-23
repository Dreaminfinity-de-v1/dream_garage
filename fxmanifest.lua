fx_version 'adamant'

game 'gta5'

description 'Garage von Grewo - Dreaminfinity.de'

version '0.2.0-beta'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',

	'locales/en.lua',

	'configs/config.lua',
	'configs/config_garage.lua',
	'configs/config_towyard.lua',

	'server/sv_function.lua',
	'server/server.lua',
	'server/sv_commands.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'@NativeUILua/NativeUI.lua',
	
	'locales/en.lua',

	'configs/config.lua',
	'configs/config_garage.lua',
	'configs/config_towyard.lua',

	'client/client.lua',
	'client/blips_npcs.lua',
	'client/interactions.lua',

	'client/functions/utils.lua',
	'client/functions/command.lua',
	'client/functions/garagemanager.lua',
	'client/functions/towyardmanager.lua',

	'client/functions/give_vehicle.lua',

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
	'zf_dialog',
}
