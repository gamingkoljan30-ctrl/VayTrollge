--[[
    🔥 VAYTROLLGE - ULTIMATE FULL EDITION
    📦 Версия: 31.0.0
    ✅ ВСЕ модули + Надёжный GUI + Nova Bypass + Автопоиск
    ⚙️ Xeno Executor Ready
]]

-- 1. СЛУЖБЫ
local Services = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    HttpService = game:GetService("HttpService"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    VirtualUser = game:GetService("VirtualUser"),
    Workspace = game:GetService("Workspace"),
    Lighting = game:GetService("Lighting"),
    UserInputService = game:GetService("UserInputService"),
    StarterGui = game:GetService("StarterGui"),
    TeleportService = game:GetService("TeleportService"),
    CoreGui = game:GetService("CoreGui"),
    CollectionService = game:GetService("CollectionService"),
    SoundService = game:GetService("SoundService"),
    PhysicsService = game:GetService("PhysicsService"),
    PathfindingService = game:GetService("PathfindingService"),
    ContextActionService = game:GetService("ContextActionService"),
    Chat = game:GetService("Chat"),
    MarketplaceService = game:GetService("MarketplaceService"),
    TextService = game:GetService("TextService"),
    GuiService = game:GetService("GuiService"),
    GroupService = game:GetService("GroupService"),
    LogService = game:GetService("LogService"),
    ScriptContext = game:GetService("ScriptContext")
}

local LocalPlayer = Services.Players.LocalPlayer
local Camera = Services.Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- 2. УТИЛИТЫ
local Utils = {}
function Utils:Notify(title, msg, duration)
    pcall(function()
        Services.StarterGui:SetCore("SendNotification", {
            Title = title or "VayTrollge",
            Text = msg,
            Duration = duration or 3,
            Button1 = "OK"
        })
    end)
end
function Utils:GetRoot()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end
function Utils:GetHumanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("Humanoid")
end
function Utils:Distance(p1, p2) return (p1 - p2).Magnitude end
function Utils:FireTouch(p1, p2) firetouchinterest(p1, p2, 0) firetouchinterest(p1, p2, 1) end
function Utils:FindPlayer(name)
    name = name:lower()
    for _, p in ipairs(Services.Players:GetPlayers()) do
        if p.Name:lower():find(name) then return p end
    end
    return nil
end
function Utils:GetAllTrolls()
    local trolls = {}
    for _, obj in ipairs(Services.Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= LocalPlayer.Character then
            local hum = obj:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                for _, trollName in ipairs(CustomLists.Trolls) do
                    if obj.Name:lower():find(trollName:lower()) then
                        table.insert(trolls, obj)
                        break
                    end
                end
            end
        end
    end
    return trolls
end

-- 3. КАСТОМНЫЕ СПИСКИ (ПОЛНЫЕ)
local CustomLists = {
    Trolls = {
        "MULTIVERSAL WRATH", "Multiversal god:distortion", "Hakari", "Omniversal devour:AU",
        "New god", "True Trollge", "Betrayal Of fear-Betrayal of fear Evolved", "Erlking Ruler",
        "The God Devourer", "The Ultimate One", "Minos Prime", "Fatal Error sonic", "Subject 002",
        "Gojo", "Heian Sukuna", "The God Who Wept", "The voices Chaos", "Water Corruption",
        "Destruction", "Trollge Queen", "Scp-173", "EMPEROR RULER", "Firefly", "1 Year Anniversary",
        "Foxy", "Chica", "Golden Freddy", "Puppet", "Cursed Guardian", "The Maw", "True Weeping God",
        "Cursed Child", "Weeping God", "Voices Love", "Voices Mind", "Voices Reality", "Voices Soul",
        "Voices Time", "Lord Of Darkness", "Lucifer", "Soul Reaper", "Error God", "Trollge",
        "Trollge 2", "Trollge 2.5", "Trollge GF", "True Troll Warrior", "Universe eater"
    },
    Items = {
        "Omniversal chest", "crossover cup", "prime soul", "Scarlet Blessing", "omni warp",
        "CHAOS CORE", "Emperor's crown", "Hyperdeath Soul", "Dark Heart", "Unsanitized Cup of Water",
        "Burning Memories", "Rich", "Black ring", "Hallowen Chest", "Eternal Power", "Void chest"
    },
    BossSummonItems = {
        "Paper", "King's Arm", "Warp Spiral", "Twisted Warp", "CentiWarp",
        "Eyes Beyond Skies", "OmniWarp", "Red Particle Emitter", "Void Essence"
    },
    Chests = {
        "Chest", "Dark Chest", "Light Chest", "Super Dark Chest", "Omniversal Chest", "Scp-096 Chest"
    },
    Cups = {
        "Mystic Cup", "Crossover Cup", "Omniversal Cup", "Void Cup", "Chaos Cup", "Dark Cup", "Light Cup"
    }
}

-- 4. НАСТРОЙКИ
local Settings = {
    Admin = { GiveToAll = false, TargetPlayer = nil, AutoRespawn = true },
    Visual = { ESP = false, Fullbright = false, NoFog = false, FOV = 70, XRay = false, ThirdPerson = false, Freecam = false },
    Combat = { KillAura = false, KillRadius = 100, Aimbot = false, AimbotRadius = 200, TriggerBot = false, SpinBot = false, AntiStun = false },
    Movement = { Fly = false, FlySpeed = 50, Noclip = false, Speed = 50, SpeedEnabled = false, InfJump = false, BHop = false },
    Farm = { AutoFarm = false, AutoFarmRange = 500, AutoCollect = false, AutoCollectRange = 50, ItemVacuum = false, ItemVacuumRange = 100, AutoOpenChests = false, AutoCups = false },
    Utility = { AntiAFK = true, FPSBoost = true, AutoClicker = false }
}

-- 5. ОБХОД NOVA И ПОИСК REMOTE (ПОЛНЫЙ)
local RemoteHunter = {
    Found = {},
    Scan = function()
        RemoteHunter.Found = {}
        -- Метод 1: Прямой поиск по ReplicatedStorage
        for _, v in ipairs(Services.ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                table.insert(RemoteHunter.Found, v)
            end
        end
        -- Метод 2: getgc (память)
        pcall(function()
            for _, v in pairs(getgc(true)) do
                if typeof(v) == "Instance" and (v:IsA("RemoteEvent") or v:IsA("RemoteFunction")) then
                    if not table.find(RemoteHunter.Found, v) then
                        table.insert(RemoteHunter.Found, v)
                    end
                end
            end
        end)
        -- Метод 3: Поиск Nova-объектов
        pcall(function()
            for _, v in pairs(getgc(true)) do
                if typeof(v) == "Instance" and v.Name == "NovaReplicatedStorage" then
                    for _, obj in ipairs(v:GetDescendants()) do
                        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                            if not table.find(RemoteHunter.Found, obj) then
                                table.insert(RemoteHunter.Found, obj)
                            end
                        end
                    end
                end
            end
        end)
        return RemoteHunter.Found
    end,
    SmartFire = function(namePattern, ...)
        local args = {...}
        for _, remote in ipairs(RemoteHunter.Found) do
            if string.find(remote.Name:lower(), namePattern:lower()) then
                pcall(function()
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer(unpack(args))
                    else
                        remote:InvokeServer(unpack(args))
                    end
                end)
                return true
            end
        end
        return false
    end
}

-- 6. АДМИН-МОДУЛЬ (ПОЛНЫЙ)
local Admin = {
    GiveTroll = function(name, target)
        local targetPlayer = target or Settings.Admin.TargetPlayer
        if RemoteHunter:SmartFire("give", name) then return true end
        if RemoteHunter:SmartFire("troll", name) then return true end
        -- Прямое взаимодействие
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") and obj.Parent and obj.Parent.Name:lower():find(name:lower()) then
                fireproximityprompt(obj)
                return true
            end
        end
        return false
    end,
    GiveItem = function(name, target)
        if RemoteHunter:SmartFire("giveitem", name) then return true end
        if RemoteHunter:SmartFire("item", name) then return true end
        local root = Utils:GetRoot()
        if root then
            for _, obj in ipairs(Services.Workspace:GetDescendants()) do
                if obj:IsA("Tool") and obj.Name:lower():find(name:lower()) then
                    local handle = obj:FindFirstChild("Handle")
                    if handle then handle.CFrame = root.CFrame; Utils:FireTouch(root, handle) return true end
                end
            end
        end
        return false
    end,
    GiveAllTrolls = function()
        local count = 0
        for _, troll in ipairs(CustomLists.Trolls) do
            if Settings.Admin.GiveToAll then
                for _, p in ipairs(Services.Players:GetPlayers()) do
                    if p ~= LocalPlayer then Admin:GiveTroll(troll, p.Name) wait(0.05) end
                end
            else
                Admin:GiveTroll(troll)
            end
            count = count + 1
            wait(0.1)
        end
        Utils:Notify("✅", "Выдано " .. count .. " троллей!")
    end,
    GiveAllItems = function()
        local count = 0
        for _, item in ipairs(CustomLists.Items) do
            if Settings.Admin.GiveToAll then
                for _, p in ipairs(Services.Players:GetPlayers()) do
                    if p ~= LocalPlayer then Admin:GiveItem(item, p.Name) wait(0.03) end
                end
            else
                Admin:GiveItem(item)
            end
            count = count + 1
            wait(0.08)
        end
        Utils:Notify("✅", "Выдано " .. count .. " предметов!")
    end,
    SetTarget = function(name)
        if name == "all" then Settings.Admin.GiveToAll = true; Settings.Admin.TargetPlayer = nil
        elseif name == "me" then Settings.Admin.GiveToAll = false; Settings.Admin.TargetPlayer = nil
        else local p = Utils:FindPlayer(name) if p then Settings.Admin.GiveToAll = false; Settings.Admin.TargetPlayer = p.Name end end
    end,
    TeleportToPlayer = function(name)
        local p = Utils:FindPlayer(name)
        if p and p.Character then
            local root = Utils:GetRoot()
            local targetRoot = p.Character:FindFirstChild("HumanoidRootPart")
            if root and targetRoot then root.CFrame = targetRoot.CFrame + Vector3.new(0, 2, 0) return true end
        end
        return false
    end,
    KillAllTrolls = function()
        local count = 0
        for _, troll in ipairs(Utils:GetAllTrolls()) do
            local hum = troll:FindFirstChild("Humanoid")
            if hum then hum.Health = 0; count = count + 1 end
        end
        Utils:Notify("💀", "Убито троллей: " .. count)
    end
}

-- 7. ВИЗУАЛ (ПОЛНЫЙ)
local Visual = {
    ESPObjects = {},
    UpdateESP = function()
        if not Settings.Visual.ESP then return end
        for _, p in ipairs(Services.Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and not Visual.ESPObjects[p] then
                local hl = Instance.new("Highlight")
                hl.FillColor = Color3.fromRGB(255,0,0); hl.FillTransparency = 0.5
                hl.Adornee = p.Character; hl.Parent = p.Character
                Visual.ESPObjects[p] = hl
            end
        end
        for p, obj in pairs(Visual.ESPObjects) do
            if not p.Parent or not p.Character then obj:Destroy(); Visual.ESPObjects[p] = nil end
        end
    end,
    UpdateXRay = function()
        if not Settings.Visual.XRay then return end
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("BasePart") then obj.LocalTransparencyModifier = 0.7 end
        end
    end,
    SetFullbright = function(v)
        Settings.Visual.Fullbright = v
        Services.Lighting.Brightness = v and 2 or 1
        Services.Lighting.FogEnd = v and 100000 or 1000
        Services.Lighting.GlobalShadows = not v
    end,
    SetNoFog = function(v)
        Settings.Visual.NoFog = v
        Services.Lighting.FogEnd = v and 100000 or 1000
    end,
    SetFOV = function(v)
        Settings.Visual.FOV = v
        Camera.FieldOfView = v
    end,
    SetThirdPerson = function(v)
        Settings.Visual.ThirdPerson = v
        LocalPlayer.CameraMode = v and Enum.CameraMode.Classic or Enum.CameraMode.LockFirstPerson
    end,
    SetFreecam = function(v)
        Settings.Visual.Freecam = v
        if v then
            Camera.CameraType = Enum.CameraType.Scriptable
            spawn(function()
                while Settings.Visual.Freecam do
                    wait()
                    local dir = Vector3.zero; local UIS = Services.UserInputService
                    if UIS:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
                    if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
                    if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
                    if UIS:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end
                    if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
                    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end
                    Camera.CFrame = Camera.CFrame + dir * 5
                end
            end)
        else
            Camera.CameraType = Enum.CameraType.Custom
        end
    end
}

-- 8. БОЙ (ПОЛНЫЙ)
local Combat = {
    KillAura = function()
        local root = Utils:GetRoot(); if not root then return end
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                local hum = obj:FindFirstChild("Humanoid"); local hrp = obj:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.Health > 0 and Utils:Distance(root.Position, hrp.Position) <= Settings.Combat.KillRadius then
                    hum.Health = 0
                end
            end
        end
    end,
    Aimbot = function()
        if not Settings.Combat.Aimbot then return end
        local closest, closestDist = nil, Settings.Combat.AimbotRadius
        for _, p in ipairs(Services.Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local head = p.Character:FindFirstChild("Head")
                if head then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if dist < closestDist then closestDist = dist; closest = head end
                    end
                end
            end
        end
        if closest then Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position) end
    end,
    TriggerBot = function()
        if not Settings.Combat.TriggerBot then return end
        local target = Mouse.Target
        if target and target.Parent then
            local hum = target.Parent:FindFirstChild("Humanoid")
            if hum and hum.Parent ~= LocalPlayer.Character then
                Services.VirtualUser:Button1Down(); wait(0.05); Services.VirtualUser:Button1Up()
            end
        end
    end,
    SpinBot = function()
        if not Settings.Combat.SpinBot then return end
        local root = Utils:GetRoot()
        if root then root.CFrame = root.CFrame * CFrame.Angles(0, 0.1, 0) end
    end
}

-- 9. ДВИЖЕНИЕ (ПОЛНЫЙ)
local Movement = {
    Fly = function()
        if not Settings.Movement.Fly then return end
        local root = Utils:GetRoot(); if not root then return end
        local bv = root:FindFirstChild("FlyVel") or Instance.new("BodyVelocity")
        bv.Name = "FlyVel"; bv.MaxForce = Vector3.new(1e5,1e5,1e5); bv.Parent = root
        local bg = root:FindFirstChild("FlyGyro") or Instance.new("BodyGyro")
        bg.Name = "FlyGyro"; bg.CFrame = Camera.CFrame; bg.MaxTorque = Vector3.new(1e5,1e5,1e5); bg.Parent = root
        local dir = Vector3.zero; local UIS = Services.UserInputService
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end
        if dir.Magnitude > 0 then bv.Velocity = dir.Unit * Settings.Movement.FlySpeed end
    end,
    Noclip = function()
        if not Settings.Movement.Noclip then return end
        local char = LocalPlayer.Character
        if char then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
    end,
    BHop = function()
        if not Settings.Movement.BHop then return end
        local hum = Utils:GetHumanoid()
        if hum and hum.FloorMaterial ~= Enum.Material.Air then hum.Jump = true end
    end,
    SetFly = function(v, speed)
        Settings.Movement.Fly = v
        if speed then Settings.Movement.FlySpeed = speed end
        if not v then
            local root = Utils:GetRoot()
            if root then
                local bv = root:FindFirstChild("FlyVel"); if bv then bv:Destroy() end
                local bg = root:FindFirstChild("FlyGyro"); if bg then bg:Destroy() end
            end
        end
    end,
    SetNoclip = function(v) Settings.Movement.Noclip = v end,
    SetSpeed = function(v)
        Settings.Movement.Speed = v; Settings.Movement.SpeedEnabled = true
        local hum = Utils:GetHumanoid()
        if hum then hum.WalkSpeed = v end
    end,
    SetInfJump = function(v)
        Settings.Movement.InfJump = v
        local hum = Utils:GetHumanoid()
        if hum then hum.UseJumpPower = not v end
    end
}

-- 10. ФАРМ (ПОЛНЫЙ)
local Farm = {
    AutoFarm = function()
        local hum = Utils:GetHumanoid(); local root = Utils:GetRoot()
        if not hum or not root then return end
        local closest, closestDist = nil, Settings.Farm.AutoFarmRange
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                local tHum = obj:FindFirstChild("Humanoid"); local tRoot = obj:FindFirstChild("HumanoidRootPart")
                if tHum and tRoot and tHum.Health > 0 then
                    local d = Utils:Distance(root.Position, tRoot.Position)
                    if d < closestDist then closestDist = d; closest = tRoot end
                end
            end
        end
        if closest then hum:MoveTo(closest.Position) end
    end,
    AutoCollect = function()
        local root = Utils:GetRoot(); if not root then return end
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Tool") then
                local handle = obj:FindFirstChild("Handle")
                if handle and Utils:Distance(root.Position, handle.Position) <= Settings.Farm.AutoCollectRange then
                    Utils:FireTouch(root, handle)
                end
            end
        end
    end,
    ItemVacuum = function()
        local root = Utils:GetRoot(); if not root then return end
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Tool") then
                local handle = obj:FindFirstChild("Handle")
                if handle and Utils:Distance(root.Position, handle.Position) <= Settings.Farm.ItemVacuumRange then
                    handle.CFrame = root.CFrame
                end
            end
        end
    end,
    AutoOpenChests = function()
        local root = Utils:GetRoot(); if not root then return end
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            for _, chestName in ipairs(CustomLists.Chests) do
                if obj.Name:lower():find(chestName:lower()) then
                    if obj:IsA("BasePart") and Utils:Distance(root.Position, obj.Position) <= 50 then
                        root.CFrame = obj.CFrame
                        wait(0.2)
                    elseif obj:IsA("Model") then
                        local prompt = obj:FindFirstChild("ProximityPrompt")
                        if prompt then fireproximityprompt(prompt) end
                    end
                end
            end
        end
    end,
    AutoCups = function()
        local char = LocalPlayer.Character
        if not char then return end
        local backpack = LocalPlayer:FindFirstChild("Backpack")
        for _, cupName in ipairs(CustomLists.Cups) do
            local cup = char:FindFirstChild(cupName) or (backpack and backpack:FindFirstChild(cupName))
            if cup then
                cup.Parent = char
                wait(0.2)
                pcall(function() cup:Activate() end)
                break
            end
        end
    end
}

-- 11. ТЕЛЕПОРТЫ (ПОЛНЫЙ)
local Teleports = {
    Locations = { Spawn = Vector3.new(0, 10, 0), Shop = Vector3.new(-50, 15, 100), Arena = Vector3.new(200, 20, 150) },
    ToPlayer = function(name) return Admin:TeleportToPlayer(name) end,
    ToLocation = function(name)
        local pos = Teleports.Locations[name]
        if pos then
            local root = Utils:GetRoot()
            if root then root.CFrame = CFrame.new(pos) return true end
        end
        return false
    end,
    SaveLocation = function(name)
        local root = Utils:GetRoot()
        if root then Teleports.Locations[name] = root.Position; Utils:Notify("📍", name .. " сохранено") return true end
        return false
    end
}

-- 12. УТИЛИТЫ (ПОЛНЫЙ)
local Utility = {
    AntiAFK = function()
        LocalPlayer.Idled:Connect(function()
            if Settings.Utility.AntiAFK then
                Services.VirtualUser:Button2Down(Vector2.new(0,0), Camera.CFrame)
                wait(1)
                Services.VirtualUser:Button2Up(Vector2.new(0,0))
            end
        end)
    end,
    ServerHop = function()
        local success, result = pcall(function()
            return Services.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100"))
        end)
        if success and result and result.data then
            for _, server in ipairs(result.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                    return true
                end
            end
        end
        return false
    end,
    Rejoin = function()
        Services.TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end,
    FPSBoost = function()
        if Settings.Utility.FPSBoost then
            pcall(function()
                settings().Rendering.QualityLevel = 1
                Services.Lighting.GlobalShadows = false
                Services.Lighting.Outlines = false
            end)
        end
    end
}

-- 13. BOSS SUMMONER
local BossSummoner = {
    SummonBoss = function(itemName)
        if not table.find(CustomLists.BossSummonItems, itemName) then return false end
        if Admin:GiveItem(itemName) then
            wait(0.5)
            local char = LocalPlayer.Character
            if char then
                local tool = char:FindFirstChild(itemName) or LocalPlayer.Backpack:FindFirstChild(itemName)
                if tool then tool.Parent = char; wait(0.2); pcall(function() tool:Activate() end) return true end
            end
        end
        return false
    end,
    SummonAllBosses = function()
        for _, item in ipairs(CustomLists.BossSummonItems) do
            BossSummoner:SummonBoss(item)
            wait(2)
        end
    end
}

-- 14. ЦИКЛЫ ОБНОВЛЕНИЯ
spawn(function()
    while true do
        wait(0.5)
        Visual:UpdateESP()
        Visual:UpdateXRay()
        if Settings.Combat.KillAura then Combat:KillAura() end
        if Settings.Combat.Aimbot then Combat:Aimbot() end
        if Settings.Combat.TriggerBot then Combat:TriggerBot() end
        if Settings.Combat.SpinBot then Combat:SpinBot() end
        if Settings.Movement.Fly then Movement:Fly() end
        if Settings.Movement.Noclip then Movement:Noclip() end
        if Settings.Movement.BHop then Movement:BHop() end
        if Settings.Farm.AutoFarm then Farm:AutoFarm() end
        if Settings.Farm.AutoCollect then Farm:AutoCollect() end
        if Settings.Farm.ItemVacuum then Farm:ItemVacuum() end
        if Settings.Farm.AutoOpenChests then Farm:AutoOpenChests() end
        if Settings.Farm.AutoCups then Farm:AutoCups() end
    end
end)

-- 15. ВСТРОЕННЫЙ GUI (ПОЛНЫЙ)
local function CreateGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VayGUI"
    ScreenGui.Parent = Services.CoreGui
    ScreenGui.ResetOnSpawn = false

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 300, 0, 450)
    Main.Position = UDim2.new(0, 10, 0.5, -225)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.BorderSizePixel = 0
    Main.Visible = true
    Main.Parent = ScreenGui

    local TitleBar = Instance.new("TextLabel")
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = Color3.fromRGB(255, 0, 128)
    TitleBar.Text = "🔥 VayTrollge v31 | " .. LocalPlayer.Name
    TitleBar.TextColor3 = Color3.new(1,1,1)
    TitleBar.Font = Enum.Font.GothamBold
    TitleBar.TextSize = 13
    TitleBar.Parent = Main

    local TabHolder = Instance.new("Frame")
    TabHolder.Size = UDim2.new(0, 80, 1, -30)
    TabHolder.Position = UDim2.new(0, 0, 0, 30)
    TabHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabHolder.BorderSizePixel = 0
    TabHolder.Parent = Main

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -80, 1, -30)
    Content.Position = UDim2.new(0, 80, 0, 30)
    Content.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Content.BorderSizePixel = 0
    Content.Parent = Main

    local Tabs = {}
    local CurrentTab = nil

    local function CreateTab(name)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, 0, 0, 30)
        Btn.Position = UDim2.new(0, 0, 0, #Tabs * 30)
        Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Btn.TextColor3 = Color3.new(1,1,1)
        Btn.Text = name
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 11
        Btn.Parent = TabHolder

        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.Visible = false
        Page.BackgroundTransparency = 1
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.ScrollBarThickness = 4
        Page.Parent = Content

        local Tab = {Button = Btn, Page = Page, Y = 10}

        Btn.MouseButton1Click:Connect(function()
            if CurrentTab then
                CurrentTab.Page.Visible = false
                CurrentTab.Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            end
            Page.Visible = true
            Btn.BackgroundColor3 = Color3.fromRGB(255, 0, 128)
            CurrentTab = Tab
        end)

        table.insert(Tabs, Tab)
        if #Tabs == 1 then
            Btn.BackgroundColor3 = Color3.fromRGB(255,0,128)
            Page.Visible = true
            CurrentTab = Tab
        end
        return Tab
    end

    local function AddButton(tab, text, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -20, 0, 28)
        Btn.Position = UDim2.new(0, 10, 0, tab.Y)
        Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Btn.TextColor3 = Color3.new(1,1,1)
        Btn.Text = text
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 11
        Btn.Parent = tab.Page
        Btn.MouseButton1Click:Connect(callback)
        tab.Y = tab.Y + 32
        tab.Page.CanvasSize = UDim2.new(0, 0, 0, tab.Y + 10)
    end

    local function AddToggle(tab, text, default, callback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -20, 0, 28)
        Frame.Position = UDim2.new(0, 10, 0, tab.Y)
        Frame.BackgroundTransparency = 1
        Frame.Parent = tab.Page

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -45, 1, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.new(1,1,1)
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 11
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Frame

        local Switch = Instance.new("TextButton")
        Switch.Size = UDim2.new(0, 40, 0, 20)
        Switch.Position = UDim2.new(1, -40, 0.5, -10)
        Switch.BackgroundColor3 = default and Color3.fromRGB(0,255,128) or Color3.fromRGB(80,80,80)
        Switch.Text = ""
        Switch.Parent = Frame

        local state = default
        Switch.MouseButton1Click:Connect(function()
            state = not state
            Switch.BackgroundColor3 = state and Color3.fromRGB(0,255,128) or Color3.fromRGB(80,80,80)
            callback(state)
        end)

        tab.Y = tab.Y + 32
        tab.Page.CanvasSize = UDim2.new(0, 0, 0, tab.Y + 10)
    end

    -- Создание табов
    local MainTab = CreateTab("🏠")
    local AdminTab = CreateTab("👑")
    local TrollTab = CreateTab("👾")
    local ItemTab = CreateTab("📦")
    local CombatTab = CreateTab("⚔️")
    local VisualTab = CreateTab("👁️")
    local MoveTab = CreateTab("🏃")
    local FarmTab = CreateTab("🌾")
    local TPTab = CreateTab("📍")
    local UtilTab = CreateTab("🔧")

    -- Заполнение
    AddButton(MainTab, "🔄 Респавн", function() LocalPlayer:LoadCharacter() end)
    AddButton(MainTab, "🔍 Сканировать Remote", function()
        local remotes = RemoteHunter:Scan()
        Utils:Notify("🔍", "Найдено: " .. #remotes)
    end)

    AddButton(AdminTab, "🎯 Цель: СЕБЕ", function() Admin:SetTarget("me") end)
    AddButton(AdminTab, "🌐 Цель: ВСЕ", function() Admin:SetTarget("all") end)
    AddButton(AdminTab, "💀 Убить всех троллей", function() Admin:KillAllTrolls() end)

    for _, troll in ipairs(CustomLists.Trolls) do
        AddButton(TrollTab, troll, function() Admin:GiveTroll(troll) end)
    end
    AddButton(TrollTab, "🎁 ВЫДАТЬ ВСЕХ", function() Admin:GiveAllTrolls() end)

    for _, item in ipairs(CustomLists.Items) do
        AddButton(ItemTab, item, function() Admin:GiveItem(item) end)
    end
    AddButton(ItemTab, "🎁 ВЫДАТЬ ВСЕ", function() Admin:GiveAllItems() end)

    AddToggle(CombatTab, "💀 Kill Aura", false, function(v) Settings.Combat.KillAura = v end)
    AddToggle(CombatTab, "🎯 Aimbot", false, function(v) Settings.Combat.Aimbot = v end)
    AddToggle(CombatTab, "🔫 Trigger Bot", false, function(v) Settings.Combat.TriggerBot = v end)
    AddToggle(CombatTab, "🌀 Spinbot", false, function(v) Settings.Combat.SpinBot = v end)

    AddToggle(VisualTab, "👁 ESP", false, function(v) Settings.Visual.ESP = v end)
    AddToggle(VisualTab, "☀ Fullbright", false, function(v) Visual:SetFullbright(v) end)
    AddToggle(VisualTab, "🌫 No Fog", false, function(v) Visual:SetNoFog(v) end)
    AddToggle(VisualTab, "🔍 X-Ray", false, function(v) Settings.Visual.XRay = v end)
    AddToggle(VisualTab, "🎥 Third Person", false, function(v) Visual:SetThirdPerson(v) end)
    AddToggle(VisualTab, "🎥 Freecam", false, function(v) Visual:SetFreecam(v) end)

    AddToggle(MoveTab, "🦅 Fly", false, function(v) Movement:SetFly(v, 50) end)
    AddToggle(MoveTab, "🚶 Noclip", false, function(v) Movement:SetNoclip(v) end)
    AddToggle(MoveTab, "🏃 Speed", false, function(v) Settings.Movement.SpeedEnabled = v; if v then Movement:SetSpeed(50) else local hum = Utils:GetHumanoid(); if hum then hum.WalkSpeed = 16 end end end)
    AddToggle(MoveTab, "🦘 Inf Jump", false, function(v) Movement:SetInfJump(v) end)
    AddToggle(MoveTab, "🏃 BHop", false, function(v) Settings.Movement.BHop = v end)

    AddToggle(FarmTab, "🤖 Auto Farm", false, function(v) Settings.Farm.AutoFarm = v end)
    AddToggle(FarmTab, "📦 Auto Collect", false, function(v) Settings.Farm.AutoCollect = v end)
    AddToggle(FarmTab, "🧲 Item Vacuum", false, function(v) Settings.Farm.ItemVacuum = v end)
    AddToggle(FarmTab, "📦 Auto Chests", false, function(v) Settings.Farm.AutoOpenChests = v end)
    AddToggle(FarmTab, "🥤 Auto Cups", false, function(v) Settings.Farm.AutoCups = v end)

    AddButton(TPTab, "📍 Spawn", function() Teleports:ToLocation("Spawn") end)
    AddButton(TPTab, "📍 Shop", function() Teleports:ToLocation("Shop") end)
    AddButton(TPTab, "💾 Save Location", function() Teleports:SaveLocation("Custom") end)

    AddButton(UtilTab, "🔄 Server Hop", function() Utility:ServerHop() end)
    AddButton(UtilTab, "🚀 Rejoin", function() Utility:Rejoin() end)
    AddToggle(UtilTab, "🛡️ Anti-AFK", true, function(v) Settings.Utility.AntiAFK = v end)
    AddToggle(UtilTab, "⚡ FPS Boost", true, function(v) Settings.Utility.FPSBoost = v; Utility:FPSBoost() end)

    -- Перетаскивание
    local dragging, dragStart, frameStart
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            frameStart = Main.Position
        end
    end)
    TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    Services.UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
        end
    end)

    -- Горячие клавиши
    Services.UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.RightControl or input.KeyCode == Enum.KeyCode.Insert then
            Main.Visible = not Main.Visible
        end
    end)
    LocalPlayer.Chatted:Connect(function(msg)
        if msg == "/vay" or msg == "/menu" then Main.Visible = not Main.Visible end
    end)

    return Main
end

-- 16. ЗАПУСК
RemoteHunter:Scan()
Utility:AntiAFK()
Utility:FPSBoost()
CreateGUI()
Utils:Notify("✅ VayTrollge v31", "Все функции загружены! RightControl / Insert / /vay")
print("VayTrollge v31 готов!")
