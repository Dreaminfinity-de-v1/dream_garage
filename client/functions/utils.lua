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