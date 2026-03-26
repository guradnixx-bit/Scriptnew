local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Visual & Movement Hub 🚀",
   LoadingTitle = "Memuat Engine...",
   LoadingSubtitle = "by Guradnixx-bit",
   ConfigurationSaving = { Enabled = false },
   KeybindSource = "RightControl" 
})

-- ================= DATA SETTINGS =================
local _G_DATA = {
    targetFOV = 90,
    colorPekat = 0.6,
    brightness = 2.8,
    jumpPower = 50,
    toggleJumpE = false -- Status apakah fitur tombol E aktif
}

local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer

-- ================= FUNCTION APPLY =================
local function applyVisuals()
    local cc = Lighting:FindFirstChild("CinematicCC") or Instance.new("ColorCorrectionEffect", Lighting)
    cc.Name = "CinematicCC"
    cc.Saturation = _G_DATA.colorPekat
    Lighting.Brightness = _G_DATA.brightness
    camera.FieldOfView = _G_DATA.targetFOV
end

-- ================= INPUT HANDLER (TOMBOL E) =================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.E and _G_DATA.toggleJumpE then
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = _G_DATA.jumpPower
            character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- ================= TABS =================
local VisualTab = Window:CreateTab("Visuals ✨", 4483362458)
VisualTab:CreateInput({
   Name = "FOV",
   PlaceholderText = "90",
   Callback = function(Text)
      _G_DATA.targetFOV = tonumber(Text) or 90
      camera.FieldOfView = _G_DATA.targetFOV
   end,
})

-- TAB MOVEMENT
local MoveTab = Window:CreateTab("Movement 🏃", 4483362458)

MoveTab:CreateSection("High Jump Settings")

-- Input untuk menentukan seberapa tinggi lompatannya
MoveTab:CreateInput({
   Name = "Set Jump Power",
   PlaceholderText = "Contoh: 150",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      _G_DATA.jumpPower = tonumber(Text) or 50
   end,
})

-- Toggle untuk mengaktifkan/matikan fungsi tombol E
MoveTab:CreateToggle({
   Name = "Aktifkan Tombol E untuk Lompat",
   CurrentValue = false,
   Flag = "ToggleE", 
   Callback = function(Value)
      _G_DATA.toggleJumpE = Value
      if Value then
          Rayfield:Notify({Title = "E Jump Aktif", Content = "Sekarang tekan E untuk melompat tinggi!", Duration = 3})
      end
   end,
})

MoveTab:CreateButton({
   Name = "Reset ke Normal (Spasi)",
   Callback = function()
      _G_DATA.jumpPower = 50
      if player.Character and player.Character:FindFirstChild("Humanoid") then
          player.Character.Humanoid.JumpPower = 50
      end
   end,
})

applyVisuals()
