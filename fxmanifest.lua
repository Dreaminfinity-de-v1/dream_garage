fx_version 'adamant'

game 'gta5'

description 'Vehicle garage from Dreaminfinity.de'

version '0.7.1-beta'

author 'EThunder, Grewo'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',

	'locales/en.lua',

	'configs/config.lua',
	'configs/config_plate.lua',
	'configs/config_garage.lua',
	'configs/config_towingyard.lua',

	'server/functions/sv_garagemanager.lua',
	'server/functions/sv_main_get.lua',
	'server/functions/sv_main_is.lua',
	'server/functions/sv_main_set.lua',
	'server/functions/sv_plate.lua',
	'server/functions/sv_vin.lua',

	'server/server.lua',
	'server/functions/sv_towingyardmanager.lua',
	'server/sv_cmd_givevehicle.lua',
	'server/sv_cmd_saveprops.lua',
	'server/sv_towingyard_Zero-User.lua',
	
	'server/functions/sv_carkey.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'@NativeUILua/NativeUI.lua',
	
	'locales/en.lua',

	'configs/config.lua',
	'configs/config_plate.lua',
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
	'client/functions/savepros.lua',

	'client/garagemanger_menu/garagemanager_menu.lua',
	'client/garagemanger_menu/parking-in/parking-in.lua',
	'client/garagemanger_menu/parking-out/parking-out.lua',
	'client/garagemanger_menu/parking-out/parking-out-sharedoptions.lua',
	'client/garagemanger_menu/parking-out-shared/parking-out-shared.lua',
	'client/garagemanger_menu/vehicle-list/vehicle-list.lua',

	'client/towingyardmanager_menu/menu_towingyardmanager.lua',
	'client/towingyardmanager_menu/menu_towingyard_out.lua',
	'client/towingyardmanager_menu/menu_towingyard_in.lua',

}

server_export {
	'setVehicle',
	'setVehicleGarage',
	'getRandomPlate',
	'getRandomPlateByGrade',
	'getRandomPlateByVehicletype',
	'getVehicleByPlate',
	'getVehicleByVIN',
}

dependencies {
	'es_extended',
	'NativeUILua',
	'mysql-async',
	'zf_dialog',
}
