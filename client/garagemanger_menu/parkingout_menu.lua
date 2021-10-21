function addParkingoutMenu(mainMenu)

    local garage = getGarageFromId(interactionArea)
    local menu = menuPool:AddSubMenu(mainMenu, _U('garage_parkingout_titel'))

    getOwnedVehiclesInGarage(function (vehicles)
        

        if #vehicles > 0 then

            for i, v in ipairs(vehicles) do
                local data = v
                local item = NativeUI.CreateItem(_U('garage_parkingout_item', v.plate), _U('garage_parkingout_item_desc'))
                if v.custom_name ~= nil then
                    item:RightLabel(v.custom_name)
                end

                item.data = data

                menu:AddItem(item)

                local _garage = garage

                menu.OnItemSelect = function(sender, _item, index)
                    onParkingoutItemClick(_item.data, _garage, sender, index, menu)
                end
                
            end
        else
            menu:AddItem(NativeUI.CreateItem(_U('garage_parkingout_noitem'), _U('garage_parkingout_noitem_desc')))
        end    
    end, garage.id, garage.vehicle_types)

    return menu
end


function onParkingoutItemClick(_data, garage, sender, _index, _menu)


    local found = false
    local data = _data
    local menu = _menu
    local index = _index

    for i,v in ipairs(garage.garagemanager.spawnpoints) do
        if #ESX.Game.GetVehiclesInArea(v.coords, v.radius) <= 0 then
            found = true

            ESX.TriggerServerCallback('dream_garage:setVehicleOutparking', function(error)

                if error == 'ok' then

                    ESX.Game.SpawnVehicle(data.data.model, v.coords , v.heading, function(vehicle)
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout'),
                            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.success,'white',true,Config.Notification.icons.parkingout)
                        ESX.Game.SetVehicleProperties(vehicle, data.data)
                        Citizen.CreateThread(function ()
                            local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
                            SetBlipSprite(blip, 1)
                            SetBlipDisplay(blip, 8)
                            SetBlipColour(blip, 61)
                            SetBlipScale(blip, 1.0)
                            SetBlipAsShortRange(blip, true)
                            SetBlipRoute(blip, true)
                            SetBlipAsMissionCreatorBlip(blip, true)
    
                            while true do
                                Citizen.Wait(500)
                                if DoesEntityExist(vehicle) == false or GetPedInVehicleSeat(vehicle, -1) ~= 0 then
                                    RemoveBlip(blip)
                                    break
                                end
                            end
                        end)
                    end)

                    menu:RemoveItemAt(index)
                    if #menu.Items <= 0 then
                        menu:AddItem(NativeUI.CreateItem(_U('garage_parkingout_noitem'), _U('garage_parkingout_noitem_desc')))
                        menu:RefreshIndex()
                    end

                elseif error == 'not_allowed' then
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_not_allowed'),
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.not_allowed)

                elseif error == 'already_out' then
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_already_out'),
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.already_out)

                elseif error == 'not_found' then
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_not_found'),
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.not_found)

                elseif error == 'database' then
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_database'),
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)
                else
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),"ERROR: " .. error,
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)
                    
                end
                
            end, data.data.plate)
            break
        end
    end

    if not found then
        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_nofreeparkarea'),
            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.default)
    end

end