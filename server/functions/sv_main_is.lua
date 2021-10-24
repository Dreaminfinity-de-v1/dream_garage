function isIdentifierExist(identifier)
    result = MySQL.Sync.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier" , {
        ['@identifier'] = identifier,
    })
    if #result >= 1 then
        return true
    end
    return false
end