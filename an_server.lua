-----[ Codigo não mexer aqui ]-------------------------------------------
RegisterServerEvent('an:getPlayerIdentifiers')
AddEventHandler('an:getPlayerIdentifiers', function()
    if GetPlayerIdentifiers(source) ~= nil then
        TriggerClientEvent('an:setPlayerIdentifiers', source, GetPlayerIdentifiers(source))
    end
end)
--------------------------------------------------------------------------