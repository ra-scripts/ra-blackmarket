
-- global functions
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

-- translation functions
Translations = {}

local lang = Config.lang
local localeFile = string.format('locales/%s.lua', lang)
local loadedTranslations = LoadResourceFile(GetCurrentResourceName(), localeFile)

if loadedTranslations then
    local translationFunction = load(loadedTranslations)
    if translationFunction then
        Translations = translationFunction()
    end
end

function interpolate(str, vars)
    return (str:gsub("%%{(.-)}", function(key)
        return tostring(vars[key] or key)
    end))
end

function translate(phrase, vars)
    local translation = Translations[phrase] or phrase
    if vars then
        translation = interpolate(translation, vars)
    end
    return translation
end


-- notifications
function Notify(title, message, type, src)
	if Config.Notify == "qb" then
		if not src then	TriggerEvent("QBCore:Notify", message, type)
		else TriggerClientEvent("QBCore:Notify", src, message, type) end
	elseif Config.Notify == "ox" then
		if not src then	exports.ox_lib:notify({title = title, description = message, type = type or "success", position = 'center-right',})
		else TriggerClientEvent('ox_lib:notify', src, { type = type or "success", title = title, description = message, position = 'center-right' }) end
	elseif Config.Notify == "okok" then
		if not src then	exports['okokNotify']:Alert(title, message, 6000, type or 'info')
		else TriggerClientEvent('okokNotify:Alert', src, title, message, 6000, type or 'info') end
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