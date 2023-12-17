local QBCore = exports['qb-core']:GetCoreObject()
local webHook = Config.WebHook

local function CheckItems()
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

local function deepCopy(orig)
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

local embedData = {
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

-- callback to check all items of the Player
QBCore.Functions.CreateCallback('ra-blackmarket:serve:CheckInventory', function(source, cb)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local items = Player.PlayerData.items
	cb(items)
end)

local function getWorthMarkedBillSlot(itemName, amountToTake)
	local Player = QBCore.Functions.GetPlayer(source)
	local playerItems = Player.PlayerData.items
	local HasTheItem = Player.Functions.GetItemByName(itemName)
	local highestWorth = 0
	local highestWorthSlot = nil
	if HasTheItem then
		for _, v in pairs(playerItems) do
			if itemName == v.name then
				if v.info and v.info.worth then
					if v.info.worth >= amountToTake and v.info.worth > highestWorth then
						highestWorth = v.info.worth
						highestWorthSlot = v.slot
					end
				end
			end
		end
		return true, highestWorthSlot, highestWorth
	else
		return false, highestWorthSlot, highestWorth
	end
end

RegisterNetEvent('ra-blackmarket:server:buyitems', function(shopid, item, totalRequest, maxAmount, price)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local cid = Player.PlayerData.citizenid
	local cash = Player.PlayerData.money.cash
	local bank = Player.PlayerData.money.bank
	local playername = Player.PlayerData.charinfo.firstname
	local CurrentBMarket = Config.BlackmarketZones[shopid]
	local amountToTake = totalRequest * price
	local HasItem, Slot, Worth = getWorthMarkedBillSlot(CurrentBMarket.MarkedBillItemName, amountToTake)
	local typePayment = CurrentBMarket.Payment
	local webhookData = deepCopy(embedData)
	webhookData[1]['title'] = Config.Buying
	webhookData[1]['color'] = Config.BuyingColor
	webhookData[1]['description'] = Lang:t("info.message2", {playername = playername, cid = cid, itemname = item, amount = totalRequest, prices = tonumber(amountToTake), types = typePayment, shopid = shopid})
	if typePayment == "markedbills" then
		if HasItem then -- check if the player has markedbills or not
			if CurrentBMarket.FixedMarkedBills then
				 if HasItem.amount >= amountToTake then
					Player.Functions.RemoveItem(CurrentBMarket.MarkedBillItemName, amountToTake)
					Player.Functions.AddItem(item, totalRequest)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
					Notify(Config.Buying, Lang:t("info.buy4",{yItem = item, Amount = totalRequest, xMoney = amountToTake}), 'success', src)
					PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = Config.BotName, embeds = webhookData}), { ['Content-Type'] = 'application/json' })
                else
					Notify(Config.Buying, Lang:t("info.notenoughmarked"), 'error', src)
                end
			else
				if Slot == nil then
					Notify(Config.Buying, Lang:t("info.notWorth"), 'error', src)
				else
					local info = {
							worth = Worth - amountToTake
						}
					Player.Functions.RemoveItem(CurrentBMarket.MarkedBillItemName, 1)
					Player.Functions.AddItem(item, totalRequest)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
					Notify(Config.Buying, Lang:t("info.buy3",{yItem = item, Amount = totalRequest, xMoney = amountToTake}), 'success', src)
					Player.Functions.AddItem(CurrentBMarket.MarkedBillItemName, 1, false, info)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[CurrentBMarket.MarkedBillItemName], "add")
					PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = Config.BotName, embeds = webhookData}), { ['Content-Type'] = 'application/json' })
				end
			end
		else
			Notify(Config.Buying, Lang:t("info.nobills"), 'error', src)
		end
	else
		if cash >= amountToTake then
			Player.Functions.RemoveMoney('cash', amountToTake, "buy-blackmarket")
			Player.Functions.AddItem(item, totalRequest)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
			Notify(Config.Buying, Lang:t("info.buy2",{xItem = item, Amount = totalRequest ,Money = amountToTake}), 'success', src)
			PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = Config.BotName, embeds = webhookData}), { ['Content-Type'] = 'application/json' })
		elseif bank >= amountToTake then
			Player.Functions.RemoveMoney('bank', amountToTake, "buy-blackmarket")
			Player.Functions.AddItem(item, totalRequest)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
			Notify(Config.Buying, Lang:t("info.buy",{xItem = item, Amount = totalRequest, Money = amountToTake}), 'success', src)
			PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = Config.BotName, embeds = webhookData}), { ['Content-Type'] = 'application/json' })
		else
			Notify(Config.Buying, Lang:t('info.NotEnoughtMoney'), 'error', src)
		end
	end
end)

RegisterNetEvent('ra-blackmarket:server:sellitems', function(totalRequest, shopid, item, price)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local playername = Player.PlayerData.charinfo.firstname
	local cid = Player.PlayerData.citizenid
	local CurrentBMarket = Config.BlackmarketZones[shopid]
	local typePayment = CurrentBMarket.Payment
	local SellWithBills = CurrentBMarket.SellWithMarkedbills
	local hasItem = Player.Functions.GetItemByName(item)
	if hasItem and totalRequest <= hasItem.amount then
	local cashtoadd = totalRequest * price
	local webhookData = deepCopy(embedData)
	webhookData[1]['title'] = Config.Selling
	webhookData[1]['color'] = Config.SellingColor
		if SellWithBills then
			webhookData[1]['description'] = Lang:t("info.message3", {playername = playername, cid = cid, itemname = item, itemamount = totalRequest, prices = tonumber(cashtoadd), shopid = shopid})
			if CurrentBMarket.FixedMarkedBills then
				Player.Functions.RemoveItem(item, totalRequest)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
				Player.Functions.AddItem(CurrentBMarket.MarkedBillItemName, cashtoadd)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[CurrentBMarket.MarkedBillItemName], "add")
				Notify(Config.Selling, Lang:t("info.sell4",{yItem = item, Amount = totalRequest, xMoney = cashtoadd}), 'success', src)
				PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = Config.BotName, embeds = webhookData}), { ['Content-Type'] = 'application/json' })
			else
				Player.Functions.RemoveItem(item, totalRequest)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
				local info = {
					worth = cashtoadd
				}
				Player.Functions.AddItem(CurrentBMarket.MarkedBillItemName, 1, false, info)
        		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[CurrentBMarket.MarkedBillItemName], 'add')
				Notify(Config.Selling, Lang:t("info.sell3",{yItem = item, Amount = totalRequest, xMoney = cashtoadd}), 'success', src)
				PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = Config.BotName, embeds = webhookData}), { ['Content-Type'] = 'application/json' })
			end
		else		
		webhookData[1]['description'] = Lang:t("info.message3", {playername = playername, cid = cid, itemname = item, itemamount = totalRequest, prices = tonumber(cashtoadd), shopid = shopid})
		Player.Functions.RemoveItem(item, totalRequest)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
		Player.Functions.AddMoney('cash', cashtoadd)
		PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = Config.BotName, embeds = webhookData}), { ['Content-Type'] = 'application/json' })
		Notify(Config.Selling, Lang:t("info.sold",{theItem = item, Cash = cashtoadd}), 'success', src)
		end
	else
		Notify(Config.Selling, Lang:t("info.errorAmount"), 'error', src)
	end
end)

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
		CheckItems()
    end
end)
