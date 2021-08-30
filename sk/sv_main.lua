ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('karpo_konttiryosto:ronklattupaskaks')
AddEventHandler('karpo_konttiryosto:ronklattupaskaks', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemi = math.random(1,#Config.itemit)
	local ase = math.random(1,#Config.aseet)
	local kuinmont = math.random(1,5)
	local matikkapaakahdeksankeskiarvo = math.random(1,100)
	xPlayer.addInventoryItem(Config.itemit[itemi], kuinmont)


	if matikkapaakahdeksankeskiarvo < 50 then --50/50 että saako lisää itemeit
		local itemi = math.random(1,#Config.itemit)
		xPlayer.addInventoryItem(Config.itemit[itemi], kuinmont)
	end

	if Config.aseita then
		if matikkapaakahdeksankeskiarvo < 5 then --5% chance saada ase
			xPlayer.addWeapon(Config.aseet[ase], 42)
		end
	end


	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('karpo_konttiryosto:onnistu', xPlayers[i], pos)
		end
	end

end)


ESX.RegisterServerCallback('karpo_konttiryosto:boliseja',function(source, cb)
    local bolis = 0
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
      local _source = xPlayers[i]
      local xPlayer = ESX.GetPlayerFromId(_source)
      if xPlayer.job.name == 'police' then
        bolis = bolis + 1
      end
    end
    cb(bolis)
end)




RegisterServerEvent('karpo_konttiryosto:poliisi')
AddEventHandler('karpo_konttiryosto:poliisi', function(pos)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('karpo_konttiryosto:blipclient', xPlayers[i], pos)
		end
	end
end)


RegisterServerEvent('karpo_konttiryosto:keskeytetty')
AddEventHandler('karpo_konttiryosto:keskeytetty', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('karpo_konttiryosto:keskeytetty', xPlayers[i])
		end
	end
end)

