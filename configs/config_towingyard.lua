Config.DefaultTowingyards = { -- and Default Garages
    car         = "towingyard_test", -- Cars, Bikes
    truck       = "none", -- LKWs, Trailers
    boat        = "none", -- Boats, Submarines
    heli        = "none", -- Helicopters
    plane       = "none", -- Planes
}

Config.Towingyards = {
    {
        id = 'towingyard_test',
        name = 'LSPD Towingyard',
        parking = {
            { pos = vector3(400.9347, -1632.3341, 29.2919), radius = 5 },
        },
        vehicle_types = {
            'truck',
            'car',
        },
        blip = {
            pos     = vector3(409.6227, -1623.1615, 29.2919),
            color   = 17,
            sprite  = 68, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        towingyardmanager = {
            pos = vector3(409.6227, -1623.1615, 28.2919),
            heading = 225.7801,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                { coords = vector3(406.88, -1636.25, 29.30), heading = 331.20, radius = 6.0 },
            },
        },

    },

}