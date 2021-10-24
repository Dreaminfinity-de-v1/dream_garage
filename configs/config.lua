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

Config.TowingyardJob = 'mechanic'
Config.ImpoundPrice = 250
Config.ImpounderPayWithBank = true
Config.ImpounderPayWithCash = true

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
        wait = "blue",
        debug = "orange",
    },
    icons = {
        car_wait = 'mdi-autorenew',
        garage_open = 'mdi-garage-open',
        garage_close = 'mdi-garage',
        garage_warn = 'mdi-garage-alert',
        database = 'mdi-database-alert',
        debug = 'mdi-bug'
    },
}

Config.Debugmode = {
    enable = true,
    blips = true,
    marker = {
        yellow = false,
        red = true,
    },
    notification = false,
}

