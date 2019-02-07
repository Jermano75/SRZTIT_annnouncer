local m = {} -- <<< Não mexas aqui
----------------------------------[ Defenições ]-----------------------------

-- Delay entre as mesangens
m.delay = 10

-- Prefixo que aparece a frente da mensagem 
-- Sufixo que aparece final da mensagem
-- Deixa o prefixo e sufixo em branco ( '' ) para desatianr.
m.prefix = '^6[Policia] '
m.suffix = '^6.'

-- Ypodes fazer as mensagens que quiseres.
-- Podes usar ^0-^9 para mudar a cor do texto.
m.messages = {   
    '^8 Isto é Um teste!',
    '^2 Programa de teste  ESX-Portugal!',
    '^5 Olá trabalho de uma snail',

}

-- Jogadores aqui marcados não iram receber este anuncios
-- Remove o "m.ignorelist = {"  para tirar opçao de evitar players
m.ignorelist = { 

}
--------------------------------------------------------------------------


















-----[ Codigo, não mexer aqui ]-------------------------------------------
local playerIdentifiers
local enableMessages = true
local timeout = m.delay * 1000 * 60 -- ms, para sec, para min
local playerOnIgnoreList = false
RegisterNetEvent('an:setPlayerIdentifiers')
AddEventHandler('an:setPlayerIdentifiers', function(identifiers)
    playerIdentifiers = identifiers
end)
Citizen.CreateThread(function()
    while playerIdentifiers == {} or playerIdentifiers == nil do
        Citizen.Wait(1000)
        TriggerServerEvent('an:getPlayerIdentifiers')
    end
    for iid in pairs(m.ignorelist) do
        for pid in pairs(playerIdentifiers) do
            if m.ignorelist[iid] == playerIdentifiers[pid] then
                playerOnIgnoreList = true
                break
            end
        end
    end
    if not playerOnIgnoreList then
        while true do
            for i in pairs(m.messages) do
                if enableMessages then
                    chat(i)
                    print('[annnouncer] Message #' .. i .. ' sent.')
                end
                Citizen.Wait(timeout)
            end
            
            Citizen.Wait(0)
        end
    else
        print('[annnouncer] Player is on ignorelist, no announcements will be received.')
    end
end)
function chat(i)
    TriggerEvent('chatMessage', '', {255,255,255}, m.prefix .. m.messages[i] .. m.suffix)
end
RegisterCommand('automessage', function()
    enableMessages = not enableMessages
    if enableMessages then
        status = '^2enabled^5.'
    else
        status = '^1disabled^5.'
    end
    TriggerEvent('chatMessage', '', {255, 255, 255}, '^5[annnouncer] automessages are now ' .. status)
end, false)
--------------------------------------------------------------------------
