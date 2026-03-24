--[[ 
    NOXERA HUB - FIXED URL & LIBRARY
--]]

-- Menggunakan pcall agar jika library gagal, game tidak crash
local success, OrionLib = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
end)

if not success then
    warn("❌ Gagal memuat Library. Link GitHub Library mungkin mati.")
    return
end

local Window = OrionLib:MakeWindow({Name = "NOXERA HUB", HidePremium = false, SaveConfig = true, IntroText = "Noxera Hub"})

-- === TAB MENU HUB ===
local HubTab = Window:MakeTab({
    Name = "Menu Hub",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

HubTab:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 250,
    Default = 16,
    Color = Color3.fromRGB(0, 255, 255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end    
})

HubTab:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 450,
    Default = 50,
    Color = Color3.fromRGB(0, 255, 255),
    Increment = 1,
    ValueName = "Power",
    Callback = function(Value)
        if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
            game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
        end
    end    
})

OrionLib:Init()
