function openTowingyardmanagerMenu()
    local playerData = ESX.GetPlayerData()

    mainMenu = NativeUI.CreateMenu(_U('towingyardmenu_titel'),_U('towingyardmenu_subtitel', getGarageFromId(interactionArea).name))
    menuPool:Add(mainMenu)

    if playerData.job.name == Config.TowingyardJob then
        local towingyardInMenu = menuPool:AddSubMenu(mainMenu, _U('towingyard_towingyardmenu_titel'))
        addTowingyardinMenu(towingyardInMenu)

        local towingyardOutMenu = menuPool:AddSubMenu(mainMenu, _U('towingyard_parkingout_titel'))
        addTowingyardoutMenu(towingyardOutMenu)

    else
        addTowingyardoutMenu(mainMenu)
    end
    
    onMenuCreated()
    mainMenu:Visible(true)

    mainMenu.OnMenuClosed = function (menu)
        HasAlreadyEnteredInteractionArea = false
        menuPool:Clear()
    end

    while isInInteractionArea and HasAlreadyEnteredInteractionArea do
        Citizen.Wait(0)
        menuPool:ProcessMenus()
    end

    menuPool:Clear()

end