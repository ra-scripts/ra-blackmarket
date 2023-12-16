local Translations = {
    info = {
		OpenMarket = '[E] - Open Blackmarket',
		errorAmount = 'you dont have this amount',
		MaxAmount = 'Max Amount Exceed',
		NotEnoughtMoney = 'you dont have any money',
		quantity = 'quantity',
		confirm = 'Confirm',
		howmuchbuy = 'Quantity you want to Buy',
		howmuchsell = 'Quantity you want to sell',
		closed = "Blackmarket closed now check back later",
		sold = 'You Sold %{theItem} to blackmarket for : $%{Cash}',
		buy = 'You Bought %{xItem} Amount : %{Amount} from the blackmarket and paid : $%{Money}',
		buy2 = 'You Bought %{xItem} Amount : %{Amount} from the blackmarket and paid with Cash : $%{Money}',
		buy3 = 'Amount deducted from markedbills $%{xMoney} For Buying : %{yItem} Amount : %{Amount}',
		buy4 = 'You Bought : %{yItem} Amount : %{Amount} and paid $%{xMoney} MarkedBills',
		nobills = 'I only accept markedbills!!',
		notWorth = 'markedbills not worth it',
		notenoughmarked = 'Not enough marked bills for the purchase',
		message2 = 'Player : **%{playername}** CitizenID : **%{cid}** purchased **%{itemname}** Amount **%{amount}** and paid : **%{prices}** paid with **%{types}** from the blackmarket number **%{shopid}**', -- this is for discord log,
		message3 = 'Player : **%{playername}** CitizenID : **%{cid}** just sell **%{itemname}** Amount **%{itemamount}** and got paid : **%{prices}**  from the blackmarket number **%{shopid}**', -- this is for discord log
		Cheat = 'Player : **%{playername}** CitizenID : **%{cid}** Trying to cheat in ra-blackmarket',
    },
    menu = {
        headermenu = '%{label}', -- dont change this 
		headermenubuy = 'Buy From: %{Name}',
		headermenusell = 'Sell to: %{Name}',
		name = 'Name',
		buy = 'Buy items',
		buyTxt = 'Buy Items and weapons',
		buytxt2 = "Name : %{item} - Price : %{price} - Max : %{Max}",
		selltxt = "Name : %{item} - Price : %{price}",
		sell = 'Sell items',
		sellTxt = 'Sell Items and weapons',
		returnmenu = 'Return',
        closemenu = 'Close Menu',
		HasNotItem = 'You dont Own this item',
    },

}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})