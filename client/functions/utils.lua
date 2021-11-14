function getGarageFromId(id)
    for i, v in ipairs(Config.Garages) do
        if v.id == id then
            return v
        end
    end
    for i, v in ipairs(Config.Towingyards) do
        if v.id == id then
            return v
        end
    end
end

function getVehicleNameByModel(model)
    local name = nil
    local makeName = GetMakeNameFromVehicleModel(model)
    local displayName = GetDisplayNameFromVehicleModel(model)

    if makeName == 'CARNOTFOUND' then
        makeName = ''
    end

    if displayName == 'CARNOTFOUND' then
        displayName = ''
    end

    if GetLabelText(makeName) ~= 'NULL' or GetLabelText(displayName) ~= 'NULL' then
        if GetLabelText(makeName) ~= 'NULL' then
            if name ~= nil then
                name = name .. ' ' .. GetLabelText(makeName)
            else
                name = GetLabelText(makeName)
            end
        end
    
        if GetLabelText(displayName) ~= 'NULL' then
            if name ~= nil then
                name = name .. ' ' .. GetLabelText(displayName)
            else
                name = GetLabelText(displayName)
            end
        end
    else
        if makeName ~= nil and makeName ~= '' and string.lower(makeName) ~= 'null' then
            if name ~= nil then
                name = name .. ' ' .. makeName
            else
                name = makeName
            end
        end
    
        if displayName ~= nil and displayName ~= '' and string.lower(displayName) ~= 'null' then
            if name ~= nil then
                name = name .. ' ' .. displayName
            else
                name = displayName
            end
        end
    end

    return name
    
end