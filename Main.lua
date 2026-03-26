local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Guradnixx Hub 🚀",
   LoadingTitle = "Memuat Fitur Pro...",
   LoadingSubtitle = "by Guradnixx-bit",
   ConfigurationSaving = { Enabled = false },
   KeybindSource = "RightControl" 
})

-- ================= DATA & SERVICES =================
local _G_DATA = {
    targetFOV = 90,
    colorPekat = 0.6,
    brightness = 2.8,
    jumpPower = 50,
    toggleJumpE = false,
    fullBrightEnabled = false,
    infJumpEnabled = false
}

local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

-- ================= FUNCTION FULL BRIGHT =================
-- Loop untuk memastikan lighting tetap terang meskipun game mencoba mengubahnya
spawn(function()
    while task.wait(0.5) do
        if _G_DATA.fullBrightEnabled then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end
    end
end)

-- ================= INFINITE JUMP HANDLER =================
UserInputService.JumpRequest:Connect(function()
    if _G_DATA.infJumpEnabled then
        player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- ================= INPUT HANDLER (TOMBOL E) =================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.E and _G_DATA.toggleJumpE then
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = _G_DATA.jumpPower
            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- ================= TABS =================

-- TAB WORLD (Full Bright & Map)
local WorldTab = Window:CreateTab("World 🌍", 4483362458)

WorldTab:CreateSection("Lighting & Environment")

WorldTab:CreateToggle({
   Name = "Full Bright (Anti Gelap)",
   CurrentValue = false,
   Callback = function(Value)
      _G_DATA.fullBrightEnabled = Value
      if not Value then
          -- Reset ke standar jika dimatikan
          Lighting.Brightness = 1
          Lighting.GlobalShadows = true
      end
   end,
})

-- TAB MOVEMENT
local MoveTab = Window:CreateTab("Movement 🏃", 4483362458)

MoveTab:CreateToggle({
   Name = "Infinite Jump (Lompat di Udara)",
   CurrentValue = false,
   Callback = function(Value)
      _G_DATA.infJumpEnabled = Value
   end,
})

MoveTab:CreateInput({
   Name = "Set Jump Power",
   PlaceholderText = "Contoh: 150",
   Callback = function(Text)
      _G_DATA.jumpPower = tonumber(Text) or 50
   end,
})

MoveTab:CreateToggle({
   Name = "Aktifkan Tombol E untuk Lompat",
   CurrentValue = false,
   Callback = function(Value)
      _G_DATA.toggleJumpE = Value
   end,
})

-- TAB VISUAL (FOV & Saturation)
local VisualTab = Window:CreateTab("Visuals ✨", 4483362458)
VisualTab:CreateInput({
   Name = "Field of View (FOV)",
   PlaceholderText = "90",
   Callback = function(Text)
      workspace.CurrentCamera.FieldOfView = tonumber(Text) or 90
   end,
})
