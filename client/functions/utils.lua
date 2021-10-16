function getGarageFromId(id)
    for i, k in ipairs(Config.Garages) do
        if k.id == id then
            return k
        end
    end
end