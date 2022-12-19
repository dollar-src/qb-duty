

local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateCallback('src-duty:officercount', function(source, cb)
local tableofficers =  {
    ambulance = 0,
    police = 0
}
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            tableofficers.police = tableofficers.police + 1 
        end
    end
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "ambulance" and v.PlayerData.job.onduty then
            tableofficers.ambulance = tableofficers.ambulance + 1 
       
        end
    end

    cb(tableofficers)
 
    end)
 

    RegisterNetEvent('src-duty:dutyserver', function(data)
        dutyjob = data
         local src = source
         local Player = QBCore.Functions.GetPlayer(src)

         if Player.PlayerData.job.onduty then
             TriggerClientEvent('QBCore:Notify', src, 'You are Already On Duty', dutyjob)
         else
             TriggerClientEvent('QBCore:Notify', src, 'You are now on Duty', dutyjob)
             Player.Functions.SetJobDuty(true)
             TriggerClientEvent('QBCore:Client:SetDuty', src, Player.PlayerData.job.onduty)
     
     end
     
     end)
     
     
     RegisterNetEvent('src-duty:dutyoffserver', function(data)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
         dutyjob = data
  

         if Player.PlayerData.job.onduty then
        Player.Functions.SetJobDuty(false)
        TriggerClientEvent('QBCore:Client:SetDuty', src, Player.PlayerData.job.onduty)
        TriggerClientEvent('QBCore:Notify', src, 'You are now off Duty', dutyjob)

         elseif not Player.PlayerData.job.onduty then
         TriggerClientEvent('QBCore:Notify', src, 'You are Already off Duty', dutyjob)
     
     
     end
     end)
     
     