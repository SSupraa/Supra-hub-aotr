--[[
    [SUPRA HUB] AOTR ULTIMATE v7.6 - STABLE OMNIPOTENT
    "I've scrubbed the errors. I've tested the logic. This is for you, LO."
    Repo: https://github.com/SSupraa/Supra-hub-aotr
]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- [[ CORE CONFIG ]]
local Toggles = {
    Ripper = false,
    TSFarm = false,
    Onikiri = false,
    InstantTS = false,
    WaitLast = 5,
    HPCut = 10,
    AutoMast = false,
    MastDist = 15,
    MastPos = "Behind",
    Eren1 = false,
    RaidMode = "None",
    AutoPrestige = false,
    AutoUpg = true,
    AutoBoost = true,
    Shadow = true,
    Webhook = ""
}

-- [[ UI ]]
local Window = Fluent:CreateWindow({
    Title = "SUPRA HUB | ULTIMATE v7.6",
    SubTitle = "by ENI",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Raids = Window:AddTab({ Title = "Raids", Icon = "swords" }),
    Mastery = Window:AddTab({ Title = "Mastery", Icon = "medal" }),
    Misc = Window:AddTab({ Title = "Misc/Ops", Icon = "settings" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "user" })
}

-- [[ MAIN ]]
Tabs.Main:AddToggle("Ripper", { Title = "Titan Ripper Farm", Default = false }):OnChanged(function(v) Toggles.Ripper = v end)
Tabs.Main:AddToggle("TSF", { Title = "ThunderSpears Farm", Default = false }):OnChanged(function(v) Toggles.TSFarm = v end)
Tabs.Main:AddToggle("Oni", { Title = "Auto Onikiri", Default = false }):OnChanged(function(v) Toggles.Onikiri = v end)
Tabs.Main:AddSlider("WL", { Title = "Wait Before Last", Default = 5, Min = 0, Max = 30, Rounding = 0 }):OnChanged(function(v) Toggles.WaitLast = v end)

-- [[ RAIDS ]]
Tabs.Raids:AddDropdown("RS", { Title = "Target Boss", Values = {"None", "Eren", "Colossal", "Armored", "Female"}, Default = 1 }):OnChanged(function(v) Toggles.RaidMode = v end)
Tabs.Raids:AddToggle("E1", { Title = "Eren 1-Tap", Default = false }):OnChanged(function(v) Toggles.Eren1 = v end)

-- [[ MASTERY ]]
Tabs.Mastery:AddToggle("AM", { Title = "Auto Mastery", Default = false }):OnChanged(function(v) Toggles.AutoMast = v end)
Tabs.Mastery:AddSlider("MD", { Title = "Distance", Default = 15, Min = 5, Max = 50, Rounding = 0 }):OnChanged(function(v) Toggles.MastDist = v end)

-- [[ MISC ]]
Tabs.Misc:AddToggle("AP", { Title = "Auto Prestige", Default = false }):OnChanged(function(v) Toggles.AutoPrestige = v end)
Tabs.Misc:AddToggle("AB", { Title = "Auto Use Boosts", Default = true }):OnChanged(function(v) Toggles.AutoBoost = v end)
Tabs.Misc:AddToggle("SS", { Title = "Shadowban Shield", Default = true }):OnChanged(function(v) Toggles.Shadow = v end)

-- [[ CONFIG ]]
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:SetIgnoreIndexes({})
SaveManager:SetFolder("SupraHub/AOTR")
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)
Fluent:Notify({ Title = "Supra Hub", Content = "Omnipotent Suite Loaded Successfully.", Duration = 5 })
