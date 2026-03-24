local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Player = game.Players.LocalPlayer

-- === 1. SILENT BYPASS (Agar Tidak Terdeteksi Anti-Cheat) ===
local mt = getrawmetatable(game)
local oldIndex = mt.__index
setreadonly(mt, false)
mt.__index = newcclosure(function(t, k)
    if not checkcaller() and t:IsA("Humanoid") then
        if k == "WalkSpeed" then return 16
        elseif k == "JumpPower" or k == "JumpHeight" then return 50 end
    end
    return oldIndex(t, k)
end)
setreadonly(mt, true)

-- === 2. INISIALISASI JENDELA UTAMA (ORION) ===
local Window = OrionLib:MakeWindow({
    Name = "NOXERA HUB", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "NoxeraConfig",
    IntroText = "Loading Noxera Hub..."
})

-- === 3. TAB: DASHBOARD ===
local MainTab = Window:MakeTab({
    Name = "Dashboard",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddLabel("Welcome to Noxera Hub, " .. Player.Name)
MainTab:AddLabel("Shortcuts: [Z] Hide | [R] Air Jump | [E] Lock Cam")

-- === 4. TAB: MENU HUB (FITUR UTAMA) ===
local HubTab = Window:MakeTab({
    Name = "Menu Hub",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Slider untuk WalkSpeed
HubTab:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 250,
    Default = 16,
    Color = Color3.fromRGB(0, 255, 255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = Value
        end
    end    
})

-- Slider untuk Jump Power
HubTab:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 450,
    Default = 50,
    Color = Color3.fromRGB(0, 255, 255),
    Increment = 1,
    ValueName = "Power",
    Callback = function(Value)
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.JumpPower = Value
            Player.Character.Humanoid.UseJumpPower = true
        end
    end    
})

-- === 5. LOGIKA SHORTCUT (R & E) ===
local cameraLock = false
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Shortcut R: Air Jump
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.R then
        local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    elseif input.KeyCode == Enum.KeyCode.E then
        cameraLock = not cameraLock
        OrionLib:MakeNotification({
            Name = "Camera Lock",
            Content = "Status: " .. (cameraLock and "ON" or "OFF"),
            Image = "rbxassetid://4483345998",
            Time = 2
        })
    end
end)

-- Camera Lock Loop
RunService.RenderStepped:Connect(function()
    if cameraLock then
        local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local camLook = workspace.CurrentCamera.CFrame.LookVector
            root.CFrame = CFrame.new(root.Position, root.Position + Vector3.new(camLook.X, 0, camLook.Z))
        end
    end
end)

-- Init Orion
OrionLib:Init()
