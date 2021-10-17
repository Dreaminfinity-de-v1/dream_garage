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
                { coords = vector3(231.8013, -807.6357, 29.4502), heading = 66.3220, radius = 8.0 },
                { coords = vector3(237.4018, -792.2230, 30.5198), heading = 67.5449, radius = 8.0 },
                { coords = vector3(242.9826, -777.4233, 29.6532), heading = 63.2060, radius = 8.0 },
                { coords = vector3(227.9198, -768.6195, 29.7889), heading = 67.9624, radius = 8.0 },
                { coords = vector3(213.9067, -781.2046, 29.8636), heading = 250.1079, radius = 8.0 },
                { coords = vector3(216.8248, -799.1686, 29.7900), heading = 68.1038, radius = 8.0 },
                { coords = vector3(227.9840, -789.3577, 29.6770), heading = 251.6137, radius = 8.0 },
                { coords = vector3(234.7001, -752.2458, 29.8256), heading = 68.6190, radius = 3.0 },
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
            { pos = vector3(-98.4077, -2005.0742, 18.0182), radius = 30 },
            { pos = vector3(-62.6902, -2007.4724, 18.0170), radius = 30 },
        },
        blip = {
            pos     = vector3(-73.2576, -2003.6951, 18.2753),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(-73.2576, -2003.6951, 17.2753),
            heading = 175.6549,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                { coords = vector3(-96.7830, -2008.0227, 18.0170), heading = 163.1878, radius = 8.0 },
                { coords = vector3(-85.3830, -2005.1162, 18.0170), heading = 349.8642, radius = 8.0 },
                { coords = vector3(-73.6487, -2010.2273, 18.0170), heading = 200.9688, radius = 8.0 },
                { coords = vector3(-53.6265, -2022.6761, 18.0170), heading = 17.8954, radius = 8.0 },
                { coords = vector3(-76.9615, -2029.4341, 18.0170), heading = 9.9522, radius = 8.0 },
                { coords = vector3(-95.5483, -2027.0048, 18.0170), heading = 344.4381, radius = 8.0 },
                { coords = vector3(-104.4445, -1984.3794, 18.0170), heading = 168.0603, radius = 8.0 },
                { coords = vector3(-82.2450, -1986.9929, 18.0170), heading = 168.8954, radius = 8.0 },
                { coords = vector3(-48.2266, -2004.3680, 18.0169), heading = 105.4939, radius = 8.0 },
                { coords = vector3(-55.2037, -1992.7819, 18.0170), heading = 136.5096, radius = 3.0 },
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