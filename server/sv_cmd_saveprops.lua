print('RegisterCommand: '..Config.Commands.save_props)
RegisterCommand(Config.Commands.save_props, function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "dream_garage.saveProps") then
        if source > 0 then
            TriggerClientEvent('dream_garage:cmd_setVehicleData', source)
            
        else
            print('This is not a console Command!')
        end
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('nopermissions', "/"..Config.Commands.save_props)}
        })
    end
end,false)


RegisterNetEvent('dream_garage:cmd_setVehicleData', function(plate, props)
    local src = source
    
    if IsPlayerAceAllowed(src, "dream_garage.saveProps") then
        
        local vehicle = getVehicleByPlate(plate) --DEGUB
        if setVehicleData(vehicle.vin, props) == true then
            TriggerClientEvent('chat:addMessage', src, {
                color = { 0, 255, 0},
                multiline = true,
                args = {_U('notifications_titel'), _U('cmd_setprops')}
            })
        else
            TriggerClientEvent('chat:addMessage', src, {
                color = { 255, 0, 0},
                multiline = true,
                args = {_U('notifications_titel'), _U('cmd_setprops_vehicle-not-found')}
            })  
        end

    else
        TriggerClientEvent('chat:addMessage', src, {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('nopermissions', Config.Commands.give_vehicle)}
        })
    end
end)