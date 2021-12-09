local allowedChars = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" }

function getRandomVehicleIdentificationNumber()
    local count = 0

    while true do
        local vin = "DI"
        count = count + 1
        if count > 10 then return nil end

        for i=1, 15 do
            vin = vin .. allowedChars[math.random(1,#allowedChars)]
        end

        if not isVehicleIdentificationNumberExist(vin) then
            return vin
        end
    end

end

function isVehicleIdentificationNumberExist(vin)
    local result = 0

    result = MySQL.Sync.fetchAll("SELECT * FROM `dream_owned_vehicles` WHERE `vin` = @vin" , {
        ['@vin'] = vin,
    })

    if #result >= 1 then
        return true
    end
    return false

end

