--// NOTIFIKASI PEMUATAN
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Elang Hub System",
    Text = "Checking Key... Please wait",
    Duration = 5
})

--// PANDA AUTH SYSTEM (DENGAN PERBAIKAN KONEKSI)
local PandaAuth
local success, err = pcall(function()
    return loadstring(game:HttpGet("https://api.pandadevelopment.net/v1/sdk/load"))()
end)

if success and err then
    PandaAuth = err
else
    warn("Gagal memuat API Panda: " .. tostring(err))
    return
end

local ServiceID = "hitboxbby" 
local ServerKey = "1e16d344-86cc-4353-87c7-e025022d77be" 

local function StartScript()
    --// SCRIPT UTAMA ELANG HUB KAMU
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local Player = Players.LocalPlayer

    local CONFIG = {
        HitboxEnabled = false,
        SmartNoclip = false,
        SafeDistance = 65,
        HitboxTransparency = 0.7,
        HitboxColor = Color3.fromRGB(0, 255, 255) 
    }

    local SETTINGS = {
        Normal = {X=8, Y=0, Z=8},
        Main   = {X=12, Y=0, Z=12},
        Ball   = {X=10, Y=10, Z=10},
        Cyl    = {X=10, Y=5, Z=10},
        Robux  = {X=10, Y=2, Z=10},
        Group  = {X=5, Y=2, Z=5} 
    }

    local Hitboxes = {}
    local lastScan = 0

    local function isOtherPlayer(obj)
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= Player and p.Character and obj:IsDescendantOf(p.Character) then return true end
        end
        return false
    end

    local function isValidTarget(obj)
        if obj:IsA("Terrain") or obj.Name == "Baseplate" or obj.Name == "Terrain" then return false end
        return true
    end

    local function getSettingType(obj)
        if obj:FindFirstAncestorOfClass("Model") then return "Group" end
        local nameLower = obj.Name:lower()
        if nameLower:find("robux") then return "Robux" end
        if obj:IsA("UnionOperation") then return "Normal" end
        if obj:IsA("Part") then
            if obj.Shape == Enum.PartType.Ball then return "Ball"
            elseif obj.Shape == Enum.PartType.Cylinder then return "Cyl" end
        end
        if nameLower:find("main") then return "Main" end
        return "Normal"
    end

    local function makeDraggable(obj, target)
        local dragging, dragStart, startPos
        obj.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                dragging = true; dragStart = input.Position; startPos = target.Position
                input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
            end
        end)
        UIS.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end

    local gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
    gui.Name = "ElangHub_V36_8_5"; gui.ResetOnSpawn = false

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 550, 0, 350); main.Position = UDim2.new(0.5, -275, 0.5, -175); main.BackgroundColor3 = Color3.fromRGB(20, 25, 30); main.ClipsDescendants = true; Instance.new("UICorner", main)

    local header = Instance.new("Frame", main); header.Size = UDim2.new(1, 0, 0, 40); header.BackgroundColor3 = Color3.fromRGB(30, 40, 50); Instance.new("UICorner", header); makeDraggable(header, main)
    local title = Instance.new("TextLabel", header); title.Text = "  🦅 ELANG HUB V36.8.5 - EASY COLOR"; title.Size = UDim2.new(0.7,0,1,0); title.TextColor3 = Color3.new(0.9,0.9,1); title.BackgroundTransparency = 1; title.TextXAlignment = 0

    local closeBtn = Instance.new("TextButton", header); closeBtn.Size = UDim2.new(0,30,0,30); closeBtn.Position = UDim2.new(1,-35,0,5); closeBtn.Text = "✕"; closeBtn.TextColor3 = Color3.new(1,0,0); closeBtn.BackgroundTransparency = 1
    local minBtn = Instance.new("TextButton", header); minBtn.Size = UDim2.new(0,30,0,30); minBtn.Position = UDim2.new(1,-70,0,5); minBtn.Text = "—"; minBtn.TextColor3 = Color3.new(1,1,1); minBtn.BackgroundTransparency = 1

    local taskbar = Instance.new("Frame", gui); taskbar.Size = UDim2.new(0, 50, 0, 50); taskbar.Position = UDim2.new(0.02, 0, 0.8, 0); taskbar.Visible = false; taskbar.BackgroundColor3 = Color3.fromRGB(20, 30, 40); taskbar.BackgroundTransparency = 0.2; Instance.new("UICorner", taskbar)
    local taskIcon = Instance.new("TextButton", taskbar); taskIcon.Size = UDim2.new(1,0,1,0); taskIcon.BackgroundTransparency = 1; taskIcon.Text = "🦅"; taskIcon.TextColor3 = Color3.fromRGB(200, 220, 255); taskIcon.TextSize = 24; makeDraggable(taskIcon, taskbar)

    minBtn.MouseButton1Click:Connect(function() main.Visible = false; taskbar.Visible = true end)
    taskIcon.MouseButton1Click:Connect(function() main.Visible = true; taskbar.Visible = false end)
    closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

    local body = Instance.new("Frame", main); body.Size = UDim2.new(1,0,1,-40); body.Position = UDim2.new(0,0,0,40); body.BackgroundTransparency = 1
    local sidebar = Instance.new("Frame", body); sidebar.Size = UDim2.new(0,130,1,0); sidebar.BackgroundColor3 = Color3.new(0,0,0); sidebar.BackgroundTransparency = 0.6
    local nav = Instance.new("ScrollingFrame", sidebar); nav.Size = UDim2.new(1,0,1,0); nav.BackgroundTransparency = 1; nav.ScrollBarThickness = 0
    Instance.new("UIListLayout", nav).Padding = UDim.new(0,5)
    local container = Instance.new("Frame", body); container.Position = UDim2.new(0,140,0,10); container.Size = UDim2.new(1,-150,1,-20); container.BackgroundTransparency = 1
    local pages = {}

    local function createTab(name)
        local p = Instance.new("ScrollingFrame", container); p.Size = UDim2.new(1,0,1,0); p.Visible = false; p.BackgroundTransparency = 1; p.CanvasSize = UDim2.new(0,0,1.8,0); p.ScrollBarThickness = 2
        Instance.new("UIListLayout", p).Padding = UDim.new(0,8); pages[name] = p
        local b = Instance.new("TextButton", nav); b.Size = UDim2.new(0.9,0,0,30); b.Text = name; b.BackgroundColor3 = Color3.fromRGB(40,50,70); b.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function() for _,pg in pairs(pages) do pg.Visible = false end; p.Visible = true end)
        return p
    end

    local dashP = createTab("Main"); local normP = createTab("Normal")
    local mainP = createTab("MainPart"); local ballP = createTab("Ball")
    local cylP = createTab("Cylinder"); local robuxP = createTab("Robux")
    local groupP = createTab("Group")
    pages["Main"].Visible = true

    local function addToggle(parent, txt, call)
        local f = Instance.new("Frame", parent); f.Size = UDim2.new(1,-10,0,35); f.BackgroundColor3 = Color3.new(0,0,0); f.BackgroundTransparency = 0.4; Instance.new("UICorner", f)
        local l = Instance.new("TextLabel", f); l.Text = "  "..txt; l.Size = UDim2.new(0.7,0,1,0); l.TextColor3 = Color3.new(1,1,1); l.BackgroundTransparency = 1; l.TextXAlignment = 0
        local b = Instance.new("TextButton", f); b.Size = UDim2.new(0,45,0,20); b.Position = UDim2.new(1,-55,0.5,-10); b.Text = "OFF"; b.BackgroundColor3 = Color3.fromRGB(150,50,50); b.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", b)
        local s = false; b.MouseButton1Click:Connect(function() s = not s; b.Text = s and "ON" or "OFF"; b.BackgroundColor3 = s and Color3.fromRGB(50,150,50) or Color3.fromRGB(150,50,50); call(s) end)
    end

    local function addXYZ(parent, tab)
        for _, axis in ipairs({"X","Y","Z"}) do
            local f = Instance.new("Frame", parent); f.Size = UDim2.new(1,-10,0,30); f.BackgroundColor3 = Color3.new(0,0,0); f.BackgroundTransparency = 0.5; Instance.new("UICorner", f)
            local l = Instance.new("TextLabel", f); l.Text = "  Extra "..axis; l.Size = UDim2.new(0.5,0,1,0); l.TextColor3 = Color3.new(1,1,1); l.BackgroundTransparency = 1; l.TextXAlignment = 0
            local t = Instance.new("TextBox", f); t.Size = UDim2.new(0.25,0,0.8,0); t.Position = UDim2.new(0.7,0,0.1,0); t.Text = tostring(tab[axis]); t.BackgroundColor3 = Color3.new(0.1,0.1,0.1); t.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", t)
            t.FocusLost:Connect(function() local v = tonumber(t.Text) if v then tab[axis] = v end end)
        end
    end

    local function addEasyColor(parent)
        local f1 = Instance.new("Frame", parent); f1.Size = UDim2.new(1,-10,0,35); f1.BackgroundColor3 = Color3.new(0,0,0,0.4); Instance.new("UICorner", f1)
        local l1 = Instance.new("TextLabel", f1); l1.Text = "  Transparency (0-1)"; l1.Size = UDim2.new(0.6,0,1,0); l1.TextColor3 = Color3.new(1,1,1); l1.BackgroundTransparency = 1; l1.TextXAlignment = 0
        local t1 = Instance.new("TextBox", f1); t1.Size = UDim2.new(0.2,0,0.7,0); t1.Position = UDim2.new(0.75,0,0.15,0); t1.Text = tostring(CONFIG.HitboxTransparency); t1.BackgroundColor3 = Color3.new(0,0,0); t1.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", t1)
        t1.FocusLost:Connect(function() local v = tonumber(t1.Text) if v then CONFIG.HitboxTransparency = v end end)

        local f2 = Instance.new("Frame", parent); f2.Size = UDim2.new(1,-10,0,60); f2.BackgroundColor3 = Color3.new(0,0,0,0.4); Instance.new("UICorner", f2)
        local l2 = Instance.new("TextLabel", f2); l2.Text = "  Quick Colors:"; l2.Size = UDim2.new(1,0,0,25); l2.TextColor3 = Color3.new(1,1,1); l2.BackgroundTransparency = 1; l2.TextXAlignment = 0
        local colorContainer = Instance.new("Frame", f2); colorContainer.Size = UDim2.new(1,0,0,30); colorContainer.Position = UDim2.new(0,0,0,25); colorContainer.BackgroundTransparency = 1
        local list = Instance.new("UIListLayout", colorContainer); list.FillDirection = Enum.FillDirection.Horizontal; list.Padding = UDim.new(0,8); list.HorizontalAlignment = Enum.HorizontalAlignment.Center

        local function createColorBtn(col)
            local b = Instance.new("TextButton", colorContainer); b.Size = UDim2.new(0,25,0,25); b.Text = ""; b.BackgroundColor3 = col; Instance.new("UICorner", b)
            b.MouseButton1Click:Connect(function() CONFIG.HitboxColor = col end)
        end
        
        createColorBtn(Color3.fromRGB(0,255,255))
        createColorBtn(Color3.fromRGB(255,0,0))
        createColorBtn(Color3.fromRGB(0,255,0))
        createColorBtn(Color3.fromRGB(255,255,0))
        createColorBtn(Color3.fromRGB(255,0,255))
        createColorBtn(Color3.fromRGB(255,255,255))
        createColorBtn(Color3.fromRGB(255,165,0))
    end

    addToggle(dashP, "Hitbox Expander", function(v) CONFIG.HitboxEnabled = v if not v then for _,data in pairs(Hitboxes) do if data.Ghost then data.Ghost:Destroy() end end Hitboxes={} end end)
    addToggle(dashP, "The Real Noclip", function(v) CONFIG.SmartNoclip = v end)
    addEasyColor(dashP)

    addXYZ(normP, SETTINGS.Normal); addXYZ(mainP, SETTINGS.Main); addXYZ(ballP, SETTINGS.Ball); addXYZ(cylP, SETTINGS.Cyl); addXYZ(robuxP, SETTINGS.Robux)
    addXYZ(groupP, SETTINGS.Group)

    RunService.Stepped:Connect(function()
        local char = Player.Character
        if not char then return end
        if CONFIG.SmartNoclip then
            for _, part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
        end
        if not CONFIG.HitboxEnabled then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        if tick() - lastScan > 0.12 then
            lastScan = tick()
            local overlap = OverlapParams.new(); overlap.FilterDescendantsInstances = {char}; overlap.FilterType = Enum.RaycastFilterType.Exclude
            local nearby = Workspace:GetPartBoundsInRadius(root.Position, CONFIG.SafeDistance, overlap)

            for _, obj in ipairs(nearby) do
                if (obj:IsA("BasePart") or obj:IsA("UnionOperation")) and obj.CanCollide and not isOtherPlayer(obj) and isValidTarget(obj) then
                    local target = obj:FindFirstAncestorOfClass("Model") or obj
                    if not Hitboxes[target] and obj.Name ~= "PreciseHitbox" then
                        local size = (target:IsA("Model") and target:GetExtentsSize() or obj.Size)
                        if size.X < 130 and size.Z < 130 then
                            local g = Instance.new("Part"); g.Name = "PreciseHitbox"; g.Anchored = true; g.CanCollide = true; g.Material = Enum.Material.ForceField; g.Parent = Workspace
                            Hitboxes[target] = {Ghost = g, Type = getSettingType(obj)}
                        end
                    end
                end
            end
        end
    end)

    RunService.Heartbeat:Connect(function()
        if not CONFIG.HitboxEnabled then return end
        local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        for target, data in pairs(Hitboxes) do
            local ghost = data.Ghost
            if target and (target:IsA("Model") or target.Parent) then
                local cf, size = (target:IsA("Model") and target:GetBoundingBox()) or (target.CFrame), (target:IsA("Model") and target:GetExtentsSize()) or (target.Size)
                if (cf.Position - root.Position).Magnitude > CONFIG.SafeDistance + 15 then
                    ghost:Destroy(); Hitboxes[target] = nil
                else
                    local s = SETTINGS[data.Type] or SETTINGS.Normal
                    local look = cf:VectorToObjectSpace(Vector3.new(0,1,0))
                    local x,y,z = math.abs(look.X), math.abs(look.Y), math.abs(look.Z)
                    local extra = (y > x and y > z) and Vector3.new(s.X, s.Y, s.Z) or (x > y and x > z) and Vector3.new(s.Y, s.X, s.Z) or Vector3.new(s.X, s.Z, s.Y)
                    ghost.Size = size + extra
                    ghost.CFrame = cf
                    ghost.Transparency = CONFIG.HitboxTransparency
                    ghost.Color = CONFIG.HitboxColor
                end
            else if ghost then ghost:Destroy() end Hitboxes[target] = nil end
        end
    end)
end

--// CEK VALIDASI
local player = game:GetService("Players").LocalPlayer
local status = PandaAuth:Validate(ServerKey, player.UserId, ServiceID)

if status == "Validated" then
    print("Elang Hub: Key Valid!")
    StartScript()
else
    local keyLink = "https://new.pandadevelopment.net/getkey?service=" .. ServiceID
    if setclipboard then setclipboard(keyLink) end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "KEY REQUIRED",
        Text = "Link copied! Paste in Browser.",
        Duration = 10
    })
    warn("Get key at: " .. keyLink)
end
