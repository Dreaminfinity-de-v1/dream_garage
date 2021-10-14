
isInInteractionArea = false
interactionArea     = nil
interactionPart     = nil
interactionMSG     = nil
HasAlreadyEnteredInteractionArea = false


--- Entering / Exiting Interaction Area
Citizen.CreateThread(function()
    local continue = true

    local lastInteractionArea     = nil
    local lastInteractionPart     = nil

    while continue do
        Citizen.Wait(250)

        continue = false

        local isIn  = false
        local area  = nil
        local part  = nil
        local MSG   = nil

		local playerPed = PlayerPedId()
		local PlayerCoords    = GetEntityCoords(playerPed)

        for k, v in pairs(Config.Garages) do
            continue = true
            local distance  = GetDistanceBetweenCoords(PlayerCoords, v.garagemanager.pos, true)
            if distance <= (v.garagemanager.radius or 2) then
                isIn = true
                area = k
                part = 'garagemanager'
                MSG = _U('help_notification_garage')
                break
            end
        end
    
        for k, v in pairs(Config.Towyards) do
            continue = true
            local distance  = GetDistanceBetweenCoords(PlayerCoords, v.toyardmanager.pos, true)
            if distance <= v.toyardmanager.radius then
                isIn = true
                area = k
                part = 'towyardmanager'
                MSG = _U('help_notification_towyard')
                break
            end
        end

        if isIn and not HasAlreadyEnteredInteractionArea then


            HasAlreadyEnteredInteractionArea = true

            lastInteractionArea = area
            lastInteractionPart = part

            isInInteractionArea = true
            interactionArea     = area
            interactionPart     = part
            interactionMSG      = MSG
            TriggerEvent('dream_garage:hasEnteredInteractionArea', area, part)
        end

        if not isIn and HasAlreadyEnteredInteractionArea then
            HasAlreadyEnteredInteractionArea = false
            isInInteractionArea = false
            interactionArea     = nil
            interactionPart     = nil
            interactionMSG      = nil
            TriggerEvent('dream_garage:hasExitedInteractionArea', area, part)
        end

    end
end)


Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)

        if interactionPart ~= nil then

            ESX.ShowHelpNotification(interactionMSG)

            if IsControlJustReleased(0, Config.KeyControle) then

                if interactionPart == 'garagemanager' then
                    --opengaragemanagerMenu()
                elseif interactionPart == 'towyardmanager' then
                    --openTowYardMenu()
                end

                interactionPart = nil
            end
        end
    end
end)