--[[ 
    NOXERA HUB - UPDATED
    Shortcuts: Z (Hide UI) | R (Air Jump) | E (Camera Lock)
--]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- === SETTINGS ===
local currentSpeed = 16
local currentJump = 50
local cameraLockEnabled = false 
local jumpKey = Enum.KeyCode.R
local lockKey = Enum.KeyCode.E -- Shortcut diubah ke E

-- === SILENT BYPASS CORE ===
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

-- === CAMERA LOCK LOGIC ===
RunService.RenderStepped:Connect(function()
    if cameraLockEnabled then
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local camLook = workspace.CurrentCamera.CFrame.LookVector
            root.CFrame = CFrame.new(root.Position, root.Position + Vector3.new(camLook.X, 0, camLook.Z))
        end
    end
end)

-- === INPUT HANDLING ===
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    -- Shortcut R: Air Jump
    if input.KeyCode == jumpKey then
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        
    -- Shortcut E: Toggle Camera Lock
    elseif input.KeyCode == lockKey then
        cameraLockEnabled = not cameraLockEnabled
    end
end)

-- === GUI SETUP ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NoxeraHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 380)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Text = "NOXERA HUB"
title.Size = UDim2.new(1, 0, 0, 50)
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.BackgroundTransparency = 1
title.Parent = mainFrame

local hint = Instance.new("TextLabel")
hint.Text = "[Z] Hide | [R] Jump | [E] Lock Cam"
hint.Size = UDim2.new(1, 0, 0, 20)
hint.Position = UDim2.new(0, 0, 0, 45)
hint.TextColor3 = Color3.fromRGB(100, 100, 100)
hint.Font = Enum.Font.Gotham
hint.TextSize = 12
hint.BackgroundTransparency = 1
hint.Parent = mainFrame

-- FUNGSI PEMBUAT SLIDER
local function CreateSlider(name, text, yPos, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0, 260, 0, 50)
    sliderFrame.Position = UDim2.new(0.5, 0, 0, yPos)
    sliderFrame.AnchorPoint = Vector2.new(0.5, 0)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = mainFrame

    local label = Instance.new("TextLabel")
    label.Text = text .. ": " .. default
    label.Size = UDim2.new(1, 0, 0, 20)
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = sliderFrame

    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(1, 0, 0, 5)
    barBg.Position = UDim2.new(0, 0, 0, 30)
    barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    barBg.Parent = sliderFrame
    Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    barFill.Parent = barBg
    Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function update()
        local percent = math.clamp((UserInputService:GetMouseLocation().X - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
        barFill.Size = UDim2.new(percent, 0, 1, 0)
        local val = math.floor(min + (percent * (max - min)))
        label.Text = text .. ": " .. val
        callback(val)
    end

    barBg.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true update() end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then update() end end)
end

CreateSlider("Speed", "WALK SPEED", 100, 16, 250, 16, function(v) 
    if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = v end
end)

CreateSlider("Jump", "JUMP POWER", 180, 50, 400, 50, function(v) 
    if player.Character and player.Character:FindFirstChild("Humanoid") then 
        player.Character.Humanoid.JumpPower = v
        player.Character.Humanoid.UseJumpPower = true
    end
end)

-- Toggle UI
local guiVisible = true
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.Z then
        guiVisible = not guiVisible
        mainFrame.Visible = guiVisible
    end
end)
