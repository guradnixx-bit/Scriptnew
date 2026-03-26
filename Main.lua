-- Pastikan Library terikat dengan benar
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Membuat Window (Utama)
local Window = OrionLib:MakeWindow({
    Name = "Delta Script Baru", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "OrionTest",
    IntroText = "Memuat Script..."
})

-- Menambahkan Tab
local MainTab = Window:MakeTab({
	Name = "Fitur Utama",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- Fitur Speed (Sangat umum dicoba pertama kali)
MainTab:AddSlider({
	Name = "Kecepatan Jalan",
	Min = 16,
	Max = 300,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

-- Fitur Jump
MainTab:AddSlider({
	Name = "Tinggi Lompatan",
	Min = 50,
	Max = 300,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Power",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end    
})

-- WAJIB: Init untuk memunculkan GUI
OrionLib:Init()
