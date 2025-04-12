Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1)
		if IsPedOnFoot(GetPlayerPed(-1)) then 
			SetRadarZoom(1100)
		elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			SetRadarZoom(1100)
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if Config.OpenGpsKay == true then
            RegisterKeyMapping(Config.Commnd, Config.Locale['gps_player'], 'keyboard', Config.OpenGps)
        end
    end
end)

RegisterKeyMapping(Config.Commnd, Config.Locale['gps_player'], 'keyboard', Config.OpenGps)
RegisterCommand(Config.Commnd, function()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(PlayerPedId(), true) then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "OpenGps"
        })
    else
        notify(Config.Locale['error_car'])
    end
end)

RegisterNUICallback("GpsPingPlayer", function(data, cb)
    local playerId = tonumber(data.playerId)
    if playerId then
        SetNuiFocus(false, false)
        TriggerServerEvent("L-TomTom:getPlayerCoords", playerId)
    end
    cb("ok")
end)

RegisterNUICallback("GpsPingMap", function(data, cb)
    local postalCode = tostring(data.postalCode:match("^%s*(.-)%s*$")) -- Verwijder spaties
    setWaypoint(postalCode)
    SetNuiFocus(false, false)
    cb("ok")
end)

RegisterNUICallback("closegps", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
end)

RegisterNetEvent("L-TomTom:setBlip")
AddEventHandler("L-TomTom:setBlip", function(coords)
    if coords then
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 280)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 1.2)
        SetBlipColour(blip, 1)
        SetBlipAsShortRange(blip, false)
        notify(Config.Locale['gps_player'])
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Location")
        EndTextCommandSetBlipName(blip)

        -- 60 seconden
        Citizen.SetTimeout(60000, function()
            RemoveBlip(blip)
        end)

    else
        notify(Config.Locale['error_player'])
    end
end)

function setWaypoint(postalCode)
    local postalCode_coords = vector3(0, 0, 0)

    for i = 1, #Config.postalcodes, 1 do
        if Config.postalcodes[i].code == postalCode then
            postalCode_coords = vector3(Config.postalcodes[i].x, Config.postalcodes[i].y, 0)
            break
        end
    end

    if postalCode_coords.x ~= 0.0 and postalCode_coords.y ~= 0.0 then
        SetNewWaypoint(postalCode_coords.x, postalCode_coords.y)

        --local blip = AddBlipForCoord(postalCode_coords.x, postalCode_coords.y, postalCode_coords.z)
        --SetBlipSprite(blip, 280) -- GPS marker
        --SetBlipColour(blip, 3)  -- Blauw (kleur ID 3)
        --SetBlipScale(blip, 1.0)  -- Grootte van de marker

        --BeginTextCommandSetBlipName("STRING")
        --AddTextComponentString("Location")
        --EndTextCommandSetBlipName(blip)
        notify(Config.Locale['gps_map_set'] ..postalCode)
        
        
    else
        notify(Config.Locale['error_locatie'])
    end
end

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end
