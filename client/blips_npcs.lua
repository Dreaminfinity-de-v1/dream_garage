blips = {}
npcs  = {}


-- Blips
Citizen.CreateThread(function()

	if not Config.EnableBlips then return end

    blips['garages'] = {}
	for k, v in pairs(Config.Garages) do
        if v.blip ~= nil then
            blips['garages'][k] = createBlip(v.center_pos, v.blip.sprite or 524, v.blip.display, v.blip.color or 3, v.blip.scale, v.blip.titel or _U('garage_blip_name'))
        end
	end

    blips['towyards'] = {}
    for k, v in pairs(Config.Towyards) do
        if v.blip ~= nil then
            blips['towyards'][k] = createBlip(v.center_pos, v.blip.sprite or 68, v.blip.display, v.blip.color or 17, v.blip.scale, v.blip.titel or _U('toyard_blip_name'))
        end
	end
end)


-- NPC
Citizen.CreateThread(function()

    for k, v in pairs(Config.Garages) do
        spawnNPC(v.garagemanager.type, v.garagemanager.model, v.garagemanager.pos, v.garagemanager.heading)
    end

    for k, v in pairs(Config.Towyards) do
        spawnNPC(v.toyardmanager.type, v.toyardmanager.model, v.toyardmanager.pos, v.toyardmanager.heading)
    end
end)


function removeNPCs()

    for i, v in ipairs(npcs) do
        DeleteEntity(v)
    end

end

function spawnNPC(type, model, pos, heading)

    if type == nil then
        type = Config.NPCsDefaultType
    end

    if model ~= nil then
        model = GetHashKey(model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end
    else
        RequestModel(GetHashKey(Config.NPCsDefaultModel))
        while not HasModelLoaded(GetHashKey(Config.NPCsDefaultModel)) do
            Wait(1)
        end
        model = GetHashKey(Config.NPCsDefaultModel)
    end

    ped = CreatePed(type, model, pos.x, pos.y, pos.z, heading, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
    end
    TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)

    table.insert( npcs, ped )
end

function createBlip(pos, sprite, display, color, scale, titel)
    local blip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, display or 2)
    SetBlipColour(blip, color)
    SetBlipScale(blip, scale or 1.0)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(titel)
    EndTextCommandSetBlipName(blip)

    return blip
end