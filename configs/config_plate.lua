Config.AllowedPlateChars = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

Config.RandomPlateSchemes = {
    trans = {prefix = "DREAM", scheme = "111"}, -- Transferplate / Default
    ls = {prefix = "LS ", scheme = "AA111"},
    bc = {prefix = "BC ", scheme = "AA111"},
    pb = {prefix = "PB ", scheme = "AA111"},

    pd = {prefix = "PD ", scheme = "AA111"},
    fd = {prefix = "FD ", scheme = "AA111"},
    ac = {prefix = "AC ", scheme = "AA111"},
    iaa = {prefix = "IAA ", scheme = "AA11"},

    vin = {prefix = "", scheme = "********"}, -- Vehicle Identification Number
}

Config.VehicleTypes = {
    motorcycle  = { default_garage = "garage_legion_square", default_scheme = "trans" }, -- Bikes
    car         = { default_garage = "towingyard_lspd", default_scheme = "trans" }, -- Cars      DEBUG default_garage
    truck       = { default_garage = "garage_truck_airport", default_scheme = "trans" }, -- LKWs, Trailers, Bus
    boat        = { default_garage = "garage_merryweather_dock", default_scheme = "vin" }, -- Boats, Submarines
    heli        = { default_garage = "garage_heli_airport", default_scheme = "vin" }, -- Helicopters
    plane       = { default_garage = "garage_plane_airport", default_scheme = "vin" }, -- Planes
    ship        = { default_garage = "garage_merryweather_dock", default_scheme = "vin" }, -- Harbour for tug
    airship     = { default_garage = "garage_airship_field", default_scheme = "vin" }, -- Airfield for blimp, blimp2, blimp3
}
