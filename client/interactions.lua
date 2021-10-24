
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

        for i, v in ipairs(Config.Garages) do
            continue = true
            local distance  = GetDistanceBetweenCoords(PlayerCoords, v.garagemanager.pos, true)
            if distance <= (v.garagemanager.radius or 2) then
                isIn = true
                area = v.id
                part = 'garagemanager'
                MSG = _U('help_notification_garage')
                break
            end
        end
    
        for i, v in ipairs(Config.Towingyards) do
            continue = true
            local distance  = GetDistanceBetweenCoords(PlayerCoords, v.towingyardmanager.pos, true)
            if distance <= v.towingyardmanager.radius then
                isIn = true
                area = v.id
                part = 'towingyardmanager'
                MSG = _U('help_notification_towingyard')
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
                    Citizen.CreateThread(function()
                        openGaragemanagerMenu()
                    end)
                elseif interactionPart == 'towingyardmanager' then
                    Citizen.CreateThread(function()
                        openTowingyardmanagerMenu()
                    end)
                end

                interactionPart = nil
            end
        end
    end
end)