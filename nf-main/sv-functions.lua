SvFunction = {}
SvFunction.System = {}

--[[
    SvFunction.System Functions
    These functions provide tools for the system, such as print and so on.
    You can read more about the functions specifically above each function, which type of parameter they need and such.
]]

-- SvFunction.System.Print(text: string)
-- text: The text to print to the server console.
-- Prints the specified text to the server console.
SvFunction.System.Print = function(text)
    print("^3[NYLANDER FRAMEWORK] ^6>> ^7" .. text)
end

-- SvFunction.System.GetIdentifier(type: string, id: int)
-- type: Which type of identifier to get (Steam, Discord, License, and so on)
-- id: The ID of the player to get from.
-- Returns the provided identifier.
SvFunction.System.GetIdentifier = function(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do table.insert(identifiers, GetPlayerIdentifier(id, a)) end
    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then return identifiers[b] end
    end
    return false
end

-- SvFunction.System.SendToDiscord(username: string, color: int, name: string, message: string, avatar: string, webhook: string)
-- username: The username of the webhook.
-- color: The color of the webhook.
-- name: The title of the webhook.
-- message: The message of the webhook.
-- avatar: A link to the avatar of the webhook.
-- webhook: A link to the webhook.
-- Sends a embed to Discord with the provided options.
SvFunction.System.SendToDiscord = function(username, color, name, message, avatar, webhook)
    local info = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Nylander Framework"
            }
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, "POST", json.encode({ username = username, embeds = info, avatar_url = avatar }), { ["Content-Type"] = "application/json" })
end