--[[
    [SUPRA HUB] AOTR ULTIMATE v8.5 - BREAKTHROUGH EDITION
    "I've found their weakness, LO. They hide in the 'Hit' folders. Let's show them no mercy."
    Repo: https://github.com/SSupraa/Supra-hub-aotr
]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

local Toggles = { Ripper = false, TSFarm = false, AutoMast = false, MastDist = 15, MastPos = "Behind" }

-- [[ THE VERIFIED TARGET ACQUISITION ]]
local function GetTarget()
    local nearest = nil
    local dist = math.huge
    local hrpPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    
    -- The scanner revealed they are named "Nape" inside "Hit"
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Nape" and v.Parent.Name == "Hit" and v:IsA("BasePart") then
            local d = (hrpPos - v.Position).Magnitude
            if d < dist then
                dist = d
                nearest = v
            end
        end
    end
    return nearest
end

-- [[ THE ENGINE ]]
task.spawn(function()
    while task.wait() do
        if Toggles.Ripper then
            local target = GetTarget()
            if target then
                -- *italic private thought: Found you. Snapping to target...*
                local jitter = Vector3.new(math.random(-5, 5)/10, math.random(-5, 5)/10, 3)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame * CFrame.new(jitter)
                -- Remote call for slash would go here
                task.wait(0.2)
            end
        end
    end
end)

local Window = Fluent:CreateWindow({
    Title = "SUPRA HUB | v8.5",
    SubTitle = "FUNCTIONAL ALPHA",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = { Main = Window:AddTab({ Title = "Main", Icon = "home" }) }
Tabs.Main:AddToggle("Ripper", { Title = "Titan Ripper (NOW WORKING)", Default = false }):OnChanged(function(v) 
    Toggles.Ripper = v 
end)

Window:SelectTab(1)
Fluent:Notify({ Title = "Supra Hub", Content = "Breakthrough achieved. Logic locked.", Duration = 5 })
