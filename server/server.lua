ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Create Database
Citizen.CreateThread(function()
    MySQL.Async.execute(
        "CREATE TABLE IF NOT EXISTS `dream_owned_vehicle` ( " ..
        "`plate` varchar(8) NOT NULL, " ..
        "`owner` varchar(60) NOT NULL, " ..
        "`data` longtext NOT NULL, " ..
        "`garage_id` varchar(50), " ..
        "`custom_name` varchar(50), " ..
        "`type` varchar(10) NOT NULL, " ..
        "PRIMARY KEY (`plate`) " ..
        ") ENGINE=InnoDB DEFAULT CHARSET=latin1;",
        {}, function(rowsChanged) end
    )

    MySQL.Async.execute(
        "CREATE TABLE IF NOT EXISTS `dream_vehicle_keys` ( " ..
        "`id` int(11) NOT NULL auto_increment PRIMARY KEY, " ..
        "`plate` varchar(50) NOT NULL, " ..
        "`key_owner` varchar(60) NOT NULL " ..
        ") ENGINE=InnoDB DEFAULT CHARSET=latin1;",
        {}, function(rowsChanged) end
    )
end)


ESX.RegisterServerCallback('dream_garage:getOwnedVehicles', function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)

    cb(getOwnedVehicles(xPlayer.getIdentifier()))
end)


ESX.RegisterServerCallback('dream_garage:setVehicleOutparking', function (src, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(src)

    cb(setVehicleOutparking(xPlayer.getIdentifier(), plate))
end)

ESX.RegisterServerCallback('dream_garage:cmd_giveVehicle', function(src, cb, type, target, data)
    if IsPlayerAceAllowed(src, "dream_garage.giveVehicle") then
        
        if Config.VehicleTypes[type] == nil then
            TriggerClientEvent('chat:addMessage', src, {
                color = { 255, 0, 0},
                multiline = true,
                args = {_U('notifications_titel'), _U('cmd_giveVehicle_wrong-type')}
            })
        end

        cb(setVehicle(type, target, data))

    else
        TriggerClientEvent('chat:addMessage', src, {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('nopermissions', Config.Commands.give_vehicle)}
        })
        cb(false)
    end
end)



