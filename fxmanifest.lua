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
	'configs/config_towingyard.lua',

	'server/functions/sv_garagemanager.lua',
	'server/functions/sv_main_get.lua',
	'server/functions/sv_main_is.lua',
	'server/functions/sv_main_set.lua',
	'server/functions/sv_plate.lua',

	'server/server.lua',
	'server/functions/sv_towingyardmanager.lua',
	'server/sv_commands.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'@NativeUILua/NativeUI.lua',
	
	'locales/en.lua',

	'configs/config.lua',
	'configs/config_garage.lua',
	'configs/config_towingyard.lua',

	'client/client.lua',
	'client/blips_npcs.lua',
	'client/interactions.lua',

	'client/functions/utils.lua',
	'client/functions/command.lua',
	'client/functions/garagemanager.lua',
	'client/functions/towingyardmanager.lua',

	'client/functions/give_vehicle.lua',

	'client/garagemanger_menu/menu_garagemanager.lua',
	'client/garagemanger_menu/menu_parking_in.lua',
	'client/garagemanger_menu/menu_parking_out.lua',
	'client/garagemanger_menu/menu_parking_list.lua',

	'client/towingyardmanager_menu/menu_towingyardmanager.lua',
	'client/towingyardmanager_menu/menu_towingyard_out.lua',
	'client/towingyardmanager_menu/menu_towingyard_in.lua',

}

dependencies {
	'es_extended',
	'NativeUILua',
	'mysql-async',
	'zf_dialog',
}
