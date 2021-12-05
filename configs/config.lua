Config                  = {}

Config.Locale           = "en"
Config.EnableBlips      = true

Config.NPCsDefaultType  = 4
Config.NPCsDefaultModel = "ig_mp_agent14"

Config.KeyControle      = 38 -- Default: 38 (E)

Config.ItemName = "carkey"
Config.TowingyardJob = "mechanic"
Config.ImpoundPrice = 250
Config.AllowedPayments = {
    {name = 'money', label = _U('config_allowedpayments_'..'money')},
    {name = 'bank', label = _U('config_allowedpayments_'..'bank')},
    --{name = 'black_money', label = _U('config_allowedpayments_black_money')},
}

Config.Commands = {
    give_vehicle = "givevehicle",
    save_props = "saveprops",
}

Config.Notification = {
    pos = "top-left",
    timeout = 5000,
    color = {
        success = "green",
        negative = "red",
        warn = "yellow",
        wait = "blue",
        debug = "orange",
    },
    icons = {
        car_wait = "mdi-autorenew",
        garage_open = "mdi-garage-open",
        garage_close = "mdi-garage",
        garage_warn = "mdi-garage-alert",
        database = "mdi-database-alert",
        debug = "mdi-bug"
    },
}

Config.Debugmode = {
    enable = false,
    blips = true,
    marker = {
        yellow = true,
        red = true,
    },
    notification = false,
}

