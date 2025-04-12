RegisterServerEvent("L-TomTom:getPlayerCoords")
AddEventHandler("L-TomTom:getPlayerCoords", function(playerId)
    local sourcePlayer = source
    local targetPlayer = GetPlayerPed(playerId)

    if targetPlayer and DoesEntityExist(targetPlayer) then
        local targetCoords = GetEntityCoords(targetPlayer)
        TriggerClientEvent("L-TomTom:setBlip", sourcePlayer, targetCoords)
    else
        TriggerClientEvent("L-TomTom:setBlip", sourcePlayer, nil)
    end
end)
