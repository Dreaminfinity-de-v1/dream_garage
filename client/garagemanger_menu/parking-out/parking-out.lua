function addParkingoutMenu(mainMenu)

    local garage = getGarageFromId(interactionArea)
    local menu = menuPool:AddSubMenu(mainMenu, _U('garage_parkingout_titel'))

    getOwnedVehiclesInGarage(function (vehicles)
        

        if #vehicles > 0 then

            for i, v in ipairs(vehicles) do


                
                local submenu = menuPool:AddSubMenu(menu, _U('garage_parkingout_item', v.plate))
                local displayName = getVehicleNameByModel(v.data.model)

                if v.custom_name ~= nil then
                    submenu.Subtitle.Text:Text(_U('garage_parkingout_item_custom', v.plate, v.custom_name))
                    submenu.ParentItem:RightLabel(v.custom_name)
                elseif displayName ~= nil then
                    submenu.Subtitle.Text:Text(_U('garage_parkingout_item_custom', v.plate, displayName))
                    submenu.ParentItem:RightLabel(displayName)
                end

                local parkingout = NativeUI.CreateItem(_U('garage_parkingout_item_parkingout'), _U('garage_parkingout_item_parkingout_desc'))
                local rename = NativeUI.CreateItem(_U('garage_parkingout_item_rename'), _U('garage_parkingout_item_rename_desc'))

                submenu.data = v

                submenu:AddItem(parkingout)
                submenu:AddItem(rename)
                addParkingoutSharedOptionsMenu(submenu)

                local _garage = garage
                
                submenu.OnItemSelect = function(sender, item, index)

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

                    for i2,v2 in ipairs(item.ParentMenu.ParentItem.ParentMenu.Items) do
                        if item.ParentMenu.ParentItem == v2 then
                            if item == parkingout then
                                onParkingoutItemClick(item.ParentMenu.data, _garage, i2, menu, submenu)

                            elseif item == rename then
                                onRenameItemClick(item)
                                
                            end
                            return
                        end
                    end

                    print("ERROR: Item not found!")
                end

                onMenuCreated(submenu)
            end
        else
            menu:AddItem(NativeUI.CreateItem(_U('garage_parkingout_noitem'), _U('garage_parkingout_noitem_desc')))
        end
        onMenuCreated(menu)
    end, garage.id, garage.vehicle_types)
    
    return menu
end

function onParkingoutItemClick(_data, garage, _index, _menu, _submenu)
    local found = false
    local data = _data
    local menu = _menu
    local submenu = _submenu
    local index = _index

    for i,v in ipairs(garage.garagemanager.spawnpoints) do
        if #ESX.Game.GetVehiclesInArea(v.coords, v.radius) <= 0 then
            found = true

            ESX.TriggerServerCallback('dream_garage:setVehicleOutparking', function(error)

                if error == 'ok' then

                    menu:RemoveItemAt(index)
                    if #menu.Items <= 0 then
                        menu:AddItem(NativeUI.CreateItem(_U('garage_parkingout_noitem'), _U('garage_parkingout_noitem_desc')))
                        menu:RefreshIndex()
                    end
                    if submenu ~= nil then
                        submenu:GoBack()
                    end

                    ESX.Game.SpawnVehicle(data.data.model, v.coords , v.heading, function(vehicle)
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout'),
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
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_not_allowed'),
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

                elseif error == 'already_out' then
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_already_out'),
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

                elseif error == 'database' then
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_database'),
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
            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_close)
    end

end

function onRenameItemClick(item)

    local dialog = exports['zf_dialog']:DialogInput({
        submit = _U('input_submit'),
        cancel = _U('input_cancel'),
        header = _U('input_rename_titel'),
        rows = {
            {
                id = 0, 
                txt = _U('input_rename_inputfield'),
                content = item.ParentMenu.data.custom_name,
            },
        }
    })


    if dialog ~= nil then

        ESX.TriggerServerCallback('dream_garage:setVehicleCustomename', function()

            
            item.ParentMenu.Subtitle.Text:Text(_U('garage_parkingout_item', item.ParentMenu.data.plate))

            if dialog[1].input ~= nil then
                item.ParentMenu.Subtitle.Text:Text(_U('garage_parkingout_item_custom', item.ParentMenu.data.plate, dialog[1].input))
                item.ParentMenu.ParentItem:RightLabel(dialog[1].input)
                item.ParentMenu.data.custom_name = dialog[1].input
            else
                item.ParentMenu.Subtitle.Text:Text(_U('garage_parkingout_item_custom', item.ParentMenu.data.plate, GetDisplayNameFromVehicleModel(item.ParentMenu.data.data.model)))
                item.ParentMenu.ParentItem:RightLabel(GetDisplayNameFromVehicleModel(item.ParentMenu.data.data.model))
                item.ParentMenu.data.custom_name = dialog[1].input

            end

        end, item.ParentMenu.data.plate, dialog[1].input)
    end
end
