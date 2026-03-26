local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Delta Script v2",
   LoadingTitle = "Memuat Hub...",
   LoadingSubtitle = "by Guradnixx",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "DeltaConfigs",
      FileName = "MyScript"
   }
})

local MainTab = Window:CreateTab("Utama", 4483362458) -- Ikon Home

MainTab:CreateSection("Fitur Player")

MainTab:CreateSlider({
   Name = "WalkSpeed (Lari)",
   Range = {16, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

MainTab:CreateSlider({
   Name = "JumpPower (Lompat)",
   Range = {50, 300},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "Slider2",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

MainTab:CreateButton({
   Name = "Hapus GUI",
   Callback = function()
      Rayfield:Destroy()
   end,
})

Rayfield:Notify({
   Title = "Berhasil!",
   Content = "Script telah dimuat dengan sukses",
   Duration = 5,
   Image = 4483362458,
})
