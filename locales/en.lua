Locales['en'] = {
  ['garage_blip_name'] = "Garage",
  ['truck_blip_name'] = "Truck Garage",
  ['heli_blip_name'] = "Helicopterfield",
  ['plane_blip_name'] = "Planehangar",
  ['boat_blip_name'] = "Boat Dock",
  ['airship_blip_name'] = "Airshipfield",
  
  ['help_notification_garage'] = "press ~INPUT_CONTEXT~ to open the ~y~Garage Menu~s~.",

  ['towingyard_blip_name'] = "Towingyard",
  ['help_notification_towingyard'] = "press ~INPUT_CONTEXT~ to open the ~y~Towingyard Menu~s~.",
  

  -- Garagemanager --
  ['garagemenu_titel'] = "Garage Menu",
  ['garagemenu_subtitel'] = "Garage: %s",
  ['garage_parkingin_titel'] = "Parking In",
  ['garage_parkingout_titel'] = "Parking Out",
  ['garage_parkinglist_titel'] = "Vehicle List",

  ['garage_parkinglist_noitem'] = "~r~No owned vehicle",
  ['garage_parkinglist_noitem_desc'] = "",
  ['garage_parkinglist_item'] = "[%s]",
  ['garage_parkinglist_item_desc'] = "",
  ['garage_parkinglist_item_out-of-garage'] = "~o~Out of garage",
  ['garage_parkinglist_item_unknown-garage'] = "~r~Unknown garage: %s",

  ['garage_parkingin_item'] = "[%s]",
  ['garage_parkingin_item_desc'] = "Enter for parking!",
  ['garage_parkingin_noitem'] = "~r~No owned vehicle",
  ['garage_parkingin_noitem_desc'] = "Drive your vehicle in area",
  
  ['garage_parkingout_item'] = "[%s]",
  ['garage_parkingout_item_custom'] = "[%s] - %s",
  ['garage_parkingout_item_parkingout'] = "Park out vehicle",
  ['garage_parkingout_item_parkingout_desc'] = "Enter for parking out!",
  ['garage_parkingout_item_rename'] = "Rename vehicle",
  ['garage_parkingout_item_rename_desc'] = "Enter for change Vehiclename",
  ['garage_parkingout_noitem'] = "~r~No owned vehicle",
  ['garage_parkingout_noitem_desc'] = "You don't have any vehicles here!",


  -- Towingyardmanager --
  ['towingyardmenu_titel'] = "Towingyard Menu",
  ['towingyardmenu_subtitel'] = "Towingyard: %s",
  ['towingyard_towingyardmenu_titel'] = "Towingyard Menu",

  ['towingyard_parkingout_titel'] = "Towingyard Vehicles",
  ['towingyard_parkingout_item'] = "[%s]",
  ['towingyard_parkingout_item_desc'] = "Enter to trigger for %s$",
  ['towingyard_parkingout_noitem'] = "~r~No owned vehicle",
  ['towingyard_parkingout_noitem_desc'] = "You don't have any vehicles here!",

  ['towingyard_parkingin_noitem'] = "~r~No owned vehicle",
  ['towingyard_parkingin_noitem_desc'] = "Drive your vehicle in area",

  ['towingyard_zero-user'] = "%s vehicles from type %s were brought to the towing yard",


-- Notifications --
  ['notifications_titel'] = "Garagemanager",
  ['notifications_towingyard_titel'] = "Towingyardmanager",
  ['notification_message_not-enough-money'] = "You haven't enough money",
  ['notification_message_not_allowed'] = "Do not allowed!",
  ['notification_message_database'] = "Error: DBase",
  ['notification_message_parking_attempt-info'] = "Vehicle is removing...",
  ['notification_message_wait-info'] = "Please wait...",
  ['notification_message_rename'] = "You changed the Vehiclename",
  ['notification_message_release'] = "You trigger the Vehicle for %s$",

  ['notification_message_parkingout'] = "Vehicle parked out!",
  ['notification_message_parkingout_nofreeparkarea'] = "No parking space",
  ['notification_message_parkingout_already_out'] = "Car already out",

  ['notification_message_parkingin_in-the-vehicle'] = "You're in this Vehicle",
  ['notification_message_parkingin'] = "Vehicle is in the Garage",
  ['notification_message_parkingin_already_in'] = "Car already in",
  ['notification_message_parkingin_not-in-area'] = "Car not in a parking area",

  ['notification_message_parkingout_debug_spawnpoint'] = "Debug_Plate: %s | Spawnring: %s",
  ['notification_message_parkingout_debug_spawnpoint2'] = "Debug_Garagename: %s",
  ['notification_message_parkingout_debug_getVehicleinParkingarea'] = "Debug_Plate: %s",

  ['input_submit'] = "Submit",
  ['input_cancel'] = "Cancel",
  ['input_rename_titel'] = "Change Car Name",
  ['input_rename_inputfield'] = "Tipe your new name here",


-- Command --
  ['nopermissions'] = "You don't have any permissions for %s!",
  ['cmd_giveVehicle'] = "The vehicle is in the garage.",
  ['cmd_giveVehicle_usage'] = "Usage: /%s <type> <model> [player] [trans|c|...] [plate]",
  ['cmd_giveVehicle_type'] = "Vehicle type",
  ['cmd_giveVehicle_model'] = "Vehicle spawnname or hash",
  ['cmd_giveVehicle_target'] = "Optional, Target player server-id/license",
  ['cmd_giveVehicle_plate-grade'] = "Optional, trans(default): 'DREAM123' | custom or c: 'TEST' | ... ",
  ['cmd_giveVehicle_plate'] = "Optional, Vehicle custom plate (max. 8 chars)",
  ['cmd_giveVehicle_maxchars'] = "max. 8 chars for [plate]",
  ['cmd_giveVehicle_invalid-model'] = "Invalid vehicle model",
  ['cmd_giveVehicle_plateuse'] = "Plate is used: [%s]",
  ['cmd_giveVehicle_wrongplate'] = "Plate to long! max 8 Chars!",
  ['cmd_giveVehicle_plateisnil'] = "ERROR - PLATE IS NIL!",
  ['cmd_giveVehicle_wrong-user'] = "The user doesn't exists!",
  ['cmd_giveVehicle_wrong-type'] = "The type doesn't exists!",


  ['cmd_setprops'] = "Vehicleprops was saved!",
  ['cmd_setprops_usage'] = "Usage: /%s",
  ['cmd_setprops_vehicle-not-found'] = "Vehicle not found",
  ['cmd_setprops_no-vehicle'] = "You're not in a Vehicle",
}



