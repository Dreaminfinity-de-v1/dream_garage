function addParkinglist(mainMenu)
    
    menu = menuPool:AddSubMenu(mainMenu, _U('garage_vehiclelist_titel'))



    ESX.TriggerServerCallback('dream_garage:getOwnedVehicles', function(vehicles)
        
        local items = {}
        local none = {}
        

        if #vehicles > 0 then
            for i, v in ipairs(vehicles) do

                item = NativeUI.CreateItem(_U('garage_vehiclelist_item', v.plate), _U('garage_vehiclelist_item_desc'))
                local displayName = getVehicleNameByModel(v.data.model)

                if v.custom_name ~= nil then
                    item:RightLabel(v.custom_name)
                elseif displayName ~= nil then
                    item:RightLabel(displayName)
                end


                if v.garage_id ~= nil then
                    if items[v.garage_id] == nil then
                        items[v.garage_id] = {}
                    end
                    table.insert( items[v.garage_id], { item = item, data = v } )
                else
                    table.insert( none, { item = item, data = v } )
                end
            end
        else
            menu:AddItem(NativeUI.CreateItem(_U('garage_vehiclelist_noitem'), _U('garage_vehiclelist_noitem_desc')))
        end     

        for _, sort in ipairs(Config.GarageParkinglistSort) do
            if sort == 'config_garages' then
                for i, v in ipairs(Config.Garages) do
                    if items[v.id] ~= nil then
                        submenu = menuPool:AddSubMenu(menu, v.name)
                        for k, v in pairs(items[v.id]) do
                            submenu:AddItem(v.item)
                            onMenuCreated(submenu)
                        end
        
                        items[v.id] = nil
                    end
                end
            elseif sort == 'config_towingyards' then
                for i, v in ipairs(Config.Towingyards) do
                    if items[v.id] ~= nil then
                        submenu = menuPool:AddSubMenu(menu, v.name)
                        for k, v in pairs(items[v.id]) do
                            submenu:AddItem(v.item)
                            onMenuCreated(submenu)
                        end
        
                        items[v.id] = nil
                    end
                end
            elseif sort == 'unknown_garages' then
                for k, v in pairs(items) do
                    if #v > 0 and v[1].data.garage_id ~= nil then
                        submenu = menuPool:AddSubMenu(menu, _U('garage_vehiclelist_item_unknown-garage', v[1].data.garage_id))
                        for i2, v2 in ipairs(v) do
                            submenu:AddItem(v2.item)
                            onMenuCreated(submenu)
                        end
                    end
                end
            elseif sort == 'out_of_garages' then
                if #none > 0 then
                    submenu = menuPool:AddSubMenu(menu, _U('garage_vehiclelist_item_out-of-garage'))
                    for k, v in pairs(none) do
                        submenu:AddItem(v.item)
                        onMenuCreated(submenu)
                    end
                end
            end
        end

        onMenuCreated(menu)
    end)

    return menu
end
