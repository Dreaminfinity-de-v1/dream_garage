menuclick_wait = false

function addTowingyardRelease(menu)

    local towingyard = getGarageFromId(interactionArea)

    getOwnedVehiclesInGarage(function(vehicles)

        if #vehicles > 0 then

            for i, v in ipairs(vehicles) do

                item = NativeUI.CreateItem(_U('towingyard_release_item', v.plate), _U('towingyard_release_item_desc', Config.ImpoundPrice))
                if v.custom_name ~= nil then
                    item:RightLabel(v.custom_name)
                end

                item.data = v
                menu:AddItem(item)

                local _towingyard = towingyard

                menu.OnItemSelect = function(sender, _item, index)

                    ESX.TriggerServerCallback('dream_garage:hasEnoughMoney', function(result)
                        if result == true then

                            if _item ~= nil and _item.data ~= nil then
                                if menuclick_wait == true then
                                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_towingyard_titel'),_U('notification_message_wait-info'),
                                        Config.Notification.pos,1,Config.Notification.color.wait,'white',true,Config.Notification.icons.car_wait)
                                    return
                                end
            
                                menuclick_wait = true
                                Citizen.CreateThread(function()
                                    Citizen.Wait(500)
                                    menuclick_wait = false
                                end)

                                onReleaseItemClick(_item.data, _towingyard, index, menu)
                            end
                        else
                            TriggerEvent("swt_notifications:captionIcon",_U('notifications_towingyard_titel'),_U('notification_message_not-enough-money'),
                                Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)
                        end
                    end)
                end
            end
        else
            menu:AddItem(NativeUI.CreateItem(_U('towingyard_release_noitem'), _U('towingyard_release_noitem_desc')))
        end

    end, towingyard.id, towingyard.vehicle_types)
end


function onReleaseItemClick(_data, towingyard, _index, _menu)


    local found = false
    local data = _data
    local menu = _menu
    local index = _index

    for i,v in ipairs(towingyard.towingyardmanager.spawnpoints) do
        if #ESX.Game.GetVehiclesInArea(v.coords, v.radius) <= 0 then
            found = true

            ESX.TriggerServerCallback('dream_garage:setVehicleOutparking', function(error)

                if error == 'ok' then

                    menu:RemoveItemAt(index)
                    if #menu.Items <= 0 then
                        menu:AddItem(NativeUI.CreateItem(_U('towingyard_release_noitem'), _U('towingyard_release_noitem_desc')))
                        menu:RefreshIndex()
                    end
                    --menu:GoBack()

                    ESX.Game.SpawnVehicle(data.data.model, v.coords , v.heading, function(vehicle)
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_towingyard_titel'),_U('notification_message_release'),
                            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.success,'white',true,Config.Notification.icons.garage_open)
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

                        TriggerServerEvent('dream_garage:removeMoney')
                    end)

                elseif error == 'not_allowed' then
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_towingyard_titel'),_U('notification_message_not_allowed'),
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

                elseif error == 'already_out' then
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_towingyard_titel'),_U('notification_message_parkingout_already_out'),
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

                elseif error == 'database' then
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_towingyard_titel'),_U('notification_message_database'),
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)
                else
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_towingyard_titel'),"ERROR: " .. error,
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)
                    
                end
                
            end, data.plate, nil)
            break
        end
    end

    if not found then
        TriggerEvent("swt_notifications:captionIcon",_U('notifications_towingyard_titel'),_U('notification_message_parkingout_nofreeparkarea'),
            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_close)
    end

end