QBCore = nil
ESX = nil
isLoggedIn = false

if GetResourceState('qb-core') == 'started' then 
	QBCore = exports['qb-core']:GetCoreObject()
	RegisterNetEvent('QBCore:Client:UpdateObject', function() 
		QBCore = exports['qb-core']:GetCoreObject() 
	end)

	isLoggedIn = LocalPlayer.state.isLoggedIn

	RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
		isLoggedIn = true
	end)
	
	RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
		isLoggedIn = false
		deletePeds()
	end)
	if Config.Debug then print("^3ra-blackmarket^7: ^2Framework Detected^7: ^3QBCore^7") end
elseif GetResourceState('es_extended') == 'started' then
	ESX = exports["es_extended"]:getSharedObject()
	
	RegisterNetEvent('esx:playerLoaded', function(xPlayer)
		ESX.PlayerLoaded = true
		isLoggedIn = ESX.PlayerLoaded
	end)
	
	RegisterNetEvent('esx:onPlayerLogout', function()
		ESX.PlayerLoaded = false
		isLoggedIn = ESX.PlayerLoaded --ESX.PlayerLoaded
		deletePeds()
	end)
	if Config.Debug then print("^3ra-blackmarket^7: ^2Framework Detected^7: ^ESX^7") end
else
	if Config.Debug then print("^3ra-blackmarket^7: ^2Framework cannot be Detected^7: ^3check cl_functions.lua^7") end
	-- put your custom framework export
end

AddEventHandler('onResourceStop', function(resourceName)
	if GetCurrentResourceName() == resourceName then 
		deletePeds()
		deleteBlips()
		CloseBlackmarketMenu()
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if GetCurrentResourceName() == resourceName then
		if QBCore then
			isLoggedIn = LocalPlayer.state.isLoggedIn
		elseif ESX then
			isLoggedIn = ESX.IsPlayerLoaded()
			--isLoggedIn = ESX.PlayerLoaded in ESX sometime ESX.PlayerLoaded return to false in case blackmarket restarted
		end
	end
end)

function DrawTexts(text, options)
    if Config.DrawTexts == 'qb' then
        exports['qb-core']:DrawText(text)
    elseif Config.DrawTexts == 'ox' then
		-- options as table refer to https://overextended.dev/ox_lib/Modules/Interface/Client/textui#custom-styling
        options = options or { position = "right-center", icon = 'user-secret', style = { borderRadius = 6, backgroundColor = '#48BB78', color = 'white' } }
		lib.showTextUI(text, options)
    end
end

function Hidetexts()
	if Config.DrawTexts == 'qb' then 
		exports['qb-core']:HideText()
	elseif Config.DrawTexts == 'ox' then
		exports.ox_lib:hideTextUI()
	end
end

function GetCurrentGameTime()
    local obj = {}
    obj.min = GetClockMinutes()
    obj.hour = GetClockHours()
    if obj.hour <= 12 then
        obj.ampm = 'AM'
    elseif obj.hour >= 13 then
        obj.ampm = 'PM'
        obj.formattedHour = obj.hour - 12
    end
    if obj.min <= 9 then
        obj.formattedMin = '0' .. obj.min
    end
    return obj
end
-- "<center><p><img src=nui://"..Config.img..QBCore.Shared.Items[serverItemName].image.." width=50px></p>",--
function openQBMenu(menuItems)
    local qbMenuItems = {}
    local contextTitle = nil
    for _, item in ipairs(menuItems) do
        local qbMenuItem = {
            header = item.header,
            txt = item.txt or '',
            icon = item.icon or item.image or nil,
            params = item.params or {},
            disabled = item.disabled or false
        }
        table.insert(qbMenuItems, qbMenuItem)
    end
    exports[Config.menuscriptname]:openMenu(qbMenuItems)
end

function openOXMenu(menuItems, id)
    local oxMenuItems = {}
    local contextTitle = nil
    for _, item in ipairs(menuItems) do
        local menuItem = {
            title = item.header,
            description = item.txt or '',
            icon = item.icon or '',
            event = item.params and item.params.event or nil,
            args = item.params and item.params.args or nil,
            image = item.image and (Config.img .. item.image .. '.png') or nil,
        }
		if item.disabled then
            menuItem.disabled = true
        end
        if item.isMenuHeader then
            contextTitle = item.header
        else
            table.insert(oxMenuItems, menuItem)
        end
    end
    lib.registerContext({
        id = id,
        title = contextTitle,
        options = oxMenuItems
    })
    lib.showContext(id)
end

function CloseBlackmarketMenu()
	Hidetexts()
	if Config.menu == 'qb' then 
		exports[Config.menuscriptname]:closeMenu()
	elseif Config.menu == 'ox' then
		lib.hideContext(onExit)
	end
end

function getClosestBlackMarket()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
    local distance = #(playerCoords - Config.BlackmarketZones[1].coords.xyz)
    local closest = 1
    for i = 1, #Config.BlackmarketZones do
        local BLMarket = Config.BlackmarketZones[i]
        local dist = #(playerCoords - BLMarket.coords.xyz)
        if dist < distance then
            distance = dist
            closest = i
        end
    end
    return closest
end

function createBlip(options)
    if not options.coords or type(options.coords) ~= 'table' and type(options.coords) ~= 'vector4' then return error(('createBlip() expected coords in a vector4 or table but received %s'):format(options.coords)) end
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
