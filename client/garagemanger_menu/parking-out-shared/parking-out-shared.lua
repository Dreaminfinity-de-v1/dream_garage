function addParkingoutSharedMenu(mainMenu)

    local garage = getGarageFromId(interactionArea)
    local menu = menuPool:AddSubMenu(mainMenu, _U('garage_parkingoutshared_titel'))

    getAllowedVehiclesInGarage(function(vehicles)
        
        if #vehicles > 0 then
            for i, v in ipairs(vehicles) do
                local item_x = NativeUI.CreateItem(_U('garage_parkingin_item', v.data.plate), _U('garage_parkingin_item_desc'))
                local displayName = getVehicleNameByModel(v.data.model)

                if v.custom_name ~= nil then
                    item_x:RightLabel(v.custom_name)
                elseif displayName ~= nil then
                    item_x:RightLabel(displayName)
                end

                item_x.data = v
                menu:AddItem(item_x)

                local _garage = garage
                
                menu.OnItemSelect = function(sender, _item, index)

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

                    onParkingoutItemClick(_item.data, _garage, index, menu)
                end
            end
        else
            menu:AddItem(NativeUI.CreateItem(_U('garage_parkingout_noitem'), _U('garage_parkingout_noitem_desc')))
        end

        onMenuCreated()
    end, garage.id, garage.vehicle_types)
    return menu
end
