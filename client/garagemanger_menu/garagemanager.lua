function openGaragemanagerMenu()


    mainMenu = NativeUI.CreateMenu(_U('garagemenu_titel'),_U('garagemenu_subtitel', getGarageFromId(interactionArea).name))
    menuPool:Add(mainMenu)

    
    addParkingoutMenu(mainMenu)
    addParkingMenu(mainMenu)
    addParkinglist(mainMenu)
    
    Citizen.Wait(250)

    menuPool:RefreshIndex()

    menuPool:ControlDisablingEnabled(false)
    menuPool:MouseControlsEnabled(false)

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

