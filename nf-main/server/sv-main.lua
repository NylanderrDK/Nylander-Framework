-- Log in console when the resource has been started/initialized.
AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    SvFunction.System.Print(resourceName .. " has been initialized.")
end)