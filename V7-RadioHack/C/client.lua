local QBCore = exports[Config.Core]:GetCoreObject()

CreateThread(function()
    for k, v in pairs(Config.Coords) do
        exports[Config.TargetName]:AddBoxZone(k, v.vector3, v.minZ, v.maxZ, {
            name = k,
            heading = v.heading,
            debugPoly = false,
        }, {
            options = {
                {
                    type = "Client",
                    event = "radio",
                    icon = "fas fa-user-secret",
                    label = "Radio Hack",
                },
            },
            distance = 2.0
        })
    end
end)

RegisterNetEvent("radio", function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result2)
        if result2 then
            TriggerEvent("input")
        else
            TriggerEvent('QBCore:Notify', "You don't have a hacking radio usb or radio", 'error')
        end
    end, {Config.radiousbhack, Config.radioitem})
end)

RegisterNetEvent("input", function()
    local input = lib.inputDialog('Dialog title', {
        {type = 'number', label = 'Channel you want to hack', description = '(1 to 10)', icon = 'fa-solid fa-walkie-talkie'},
    })

    local channel = input[1]

    if channel == nil then
    else
        if channel >= 1 and channel <= 10 then
            TriggerEvent("challenge", channel)
        else
            TriggerEvent('QBCore:Notify', "Invalid number choose between 1 - 10", "error")
        end
    end
end)

RegisterNetEvent("challenge", function(chan)
    exports[Config.PsUi]:VarHack(function(success)
        if success then
            TriggerEvent("enterradio", chan)
            TriggerServerEvent('QBCore:Server:RemoveItem', Config.radiousbhack, 1)
            TriggerEvent('QBCore:Notify', "You have successfully hacked the system.", 'success')
        else
            TriggerEvent('QBCore:Notify', "You have failed to hack the system.", 'error')
            TriggerServerEvent('QBCore:Server:RemoveItem', Config.radiousbhack, 1)
        end
    end, 5, 3)
end)

RegisterNetEvent("enterradio", function(idrad)
    exports[Config.voicescript]:setVoiceProperty("radioEnabled", true)
    exports[Config.voicescript]:setRadioChannel(tonumber(idrad))
    TriggerServerEvent("WL-radio:server:addradiolist", idrad)
    TriggerServerEvent('pma-voice:setTalkingOnRadio', false)
    TriggerEvent('QBCore:Notify', "You are now connected to the radio channel " .. tostring(idrad), 'error')
end)

-- V7-Store <Discord: discord.gg/7xeJj9Akf6>