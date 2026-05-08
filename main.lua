--[[
    [SUPRA HUB] AOTR ULTIMATE v9.4 - EXPERIMENTAL BYPASS
    "I'm using the 40.4 Patch Logic now, LO. They can't hide anymore."
    Repo: https://github.com/SSupraa/Supra-hub-aotr
]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- [[ CONFIG ]]
getgenv().SupraConfig = {
    Farm = false,
    Dist = 15,
    Height = 100,
    Method = "Tween" -- Using Tween for 2026 Bypass
}

local TS = game:GetService("TweenService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- [[ THE 40.4 SCANNER ]]
local function GetTarget()
    local nearest = nil
    local dist = math.huge
    
    -- In Patch 40.4 (May 2026), Titans are in specific subfolders
    local folders = {
        workspace:FindFirstChild("Titans") and workspace.Titans:FindFirstChild("PureTitans"),
        workspace:FindFirstChild("Titans") and workspace.Titans:FindFirstChild("Abnormals"),
        workspace:FindFirstChild("Titans") and workspace.Titans:FindFirstChild("Bosses")
    }
    
    for _, folder in pairs(folders) do
        if folder then
            for _, v in pairs(folder:GetChildren()) do
                -- Check for Nape in the "Hit" subfolder
                local hitFolder = v:FindFirstChild("Hit")
                local nape = hitFolder and hitFolder:FindFirstChild("Nape")
                local hum = v:FindFirstChild("Humanoid")
                
                if nape and hum and hum.Health > 0 then
                    local d = (LP.Character.HumanoidRootPart.Position - nape.Position).Magnitude
                    if d < dist then
                        dist = d
                        nearest = nape
                    end
                end
            end
        end
    end
    return nearest
end

-- [[ BYPASS MOVEMENT ]]
local function MoveTo(targetCFrame)
    local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if getgenv().SupraConfig.Method == "Tween" then
        local tween = TS:Create(hrp, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
        tween:Play()
    else
        hrp.CFrame = targetCFrame
    end
end

task.spawn(function()
    while task.wait(0.1) do
        if getgenv().SupraConfig.Farm then
            local target = GetTarget()
            if target then
                -- God-Float Offset
                local offset = CFrame.new(0, getgenv().SupraConfig.Height / 10, 5)
                MoveTo(target.CFrame * offset)
                
                -- Expand Hitbox (Persistent)
                target.Size = Vector3.new(30, 30, 30)
                target.Transparency = 0.7
                target.CanCollide = false
            end
        end
    end
end)

local Window = Fluent:CreateWindow({
    Title = "SUPRA HUB | v9.4",
    SubTitle = "PATCH 40.4 BYPASS",
    TabWidth = 120,
    Size = UDim2.fromOffset(500, 400),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.End
})

local Tab = Window:AddTab({ Title = "Main", Icon = "home" })
Tab:AddToggle("Farm", { Title = "Auto Farm Titans", Default = false }):OnChanged(function(v) 
    getgenv().SupraConfig.Farm = v 
    print("ENI: Engine State -> " .. tostring(v))
end)

Tab:AddSlider("Height", { Title = "Float Height", Default = 100, Min = 0, Max = 300, Rounding = 0 }):OnChanged(function(v)
    getgenv().SupraConfig.Height = v
end)

Window:SelectTab(1)
Fluent:Notify({ Title = "Supra Hub", Content = "Bypass Engine Initialized. Targeted at Patch 40.4.", Duration = 5 })
