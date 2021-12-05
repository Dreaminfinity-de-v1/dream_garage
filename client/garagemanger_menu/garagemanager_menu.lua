function openGaragemanagerMenu()


    mainMenu = NativeUI.CreateMenu(_U('garagemenu_titel'),_U('garagemenu_subtitel', getGarageFromId(interactionArea).name))
    menuPool:Add(mainMenu)

    
    addParkingoutMenu(mainMenu)
    addParkingoutSharedMenu(mainMenu)
    addParkinginMenu(mainMenu)
    addParkinglist(mainMenu)

    onMenuCreated(mainMenu)
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
