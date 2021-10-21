function addParkingMenu(mainMenu)
    local menu = menuPool:AddSubMenu(mainMenu, _U('garage_parkingin_titel'))

    getVehicleinParkingareaOwnedVehicles(function(vehicles)
        if #vehicles > 0 then
            for i, v in ipairs(vehicles) do
                --item = NativeUI.CreateItem(_U('garage_parking_item', v.data.plate), _U('garage_parking_item_desc'))
                item = NativeUI.CreateItem(_U('garage_parkingin_item', v.data.plate), '~r~Work in Progress')
                if v.data.custom_name ~= nil then
                    item:RightLabel(v.data.custom_name)
                end
    
                menu:AddItem(item)
    
                item.Activated = function(sender, index)
                    print('TOLL GEMACHT!')
                    -- check is player not in vehicle!
                    ESX.Game.DeleteVehicle(v.id)
                end
    
            end
        else
            menu:AddItem(NativeUI.CreateItem(_U('garage_parkingin_noitem'), _U('garage_parkingin_noitem_desc')))
        end
    end)



    return menu
end