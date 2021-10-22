-- Add Remove Commands Suggestions
local commandParameters = {
    { name = '<type>', help = _U('cmd_giveVehicle_type') },
    { name = '<model>', help = _U('cmd_giveVehicle_model') },
    { name = 'target', help = _U('cmd_giveVehicle_target') },
    { name = 'plategrade', help = _U('cmd_giveVehicle_plate-grade') },
    { name = '"plate"', help = _U('cmd_giveVehicle_plate') },
}
TriggerEvent('chat:addSuggestion', ('/%s'):format(Config.Commands.give_vehicle), _U('cmd_giveVehicle_usage', Config.Commands.give_vehicle), commandParameters)

-- /giveVehicle <adder> [2] [0 | 1 | 2] [custom plate]
RegisterNetEvent('dream_garage:cmd_giveVehicle', function(_type, _model, _target, _plate)
    local ped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(ped)
    local type = _type
    local model = _model
    local target = _target
    local plate = _plate
    local spawned = false

    if plate ~= nil and #plate > 8 then
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('cmd_giveVehicle_maxchars')}
        })
        return
    end


    ESX.Game.SpawnVehicle(model, playerCoords, 0.0, function(vehicle)
        if DoesEntityExist(vehicle) then
            spawned = true
            SetEntityVisible(vehicle, false, false)
            FreezeEntityPosition(vehicle, true)
			SetEntityCollision(vehicle, false)
            
            if Config.Debugmode.enable == true then
                print('Übergebene Plate: ['..plate..']')
            end
            ESX.Game.SetVehicleProperties(vehicle, {
                plate = plate,
                fuelLevel = 100,
                engineHealth = 10000,
                tankHealth = 10000,
                bodyHealth = 10000,
                dirtLevel = 0.0,
            })

            local data = ESX.Game.GetVehicleProperties(vehicle)
            data.plate = GetVehicleNumberPlateText(vehicle)

            if Config.Debugmode.enable == true then
                print('Gesetzte Plate: ['..data.plate..']')
            end
            ESX.Game.DeleteVehicle(vehicle)

            if Config.VehicleTypes[type] == nil then
                TriggerEvent('chat:addMessage', {
                    color = { 255, 0, 0},
                    multiline = true,
                    args = {_U('notifications_titel'), _U('cmd_giveVehicle_wrong-type')}
                })
            else
                ESX.TriggerServerCallback('dream_garage:cmd_giveVehicle', function(error) 
                    if error == true then
                        TriggerEvent('chat:addMessage', {
                            color = { 0, 255, 0},
                            multiline = true,
                            args = {_U('notifications_titel'), _U('cmd_giveVehicle')}
                        })
                    else
                        TriggerEvent('chat:addMessage', {
                            color = { 255, 0, 0},
                            multiline = true,
                            args = {_U('notifications_titel'), _U('cmd_giveVehicle_wrong-user')}
                        })
                    end
                end, type, target, data)

            end
        end
    end)

    Wait(2500)
	if not spawned then
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('cmd_giveVehicle_invalid-model')}
        })
	end
end)