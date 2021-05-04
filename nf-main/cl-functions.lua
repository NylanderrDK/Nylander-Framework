ClFunction = {}
ClFunction.System = {}
ClFunction.Game = {}
ClFunction.UI = {}

--[[
    ClFunction.System Functions
    These functions provide tools for the system, such as print and so on.
    You can read more about the functions specifically above each function, which type of parameter they need and such.
]]

-- ClFunction.System.Print(text: string)
-- text: The text you wanna print.
-- Prints the specified text to the client console (F8).
ClFunction.System.Print = function(text)
    print("^3[NYLANDER FRAMEWORK] ^6>> ^7" .. text)
end

-- ClFunction.System.CountTableLength(table: table)
-- table: The table the function should count in.
-- Counts the total of values in the specified result, and returns it.
ClFunction.System.CountTableLength = function(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end

-- ClFunction.System.ValueInTable(table: table, val: any)
-- table: The table the function should check in.
-- val: The value the function should check for.
-- Checks if the provided value is in the provided table.
ClFunction.System.ValueInTable = function(table, val)
    for k, v in pairs(table) do
        if val == v then return true end
    end
    return false
end

--[[
    ClFunction.Game Functions
    These functions provide easy access to game functions, such as sounds, emotes and so on.
    You can read more about the functions specifically above each function, which type of paramter they need and such.
]]

-- ClFunction.Game.StartEmote(anim: string)
-- anim: The name of the animation to play (reference: https://alexguirre.github.io/animations-list/)
-- Starts the provided animation on the ped.
ClFunction.Game.StartEmote = function(anim)
    if IsPedActiveInScenario(PlayerPedId()) then
        ClearPedTasks(PlayerPedId())
    else
        TaskStartScenarioInPlace(PlayerPedId(), anim, 0, true)
    end
end

-- ClFunction.Game.StopEmote()
-- Stops the current playing animation/scenario, if any.
ClFunction.Game.StopEmote = function()
    if IsPedActiveInScenario(PlayerPedId()) then
        ClearPedTasks(PlayerPedId())
    end
end

-- ClFunction.Game.FadeIn(ms: int)
-- ms: How long (in miliseconds) the fade in should take.
-- Fades the view in.
ClFunction.Game.FadeIn = function(ms)
    DoScreenFadeIn(ms)
    while not IsScreenFadedIn() do Wait(100) end
end

-- ClFunction.Game.FadeOut(ms: int)
-- ms: How long (in miliseconds) the fade out should take.
-- Fades the view out.
ClFunction.Game.FadeOut = function(ms)
    DoScreenFadeOut(ms)
    while not IsScreenFadedOut() do Wait(100) end
end

-- ClFunction.Game.GiveWeapon(id: string, ammo: int)
-- hash: The hash key of the weapon to give (reference: https://wiki.rage.mp/index.php?title=Weapons, look for *ID*)
-- ammo: The number of ammo to give.
-- Gives the specified weapon to ped, with the amount of ammo.
ClFunction.Game.GiveWeapon = function(id, ammo)
    GiveWeaponToPed(PlayerPedId(), GetHashKey(hash), ammo, false, false)
end

-- ClFunction.Game.PlaySound(name: string, ref: string)
-- name: The name of the audio (refrence: https://pastebin.com/DCeRiaLJ)
-- ref: The audio reference (reference: https://pastebin.com/DCeRiaLJ)
-- Plays the selected sound on the client.
ClFunction.Game.PlaySound = function(name, ref)
    PlaySoundFrontend(-1, name, ref, 1)
end

-- ClFunction.Game.LoadDict(name: string)
-- name: The name of the animation dictionary to load.
-- Loads the provided animation dictionary.
ClFunction.Game.LoadDict = function(name)
    RequestAnimDict(name)
    while not HasAnimDictLoaded(name) do Wait(100) end
end

-- ClFunction.Game.GetVehicleInFront()
-- Returns the vehciel in front of the player.
ClFunction.Game.GetVehicleInFront = function()
    local ped = PlayerPedId()
    local pedPos = GetEntityCoords(ped)
    local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pedPos.x, pedPos.y, pedPos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, ped, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

--[[
    ClFunction.UI Functions
    These functions provide easy access UI features, such as notifications, custom HUD and so on.
    You can read more about the functions specifically above each function, which type of parameter they need and such.
]]

-- ClFunction.UI.DefaultNotification(text: string)
-- text: The text of the notification (example: WIP)
-- Shows a default notification above the minimap with the provided text.
ClFunction.UI.DefaultNotification = function(text)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(true, true)
end

-- ClFunction.UI.PictureNotification(picture: string, title: string, subtitle: string, text: string, flash: bool, iconType: int)
-- picture: The picture you want to use (reference: https://wiki.gtanet.work/index.php?title=Notification_Pictures)
-- title: The title of the notification (example: WIP)
-- subtitle: The subtitle of the notification (example: WIP)
-- text: The text of the notification (example: WIP)
-- flash: Whether the notification should blink or not.
-- iconType: Which icon that should be displayed in the upper right corner (0: nothing, 1: chat box, 2: email, 3: add friend request, 7: right jumping arrow, 8: RP icon, 9: $ icon)
-- Shows a notification with a picture (reference: https://wiki.gtanet.work/index.php?title=Notification_Pictures) above the minimap, with the provided title, subtitle and text.
ClFunction.UI.PictureNotification = function(picture, title, subtitle, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(picture, picture, flash, iconType, title, subtitle)
    DrawNotification(flash, false)
end

-- ClFunction.UI.KeyboardInput(entry: string, placeholder: string, maxLength: int)
-- entry: The title of the input (example: WIP)
-- placeholder: The placeholder of the input (example: WIP)
-- maxLength: The maximum number of characters the input can take.
-- Shows a input field on the screen, and returns the value.
ClFunction.UI.KeyboardInput = function(entry, placeholder, maxLength)
    AddTextEntry("FMMC_KEY_TIP1", entry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", placeholder, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do Wait(0) end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        return result
    else
        Wait(500)
        return nil
    end
end

-- ClFunction.UI.Draw2DText(x: float, y: float, width: int, height: int, scale: int, r: int, g: int, b: int, a: int, text: string)
-- x: The x-position of the text
-- y: The y-position of the text
-- width: The width of the text
-- height: The height of the text
-- scale: The scale of the text
-- r: The r-value for the color of the text
-- g: The g-value for the color of the text
-- b: The b-value for the color of the text
-- a: The a-value for the color of the text
-- text: The text it self
-- Draws a 2D text on the screen, with the provided settings/properties.
ClFunction.UI.Draw2DText = function(x, y, width, height, scale, r, g, b, a, text)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow()
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

-- ClFunction.UI.Draw3DText(x: float, y: float, z: float, text: string)
-- x: The x-position of the text
-- y: The y-position of the text
-- z: The z-position of the text
-- text: The text it self
ClFunction.UI.Draw3DText = function(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STIRNG")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = string.len(text) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end