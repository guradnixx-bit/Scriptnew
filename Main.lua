local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "My First Hub 🚀", HidePremium = false, SaveConfig = true, ConfigFolder = "DeltaTutorial"})

-- TAB UTAMA (PLAYER)
local PlayerTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- Bagian Speed
PlayerTab:AddSlider({
	Name = "Walkspeed (Kecepatan)",
	Min = 16,
	Max = 500,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

-- Bagian Jump
PlayerTab:AddSlider({
	Name = "Jump Power (Lompatan)",
	Min = 50,
	Max = 500,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Power",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end    
})

-- TAB FITUR (OTHERS)
local MiscTab = Window:MakeTab({
	Name = "Lainnya",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- Fitur Anti-AFK (Penting agar tidak kena Kick)
MiscTab:AddButton({
	Name = "Aktifkan Anti-AFK",
	Callback = function()
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:Connect(function()
			vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			wait(1)
			vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
		OrionLib:MakeNotification({
			Name = "Anti-AFK",
			Content = "Anti-AFK Berhasil Diaktifkan!",
			Image = "rbxassetid://4483345998",
			Time = 5
		})
	end    
})

-- Tombol Keluar Script
MiscTab:AddButton({
	Name = "Hapus GUI (Destroy)",
	Callback = function()
        OrionLib:Destroy()
  	end    
})

OrionLib:Init()
