ESX = nil
while not ESX do TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end) end

notify = function(source, type, msg, duration, title)
	if type ~= nil and msg ~= nil then
		if Config.Notification.server == "ns" then
			if type == 1 then
				TriggerClientEvent("nightstudio_notify:sendNotify", source, title, msg, duration, "success")
			elseif type == 2 then
				TriggerClientEvent("nightstudio_notify:sendNotify", source, title, msg, duration, "info")
			elseif type == 3 then
				TriggerClientEvent("nightstudio_notify:sendNotify", source, title, msg, duration, "error")
			elseif type == 4 then
				TriggerClientEvent("nightstudio_notify:sendNotify", source, title, msg, duration, "warning")
			end
		elseif Config.Notification.server == "mythic_old" then
			if type == 1 then
				TriggerClientEvent("mythic_notify:client:SendAlert:custom", source, {
					type = "success",
					text = msg,
					length = 10000,
				})
			elseif type == 2 then
				TriggerClientEvent("mythic_notify:client:SendAlert:custom", source, {
					type = "inform",
					text = msg,
					length = 10000,
				})
			elseif type == 3 or 4 then
				TriggerClientEvent("mythic_notify:client:SendAlert:custom", source, {
					type = "error",
					text = msg,
					length = 10000,
				})
			end
		elseif Config.Notification.server == "mythic_new" then
			if type == 1 then
				TriggerClientEvent("mythic_notify:client:SendAlert", source, {
					type = "success",
					text = msg,
					style = {
						["background-color"] = "#ffffff",
						["color"] = "#000000",
					},
				})
			elseif type == 2 then
				TriggerClientEvent("mythic_notify:client:SendAlert", source, {
					type = "inform",
					text = msg,
					style = {
						["background-color"] = "#ffffff",
						["color"] = "#000000",
					},
				})
			elseif type == 3 or 4 then
				TriggerClientEvent("mythic_notify:client:SendAlert", source, {
					type = "error",
					text = msg,
					style = {
						["background-color"] = "#ffffff",
						["color"] = "#000000",
					},
				})
			end
		elseif Config.Notification.server == "esx" then
			TriggerClientEvent("esx:showNotification", source, msg)
		elseif Config.Notification.server == "chat" then
			TriggerClientEvent("chat:addMessage", source, {
				color = {255, 0, 0},
				multiline = true,
				args = {"Me", msg},
			})
		elseif Config.Notification.server == "custom" then
			-- Insert Custom Notification here
		end
	end
end

function CheckSize(source, drug, size, count)
		local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	local tsize = nil
 if Config.Items[drug].large and next(Config.Items[drug].large) then
  for k, v in pairs(Config.Items[drug].large) do
   if k ~= 'final' then
    if xPlayer.getInventoryItem(k).count == 0 then
     tsize = 'small'
     goto itstiny
    else
     tsize = 'large'
    end
   end
  end
 else
  tsize = 'small'
 end

	::itstiny::
	if tsize == 'large' and count < size then
		tsize = 'small'
		return tsize
	elseif tsize == 'large' and count > size then
		return tsize
	elseif tsize == 'small' then
		return tsize
	else
		notify(_source, 3, _U('size_error'), 'SIZE CHECK ERROR', 5000)
	end
end

RegisterServerEvent('BLdrugitems:makesmall')
AddEventHandler('BLdrugitems:makesmall', function(source, drug)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	local MItems = {}
	local missing, fproduct, fcount = false, nil, nil

	for k, v in pairs(Config.Items[drug].small) do
		local minimum = v.count
		local havethis = xPlayer.getInventoryItem(k).count
		if k ~= 'final' and havethis < minimum then
			missing = true
			table.insert(MItems, k)
		end
	end

	if missing then
		for z = 1, #MItems do
			notify(_source, 3, _U('missing_items', MItems[z]), 'Not Enough Resources', 5000)
			Wait(1)
		end
	else
		for k, v in pairs(Config.Items[drug].small) do
			if k ~= 'final' and not v.keep then
				xPlayer.removeInventoryItem(k, v.count)
				Wait(1)
			elseif k == 'final' then
				fproduct = v.name
				fcount = v.count
			end
		end
		xPlayer.removeInventoryItem(drug, 1)
		xPlayer.addInventoryItem(fproduct, fcount)
	end

end)

RegisterServerEvent('BLdrugitems:makelarge')
AddEventHandler('BLdrugitems:makelarge', function(source, drug)
	local xPlayer = ESX.GetPlayerFromId(source)
	local famount, fproduct, fcount = nil, nil, nil

	for k, v in pairs(Config.ItemNames) do if v.name == drug then famount = v.Lsize end end

	for k, v in pairs(Config.Items[drug].large) do
		if k ~= 'final' and not v.keep then
			xPlayer.removeInventoryItem(k, v.count)
			Wait(1)
		elseif k == 'final' then
			fproduct = v.name
			fcount = v.count
		end
	end
	xPlayer.removeInventoryItem(drug, famount)
	xPlayer.addInventoryItem(fproduct, fcount)

end)

AddEventHandler('onResourceStart', function(resourceName) if (GetCurrentResourceName() == resourceName) then RegisterItems() end end)

function RegisterItems()
	for i = 1, #Config.ItemNames do
		ESX.RegisterUsableItem(Config.ItemNames[i].name, function(source)
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(source)
			local drug = xPlayer.getInventoryItem(Config.ItemNames[i].name).count
			local size = CheckSize(_source, Config.ItemNames[i].name, Config.ItemNames[i].Lsize, drug)

			if size == 'small' then
				TriggerEvent('BLdrugitems:makesmall', _source, Config.ItemNames[i].name)
			elseif size == 'large' then
				TriggerEvent('BLdrugitems:makelarge', _source, Config.ItemNames[i].name)
			else
				notify(_source, 3, _U('making_error'), 'Creation Error', 5000)
			end

		end)
	end
end
