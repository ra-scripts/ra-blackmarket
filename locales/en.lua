local Translations = {
	-- general info
	-- client
		["closed"] = "Closed!",
		["bclosed"] = "Blackmarket closed now check back later",
	-- client menu	
		["headermenu"] = '%{label}', -- dont change this 
		["buyMenu"] = 'Buy items',
		["buyTxt"] = 'Buy Items and weapons',
		["sellMenu"] = 'Sell items',
		["sellTxt"] = 'Sell Items and weapons',
		["closemenu"] = 'Close Menu',
		["openblackmarket"] = '[E] - open %{label}',
		["headermenubuy"] = 'Buy From: %{Name}',
		["returnmenu"] = 'Return',
		["howmuchbuy"] = 'Quantity you want to Buy',
		["confirm"] = 'Confirm',
		["MaxAmount"] = 'Max Amount Exceed',
		["quantity"] = 'quantity',
		["howmuchsell"] = 'Quantity you want to sell',
		["headermenusell"] = 'Sell to: %{Name}',
		["HasNotItem"] = 'You dont Own this item',
	--server
		["buywithmbills"] = 'You Bought : %{yItem} Amount : %{Amount} and paid $%{xMoney} MarkedBills',
		["buywithcash"] = 'You Bought %{xItem} Amount : %{Amount} from the blackmarket and paid with Cash : $%{Money}',
		["buywithbank"] = 'You Bought %{xItem} Amount : %{Amount} from the blackmarket and paid with bank: $%{Money}',
		["sellwithbills"] = 'You sell : %{yItem} Amount : %{Amount} and got paid $%{xMoney} with MarkedBills',
		["notenoughmarked"] = 'Not enough markedbills',
		["notWorth"] = 'markedbills not worth it',
		["buywithmbillsded"] = 'Amount deducted from markedbills $%{xMoney} For Buying : %{yItem} Amount : %{Amount}',
		["NotEnoughtMoney"] = 'you dont have enought money',
		["sold"] = 'You Sold %{Item} to blackmarket for : $%{Cash}',
		["errorAmount"] = 'you dont have this amount',
	-- discord logs
		["disbuylog"] = 'Player : **%{playername}** \n CitizenID : **%{cid}** \n purchased **%{itemname}** \n Amount **%{amount}** \n and paid : **%{prices}** \n paid with **%{types}** \n from the blackmarket number **%{shopid}**', -- this is for discord log,
		["disselllog"] = 'Player : **%{playername}** \n CitizenID : **%{cid}** \n just sell **%{itemname}** \n Amount **%{itemamount}** \n and got paid : **%{prices}** \n from the blackmarket number **%{shopid}**', -- this is for discord log
}
return Translations