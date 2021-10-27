function setVehicleInTowingyardByZeroUser()
    local players = GetPlayers()

    if #players <= 0 then
        local changes = 0

        for k, v in pairs(Config.DefaultTowingyards) do
            
            changes = MySQL.Sync.execute("UPDATE `dream_owned_vehicle` SET `garage_id` = @garage_id WHERE `garage_id` IS NULL AND `type` = @type", {
                
                ['@type'] = k,
                ['@garage_id'] = v,
            })
            if Config.Debugmode.enable == true then
                if changes ~= 0 then
                    print(_U('towingyard_zero-user', changes, k))
                end
            end
        end
    end
end

AddEventHandler('playerDropped', function (reason)
    local players = GetPlayers()
    if #players <= 0 then
        setVehicleInTowingyardByZeroUser()
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        local players = GetPlayers()
        if #players <= 0 then
            setVehicleInTowingyardByZeroUser()
        end
    end
end)