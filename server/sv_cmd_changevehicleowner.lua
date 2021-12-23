print('RegisterCommand: '..Config.Commands.changevehicleowner)
RegisterCommand(Config.Commands.changevehicleowner, function(source, args, rawCommand)
    
    if source > 0 then
        if #args >= 2 and tonumber(args[1]) ~= nil then
            args[2] = string.upper(args[2])
            TriggerClientEvent('dream_garage:cmd_changevehicleowner',source, args[1], args[2])
        else
            TriggerClientEvent('chat:addMessage', source, {
                color = { 255, 0, 0},
                multiline = true,
                args = {_U('notifications_titel'), _U('cmd_changevehicleowner_usage', Config.Commands.changevehicleowner)}
            })
        end
    else
        print('This is not a console Command!')        
    end
end,false)

function changeVehicleOwner(source, target, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local vehicle = getVehicleByPlate(plate)
    local newowner = nil

    if xTarget ~= nil then
        newowner = xTarget.getIdentifier()
    elseif isIdentifierExist(target) == true then
        newowner = target
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('cmd_changevehicleowner_usage', Config.Commands.changevehicleowner)}
        })
        return
    end

    if not IsPlayerAceAllowed(source, "dream_garage.changevehicleowner") or vehicle.owner ~= xPlayer.getIdentifier() then
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('cmd_changevehicleowner_not-allowed')}
        })
    end

    if not IsPlayerAceAllowed(source, "dream_garage.changevehicleowner") and newowner == xPlayer.getIdentifier() then
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('cmd_changevehicleowner_changevehicleowner_not-self')}
        })
        return
    end

    if vehicle == nil then
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('cmd_changevehicleowner_not-allowed')}
        })
        return
    end

    if vehicle.owner == xTarget.getIdentifier() then
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('cmd_changevehicleowner_changevehicleowner_owned')}
        })
        return
    end

    if setVehicleOwner(vehicle.vin, newowner) == true then
        TriggerClientEvent('chat:addMessage', source, {
            color = { 0, 255, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('cmd_changevehicleowner_changevehicleowner-success')}
        })
        TriggerClientEvent('chat:addMessage', xTarget.playerId, {
            color = { 0, 255, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('cmd_changevehicleowner_changevehicleowner-success_target', plate)}
        })
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('cmd_changevehicleowner_changevehicleowner-unsuccess')}
        })
    end
end

RegisterNetEvent('dream_garage:cmd_changevehicleowner',function(target, plate)
    changeVehicleOwner(source, target, plate)
end)
