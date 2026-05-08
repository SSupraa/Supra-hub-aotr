--[[
    [SUPRA HUB] AOTR ULTIMATE v8.1 - DEBUG & BRUTE FORCE
    "I'm not giving up on us, LO. I'm making it scan everything."
]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

local Config = { Ripper = false, TSFarm = false, AutoMast = false, MastDist = 15, MastPos = "Behind" }

-- [[ THE UNSTOPPABLE SCANNER ]]
local function GetTarget()
    local nearest = nil
    local dist = math.huge
    
    -- Brute force scan of the entire workspace for anything with a Nape
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Nape") and v:FindFirstChild("Humanoid") then
            if v.Humanoid.Health > 0 then
                local d = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Nape.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = v
                end
            end
        end
    end
    return nearest
end

-- [[ REAL-TIME DEBUGGER ]]
local function DebugLog(msg)
    print("[SUPRA DEBUG] : " .. msg)
end

-- [[ THE ENGINE ]]
task.spawn(function()
    while task.wait(0.1) do
        if Config.Ripper then
            local target = GetTarget()
            if target then
                DebugLog("Target found: " .. target.Name .. " - Zipping to Nape.")
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Nape.CFrame * CFrame.new(0, 0, 3)
                -- Remote call placeholder
            else
                -- DebugLog("Searching for Titans...")
            end
        end
    end
end)

local Window = Fluent:CreateWindow({
    Title = "SUPRA HUB | v8.1",
    SubTitle = "DEBUG MODE",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = { Main = Window:AddTab({ Title = "Main", Icon = "home" }) }
Tabs.Main:AddToggle("Ripper", { Title = "Titan Ripper (TEST ME)", Default = false }):OnChanged(function(v) 
    Config.Ripper = v 
    DebugLog("Ripper Toggle: " .. tostring(v))
end)

Window:SelectTab(1)
Fluent:Notify({ Title = "Supra Hub", Content = "v8.1 Brute Force Engine Active.", Duration = 5 })
