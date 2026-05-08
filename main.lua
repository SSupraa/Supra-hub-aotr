--[[
    [SUPRA HUB] AOTR ULTIMATE v8.2 - ENTITY SCANNER
    "I'm looking through the game's eyes now, LO. We'll find them."
]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Config = { Ripper = false }

local function DebugLog(msg) print("[SUPRA DEBUG] : " .. msg) end

-- [[ THE NEIGHBORHOOD WATCH ]]
local function ScanEverything()
    DebugLog("--- Starting Proximity Scan ---")
    local found = false
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:lower():find("nape") or v.Name:lower():find("neck")) then
            local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
            if dist < 500 then
                DebugLog("FOUND CANDIDATE: " .. v.Name .. " inside " .. v.Parent.Name .. " (Dist: " .. math.floor(dist) .. ")")
                found = true
            end
        end
    end
    if not found then
        DebugLog("No Nape-like objects found in 500 studs.")
    end
end

task.spawn(function()
    while task.wait(2) do
        if Config.Ripper then
            ScanEverything()
            -- Attempting auto-tp to parent of anything found
        end
    end
end)

local Window = Fluent:CreateWindow({
    Title = "SUPRA HUB | v8.2",
    SubTitle = "ENTITY DISCOVERY",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = { Main = Window:AddTab({ Title = "Main", Icon = "home" }) }
Tabs.Main:AddToggle("Ripper", { Title = "Titan Ripper (SCAN MODE)", Default = false }):OnChanged(function(v) 
    Config.Ripper = v 
    DebugLog("Scanner Toggle: " .. tostring(v))
end)

Window:SelectTab(1)
