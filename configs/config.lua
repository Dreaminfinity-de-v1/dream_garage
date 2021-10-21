Config                  = {}

Config.Locale           = 'en'
Config.EnableBlips      = true

Config.NPCsDefaultType  = 4
Config.NPCsDefaultModel = "ig_mp_agent14"

Config.KeyControle      = 38 -- Default: 38 (E)

Config.RandomPlateSchemes = {
    grade_0 = "11AAA111", -- Default Value
    grade_1 = "AAA 1234", -- other Default Value
}

Config.Commands = {
    give_vehicle = 'givevehicle',
}

Config.Notification = {
    pos = 'top-left',
    timeout = 5000,
    color = {
        success = "green",
        negative = "red",
        warn = "yellow",
        debug = "orange",
    },
    icons = {
        debug = 'mdi-bug',
        default = 'mdi-garage-variant',
        parkingout = 'mdi-garage-open',
        --parkingin = 'mdi-garage',
        not_allowed = 'mdi-garage-alert',
        already_out = 'mdi-garage-alert',
        not_found = 'mdi-garage-alert',
        database = 'mdi-database-alert',
    },
}

Config.Debugmode = {
    enable = false,
    blips = true,
    marker = {
        yellow = false,
        red = false,
    },
    notification = true,
}

