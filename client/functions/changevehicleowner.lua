-- Add Remove Commands Suggestions
local commandParameters = {
    { name = 'target', help = _U('cmd_changevehicleowner_target') },
    { name = '"plate"', help = _U('cmd_changevehicleowner_plate') },
}
TriggerEvent('chat:addSuggestion', ('/%s'):format(Config.Commands.changevehicleowner), _U('cmd_changevehicleowner_usage', Config.Commands.changevehicleowner), commandParameters)

-- /cvo 
RegisterNetEvent('dream_garage:cmd_changevehicleowner', function(_target, _plate)
    local ped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(ped)
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


    ESX.Game.SpawnVehicle('adder', playerCoords, 0.0, function(vehicle)
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
            })

            local data = ESX.Game.GetVehicleProperties(vehicle)
            data.plate = GetVehicleNumberPlateText(vehicle)

            if Config.Debugmode.enable == true then
                print('Gesetzte Plate: ['..data.plate..']')
            end
            ESX.Game.DeleteVehicle(vehicle)

           
            TriggerServerEvent('dream_garage:cmd_changevehicleowner', target, data.plate)

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