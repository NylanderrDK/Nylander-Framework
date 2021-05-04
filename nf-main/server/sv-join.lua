local card = {
    {
        "type": "AdaptiveCard",
        "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
        "version": "1.3",
        "body": [
            {
                "type": "Container",
                "items": [
                    {
                        "type": "TextBlock",
                        "text": Config.Language[Config.Locale]["server_name"],
                        "wrap": true,
                        "fontType": "Default",
                        "size": "ExtraLarge",
                        "weight": "Bolder",
                        "color": "Light"
                    },
                    {
                        "type": "ColumnSet",
                        "height": "stretch",
                        "minHeight": "5px",
                        "bleed": true,
                        "selectAction": {
                            "type": "Action.OpenUrl"
                        },
                        "columns": [
                            {
                                "type": "Column",
                                "width": "stretch",
                                "items": [
                                    {
                                        "type": "ActionSet",
                                        "actions": [
                                            {
                                                "type": "Action.OpenUrl",
                                                "title": Config.Language[Config.Locale]["join_discord"],
                                                "url": Config.DiscordLink,
                                                "style": "positive",
                                                "iconUrl": ""
                                            }
                                        ]
                                    }
                                ]
                            },
                            {
                                "type": "Column",
                                "width": "stretch",
                                "items": [
                                    {
                                        "type": "ActionSet",
                                        "actions": [
                                            {
                                                "type": "Action.Submit",
                                                "title": Config.Language[Config.Locale]["join_play"],
                                                "style": "positive",
                                                "id": "connect"
                                            }
                                        ]
                                    }
                                ],
                                "backgroundImage": {}
                            }
                        ],
                        "horizontalAlignment": "Center"
                    }
                ],
                "style": "default",
                "bleed": true,
                "height": "stretch",
                "isVisible": true
            }
        ]
    }
}

AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
    local source = source
    deferrals.defer()
    Citizen.Wait(50)

    deferrals.presentCard(card, function(data, rawData)
        if data.submitId = "connect" then
            deferrals.done()
        end
    end)
end)