-- Blibs

-- Blib legende
--center_pos = vector3(209.30, -807.50, 30.90),

-- blip: All blip options (optinal)
--      titel: Name of the garage (optinal)
--      color: Color of blip (optinal)
--      sprite: Type of blip icon (optinal)
--      scale: Size of the blip (optinal)
--      display: displayoptions on maps (optinal)


Config.Garages = {
    garage_legion_square = {
        name = 'Legion Square',
        center_pos = vector3(224.1212, -788.4551, 30.8791),
        blip = {
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(213.7076, -809.4626, 30.0149),
            heading = 345.5377,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                { coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
                { coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
                { coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
                { coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
            },
        },

    },

}