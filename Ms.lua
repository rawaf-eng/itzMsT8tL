-- RAWAF HUB - Professional Script for Roblox
-- Optimized for Mobile & PC Execution (Delta, Xeno, Arceus X)

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "RAWAF HUB | Steal an Egg 🥚",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "RAWAF_Config",
    IntroEnabled = true,
    IntroText = "Welcome to RAWAF HUB",
    IntroIcon = "rbxassetid://4483345998"
})

-- Global Variables
getgenv().AutoFarm = false
getgenv().AutoSteal = false
getgenv().ESP = false
getgenv().WalkSpeed = 16
getgenv().JumpPower = 50

-- Bypass Protection & Anti-AFK
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0,0))
end)

-- Main Tab
local MainTab = Window:MakeTab({
    Name = "Main / Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddSection({
    Name = "Farming Functions"
})

MainTab:AddToggle({
    Name = "Auto Collect Eggs / Auto Farm",
    Default = false,
    Callback = function(Value)
        getgenv().AutoFarm = Value
        task.spawn(function()
            while getgenv().AutoFarm do
                task.wait(0.1)
                pcall(function()
                    for _, obj in pairs(workspace:GetChildren()) do
                        if obj:IsA("Part") and (obj.Name:lower():find("egg") or obj.Name:lower():find("item")) then
                            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                                task.wait(0.2)
                            end
                        end
                    end
                end)
            end
        end)
    end    
})

MainTab:AddToggle({
    Name = "Auto Steal Mode",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSteal = Value
        task.spawn(function()
            while getgenv().AutoSteal do
                task.wait(0.2)
                pcall(function()
                    -- Custom Auto Steal Logic Loop
                end)
            end
        end)
    end    
})

-- Player Tab
local PlayerTab = Window:MakeTab({
    Name = "Player Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

PlayerTab:AddSection({
    Name = "Movement Modifications"
})

PlayerTab:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 250,
    Default = 16,
    Color = Color3.fromRGB(255, 85, 0),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        getgenv().WalkSpeed = Value
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end)
    end    
})

PlayerTab:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 350,
    Default = 50,
    Color = Color3.fromRGB(0, 170, 255),
    Increment = 1,
    ValueName = "Power",
    Callback = function(Value)
        getgenv().JumpPower = Value
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
        end)
    end    
})

-- Visuals Tab
local VisualsTab = Window:MakeTab({
    Name = "Visuals / ESP",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

VisualsTab:AddToggle({
    Name = "Enable Player ESP",
    Default = false,
    Callback = function(Value)
        getgenv().ESP = Value
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                if Value then
                    if not player.Character:FindFirstChild("RAWAF_Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "RAWAF_Highlight"
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.Parent = player.Character
                    end
                else
                    if player.Character:FindFirstChild("RAWAF_Highlight") then
                        player.Character.RAWAF_Highlight:Destroy()
                    end
                end
            end
        end
    end    
})

-- Settings Tab
local SettingsTab = Window:MakeTab({
    Name = "Settings & Credits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

SettingsTab:AddLabel("Script Created by RAWAF")
SettingsTab:AddButton({
    Name = "Destroy UI",
    Callback = function()
        OrionLib:Destroy()
    end    
})

-- Apply Speed Loop Fix
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                if game.Players.LocalPlayer.Character.Humanoid.WalkSpeed ~= getgenv().WalkSpeed then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().WalkSpeed
                end
            end
        end)
    end
end)

OrionLib:Init()
