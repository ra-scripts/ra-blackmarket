QBCore = nil
ESX = nil

if GetResourceState('qb-core') == 'started' then 
	QBCore = exports['qb-core']:GetCoreObject()
	if Config.Debug then 
		print("^3ra-blackmarket^7: ^2Framework Detected^7: ^3QBCore^7")
	end
elseif GetResourceState('es_extended') == 'started' then
	ESX = exports["es_extended"]:getSharedObject()
	if Config.Debug then print("^3ra-blackmarket^7: ^2Framework Detected^7: ^ESX^7") end
else
	if Config.Debug then print("^3ra-blackmarket^7: ^2Framework cannot be Detected^7: ^3check sv_functions.lua^7") end
	-- put your custom framework export
end

-- framework functions
function getPlayer(src)
	if QBCore then
		return QBCore.Functions.GetPlayer(src)
	elseif ESX then
		return ESX.GetPlayerFromId(src)
	else
		if Config.Debug then print("^3ra-blackmarket^7: ^2error in getPlayer() sv_function.lua^7: ^3check sv_functions.lua^7") end
		-- return your current framework
	end
end

function GetPlayerCitizenID(src)
	local Player = getPlayer(src)
	local cid = nil
	if QBCore then
		cid = Player.PlayerData.citizenid
	elseif ESX then
		cid = Player.identifier
	else
		if Config.Debug then print("^3ra-blackmarket^7: ^2error in GetPlayerCitizenID() sv_function.lua^7: ^3check sv_functions.lua^7") end
		-- cid = the player identifer of your current framework
	end
	return cid
end

function GetPlyName(src)
	local Player = getPlayer(src)
	local name = nil
	if QBCore then
		name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname or GetPlayerName(src)
	elseif ESX then
		name = Player.get('firstName') .. ' ' .. Player.get('lastName') or Player.getName() or GetPlayerName(src)
	else
		if Config.Debug then print("^3ra-blackmarket^7: ^2error in GetPlyName() sv_function.lua^7: ^3check sv_functions.lua^7") end
		-- name = ?
	end
	return name
end

function GetPlayerMoney(src)
	local Player = getPlayer(src)
	local cash = nil
	local bank = nil
	local blackmoney = nil
	if QBCore then
		cash = Player.PlayerData.money.cash
		bank = Player.PlayerData.money.bank
	elseif ESX then
		cash = Player.getAccount('money').money
		bank = Player.getAccount('bank').money
		blackmoney = Player.getAccount('black_money').money
	else
		if Config.Debug then print("^3ra-blackmarket^7: ^2error in GetPlayerMoney() sv_function.lua^7: ^3check sv_functions.lua^7") end
		-- cash = the player identifer of your current framework
		-- bank
	end
	return cash, bank, blackmoney
end

function AddMoney(src, type, amount, reason)
	local Player = getPlayer(src)
	if QBCore then
		if type == 'money' then
			Player.Functions.AddMoney('cash', amount, reason)
		elseif type == 'bank' then
			Player.Functions.AddMoney('bank', amount, reason)
		end
	elseif ESX then
		if type == 'money' then
			Player.addAccountMoney('money', amount, reason)
		elseif type == 'bank' then
			Player.addAccountMoney('bank', amount, reason)
		elseif type == 'black_money' then
			Player.addAccountMoney('black_money', amount, reason)
		end	
	else
		if Config.Debug then print("^3ra-blackmarket^7: ^2error in RemoveMoney() sv_function.lua^7: ^3check sv_functions.lua^7") end
	end
end

function RemoveMoney(src, amount, reason)
	local Player = getPlayer(src)
	if QBCore then
		Player.Functions.RemoveMoney('cash', amount, reason)
	elseif ESX then
		Player.removeAccountMoney('money', amount, reason)
	else
		if Config.Debug then print("^3ra-blackmarket^7: ^2error in RemoveMoney() sv_function.lua^7: ^3check sv_functions.lua^7") end
	end
end

function RemoveBank(src, amount, reason)
	local Player = getPlayer(src)
	if QBCore then
		Player.Functions.RemoveMoney('bank', amount, reason)
	elseif ESX then
		Player.removeAccountMoney('bank', amount, reason)
	else
		if Config.Debug then print("^3ra-blackmarket^7: ^2error in RemoveBank() sv_function.lua^7: ^3check sv_functions.lua^7") end
	end
end

function RemoveBlack(src, amount, reason)
	local Player = getPlayer(src)
	if ESX then 
		Player.removeAccountMoney('black_money', amount, reason)
	end
end

function CheckPlayerItem(src, itemName, amount)
	local Player = getPlayer(src)
    if Config.inventory == "qb" then
        local item = Player.Functions.GetItemByName(itemName)
        if item and item.amount >= amount then
            return true
        end
    elseif Config.inventory == "ox" then
        local items = exports.ox_inventory:Search(src, 'count', itemName)
        if items >= amount then
            return true
        end
    end
    return false
end


function AddItem(src, item, amount, bool, info)
	local Player = getPlayer(src)
	if Config.inventory == "qb" then
		if info then 
			Player.Functions.AddItem(item, amount, false, info)
		else
			Player.Functions.AddItem(item, amount)
		end
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	elseif Config.inventory == "ox" then
		exports.ox_inventory:AddItem(src, item, amount)
	end
end

function RemoveItem(src, item, amount)
	local Player = getPlayer(src)
	if Config.inventory == "qb" then
		Player.Functions.RemoveItem(item, amount)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
	elseif Config.inventory == "ox" then
		exports.ox_inventory:RemoveItem(src, item, amount)
	end
end

function CheckItems()
	if Config.inventory == "qb" then
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
	elseif Config.inventory == "ox" then
		local Items = exports.ox_inventory:Items()
		for k, zone in pairs(Config.BlackmarketZones) do
			for _, itemData in pairs(zone.ItemstoBuy) do
				local itemName = itemData.name
				if not Items[itemName] then
					print(string.format("^5Debug^7: ^3Item^7 ^3'%s'^7: ^5In Config.BlackmarketZones["..k.."].ItemstoBuy ^7^2does not exist in Ox Inventory!^7 ", itemName))
				end
			end
			for _, itemData in pairs(zone.ItemstoSell) do
				local itemName = itemData.name
				if not Items[itemName] then
					print(string.format("^5Debug^7: ^3Item^7 ^3'%s'^7: ^5In Config.BlackmarketZones["..k.."].ItemstoSell ^7^2does not exist in Ox Inventory!^7 ", itemName))
				end
			end
		end
	end
end

function PrintConfig()
	if Config.target then
		print("^3Target Enabled^7: " .. tostring(Config.target))
		print("^3Target Resource^7: " .. Config.TargetResource)
	end
    print("^3Inventory^7: " .. Config.inventory)
    print("^3Menu^7: " .. Config.menu)
    print("^3Image Path^7: " .. Config.img)
    print("^3Notify Method^7: " .. Config.Notify)
    print("^3Draw Texts^7: " .. Config.DrawTexts)
	if Config.WebHook == "" then
		print("^2WebHook is Missing!^7 ^3Please Add WebHook^7 ")
	end
end

AddEventHandler('onResourceStart', function(resource)
	if GetCurrentResourceName() == resource then
		CheckItems()
		if Config.Debug then 
			PrintConfig()
		end
	end
end)