menuclick_wait = false

function addParkinginMenu(mainMenu)
    local garage = getGarageFromId(interactionArea)
    local menu = menuPool:AddSubMenu(mainMenu, _U('garage_parkingin_titel'))

    getOwnedVehiclesInParkingarea(function(vehicles)
        if #vehicles > 0 then
            for i, v in ipairs(vehicles) do
                item = NativeUI.CreateItem(_U('garage_parkingin_item', v.data.plate), _U('garage_parkingin_item_desc'))
                if v.data.custom_name ~= nil then
                    item:RightLabel(v.data.custom_name)
                end

                item.data = v
                menu:AddItem(item)

                local _garage = garage

                menu.OnItemSelect = function(sender, _item, index)
                    
                    if _item ~= nil and _item.data ~= nil then
                        if menuclick_wait == true then
                            TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_wait-info'),
                                Config.Notification.pos,1,Config.Notification.color.wait,'white',true,Config.Notification.icons.car_wait)
                            return
                        end
    
                        menuclick_wait = true
                        Citizen.CreateThread(function()
                            Citizen.Wait(500)
                            menuclick_wait = false
                        end)

                        onParkinginItemClick(_item.data, _garage, sender, index, menu)
                    end
                end
    
            end
        else
            menu:AddItem(NativeUI.CreateItem(_U('garage_parkingin_noitem'), _U('garage_parkingin_noitem_desc')))
        end
    end, garage.vehicle_types)



    return menu
end


function onParkinginItemClick(_data, garage, sender, _index, _menu)

    local data = _data
    local menu = _menu
    local index = _index
    
    local ped = GetPlayerPed(-1)
    if GetVehiclePedIsIn(ped,false) ~= data.id then
        
        getOwnedVehiclesInParkingarea(function(vehicle)

            if vehicle ~= nil then
                ESX.TriggerServerCallback('dream_garage:setVehicleInparking', function(error)

                    if error == 'ok' then
                        if deleteVehicle(data, menu, index) == true then
                            TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingin'),
                                Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.success,'white',true,Config.Notification.icons.garage_close)
                        end



                    elseif error == 'not_allowed' then
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_not_allowed'),
                            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

                    elseif error == 'already_in' then
                        if deleteVehicle(data, menu, index) == true then
                            TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingin_already_in'),
                                Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.warn,'black',true,Config.Notification.icons.garage_close)
                        end


                    elseif error == 'database' then
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_database'),
                            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)
                    else
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),"ERROR: " .. error,
                            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)
                        
                    end

                end, data.data.plate, garage.id, ESX.Game.GetVehicleProperties(data.id))
            else
                TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingin_not-in-area'),
                    Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)
            end
        end, garage.vehicle_types, data.data.plate)
    else
        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingin_in-the-vehicle'),
            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_close)
    end
end


function deleteVehicle(data, menu, index)
    local attempt = 0

    while not NetworkHasControlOfEntity(data.id) and attempt < 20 and DoesEntityExist(data.id) do
        Citizen.Wait(100)
        NetworkRequestControlOfEntity(data.id)
        if attempt % 10 == 0 then
            TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parking_attempt-info'),
                Config.Notification.pos,1,Config.Notification.color.wait,'white',true,Config.Notification.icons.car_wait)
        end
        attempt = attempt + 1
    end

    if NetworkHasControlOfEntity(data.id) then
        ESX.Game.DeleteVehicle(data.id)

        menu:RemoveItemAt(index)
        if #menu.Items <= 0 then
            menu:AddItem(NativeUI.CreateItem(_U('garage_parkingout_noitem'), _U('garage_parkingout_noitem_desc')))
            menu:RefreshIndex()
        end

        return true
    else
        ESX.TriggerServerCallback('dream_garage:setVehicleOutparking', function(error) end, data.data.plate)
        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_not_allowed'),
            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)
    end

end