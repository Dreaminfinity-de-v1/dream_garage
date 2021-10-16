-- Blibs

-- Blib legende
--parking = vector3(209.30, -807.50, 30.90),

-- blip: All blip options (optinal)
--      titel: Name of the garage (optinal)
--      color: Color of blip (optinal)
--      sprite: Type of blip icon (optinal)
--      scale: Size of the blip (optinal)
--      display: displayoptions on maps (optinal)

Config.GarageParkinglistSort = {
    'out_of_garages',
    'config_garages',
    'unknown_garages',
}

Config.Garages = {
    {  --24/7
        id = 'garage_legion_square',
        name = 'Legion Square Garage',
        parking = {
            { pos = vector3(228.1697, -790.0316, 30.3982), radius = 30 },
        },
        blip = {
            pos     = vector3(228.1697, -790.0316, 30.3982),
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
                --{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
            },
        },

    },
    
    {
        id = 'garage_airport',
        name = 'Airpot Garage',
        parking = {
            { pos = vector3(-936.4885, -2644.5110, 19.1047), radius = 30 },
        },
        blip = {
            pos     = vector3(-936.4885, -2644.5110, 19.1047),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(-950.3012, -2631.7415, 18.2125),
            heading = 148.0312,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                --{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
            },
        },
    },
    
    {
        id = 'garage_paleto_bay',
        name = 'Paleto Bay Garage',
        parking = {
            { pos = vector3(150.3508, 6603.0908, 29.8593), radius = 40 },
        },
        blip = {
            pos     = vector3(150.3508, 6603.0908, 29.8593),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(105.5913, 6614.0332, 31.3974),
            heading = 141.7159,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                --{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
            },
        },
    },
    
    {
        id = 'garage_maze_bank_arena',
        name = 'Maze Bank Arena Garage',
        parking = {
            { pos = vector3(-196.7715, -1947.2906, 27.1880), radius = 30 },
            { pos = vector3(-189.5186, -1977.9299, 27.1962), radius = 30 },
            { pos = vector3(-202.2609, -2041.4150, 27.6204), radius = 40 },
            { pos = vector3(-234.6931, -2078.8992, 27.6206), radius = 40 },
        },
        blip = {
            pos     = vector3(-192.5227, -1960.4939, 27.6210),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(-176.4105, -1997.9507, 26.7508),
            heading = 17.9685,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                --{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
            },
        },
    },



    --[[
    garage_sandyshoes = {
        name = 'Sandy Shoes Garage',
        parking = {
            vector3(615.6784, 2732.1797, 41.9561),
        },
        parking_radius = 30,
        blip = {
            pos     = vector3(615.6784, 2732.1797, 41.9561),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(605.8505, 2745.7065, 41.0048),
            heading = 178.3573,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                --{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
            },
        },
    },
    
    garage_ocean_highway = {
        name = 'Ocean Highway Garage',
        parking = {
            vector3(-3145.6841, 1090.3347, 20.6936),
        },
        parking_radius = 35,
        blip = {
            pos     = vector3(-3145.6841, 1090.3347, 20.6936),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(-3157.9695, 1095.1080, 19.8621),
            heading = 236.2624,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                --{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
            },
        },
    },
    
    garage_racetrack = {
        name = 'Racetrack Garage',
        parking = {
            vector3(1133.4426, 59.4473, 80.7554),
        },
        parking_radius = 40,
        blip = {
            pos     = vector3(1133.4426, 59.4473, 80.7554),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(1104.2471, 87.3438, 79.8904),
            heading = 254.1080,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                --{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
            },
        },
    },
    
    garage_mission_row = {
        name = 'Mission Row Garage',
        parking = {
            vector3(447.5323, -1158.0652, 29.2918),
        },
        parking_radius = 40,
        blip = {
            pos     = vector3(447.5323, -1158.0652, 29.2918),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(453.3174, -1145.7388, 28.5141),
            heading = 170.1745,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                --{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
            },
        },
    },
    
    garage_venise = {
        name = 'Venise Garage',
        parking = {
            vector3(-1074.8715, -1253.1093, 5.5486),
        },
        parking_radius = 30,
        blip = {
            pos     = vector3(-1074.8715, -1253.1093, 5.5486),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(-1083.0234, -1262.0144, 4.5978),
            heading = 297.2850,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                --{ coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
            },
        },
    },

    --]]






    
}