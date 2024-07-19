Config = {}
Config.lang = 'en'
Config.Debug = true -- enable debug
Config.UpdateCheck = true -- enable version check 
Config.target = false -- enable target eye, if false we use polyzone
Config.TargetResource = "qb" -- support qb for qb-target / ox for ox_target only
Config.inventory = "qb" -- qb for qb-inventory/ ox for ox_inventory
Config.menu = "qb" -- qb for qb-menu/ ox for ox_lib Context Menu
Config.menuscriptname = 'qb-menu' -- what is you menu script name this for qb-menu in case u changed it 
Config.img = "nui://qb-inventory/html/images/" -- Set this to your inventory images if qb use nui://qb-inventory/html/images/ || if ox nui://ox_inventory/web/images/
Config.Notify = "qb" -- qb / ox / okokNotify / t / infinity / rr / mythic_notify
Config.DrawTexts = "qb" -- qb / ox 

--// discord weboohks START\\----
Config.WebHook = "" -- your discord webhook here 
Config.Buying = "Blackmarket Buys" -- title for buying 
Config.Selling = "Blackmarket Sells" -- title for selling
Config.BuyingColor = "697900" -- Green
Config.SellingColor = "16711680" -- red
Config.BotName = "My Custom server" -- bot name 
Config.BotLogo = "https://dunb17ur4ymx4.cloudfront.net/webstore/logos/ec05c809016751d0949acdad93b73441f6d7e4ea.jpg" -- bot logo
--// discord weboohks END\\----

--// Blackmarket Locations START\\----
Config.BlackmarketZones = {
	{
		PedModel = "ig_g", --https://wiki.rage.mp/index.php?title=Peds
		coords = vector4(781.33, 1274.69, 360.28, 275.86),  -- location of the ped
		Distance = 1.5, -- distance for target
		DebugPoly = false, -- for polyzone
		length = 4.5, -- for polyzone
		width = 3.5, -- for polyzone
		ShowBlip = true, -- true to show blips on maps , false disable blips
		blipSpirit= 150, -- https://docs.fivem.net/docs/game-references/blips/
		blipColor = 1,  -- https://docs.fivem.net/docs/game-references/blips/
		blipScal = 0.6, 
		label = "Blackmarket", -- blip label
		enableBuy = true, -- enable / disable buy items from blackmarket
		buyPayment = "money", -- ONLY THIS VALUES [money, bank, markedbills, black_money] money (will use cash [qb] / money [esx] ) , bank for both esx/qbcore , markedbills (for qb only), black_money for ESX only 
		-- this for buying items from blackmarket
		enableSell = true, -- enable / disable sell items to blackmarket
		sellPayment = "money", -- ONLY THIS VALUES [money, bank, markedbills, black_money] money (will use cash [qb] / money [esx] ) , bank for both esx/qbcore , markedbills (for qb only), black_money for ESX only
		-- this for selling items to blackmarket
		MarkedBillItemName = "markedbills", -- this only for qbcore the markedbills item name in qb-core/shared/items.lua
		FixedMarkedBills = false, -- FOR QBCORE ONLY in case your markedbills has fixed amount like 1$ for example if lockpick cost 100 then you need to have 100 markedbills, if false will use markedbills info worth
		UseTime = false, -- True will use in-game Time , False always open
		TimeOpen = 23, -- if use time is Flase no need to edit this if its TRUE so this is time open for blackmarket
		TimeClose = 24,  --- time for close blackmarket 24 mean 00:00 midnight [ formatted 1 = AM , 2 = AM .... 13 = PM, 14 = PM ... 23 = PM , 24 = 00:00 ]
		ItemstoBuy = { -- list all items players can buy it from the blackmarket please make sure to add the items in qb-core/shared/items.lua , if ESX add to database , if ox_inventory add to data/items.lua
			{name = "lockpick", price = 100, MaxAmount = 50},
			{name = "advancedlockpick", price = 1000, MaxAmount = 20},
			{name = "electronickit", price = 2500, MaxAmount = 15},
			{name = "gatecrack", price = 2500, MaxAmount = 10},
			{name = "thermite", price = 1500, MaxAmount = 10},
			{name = "trojan_usb", price = 3000, MaxAmount = 10},
			{name = "screwdriverset", price = 500, MaxAmount = 10},
			{name = "drill", price = 3000, MaxAmount = 10},
			--{name = "armor", price = 2500, MaxAmount = 10},
			--{name = "radio", price = 3000, MaxAmount = 10},
			-- add more here 
		},
		ItemstoSell = { -- list all items players can sell it to the blackmarket 
			{name = "rolex", price = 1500, MaxAmount = 20},
			{name = "diamond_ring", price = 1500, MaxAmount = 10},
			{name = "diamond", price = 1500, MaxAmount = 10},
			{name = "goldchain", price = 3000, MaxAmount = 10},
			{name = "tenkgoldchain", price = 3000, MaxAmount = 10},
			{name = "goldbar", price = 3000, MaxAmount = 10},
			-- add more here 
		},
	},
	--[[
		add more blackmarket zones
	]]--
}

--// Blackmarket Locations END\\----