print('RegisterCommand: '..Config.Commands.give_vehicle)
RegisterCommand(Config.Commands.give_vehicle, function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "dream_garage.giveVehicle") then
        if type(args[5]) == "string" then
            args[5] = string.upper(args[5])
        end
        
        if source > 0 then
            if #args == 2 then
                giveVehicle(source, args[1], args[2], source, getRandomPlateByGrade(0))
    
            elseif #args == 3 then
                giveVehicle(source, args[1], args[2], args[3], getRandomPlateByGrade(0))
    
            elseif #args == 4 then
                if args[4] == '0' then
                    giveVehicle(source, args[1], args[2], args[3], getRandomPlateByGrade(0))
                elseif args[4] == '1' then
                    giveVehicle(source, args[1], args[2], args[3], getRandomPlateByGrade(1))
                else
                    TriggerClientEvent('chat:addMessage', source, {
                        color = { 255, 0, 0},
                        multiline = true,
                        args = {_U('notifications_titel'), _U('cmd_giveVehicle_usage', Config.Commands.give_vehicle)}
                    })
                end
            elseif #args >= 5 and args[4] == '2' then
                if #args[5] <= 8 then
                    if not isPlateExist(args[5]) then
                        giveVehicle(source, args[1], args[2], args[3], args[5])
                    else
                        TriggerClientEvent('chat:addMessage', source, {
                            color = { 255, 0, 0},
                            multiline = true,
                            args = {_U('notifications_titel'), _U('cmd_giveVehicle_plateuse', args[5])}
                        })
                    end
                else
                    TriggerClientEvent('chat:addMessage', source, {
                        color = { 255, 0, 0},
                        multiline = true,
                        args = {_U('notifications_titel'), _U('cmd_giveVehicle_wrongplate')}
                    })
                end
            else
                TriggerClientEvent('chat:addMessage', source, {
                    color = { 255, 0, 0},
                    multiline = true,
                    args = {_U('notifications_titel'), _U('cmd_giveVehicle_usage', Config.Commands.give_vehicle)}
                })
            end
            
        else
            print('This is not a console Command!')
        end
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('nopermissions', "/"..Config.Commands.give_vehicle)}
        })
    end
end,false)


function giveVehicle(source, type, model, target, plate)
    if plate ~= nil then
        TriggerClientEvent('dream_garage:cmd_giveVehicle', source, type, model, target, plate)
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('cmd_giveVehicle_plateisnil')}
        })
    end
end