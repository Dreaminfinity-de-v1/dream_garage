ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

allVehicles = nil

-- Create Database
Citizen.CreateThread(function()
    MySQL.Async.execute(
        "CREATE TABLE IF NOT EXISTS `dream_owned_vehicle` ( " ..
        "`plate` varchar(50) NOT NULL, " ..
        "`owner` varchar(60) NOT NULL, " ..
        "`vehicle` longtext NOT NULL, " ..
        "`garage_name` varchar(50), " ..
        "`vehicle_name` varchar(50), " ..
        "`type` varchar(10) NOT NULL DEFAULT 'car', " ..
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

    loadAllVehicles()
end)



function loadAllVehicles()

    allVehicles = MySQL.Sync.fetchAll('SELECT * FROM `dream_owned_vehicle` ORDER BY `dream_owned_vehicle`.`garage_name` ASC', {})   
end



function getOwnedVehicles(id)

    local result = {}
    for i,v in ipairs(allVehicles) do

        if v.owner == id then
            table.insert( result, v)
        end
    end

    return result
end

ESX.RegisterServerCallback('dream_garage:getOwnedVehicles', function(src, cb)

    local xPlayer = ESX.GetPlayerFromId(src)
    cb(getOwnedVehicles(xPlayer.getIdentifier()))
end)


AddEventHandler('esx:playerLoaded', function(playerData)
    
    loadAllVehicles()
end)