function addSharedParkingoutMenu(vehiclemenu_item)
    
    local sharedmenu = menuPool:AddSubMenu(vehiclemenu_item, _U('garage_parkingout_item_shared'), _U('garage_parkingout_item_shared_desc'))

    local addsharedcharacter = NativeUI.CreateItem(_U('garage_parkingout_item_shared_add'), _U('garage_parkingout_item_shared_add_desc'))

    sharedmenu:AddItem(addsharedcharacter)

    ESX.TriggerServerCallback('dream_garage:getSharedCharacters', function(vehicleChars)
        
        if #vehicleChars > 0 then

            for i, v in ipairs(vehicleChars) do
                local characterkeymenu = menuPool:AddSubMenu(sharedmenu, _U('garage_parkingout_item_shared_char', v.name), _U('garage_parkingout_item_shared_char_desc'))
                local itemremove = NativeUI.CreateItem(_U('garage_parkingout_item_shared_char_remove'), _U('garage_parkingout_item_shared_char_remove_desc'))
                local itemrename = NativeUI.CreateItem(_U('garage_parkingout_item_shared_char_rename'),_U('garage_parkingout_item_shared_char_rename_desc'))

                characterkeymenu.data = v
                characterkeymenu:AddItem(itemrename)
                characterkeymenu:AddItem(itemremove)

                
                characterkeymenu.OnItemSelect = function(sender, item, index)
                    local menu = item.ParentMenu
                    if item == itemremove then
                        onSharedRemoveItemClick(sender, item, index, menu)
                    elseif item == itemrename then
                        onSharedRenameItemClick(sender, item, index, menu)
                    end
                end
            end
        end
        onMenuCreated()
    end, vehiclemenu_item.data.plate)
    
        
    sharedmenu.OnItemSelect = function(sender, item, index)

        if item == addsharedcharacter then
            onSharedAddItemClick(sender, item, index)
        end
    end

    onMenuCreated()
end

function onSharedAddItemClick(sender, item, index)

    local data = item.ParentMenu.ParentItem.ParentMenu.data
    local found = false

    for i,v in ipairs(ESX.GetPlayerData().inventory) do
        if v.name == 'carkey' and v.count >= 1 then
            found = true
            break
        end
    end

    if found then
        local dialog = exports['zf_dialog']:DialogInput({
            submit = _U('input_submit'),
            cancel = _U('input_cancel'),
            header = _U('input_addsharedcharacter_titel'),
            rows = {
                {
                    id = 0, 
                    txt = _U('input_addsharedcharacter_inputfield'),
                },
                {
                    id = 1, 
                    txt = _U('input_addsharedcharacterid_inputfield'),
                },
            }
        })

        if dialog ~= nil then
            
            if dialog[1].input == nil then
                TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_sharedvehicle_no_name'),
                Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

            elseif #dialog[1].input > 20 then
                TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_sharedvehicle_name_to_long'),
                    Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

            elseif dialog[2].input == nil or type(tonumber(dialog[2].input)) ~= 'number' then
                TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_sharedvehicle_no_userid'),
                    Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

            else
                ESX.TriggerServerCallback('dream_garage:addSharedCharacter', function(error, target)
                    if error == 'ok' then
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_sharedvehicle'),
                            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.success,'white',true,Config.Notification.icons.garage_warn)

                        local characterkeymenu = menuPool:AddSubMenu(item.ParentMenu, _U('garage_parkingout_item_shared_char', dialog[1].input), _U('garage_parkingout_item_shared_char_desc'))
                        local itemremove = NativeUI.CreateItem(_U('garage_parkingout_item_shared_char_remove'), _U('garage_parkingout_item_shared_char_remove_desc'))
                        local itemrename = NativeUI.CreateItem(_U('garage_parkingout_item_shared_char_rename'),_U('garage_parkingout_item_shared_char_rename_desc'))
        
                        characterkeymenu.data = {plate = data.plate, key_owner = target, name = dialog[1].input}
                        characterkeymenu:AddItem(itemrename)
                        characterkeymenu:AddItem(itemremove)

                        characterkeymenu:RefreshIndex()
                        item.ParentMenu:RefreshIndex()
                        menuPool:ControlDisablingEnabled(false)
                        menuPool:MouseControlsEnabled(false)
        
                        
                        characterkeymenu.OnItemSelect = function(sender, item, index)
                            local menu = item.ParentMenu
                            if item == itemremove then
                                onSharedRemoveItemClick(sender, item, index, menu)
                            elseif item == itemrename then
                                onSharedRenameItemClick(sender, item, index, menu)
                            end
                        end

                    elseif error == 'not_allowed' then
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_not_allowed'),
                            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)
                    
                    elseif error == 'owner_exist' then
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_sharedvehicle_owner_exist'),
                            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)
                    
                    elseif error == 'cant_give_self' then
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_sharedvehicle_cant_give_self'),
                            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

                    elseif error == 'database' then
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_database'),
                            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)

                    elseif error == 'player_not_exist' then
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_sharedvehicle_player_not_exist'),
                            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)
   
                    elseif error == 'no_item' then
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_sharedvehicle_no_carkey'),
                            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)

                    else
                        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),"ERROR: " .. error,
                            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)

                    end
                end, dialog[1].input, dialog[2].input, data.plate)
            end
            
        end
    else
        TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_sharedvehicle_no_carkey'),
        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)
    end
end

function onSharedRemoveItemClick(sender, item, index, menu)
    ESX.TriggerServerCallback('dream_garage:removeSharedCharacter', function(error)

        if error == 'ok' then
            TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_removesharedvehicle'),
                Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.success,'white',true,Config.Notification.icons.garage_warn)

                menu:GoBack()
            
                for i,v in ipairs(menu.ParentItem.ParentMenu.Items) do
                    if menu.ParentItem == v then
                        menu.ParentItem.ParentMenu:RemoveItemAt(i)
                    end
                end

        elseif error == 'not_allowed' then
            TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_not_allowed'),
                Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

        elseif error == 'database' then
            TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_database'),
                Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)

        elseif error == 'player_not_exist' then
            TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_sharedvehicle_player_not_exist'),
                Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)

        elseif error == 'no_place' then
            TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_removesharedvehicle_no_place'),
                Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)

        else
            TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),"ERROR: " .. error,
                Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)

        end                 
    end, menu.data)
end

function onSharedRenameItemClick(sender, item, index, menu)

    local dialog = exports['zf_dialog']:DialogInput({
        submit = _U('input_submit'),
        cancel = _U('input_cancel'),
        header = _U('input_renamesharedcharacter_titel'),
        rows = {
            {
                id = 0, 
                txt = _U('input_renamesharedcharacter_inputfield'),
                content = item.ParentMenu.data.name,
            },
        }
    })
        
    if dialog ~= nil then

        
        if dialog[1].input == nil then
            TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_sharedvehicle_no_name'),
            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

        elseif #dialog[1].input > 20 then
            TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_sharedvehicle_name_to_long'),
                Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)

        else

            ESX.TriggerServerCallback('dream_garage:setSharedCharacterName', function(error)

                if error == 'ok' then
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_renamesharedcharactername'),
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.success,'white',true,Config.Notification.icons.garage_warn)
                
                    if dialog[1].input ~= nil then
                        menu.Subtitle.Text:Text(_U('garage_parkingout_item_shared_char', dialog[1].input), _U('garage_parkingout_item_shared_char_desc'))
                        menu.ParentItem.Text:Text(_U('garage_parkingout_item_shared_char', dialog[1].input), _U('garage_parkingout_item_shared_char_desc'))
                        menu.data.name = dialog[1].input
                    end

        
                elseif error == 'not_allowed' then
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_not_allowed'),
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)
        
                elseif error == 'database' then
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_database'),
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)
        
                elseif error == 'player_not_exist' then
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_sharedvehicle_player_not_exist'),
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)
        
                else
                    TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),"ERROR: " .. error,
                        Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.database)
        
                end

            end, menu.data, dialog[1].input)
        end
    end
end
