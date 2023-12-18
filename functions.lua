function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function CheckItems()
    local Items = QBCore.Shared.Items
    for k, zone in pairs(Config.BlackmarketZones) do
        for _, itemData in pairs(zone.ItemstoBuy) do
            local itemName = itemData.name
            if not Items[itemName] then
				print(string.format("^5Debug^7: ^3Item^7 ^3'%s'^7: ^5In Config.BlackmarketZones["..k.."].ItemstoBuy ^7^2does not exist in QBCore.Shared.Items!^7 ", itemName))
            end
        end
        for _, itemData in pairs(zone.ItemstoSell) do
            local itemName = itemData.name

            if not Items[itemName] then
				print(string.format("^5Debug^7: ^3Item^7 ^3'%s'^7: ^5In Config.BlackmarketZones["..k.."].ItemstoSell ^7^2does not exist in QBCore.Shared.Items!^7 ", itemName))
            end
        end
    end
end

function deepCopy(orig)
    local copy
    if type(orig) == 'table' then
        copy = {}
        for k, v in next, orig, nil do
            copy[deepCopy(k)] = deepCopy(v)
        end
        setmetatable(copy, deepCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

embedData = {
    {
        ['title'] = "",
        ['color'] = "",
        ['footer'] = {['text'] = os.date('%c'),},
        ['description'] = "",
        ['author'] = {
            ['name'] = Config.BotName,
            ['icon_url'] = Config.BotLogo,
        },
    }
}

function CloseBlackmarketMenu()
    exports['qb-menu']:closeMenu()
    exports['qb-core']:HideText()
end

function getClosestBlackMarket()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
    local distance = #(playerCoords - Config.BlackmarketZones[1].coords)
    local closest = 1
    for i = 1, #Config.BlackmarketZones do
        local BLMarket = Config.BlackmarketZones[i]
        local dist = #(playerCoords - BLMarket.coords)
        if dist < distance then
            distance = dist
            closest = i
        end
    end
    return closest
end

function createBlip(options)
    if not options.coords or type(options.coords) ~= 'table' and type(options.coords) ~= 'vector3' then return error(('createBlip() expected coords in a vector3 or table but received %s'):format(options.coords)) end
    local blip = AddBlipForCoord(options.coords.x, options.coords.y, options.coords.z)
    SetBlipSprite(blip, options.sprite or 1)
    SetBlipDisplay(blip, options.display or 4)
    SetBlipScale(blip, options.scale or 1.0)
    SetBlipColour(blip, options.colour or 1)
    SetBlipAsShortRange(blip, options.shortRange or false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(options.title or 'No Title Given')
    EndTextCommandSetBlipName(blip)
    return blip
end

function Notify(title, message, type, src)
	if Config.Notify == "okok" then
		if not src then	exports['okokNotify']:Alert(title, message, 6000, type or 'info')
		else TriggerClientEvent('okokNotify:Alert', src, title, message, 6000, type or 'info') end
	elseif Config.Notify == "qb" then
		if not src then	TriggerEvent("QBCore:Notify", message, type)
		else TriggerClientEvent("QBCore:Notify", src, message, type) end
	elseif Config.Notify == "mythic_notify" then
		if not src then	exports['mythic_notify']:SendAlert(type or 'inform', message, 2500, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
		else TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = type, text = message, length = 6000 }) end
	elseif Config.Notify == "t" then
		if not src then exports['t-notify']:Custom({title = title, style = type, message = message, sound = true})
		else TriggerClientEvent('t-notify:client:Custom', src, { style = type, duration = 6000, title = title, message = message, sound = true}) end
	elseif Config.Notify == "infinity" then
		if not src then TriggerEvent('infinity-notify:sendNotify', message, type)
		else TriggerClientEvent('infinity-notify:sendNotify', src, message, type) end
	elseif Config.Notify == "rr" then
		if not src then exports.rr_uilib:Notify({msg = message, type = type, style = "dark", duration = 6000, position = "top-right", })
		else TriggerClientEvent("rr_uilib:Notify", src, {msg = message, type = type, style = "dark", duration = 6000, position = "top-right", }) end
	end
end