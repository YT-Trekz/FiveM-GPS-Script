RegisterServerEvent("L-TomTom:getPlayerCoords")
AddEventHandler("L-TomTom:getPlayerCoords", function(playerId)
    local sourcePlayer = source
    local targetPlayer = GetPlayerPed(playerId)

    if targetPlayer and DoesEntityExist(targetPlayer) then
        local targetCoords = GetEntityCoords(targetPlayer)
        TriggerClientEvent("L-TomTom:setBlip", sourcePlayer, targetCoords)
    else
        -- Stuur 'nil' als de speler niet bestaat
        TriggerClientEvent("L-TomTom:setBlip", sourcePlayer, nil)
    end
end)
