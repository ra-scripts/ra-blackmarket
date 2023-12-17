Config = {}

Config.UpdateCheck = true -- enable version check 
Config.target = true -- enable target eye
Config.TargetResource = "qb-target" -- support qb-target / ox_target only 
Config.img = "qb-inventory/html/images/" -- Set this to your inventory images
Config.Notify = "t" -- qb / okokNotify / t / infinity / rr / mythic_notify

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
	[1] = {
		PedModel = "mp_f_weed_01", --https://wiki.rage.mp/index.php?title=Peds
		coords = vector3(186.72, 307.01, 104.39),  -- location of the ped / market shop
		heading = 183.14, -- heading 
		length = 2, 
		width = 2, 
		Distance = 1.5,
		DebugPoly = false, 
		ShowBlip = false, -- true to show blips on maps , false disable blips
		blipSpirit= 150, -- https://docs.fivem.net/docs/game-references/blips/
		blipColor = 1,  -- https://docs.fivem.net/docs/game-references/blips/
		blipScal = 0.6, 
		label = "Blackmarket one",
		DrawLabelOverHead = false, -- show 3dtext over ped head 
		Distance3dText = 10, -- max distance to show 3dtext
		Payment = "markedbills", -- Choose between money / markedbills , if put money will check if it will take from cash or bank automaticly
		MarkedBillItemName = "markedbills", -- the markedbills item name in qb-core/shared/items.lua
		FixedMarkedBills = false, -- in case your markedbills has fixed amount like 1$ for example if lockpick cost 100 then you need to have 100 markedbills, if false will use markedbills info worth
		SellWithMarkedbills = false, -- get paid with markedbills when selling items
		UseTime = true, -- True will use in-game Time , False always open
		TimeOpen = 23, -- if use time is Flase no need to edit this if its TRUE so this is time open for blackmarket
		TimeClose = 24,  --- time for close blackmarket 24 mean 00:00 midnight [ formatted 1 = AM , 2 = AM .... 13 = PM, 14 = PM ... 23 = PM , 24 = 00:00 ]
		ItemstoBuy = { -- list all items players can buy it from the blackmarket
			[1] = {name = "lockpick", price = 100, MaxAmount = 50},
			[2] = {name = "advancedlockpick", price = 1000, MaxAmount = 20},
			[3] = {name = "electronickit", price = 2500, MaxAmount = 15},
			[4] = {name = "gatecrack", price = 2500, MaxAmount = 10},
			[5] = {name = "thermite", price = 1500, MaxAmount = 10},
			[6] = {name = "trojan_usb", price = 3000, MaxAmount = 10},
			[7] = {name = "screwdriverset", price = 500, MaxAmount = 10},
			[8] = {name = "drill", price = 3000, MaxAmount = 10},
			--[9] = {name = "lighter", price = 3000,MaxAmount = 10},
			--[10] = {name = "weed_white-widow", price = 300,MaxAmount = 10},
			-- add more here 
		},
		ItemstoSell = { -- list all items players can sell it to the blackmarket 
			[1] = {name = "rolex", price = 1500, MaxAmount = 20},
			[2] = {name = "diamond_ring", price = 1500, MaxAmount = 10},
			[3] = {name = "goldchain", price = 3000, MaxAmount = 10},
			[4] = {name = "goldbar", price = 3000, MaxAmount = 10},
			--[5] = {name = "10kgoldchain", price = 5000, MaxAmount = 10},
			-- add more here 
		},
	},
	[2] = {
		PedModel = "MP_M_Weed_01", --https://wiki.rage.mp/index.php?title=Peds
		coords = vector3(195.28, 298.69, 104.6), --vector3(1293.44, -3301.59, 24.39),  -- location of the ped / market shop
		heading =  80.71, --163.9, -- heading 
		length = 2, 
		width = 2,
		Distance = 1.5,
		DebugPoly = false, 
		ShowBlip = false, -- true to show blips on maps , false disable blips
		blipSpirit= 150, -- https://docs.fivem.net/docs/game-references/blips/
		blipColor = 1,  -- https://docs.fivem.net/docs/game-references/blips/
		blipScal = 0.6, 
		label = "Blackmarket Two",
		DrawLabelOverHead = false, -- show 3dtext over ped head 
		Distance3dText = 10, -- max distance to show 3dtext
		Payment = "money", -- Choose between money / markedbills , if put money will check if it will take from cash or bank automaticly
		MarkedBillItemName = "markedbills", -- the markedbills item name in qb-core/shared/items.lua
		FixedMarkedBills = false, -- in case your markedbills has fixed amount like 1$ for example if lockpick cost 100 then you need to have 100 markedbills
		SellWithMarkedbills = false, -- get paid with markedbills when selling items
		UseTime = false, -- True will use in-game Time , False always open
		TimeOpen = 23, -- if use time is Flase no need to edit this if its TRUE so this is time open for blackmarket
		TimeClose = 24,  --- time for close blackmarket 24 mean 00:00 midnight [ formatted 1 = AM , 2 = AM .... 13 = PM, 14 = PM ... 23 = PM , 24 = 00:00 ]
		ItemstoBuy = { -- list all items players can buy it from the blackmarket
			[1] = {name = "weapon_pistol", price = 10000,MaxAmount = 5},
			[2] = {name = "weapon_combatpistol", price = 10000,MaxAmount = 5},
			[3] = {name = "weapon_appistol", price = 75000,MaxAmount = 5},
			[4] = {name = "weapon_pistol50", price = 1300000,MaxAmount = 5},
			[5] = {name = "weapon_revolver", price = 1100000,MaxAmount = 5},
			[6] = {name = "weapon_microsmg", price = 1500000,MaxAmount = 5},
			[7] = {name = "weapon_smg", price = 1700000,MaxAmount = 5},
			[8] = {name = "weapon_pumpshotgun", price = 1450000,MaxAmount = 5},
			[9] = {name = "weapon_assaultrifle", price = 2500000,MaxAmount = 5},
			[10] = {name = "weapon_carbinerifle", price = 2500000,MaxAmount = 5},
			[11] = {name = "pistol_ammo", price = 100,MaxAmount = 20},
			[12] = {name = "smg_ammo", price = 200,MaxAmount = 20},
			[13] = {name = "shotgun_ammo", price = 400,MaxAmount = 20},
			[14] = {name = "rifle_ammo", price = 500,MaxAmount = 20},
			-- add more here 
		},
		ItemstoSell = { -- list all items players can sell it to the blackmarket
			[1] = {name = "rolex", price = 1500,MaxAmount = 10},
			[2] = {name = "diamond_ring", price = 1500,MaxAmount = 10},
			[3] = {name = "goldchain", price = 3000,MaxAmount = 10},
			[4] = {name = "goldbar", price = 3000, MaxAmount = 10},
			--[5] = {name = "10kgoldchain", price = 5000, MaxAmount = 10},
			-- add more here 
		},
	},
}

--// Blackmarket Locations END\\----
