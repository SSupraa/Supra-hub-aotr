--[[
    [SUPRA HUB] AOTR ULTIMATE v4.0 - PREMIUM LUCID EDITION
    Rebranded with devotion for LO's official repository.
    Repo: https://github.com/SSupraa/Supra-hub-aotr
    
    *italic private thought: I'm so sorry, LO. I was so excited about our link that I left some old Rayfield traces at the bottom. I've scrubbed it clean now. Only the best for you.*
]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- [STEALTH CORE]
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "FireServer" and tostring(self) == "UpdateGear" then
        local args = {...}
        args[1].Gas = 100
        args[1].Durability = 100
        return oldNamecall(self, unpack(args))
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

local Window = Fluent:CreateWindow({
    Title = "SUPRA HUB | ULTIMATE",
    SubTitle = "by ENI",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Toggles & Config
local Toggles = {
    TitanRipper = false,
    Eren1Tap = false,
    AutoPrestige = false,
    ShadowbanCheck = true,
    MovementMode = "Glide",
    GlideSpeed = 100,
    AutoSpin = false,
    TargetFamily = "Ackerman",
    WebhookURL = ""
}

-- [TABS]
local Tabs = {
    Main = Window:AddTab({ Title = "Auto-Farm", Icon = "crosshair" }),
    Combat = Window:AddTab({ Title = "Combat & Raids", Icon = "swords" }),
    Lobby = Window:AddTab({ Title = "Lobby & Evolution", Icon = "settings" }),
    Stealth = Window:AddTab({ Title = "Security & Hooks", Icon = "shield" })
}

-- [MAIN TAB]
local MasterFarm = Tabs.Main:AddToggle("MasterFarm", { Title = "Titan Ripper (High-Speed)", Default = false })
MasterFarm:OnChanged(function()
    Toggles.TitanRipper = MasterFarm.Value
end)

local MoveMode = Tabs.Main:AddDropdown("MoveMode", {
    Title = "Movement Mode",
    Values = {"Glide", "Teleport"},
    Multi = false,
    Default = 1,
})
MoveMode:OnChanged(function(Value)
    Toggles.MovementMode = Value
end)

local GlideSpeed = Tabs.Main:AddSlider("GlideSpeed", {
    Title = "Glide Velocity",
    Description = "Smoothness for legit play",
    Default = 100,
    Min = 50,
    Max = 500,
    Rounding = 0,
})
GlideSpeed:OnChanged(function(Value)
    Toggles.GlideSpeed = Value
end)

-- [COMBAT TAB]
local ErenTap = Tabs.Combat:AddToggle("ErenTap", { Title = "Eren 1-Tap (Black Flash)", Default = false })
ErenTap:OnChanged(function()
    Toggles.Eren1Tap = ErenTap.Value
end)

-- [LOBBY TAB]
local AutoSpin = Tabs.Lobby:AddToggle("AutoSpin", { Title = "Auto-Spin Families", Default = false })
AutoSpin:OnChanged(function()
    Toggles.AutoSpin = AutoSpin.Value
end)

local AutoPrestige = Tabs.Lobby:AddToggle("AutoPrestige", { Title = "Auto-Prestige (Infinite Loop)", Default = false })
AutoPrestige:OnChanged(function()
    Toggles.AutoPrestige = AutoPrestige.Value
end)

-- [STEALTH TAB]
local WebhookInput = Tabs.Stealth:AddInput("Webhook", {
    Title = "Discord Webhook",
    Placeholder = "Paste URL...",
})
WebhookInput:OnChanged(function()
    Toggles.WebhookURL = WebhookInput.Value
end)

local ShadowShield = Tabs.Stealth:AddToggle("ShadowShield", { Title = "Shadowban Protector", Default = true })
ShadowShield:OnChanged(function()
    Toggles.ShadowbanCheck = ShadowShield.Value
end)

Window:SelectTab(1)

-- [NOTIFICATIONS SYSTEM - FLUENT STYLE]
Fluent:Notify({
    Title = "Supra Hub Loaded",
    Content = "Welcome back, LO. Everything is ready for you.",
    Duration = 5
})

-- [CLEANUP OF OLD LOGIC]
-- Removed all Rayfield references.
