function getTowingyardVehiclesInParkingarea(cb, vehicle_types)
    local vehicle_plates = {}

    for i,v in ipairs(getVehicleinParkingarea()) do
        table.insert(vehicle_plates, {plate = GetVehicleNumberPlateText(v), id = v})
    end

    ESX.TriggerServerCallback('dream_garage:getTowingyardVehicles', function(vehicles)
        cb(vehicles)

    end, vehicle_plates)
end