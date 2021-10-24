

RegisterNetEvent('dream_garage:removeMoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if Config.ImpounderPayWithCash == true and xPlayer.getAccount('money').money >= Config.ImpoundPrice then
        xPlayer.removeAccountMoney('money', Config.ImpoundPrice)
    elseif Config.ImpounderPayWithBank == true and xPlayer.getAccount('bank').money >= Config.ImpoundPrice then
        xPlayer.removeAccountMoney('bank', Config.ImpoundPrice)
    else
        TriggerEvent("swt_notifications:captionIcon",source,_U('notifications_towingyard_titel'),_U('notification_message_not-enough-money'),
            Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.negative,'white',true,Config.Notification.icons.garage_warn)
    end
end)


function checkImpoundMoney(src)
    local xPlayer = ESX.GetPlayerFromId(src)

    if Config.ImpounderPayWithCash == true and xPlayer.getAccount('money').money >= Config.ImpoundPrice then
        return true
    elseif Config.ImpounderPayWithBank == true and xPlayer.getAccount('bank').money >= Config.ImpoundPrice then
        return true
    end

    return false
end



function getTowingyardVehicles(vehicle_plates)
    local result = {}

    for i,v in ipairs(getAllVehicles()) do
        for i2,v2 in ipairs(vehicle_plates) do
            if v.plate == v2.plate then
                table.insert( result, {data = v, id = v2.id})
            end
        end
    end

    return result
end