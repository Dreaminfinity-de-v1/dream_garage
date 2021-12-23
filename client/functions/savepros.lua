
TriggerEvent('chat:addSuggestion', ('/%s'):format(Config.Commands.save_props), _U('cmd_setprops_usage', Config.Commands.save_props))

RegisterNetEvent('dream_garage:cmd_setVehicleData', function()
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsUsing(ped)
    local props = ESX.Game.GetVehicleProperties(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)

    if vehicle ~= 0 then
        TriggerServerEvent('dream_garage:cmd_setVehicleData', plate, props)
    else
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {_U('notifications_titel'), _U('cmd_setprops_no-vehicle')}
        })
    end


end)