local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}



RegisterNUICallback('CloseMenu:NuiCallback', function(data)
    OpenUi = false
    SetNuiFocus(false, false)
end)

dutyui = function (data)
local actions = 'showui'

    local job = data.jobname

    if job == 'police' then
        actions = 'showui'
    else
        actions = 'showems'
    end

    QBCore.Functions.TriggerCallback('src-duty:officercount', function(cb)
 local officerpolice = cb.police
 local officerambulance = cb.ambulance

    PlayerData = QBCore.Functions.GetPlayerData()
        SetNuiFocus(true, true)
   
   
        SendNUIMessage({
            action = actions,
            fullname =   PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname,
            ambulance = officerambulance,
            police = officerpolice

        })
  
    end)
    end


    RegisterNUICallback('src-duty:dutyoffclient', function()
        local job = PlayerJob.name
        

      TriggerServerEvent('src-duty:dutyoffserver',job) 
        
    end)

    RegisterNUICallback('src-duty:dutyonclient', function()
        local job = PlayerJob.name
        

      TriggerServerEvent('src-duty:dutyserver', job) 
        
    end)

         

    RegisterNUICallback('src:wash:client:cashout', function (data)
    local blackmoney = data.money

      if blackmoney  ~= nil then
      TriggerServerEvent('src-wash:server:payment',data)

      end

    end)



Citizen.CreateThread(function()
    local job = nil
    local sleep
    while true do
        sleep = 2000
        
        pcord = GetEntityCoords(PlayerPedId())
        for i, v in ipairs(Shared.Duty.Locations) do
            dst = GetDistanceBetweenCoords(pcord, v.coord)
            if dst < 3 then
                job = v.jobname
            end
            if dst < 3 and PlayerJob.name == job then
                sleep = 5
                ShowFloatingHelpNotificationsc(v.keymsg, v.coord, v.keymsg)
                if IsControlJustReleased(1, 51) and dst < 1 then
                    dutyui(v)
                    OpenUi = true
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)


function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 350
    scale = scale * fov
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(20, 126, 117, 122)
        BeginTextCommandDisplayText("STRING")
        SetTextCentre(true)
        AddTextComponentSubstringPlayerName(text)
        ClearDrawOrigin()
        DrawText(_x, _y)
    end
end

function ShowFloatingHelpNotificationsc(msg, coords, name)
    AddTextEntry('FloatingHelpNotificationsc' .. name, msg)
    SetFloatingHelpTextWorldPosition(1, coords + vector3(0, 0, 0.3))
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('FloatingHelpNotificationsc' .. name)
    EndTextCommandDisplayHelp(2, 0, 0, -1)
end







RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)


AddEventHandler("onResourceStart", function(JobInfo)
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)