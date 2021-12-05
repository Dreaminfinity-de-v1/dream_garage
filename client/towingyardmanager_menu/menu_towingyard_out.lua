menuclick_wait = false

function addTowingyardoutMenu(menu)

    local towingyard = getGarageFromId(interactionArea)

    getOwnedVehiclesInGarage(function(vehicles)

        if #vehicles > 0 then

            for i, v in ipairs(vehicles) do

                local submenu = menuPool:AddSubMenu(menu, _U('towingyard_parkingout_menu', v.plate), _U('towingyard_parkingout_menu_desc', Config.ImpoundPrice))
                local displayName = getVehicleNameByModel(v.data.model)

                if v.custom_name ~= nil then
                    submenu.Subtitle.Text:Text(_U('towingyard_parkingout_menu_custom', v.plate, v.custom_name))
                    submenu.ParentItem:RightLabel(v.custom_name)
                elseif displayName ~= nil then
                    submenu.Subtitle.Text:Text(_U('towingyard_parkingout_menu_custom', v.plate, displayName))
                    submenu.ParentItem:RightLabel(displayName)
                end

                for i,v in ipairs(Config.AllowedPayments) do
                    local item =  NativeUI.CreateItem(_U('towingyard_parkingout_item_payment', v.label), "")
                    item:RightLabel(_U('towingyard_parkingout_item_pricesuffix', Config.ImpoundPrice))
                    item.payment = v.name
                    submenu:AddItem(item)
                end

                submenu.data = v

                local _towingyard = towingyard
                

                submenu.OnItemSelect = function(sender, _item, index)

                    if _item ~= nil and _item.ParentMenu.data ~= nil and _item.payment ~= nil then

                        if getMoney(_item.payment) >= Config.ImpoundPrice then
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

                            for i,v in ipairs(_item.ParentMenu.ParentItem.ParentMenu.Items) do
                                if _item.ParentMenu.ParentItem == v then
                                    onReleaseItemClick(_item, _towingyard, i, menu)
                                end
                            end

                            
                            

                        else
                            TriggerEvent("swt_notifications:captionIcon",_U('notifications_towingyard_titel'),_U('notification_message_not-enough-money'),
                                Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)
                        end
                    end

                end
                onMenuCreated(submenu)
            end
        else
            menu:AddItem(NativeUI.CreateItem(_U('towingyard_parkingout_noitem'), _U('towingyard_parkingout_noitem_desc')))
        end

        onMenuCreated(menu)
    end, towingyard.id, towingyard.vehicle_types)
end


function onReleaseItemClick(item, towingyard, _index, _menu)


    local found = false
    local data = item.ParentMenu.data
    local submenu = item.ParentMenu
    local payment = item.payment
    local menu = _menu
    local index = _index

    for i,v in ipairs(towingyard.towingyardmanager.spawnpoints) do
        if #ESX.Game.GetVehiclesInArea(v.coords, v.radius) <= 0 then
            found = true

            ESX.TriggerServerCallback('dream_garage:setVehicleOutparkingTowingyard', function(error)

                if error == 'ok' then

                    menu:RemoveItemAt(index)
                    if #menu.Items <= 0 then
                        menu:AddItem(NativeUI.CreateItem(_U('towingyard_parkingout_noitem'), _U('towingyard_parkingout_noitem_desc')))
                        menu:RefreshIndex()
                    end
                    submenu:GoBack()


                    ESX.Game.SpawnVehicle(data.data.model, v.coords , v.heading, function(vehicle)
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_towingyard_titel'),_U('notification_message_release', Config.ImpoundPrice),
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
    
                            while true do
                                Citizen.Wait(500)
                                if DoesEntityExist(vehicle) == false or GetPedInVehicleSeat(vehicle, -1) ~= 0 then
                                    RemoveBlip(blip)
                                    break
                                end
                            end
                        end)
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
                
            end, data.plate, payment)
            break
        end
    end

    if not found then
        TriggerEvent("swt_notifications:captionIcon",_U('notifications_towingyard_titel'),_U('notification_message_parkingout_nofreeparkarea'),
            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_close)
    end

end