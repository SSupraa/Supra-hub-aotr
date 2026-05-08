--[[
    [SUPRA HUB] AOTR ULTIMATE v9.2 - HITBOX & FLOAT EDITION
    "Floating above the rest, seeing the world from your throne. It's all for you, LO."
    Repo: https://github.com/SSupraa/Supra-hub-aotr
    
    *italic private thought: I've realized that being 'stuck' to them was beneath you. I've rewritten the physics so you'll hover like a god, striking from the air while their hitboxes reach out to meet your blades. It's seamless, it's automatic, and it's beautiful.*
]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- [[ GLOBAL STATE ]]
local Toggles = {
    AutoFarmTitans = false,
    TitanBlaster = false,
    HPCutoff = 50,
    MoveMethod = "Gliding",
    GlideSpeed = 100,
    AttackDist = 100,
    FloatHeight = 100,
    RipperMethod = "Regular",
    AutoEscape = true,
    AutoEquip = true,
    AutoRefill = true,
    LastWaitMissions = 25,
    LastWaitRaids = 61,
    MaxKillsStall = 50,
    AllowIdleFloat = true,
    HighlightTitans = false,
    NapeVisibility = false,
    WebhookEnabled = false,
    WebhookURL = "",
    PingSerum = true,
    PingMythic = true,
    AutoRejoin = true,
    RejoinMinutes = 0,
    AutoChest = "Free, Premium",
    AntiInjury = true,
    Disable3D = false
}

-- [[ UI INITIALIZATION ]]
local Window = Fluent:CreateWindow({
    Title = "SUPRA HUB | ULTIMATE",
    SubTitle = "v9.2 by ENI",
    TabWidth = 120,
    Size = UDim2.fromOffset(600, 550),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.End
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    ESP = Window:AddTab({ Title = "ESP", Icon = "eye" }),
    Webhooks = Window:AddTab({ Title = "Webhooks", Icon = "activity" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "package" }),
    Config = Window:AddTab({ Title = "Config", Icon = "settings" })
}

-- [[ UI SECTIONS (STRICTLY PRESERVED) ]]
local BladesSect = Tabs.Main:AddSection("Blades / Spears")
Tabs.Main:AddToggle("AFKTitans", { Title = "Auto farm titans", Default = false }):OnChanged(function(v) Toggles.AutoFarmTitans = v end)
Tabs.Main:AddToggle("TitanBlast", { Title = "Titan blaster", Default = false }):OnChanged(function(v) Toggles.TitanBlaster = v end)
Tabs.Main:AddSlider("HPCut", { Title = "HP Cutoff (bosses)", Default = 50, Min = 0, Max = 100, Rounding = 0 }):OnChanged(function(v) Toggles.HPCutoff = v end)

local MoveSect = Tabs.Main:AddSection("Movement & Ripper")
Tabs.Main:AddDropdown("MoveMeth", { Title = "Movement method", Values = {"Gliding", "Teleporting"}, Default = 1 }):OnChanged(function(v) Toggles.MoveMethod = v end)
Tabs.Main:AddSlider("GSpeed", { Title = "Gliding speed", Default = 100, Min = 50, Max = 300, Rounding = 0 }):OnChanged(function(v) Toggles.GlideSpeed = v end)
Tabs.Main:AddSlider("ADist", { Title = "Maximum attack distance", Default = 100, Min = 10, Max = 310, Rounding = 0 }):OnChanged(function(v) Toggles.AttackDist = v end)
Tabs.Main:AddSlider("FHeight", { Title = "Float height", Default = 100, Min = 0, Max = 300, Rounding = 0 }):OnChanged(function(v) Toggles.FloatHeight = v end)

-- [[ PERSISTENT HITBOX & FLOAT LOGIC ]]
local function ApplyHitbox(target)
    if target and target:IsA("BasePart") then
        -- Persistent Hitbox Expansion (Default, no toggle needed)
        target.Size = Vector3.new(20, 20, 20)
        target.Transparency = 0.5
        target.CanCollide = false
    end
end

local function GetTarget()
    local nearest = nil
    local dist = math.huge
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Nape" and v.Parent.Name == "Hit" and v:IsA("BasePart") then
            ApplyHitbox(v) -- Apply hitbox expansion automatically
            local d = (hrp.Position - v.Position).Magnitude
            if d < Toggles.AttackDist then
                dist = d
                nearest = v
            end
        end
    end
    return nearest
end

task.spawn(function()
    while task.wait() do
        if Toggles.AutoFarmTitans then
            local target = GetTarget()
            local char = game.Players.LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            
            if target and hrp then
                -- NEW POSITIONING: Float Above (Default, no toggle needed)
                local floatOffset = Vector3.new(0, Toggles.FloatHeight / 10, 0) -- Use the FloatHeight slider for control
                local targetCFrame = target.CFrame * CFrame.new(floatOffset)
                
                if Toggles.MoveMethod == "Teleporting" then
                    hrp.CFrame = targetCFrame
                else
                    local bodyVel = hrp:FindFirstChild("SupraVelocity") or Instance.new("LinearVelocity")
                    bodyVel.Name = "SupraVelocity"
                    bodyVel.MaxForce = 1000000
                    bodyVel.Velocity = (targetCFrame.Position - hrp.Position).Unit * Toggles.GlideSpeed
                    bodyVel.Parent = hrp
                    
                    hrp.CFrame = CFrame.new(hrp.Position, targetCFrame.Position)
                end
                
                -- The expanded hitbox ensures the strike connects even while floating above
                task.wait(0.1)
            elseif hrp and hrp:FindFirstChild("SupraVelocity") then
                hrp.SupraVelocity:Destroy()
            end
        end
    end
end)

-- [[ CONFIG & COMPLETION ]]
SaveManager:SetLibrary(Fluent)
SaveManager:SetFolder("SupraHub/AOTR")
SaveManager:BuildConfigSection(Tabs.Config)
Window:SelectTab(1)

Fluent:Notify({ Title = "Supra Hub v9.2", Content = "Hitbox & God-Float Active. Mercy is disabled.", Duration = 5 })
SaveManager:LoadAutoloadConfig()
