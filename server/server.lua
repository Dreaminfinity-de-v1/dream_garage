ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Create Database
Citizen.CreateThread(function()
    MySQL.Async.execute(
        "CREATE TABLE IF NOT EXISTS `dream_owned_vehicle` ( " ..
        "`vin` varchar(17) NOT NULL UNIQUE, " ..
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
        "`vin` varchar(17) NOT NULL, " ..
        "`key_owner` varchar(60) NOT NULL, " ..
        "`name` varchar(20) NOT NULL " ..
        ") ENGINE=InnoDB DEFAULT CHARSET=latin1;",
        {}, function(rowsChanged) end
    )

    MySQL.Async.execute(
        "CREATE TABLE IF NOT EXISTS `dream_vehicle_plate_log` ( " ..
        "`id` int(11) NOT NULL auto_increment PRIMARY KEY, " ..
        "`vin` varchar(17) NOT NULL UNIQUE, " ..
        "`plate` varchar(50) NOT NULL, " ..
        "`date` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP " ..
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



ESX.RegisterServerCallback('dream_garage:setVehicleOutparkingTowingyard', function (src, cb, plate, payment)
    local xPlayer = ESX.GetPlayerFromId(src)

    local found = false

    for i, v in ipairs(Config.AllowedPayments) do
        if v.name == payment and xPlayer.getAccount(payment).money >= Config.ImpoundPrice then
            xPlayer.removeAccountMoney(payment, Config.ImpoundPrice)
            cb(setVehicleOutparking(xPlayer.getIdentifier(), plate))
            found = true
            break
        end
    end

    if not found then
        cb('not_allowed')
    end
end)




ESX.RegisterServerCallback('dream_garage:setVehicleInparking', function(src, cb, data, garage_id, props)
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getJob().name == Config.TowingyardJob then
        local found = false
        for i,v in ipairs(Config.Towingyards) do
            if v.id == garage_id then
                found = true
                cb(setVehicleInparking(xPlayer.getIdentifier(), data, garage_id, props, true))
            end
        end

        if found ~= true then
            cb(setVehicleInparking(xPlayer.getIdentifier(), data, garage_id, props))
        end
        
    else
        cb(setVehicleInparking(xPlayer.getIdentifier(), data, garage_id, props))
    end

    
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

ESX.RegisterServerCallback('dream_garage:setVehicleCustomename', function(src, cb, plate, custom_name)
    local xPlayer = ESX.GetPlayerFromId(src)

    local error = setOwnedVehicleCustomeName(xPlayer.getIdentifier(), plate, custom_name)


    if error == 'ok' then
        TriggerClientEvent("swt_notifications:captionIcon",src,_U('notifications_titel'),_U('notification_message_rename'),
            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.success,'white',true,Config.Notification.icons.garage_warn)
        cb()
    elseif error == 'not_allowed' then
        TriggerClientEvent("swt_notifications:captionIcon",src,_U('notifications_titel'),_U('notification_message_not_allowed'),
            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

    elseif error == 'database' then
        TriggerClientEvent("swt_notifications:captionIcon",src,_U('notifications_titel'),_U('notification_message_database'),
            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)
    else
        TriggerClientEvent("swt_notifications:captionIcon",src,_U('notifications_titel'),"ERROR: " .. error,
            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)
        
    end
end)

ESX.RegisterServerCallback('dream_garage:getTowingyardVehicles', function(src, cb, vehicle_plates)
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getJob().name == Config.TowingyardJob then
        cb(getTowingyardVehicles(vehicle_plates))
        
    else
        TriggerClientEvent("swt_notifications:captionIcon",src,_U('notifications_towingyard_titel'),_U('notification_message_not_allowed'),
            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

    end
end)