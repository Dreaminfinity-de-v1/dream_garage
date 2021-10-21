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

Config.VehicleTypes = { -- and Default Garages
    car         = "garage_legion_square", -- Cars, Bikes
    truck       = "none", -- LKWs, Trailers
    boat        = "none", -- Boats, Submarines
    heli        = "none", -- Helicopters
    plane       = "none", -- Planes
}

Config.Garages = {
    {  --24/7
        id = 'garage_legion_square',
        name = "Legion Square Garage",
        vehicle_types = {
            'car',
        },
        parking = {
            { pos = vector3(228.1697, -790.0316, 30.3982), radius = 28 },
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
        name = "Airpot Garage",
        vehicle_types = {
            'car',
        },
        parking = {
            { pos = vector3(-949.2521, -2673.2676, 21.6195), radius = 30 },
            { pos = vector3(-917.3931, -2618.3787, 21.6042), radius = 30 },
            { pos = vector3(-933.0595, -2644.6980, 19.1047), radius = 30 },
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
                { coords = vector3(-958.6937, -2648.0168, 19.7511), heading = 59.3152, radius = 6.0 },
                { coords = vector3(-964.3865, -2658.1204, 21.1813), heading = 62.3598, radius = 6.0 },
                { coords = vector3(-972.2988, -2671.5671, 21.6050), heading = 58.1894, radius = 6.0 },
                { coords = vector3(-969.3629, -2681.4172, 21.6049), heading = 148.8502, radius = 6.0 },
                { coords = vector3(-957.8779, -2688.0564, 21.6049), heading = 144.9756, radius = 6.0 },
                { coords = vector3(-946.3151, -2694.8289, 21.6049), heading = 146.5188, radius = 6.0 },
                { coords = vector3(-936.2894, -2692.3230, 21.6091), heading = 235.7264, radius = 6.0 },
                { coords = vector3(-929.9230, -2682.5071, 21.5032), heading = 236.9766, radius = 6.0 },
                { coords = vector3(-924.4135, -2672.9612, 20.3153), heading = 247.1993, radius = 6.0 },
                { coords = vector3(-906.5276, -2640.8931, 20.2364), heading = 239.8289, radius = 6.0 },
                { coords = vector3(-900.8298, -2630.8447, 21.4890), heading = 232.0324, radius = 6.0 },
                { coords = vector3(-894.6462, -2620.9661, 21.6049), heading = 238.7265, radius = 6.0 },
                { coords = vector3(-897.8193, -2611.3892, 21.6048), heading = 331.3382, radius = 6.0 },
                { coords = vector3(-906.3393, -2606.0081, 21.6048), heading = 309.6403, radius = 6.0 },
                { coords = vector3(-916.0782, -2600.4138, 21.6048), heading = 291.2305, radius = 6.0 },
                { coords = vector3(-943.9152, -2623.4551, 19.7843), heading = 58.6080, radius = 6.0 },
                { coords = vector3(-937.7944, -2613.9578, 21.1780), heading = 58.8540, radius = 6.0 },
                { coords = vector3(-930.1907, -2600.4160, 21.6048), heading = 58.2391, radius = 6.0 },
                { coords = vector3(-914.8549, -2656.0986, 19.1051), heading = 155.8335, radius = 3.0 },
            },
        },
    },
    {
        id = 'garage_paleto_bay',
        name = 'Paleto Bay Garage',
        vehicle_types = {
            'car',
        },
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
                { coords = vector3(142.3494, 6574.9351, 31.9432), heading = 83.4999, radius = 6.0 },
                { coords = vector3(137.4289, 6580.1938, 32.002), heading = 53.2110, radius = 6.0 },
                { coords = vector3(132.8394, 6585.2866, 31.9597), heading = 65.3987, radius = 6.0 },
                { coords = vector3(126.6691, 6590.0186, 31.9378), heading = 77.2411, radius = 6.0 },
                { coords = vector3(122.6001, 6594.3223, 32.0118), heading = 80.1833, radius = 6.0 },
                { coords = vector3(118.2518, 6599.2544, 32.0160), heading = 77.1947, radius = 6.0 },
                { coords = vector3(145.0284, 6601.5703, 31.8497), heading = 340.1880, radius = 6.0 },
                { coords = vector3(151.0921, 6606.2725, 31.8742), heading = 176.1228, radius = 6.0 },
                { coords = vector3(155.6371, 6592.7261, 31.8449), heading = 345.9754, radius = 6.0 },
                { coords = vector3(141.0624, 6646.7988, 31.6397), heading = 218.7746, radius = 6.0 },
            },
        },
    },
    {
        id = 'garage_maze_bank_arena',
        name = 'Maze Bank Arena Garage',
        vehicle_types = {
            'car',
        },
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
    {
        id = 'garage_vespucci_lspd',
        name = 'LSPD Vespucci Garage',
        vehicle_types = {
            'car',
        },
        parking = {
            { pos = vector3(-1179.2786, -734.8218, 20.3068), radius = 30 },
            { pos = vector3(-1133.0995, -759.3384, 18.9847), radius = 25 },
            { pos = vector3(-1143.9053, -744.0809, 19.7862), radius = 25 },
        },
        blip = {
            pos     = vector3(-1158.7681, -740.4506, 18.8899),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(-1158.7681, -740.4506, 18.8899),
            heading = 38.7913,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                { coords = vector3(-1132.3346, -763.9393, 18.680), heading = 113.7447, radius = 6.0 },
                { coords = vector3(-1137.0966, -758.0371, 19.0050), heading = 107.0515, radius = 6.0 },
                { coords = vector3(-1141.9240, -751.8690, 19.3229), heading = 108.7987, radius = 6.0 },
                { coords = vector3(-1146.3973, -745.6348, 19.6365), heading = 96.0388, radius = 6.0 },
                { coords = vector3(-1141.8032, -740.6735, 20.0382), heading = 286.9442, radius = 6.0 },
                { coords = vector3(-1136.8408, -746.3440, 19.7588), heading = 280.8288, radius = 6.0 },
                { coords = vector3(-1131.5725, -752.5545, 19.4697), heading = 291.4337, radius = 6.0 },
                { coords = vector3(-1127.2299, -758.2633, 19.1810), heading = 286.9401, radius = 6.0 },
                { coords = vector3(-1184.4122, -745.4860, 19.9338), heading = 140.9869, radius = 6.0 },
                { coords = vector3(-1201.7086, -729.7509, 21.1223), heading = 119.0481, radius = 6.0 },
                { coords = vector3(-1167.3438, -749.5873, 19.2819), heading = 301.1173, radius = 3.0 },
            },
        },
    },
    {
        id = 'garage_jetsam_terminal',
        name = 'Jetsam Terminal Garage',
        vehicle_types = {
            'car',
        },
        parking = {
            { pos = vector3(772.7468, -2950.4924, 5.9386), radius = 20 },
            { pos = vector3(773.0107, -2976.9055, 5.8007), radius = 20 },
        },
        blip = {
            pos     = vector3(772.7162, -2966.0630, 5.9694),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(797.5309, -2988.7974, 5.0209),
            heading = 92.2195,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                { coords = vector3(781.2951, -2984.5798, 5.8013), heading = 248.9123, radius = 6.0 },
                { coords = vector3(781.6495, -2977.1191, 5.8007), heading = 248.9123, radius = 6.0 },
                { coords = vector3(781.9598, -2969.6450, 5.8007), heading = 248.9123, radius = 6.0 },
                { coords = vector3(781.0545, -2961.3281, 5.8007), heading = 248.9123, radius = 6.0 },
                { coords = vector3(781.2330, -2953.7656, 5.8007), heading = 248.9123, radius = 6.0 },
                { coords = vector3(769.8645, -2978.8459, 5.8007), heading = 294.0852, radius = 6.0 },
                { coords = vector3(770.0861, -2970.6162, 5.8007), heading = 294.0852, radius = 6.0 },
                { coords = vector3(770.2626, -2963.0613, 5.8007), heading = 294.0852, radius = 6.0 },
                { coords = vector3(770.2103, -2955.6199, 5.8007), heading = 294.0852, radius = 6.0 },
                { coords = vector3(770.5714, -2947.9050, 5.8007), heading = 294.0852, radius = 6.0 },
                { coords = vector3(797.6078, -2943.3174, 5.9055), heading = 85.4384, radius = 3.0 },
            },
        },
    },
    {
        id = 'garage_richman_hotel',
        name = 'Richman Hotel Garage',
        vehicle_types = {
            'car',
        },
        parking = {
            { pos = vector3(-1315.0947, 275.2265, 63.5426), radius = 20 },
            { pos = vector3(-1314.5939, 255.4482, 62.3233), radius = 20 },
            { pos = vector3(-1340.4537, 253.5600, 61.4908), radius = 20 },
            { pos = vector3(-1283.0166, 257.6262, 63.6943), radius = 20 },
        },
        blip = {
            pos     = vector3(-1314.8999, 268.5426, 63.4257),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(-1292.5110, 275.7513, 63.7146),
            heading = 92.2195,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                { coords = vector3(-1304.8829, 276.5799, 64.1004), heading = 322.9207, radius = 6.0 },
                { coords = vector3(-1292.1351, 268.9697, 64.1483), heading = 318.9586, radius = 6.0 },
                { coords = vector3(-1273.5431, 253.9923, 63.6298), heading = 6.4668, radius = 6.0 },
                { coords = vector3(-1281.4858, 253.6290, 63.4469), heading = 2.0835, radius = 6.0 },
                { coords = vector3(-1289.1658, 251.8432, 63.0880), heading = 187.4910, radius = 6.0 },
                { coords = vector3(-1297.1315, 250.9122, 62.7045), heading = 183.4099, radius = 6.0 },
                { coords = vector3(-1305.1238, 253.0692, 62.5081), heading = 357.1659, radius = 6.0 },
                { coords = vector3(-1312.8727, 252.4757, 62.1825), heading = 357.1659, radius = 6.0 },
                { coords = vector3(-1320.6947, 249.1976, 61.7383), heading = 185.1310, radius = 6.0 },
                { coords = vector3(-1328.3097, 247.6781, 61.3883), heading = 182.9538, radius = 6.0 },
                { coords = vector3(-1335.6722, 246.2920, 61.0141), heading = 191.4428, radius = 6.0 },
                { coords = vector3(-1344.0999, 249.1837, 60.9911), heading = 10.0353, radius = 6.0 },
                { coords = vector3(-1351.5770, 246.9243, 60.5507), heading = 6.4435, radius = 6.0 },
                { coords = vector3(-1321.3328, 262.4420, 62.6452), heading = 336.0211, radius = 6.0 },
                { coords = vector3(-1319.4661, 280.1487, 63.7955), heading = 44.5687, radius = 6.0 },
                { coords = vector3(-1325.7610, 275.6496, 63.4343), heading = 40.1820, radius = 6.0 },
                { coords = vector3(-1331.8873, 270.5453, 62.9802), heading = 48.8518, radius = 6.0 },
                { coords = vector3(-1335.2247, 263.0762, 62.3838), heading = 225.6285, radius = 6.0 },
                { coords = vector3(-1313.9346, 280.3712, 63.9218), heading = 178.4065, radius = 3.0 },
            },
        },
    },
    {
        id = 'garage_mission_row',
        name = 'Mission Row Garage',
        vehicle_types = {
            'car',
        },
        parking = {
            { pos = vector3(447.5323, -1158.0652, 29.2918), radius = 15 },
            { pos = vector3(471.0376, -1156.6951, 29.3060), radius = 15 },
            { pos = vector3(421.3093, -1158.3462, 29.2920), radius = 15 },
        },
        blip = {
            pos     = vector3(453.4159, -1145.6571, 29.5141),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(453.4159, -1145.6571, 28.5141),
            heading = 181.2930,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                { coords = vector3(449.7267, -1157.6992, 29.2918), heading = 83.9489, radius = 6.0 },
                { coords = vector3(467.4682, -1161.0370, 29.2918), heading = 268.2710, radius = 6.0 },
                { coords = vector3(467.8770, -1154.7925, 29.2918), heading = 268.2710, radius = 6.0 },
                { coords = vector3(487.0495, -1151.9452, 29.2918), heading = 268.4257, radius = 6.0 },
                --{ coords = vector3(487.4762, -1157.5077, 29.2918), heading = 265.1672, radius = 6.0 }, -- Too tight
                { coords = vector3(487.0591, -1163.7765, 29.2918), heading = 268.2949, radius = 6.0 },
                { coords = vector3(482.7648, -1168.8723, 29.2918), heading = 59.3287, radius = 6.0 },
                { coords = vector3(473.1275, -1163.8098, 29.2918), heading = 83.9489, radius = 6.0 },
                --{ coords = vector3(472.3307, -1157.8555, 29.2918), heading = 83.9489, radius = 6.0 }, -- Too tight
                --{ coords = vector3(472.1539, -1151.5900, 29.2918), heading = 83.9489, radius = 6.0 }, -- Too tight
                { coords = vector3(442.0641, -1157.7759, 29.2919), heading = 83.9489, radius = 6.0 },
                { coords = vector3(442.1941, -1163.8042, 29.2919), heading = 83.9489, radius = 6.0 },
                { coords = vector3(430.5609, -1154.8610, 29.2920), heading = 83.9489, radius = 6.0 },
                { coords = vector3(430.1284, -1161.0101, 29.2920), heading = 83.9489, radius = 6.0 },
                { coords = vector3(423.2889, -1163.9515, 29.2920), heading = 83.9489, radius = 6.0 },
                { coords = vector3(423.2848, -1157.8309, 29.2920), heading = 83.9489, radius = 6.0 },
                { coords = vector3(410.9955, -1154.6403, 29.2920), heading = 83.9489, radius = 6.0 },
                { coords = vector3(410.9242, -1160.8193, 29.2920), heading = 83.9489, radius = 6.0 },
                { coords = vector3(411.2191, -1167.7162, 29.2920), heading = 83.9489, radius = 6.0 },
                { coords = vector3(436.6050, -1146.6865, 29.3305), heading = 270.8984, radius = 3.0 }, -- SPARE
            },
        },
    },
    {
        id = 'garage_la_spada',
        name = 'La Spada Garage',
        vehicle_types = {
            'car',
        },
        parking = {
            { pos = vector3(-996.5576, -1285.1532, 5.6222), radius = 22 },
            { pos = vector3(-987.4981, -1280.8955, 5.9246), radius = 20 },
        },
        blip = {
            pos     = vector3(-1026.7461, -1305.5083, 6.1357),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(-1026.7461, -1305.5083, 5.1357),
            heading = 50.0547,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                { coords = vector3(-1010.9372, -1302.4521, 6.1210), heading = 75.8608, radius = 6.0 },
                { coords = vector3(-1008.7927, -1290.7201, 6.1763), heading = 59.8288, radius = 6.0 },
                { coords = vector3(-999.1097, -1299.7584, 5.9917), heading = 79.5687, radius = 6.0 },
                { coords = vector3(-992.5731, -1291.5942, 5.9407), heading = 232.6795, radius = 6.0 },
                { coords = vector3(-987.9603, -1286.4490, 5.8837), heading = 217.1182, radius = 6.0 },
                { coords = vector3(-982.2605, -1282.6527, 5.8057), heading = 201.6382, radius = 6.0 },
                { coords = vector3(-976.0433, -1280.8918, 5.7148), heading = 188.0311, radius = 6.0 },
                { coords = vector3(-1010.1723, -1314.4932, 6.0326), heading = 115.5331, radius = 3.0 }, -- SPARE
            },
        },
    },



    --[[ Template
    {
        id = 'garage_xyz',
        name = 'XYZ Garage',
        vehicle_types = {
            'car',
        },
        parking = {
            { pos = vector3(x, y, z), radius = 30 },
        },
        blip = {
            pos     = vector3(x, y, z),
            color   = 3,
            sprite  = 524, -- Icontype
            scale   = 1.0,
            display = 2,
        },

        garagemanager = {
            pos = vector3(x, y, z),
            heading = h,
            type = 4,
            model = "a_m_y_bevhills_02",
            radius = 2,
            
            spawnpoints = {
                --{ coords = vector3(x, y, z), heading = h, radius = 6.0 },
                --{ coords = vector3(x, y, z), heading = h, radius = 3.0 }, -- SPARE
            },
        },
    },
    --]]

    
}