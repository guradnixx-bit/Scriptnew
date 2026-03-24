-- Template GUI Tabbed Sederhana (Model Starship)
local players = game:GetService("Players")
local player = players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- === Main Objects ===
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Corner = Instance.new("UICorner")

-- === Sidebar ===
local Sidebar = Instance.new("Frame")
local HomeTabButton = Instance.new("TextButton")
local SettingsTabButton = Instance.new("TextButton")
local SidebarList = Instance.new("UIListLayout")

-- === Pages (Tab Content) ===
local PageHolder = Instance.new("Frame")
local HomePage = Instance.new("Frame")
local SettingsPage = Instance.new("Frame")

-- Set-up ScreenGui
ScreenGui.Parent = PlayerGui
ScreenGui.Name = "HubTemplate"

-- Set-up MainFrame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25) -- Gelap
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Draggable = true -- Biar bisa digeser
MainFrame.Active = true

Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

-- === Setup Sidebar ===
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Sidebar.Size = UDim2.new(0.3, 0, 1, 0)

Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)
SidebarList.Parent = Sidebar
SidebarList.Padding = UDim.new(0, 5)

-- Tambahkan Header di Sidebar (Pola Profil)
local Header = Instance.new("TextLabel")
Header.Parent = Sidebar
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Text = "MENU HUB"
Header.TextColor3 = Color3.fromRGB(150, 150, 150)
Header.TextSize = 16
Header.BackgroundTransparency = 1

-- Fungsi untuk membuat tombol tab di sidebar
local function createTabButton(name, parent)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = UDim2.new(1, 0, 0, 30)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    button.BackgroundTransparency = 1
    button.TextSize = 14
    
    local c = Instance.new("UICorner", button)
    c.CornerRadius = UDim.new(0, 5)
    
    return button
end

HomeTabButton = createTabButton("🏠 Dashboard", Sidebar)
SettingsTabButton = createTabButton("⚙️ Settings", Sidebar)

-- === Setup Pages ===
PageHolder.Parent = MainFrame
PageHolder.Position = UDim2.new(0.3, 5, 0, 0)
PageHolder.Size = UDim2.new(0.7, -5, 1, 0)
PageHolder.BackgroundTransparency = 1

HomePage.Name = "HomePage"
HomePage.Parent = PageHolder
HomePage.Size = UDim2.new(1, 0, 1, 0)
HomePage.BackgroundTransparency = 1
HomePage.Visible = true -- Default visible

SettingsPage.Name = "SettingsPage"
SettingsPage.Parent = PageHolder
SettingsPage.Size = UDim2.new(1, 0, 1, 0)
SettingsPage.BackgroundTransparency = 1
SettingsPage.Visible = false

-- Isi konten Home (Contoh)
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Parent = HomePage
WelcomeLabel.Text = "Welcome, " .. player.Name .. "!"
WelcomeLabel.Size = UDim2.new(1, 0, 0, 50)
WelcomeLabel.TextSize = 20
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeLabel.BackgroundTransparency = 1

-- === Logika Switch Tab ===
local function switchPage(activePageName)
    HomePage.Visible = false
    SettingsPage.Visible = false
    
    if activePageName == "Home" then
        HomePage.Visible = true
        HomeTabButton.BackgroundTransparency = 0 -- Efek selected
        SettingsTabButton.BackgroundTransparency = 1
    elseif activePageName == "Settings" then
        SettingsPage.Visible = true
        SettingsTabButton.BackgroundTransparency = 0
        HomeTabButton.BackgroundTransparency = 1
    end
end

-- Tombol Input Event
HomeTabButton.MouseButton1Click:Connect(function() switchPage("Home") end)
SettingsTabButton.MouseButton1Click:Connect(function() switchPage("Settings") end)

-- Set default page
switchPage("Home")
