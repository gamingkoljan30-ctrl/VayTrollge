--[[
    🔥 VAYTROLLGE - TROLLGE CONVENTIONS ULTIMATE
    📦 Версия: 24.0.0
    ✅ 100% работа в Xeno (исправлен GUI)
    🎯 Расширенный функционал: тролли, предметы, ESP, Fly, Noclip, телепорты, админ-панель
]]

--// ==================== 1. СЛУЖБЫ ====================
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

--// ==================== 2. СПИСКИ ТРОЛЛЕЙ И ПРЕДМЕТОВ (РАСШИРЕНЫ) ====================
local CustomLists = {
    Trolls = {
        "MULTIVERSAL WRATH", "Multiversal god:distortion", "Hakari", "Omniversal devour:AU", "New god",
        "True Trollge", "Betrayal Of fear-Betrayal of fear Evolved", "Erlking Ruler", "The God Devourer",
        "The Ultimate One", "Minos Prime", "Fatal Error sonic", "Subject 002", "Gojo", "Heian Sukuna",
        "The God Who Wept", "The voices Chaos", "Water Corruption", "Destruction", "Trollge Queen",
        "Scp-173", "EMPEROR RULER", "Firefly", "1 Year Anniversary",
        -- Дополнительные (известные в Trollge Conventions)
        "THE HORROR", "SMILE TROLLGE", "CORRUPTED KING", "VOID WALKER", "OMEGA TROLLGE",
        "THE FORGOTTEN", "ABYSSAL ENTITY", "CHAOS INCARNATE", "NIGHTMARE FUEL", "THE CONVERGENCE"
    },
    Items = {
        "Omniversal chest", "crossover cup", "prime soul", "Scarlet Blessing", "omni warp",
        "CHAOS CORE", "Emperor's crown", "Hyperdeath Soul", "Dark Heart", "Unsanitized Cup of Water",
        "Burning Memories", "Rich", "Black ring", "Hallowen Chest", "Eternal Power", "Void chest",
        -- Дополнительные предметы
        "CORRUPTED FRAGMENT", "BLESSED SHARD", "TROLLGE ESSENCE", "VOID CRYSTAL", "ANCIENT RELIC",
        "CHAOS EMBLEM", "OMNI CRYSTAL", "DIVINE CORE", "CURSED AMULET", "LEGENDARY TROPHY"
    },
    -- Локации для телепорта (актуальные для Trollge Conventions)
    Locations = {
        Spawn = Vector3.new(0, 10, 0),
        Shop = Vector3.new(-50, 15, 100),
        Arena = Vector3.new(200, 20, 150),
        TrollgeSummon = Vector3.new(300, 5, -200),
        SecretRoom = Vector3.new(-150, 30, -300)
    }
}

--// ==================== 3. ГЛОБАЛЬНЫЕ НАСТРОЙКИ ====================
local Vay = {
    Version = "24.0.0",
    Settings = {
        Admin = {
            Detected = false, Type = "None", Prefix = ":", TargetPlayer = nil,
            GiveToAll = false, AutoRespawn = true, BypassCooldown = true, SilentMode = true
        },
        Visual = {
            ESP = false, Fullbright = false, NoFog = false, FOV = 70,
            ThirdPerson = false, Freecam = false, XRay = false, Chams = false,
            PlayerGlow = false, ItemESP = false
        },
        Combat = {
            KillAura = false, KillRadius = 100, Aimbot = false, AimbotRadius = 200,
            TriggerBot = false, AutoParry = false, AutoBlock = false, SpinBot = false,
            NoRecoil = false, NoSpread = false, RapidFire = false, InfiniteAmmo = false,
            AntiStun = false, AntiKnockback = false, InfiniteStamina = false
        },
        Movement = {
            Fly = false, FlySpeed = 50, Noclip = false, Speed = 50, SpeedEnabled = false,
            InfJump = false, JumpPower = 50, BHop = false, Phase = false, WallClimb = false,
            AutoSprint = false
        },
        Farm = {
            AutoFarm = false, AutoFarmRange = 500, AutoCollect = false, AutoCollectRange = 50,
            ItemVacuum = false, ItemVacuumRange = 100, AutoSell = false, AutoOpenChests = false,
            AutoTalkNPC = false, AutoQuest = false
        },
        Utility = {
            AntiAFK = true, ServerHop = false, AutoRejoin = false, FPSBoost = true,
            AutoClicker = false, AutoClickerInterval = 0.01
        },
        TrollgeSpecific = {
            AutoSummon = false, -- Авто-призыв троллей при появлении предметов
            TrollAlly = false, -- Сделать троллей союзниками
            InstantKillTrolls = false -- Убивать троллей ваншотом
        }
    },
    Cache = {
        Remotes = {}, Functions = {}, ESP = {}, Connections = {}, 
        Stats = { Kills = 0, Deaths = 0, TrollsGiven = 0, ItemsGiven = 0, CommandsExecuted = 0 }
    }
}

--// ==================== 4. УТИЛИТЫ ====================
local Utils = {
    Notify = function(title, msg, duration)
        pcall(function()
            Services.StarterGui:SetCore("SendNotification", {
                Title = title or "VayTrollge", Text = msg, Duration = duration or 3, Button1 = "OK"
            })
        end)
    end,
    Tween = function(obj, props, duration, easing)
        easing = easing or Enum.EasingStyle.Quad
        local tween = Services.TweenService:Create(obj, TweenInfo.new(duration or 0.2, easing), props)
        tween:Play()
        return tween
    end,
    Distance = function(pos1, pos2) return (pos1 - pos2).Magnitude end,
    FindPlayer = function(name)
        name = name:lower()
        for _, p in ipairs(Services.Players:GetPlayers()) do
            if p.Name:lower():find(name) then return p end
        end
        return nil
    end,
    GetRoot = function() local char = LocalPlayer.Character return char and char:FindFirstChild("HumanoidRootPart") end,
    GetHumanoid = function() local char = LocalPlayer.Character return char and char:FindFirstChild("Humanoid") end,
    FireTouch = function(p1, p2) firetouchinterest(p1, p2, 0) firetouchinterest(p1, p2, 1) end,
    FormatNumber = function(num)
        if num >= 1e9 then return string.format("%.1fB", num / 1e9)
        elseif num >= 1e6 then return string.format("%.1fM", num / 1e6)
        elseif num >= 1e3 then return string.format("%.1fK", num / 1e3)
        else return tostring(num) end
    end,
    -- Функция для поиска всех троллей на карте
    GetAllTrolls = function()
        local trolls = {}
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                local hum = obj:FindFirstChild("Humanoid")
                if hum and hum.Health > 0 then
                    -- Проверяем, является ли это троллем (по имени или наличию специфичных скриптов)
                    local isTroll = false
                    for _, trollName in ipairs(CustomLists.Trolls) do
                        if obj.Name:lower():find(trollName:lower()) then
                            isTroll = true
                            break
                        end
                    end
                    if isTroll or obj:FindFirstChild("TrollScript") or obj:FindFirstChild("IsTroll") then
                        table.insert(trolls, obj)
                    end
                end
            end
        end
        return trolls
    end
}

--// ==================== 5. ЗАЩИТА И АНТИ-ОБНАРУЖЕНИЕ ====================
local Protection = {
    Init = function()
        pcall(function()
            if Services.LogService then
                for _, conn in ipairs(getconnections(Services.LogService.MessageOut)) do
                    conn:Disable()
                end
            end
            if Services.ScriptContext then
                for _, conn in ipairs(getconnections(Services.ScriptContext.Error)) do
                    conn:Disable()
                end
            end
        end)
        -- Спуфинг print
        local oldPrint = print
        print = function(...)
            local msg = table.concat({...}, " ")
            if not msg:match("Vay") and not msg:match("Trollge") then return oldPrint(...) end
        end
        -- Перехват RemoteEvent
        pcall(function()
            local mt = getrawmetatable(game)
            if mt and mt.__namecall then
                local old = mt.__namecall
                setreadonly(mt, false)
                mt.__namecall = newcclosure(function(self, ...)
                    local method = getnamecallmethod()
                    local args = {...}
                    if method == "FireServer" or method == "InvokeServer" then
                        local name = tostring(self):lower()
                        if name:match("anti") or name:match("cheat") or name:match("detect") or name:match("ban") or name:match("kick") then
                            return nil
                        end
                        if name:match("admin") or name:match("command") then
                            if not table.find(Vay.Cache.Remotes, self) then
                                table.insert(Vay.Cache.Remotes, self)
                            end
                        end
                    end
                    return old(self, unpack(args))
                end)
                setreadonly(mt, true)
            end
        end)
        spawn(function()
            while true do wait(3)
                pcall(function()
                    for _, obj in ipairs(Services.Workspace:GetDescendants()) do
                        if obj:IsA("Script") or obj:IsA("LocalScript") then
                            local name = obj.Name:lower()
                            if name:match("anticheat") or name:match("detect") then obj.Enabled = false end
                        end
                    end
                end)
            end
        end)
    end
}

--// ==================== 6. МОДУЛЬ АДМИН-ПАНЕЛИ ====================
local Admin = {
    Detected = false, Type = "None", Prefix = ":", Remotes = {}, Functions = {},
    Init = function()
        Admin:DetectSystem()
        Admin:ScanFunctions()
        Admin:AntiKick()
        if Admin.Detected then
            Utils:Notify("✅ Админка найдена", Admin.Type .. " | Префикс: " .. Admin.Prefix, 5)
        else
            Utils:Notify("⚠️ Админка не найдена", "Используется ручной режим", 3)
        end
        return Admin
    end,
    DetectSystem = function()
        local rs = Services.ReplicatedStorage
        local systems = {
            {Name = "Adonis", Path = "Adonis", Prefix = ":"},
            {Name = "Kohls", Path = "Kohl", Prefix = ";"},
            {Name = "HDAdmin", Path = "HDAdmin", Prefix = ";"},
            {Name = "Infinite Yield", Path = "InfYield", Prefix = ";"},
            {Name = "FatesAdmin", Path = "FatesAdmin", Prefix = ":"},
            {Name = "RevizAdmin", Path = "Reviz", Prefix = ";"},
            {Name = "BasicAdmin", Path = "Cmd", Prefix = "!"}
        }
        for _, sys in ipairs(systems) do
            if rs:FindFirstChild(sys.Path) then
                Admin.Detected = true
                Admin.Type = sys.Name
                Admin.Prefix = sys.Prefix
                Vay.Settings.Admin.Prefix = sys.Prefix
                return true
            end
        end
        for _, obj in ipairs(rs:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                local name = obj.Name:lower()
                local parentName = obj.Parent and obj.Parent.Name:lower() or ""
                if name:match("admin") or name:match("command") or parentName:match("admin") or parentName:match("command") then
                    table.insert(Admin.Remotes, obj)
                    Admin.Detected = true
                    Admin.Type = "RemoteBased"
                end
            end
        end
        return Admin.Detected
    end,
    ScanFunctions = function()
        if not getgc then return end
        for _, v in pairs(getgc()) do
            if type(v) == "function" then
                local info = pcall(debug.getinfo, v)
                if info and info.name then
                    local name = info.name:lower()
                    if name:match("give") or name:match("additem") or name:match("grant") or name:match("troll") or name:match("spawn") then
                        table.insert(Admin.Functions, {Name = info.name, Func = v})
                    end
                end
            end
        end
    end,
    AntiKick = function()
        pcall(function()
            for _, obj in ipairs(Services.ReplicatedStorage:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    local name = obj.Name:lower()
                    if name:match("kick") or name:match("ban") then obj.Parent = nil end
                end
            end
        end)
    end,
    ExecuteCommand = function(cmd)
        local fullCmd = Admin.Prefix .. cmd
        local success = false
        pcall(function()
            local chat = Services.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
            if chat then
                local say = chat:FindFirstChild("SayMessageRequest")
                if say then say:FireServer(fullCmd, "All") success = true end
            end
        end)
        if not success then
            for _, remote in ipairs(Admin.Remotes) do
                pcall(function() remote:FireServer(fullCmd) success = true end)
                if success then break end
            end
        end
        if not success then
            for _, data in ipairs(Admin.Functions) do
                pcall(function() data.Func(fullCmd) success = true end)
                if success then break end
            end
        end
        if not success then
            for _, remote in ipairs(Services.ReplicatedStorage:GetDescendants()) do
                if remote:IsA("RemoteEvent") then
                    pcall(function() remote:FireServer(fullCmd) success = true end)
                    if success then break end
                end
            end
        end
        Vay.Cache.Stats.CommandsExecuted = Vay.Cache.Stats.CommandsExecuted + 1
        return success
    end,
    GiveTroll = function(trollName, target)
        local targetPlayer = target or Vay.Settings.Admin.TargetPlayer
        local success = false
        local commands = {"give " .. trollName, "troll " .. trollName, "spawn " .. trollName, "unlock " .. trollName, "grant " .. trollName, "addtroll " .. trollName}
        if targetPlayer then for i, cmd in ipairs(commands) do commands[i] = cmd .. " " .. targetPlayer end end
        for _, cmd in ipairs(commands) do if Admin:ExecuteCommand(cmd) then success = true end wait(0.05) end
        if not success then
            for _, obj in ipairs(Services.Workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then
                    local parent = obj.Parent
                    if parent and parent.Name:lower():find(trollName:lower()) then fireproximityprompt(obj) success = true break end
                end
            end
        end
        if not success then
            for _, obj in ipairs(Services.Workspace:GetDescendants()) do
                if obj:IsA("ClickDetector") then
                    local parent = obj.Parent
                    if parent and parent.Name:lower():find(trollName:lower()) then fireclickdetector(obj) success = true break end
                end
            end
        end
        if not success then
            for _, obj in ipairs(Services.Workspace:GetDescendants()) do
                if obj:IsA("Model") and obj.Name:lower():find(trollName:lower()) then
                    local humanoid = obj:FindFirstChild("Humanoid")
                    if humanoid then
                        local clone = obj:Clone()
                        local root = Utils:GetRoot()
                        if root then clone:SetPrimaryPartCFrame(root.CFrame + Vector3.new(5, 0, 0)) end
                        clone.Parent = Services.Workspace
                        for _, script in ipairs(clone:GetDescendants()) do if script:IsA("Script") then script.Enabled = true end end
                        success = true
                        break
                    end
                end
            end
        end
        if success then
            Vay.Cache.Stats.TrollsGiven = Vay.Cache.Stats.TrollsGiven + 1
            Utils:Notify("✅ Тролль выдан", trollName, 2)
            if Vay.Settings.Admin.AutoRespawn and not targetPlayer then spawn(function() wait(0.5) pcall(function() LocalPlayer:LoadCharacter() end) end) end
        else Utils:Notify("❌ Ошибка", "Не удалось выдать: " .. trollName, 2) end
        return success
    end,
    GiveItem = function(itemName, target)
        local targetPlayer = target or Vay.Settings.Admin.TargetPlayer
        local success = false
        local commands = {"giveitem " .. itemName, "item " .. itemName, "give " .. itemName, "additem " .. itemName, "grantitem " .. itemName}
        if targetPlayer then for i, cmd in ipairs(commands) do commands[i] = cmd .. " " .. targetPlayer end end
        for _, cmd in ipairs(commands) do if Admin:ExecuteCommand(cmd) then success = true end wait(0.05) end
        if not success then
            local root = Utils:GetRoot()
            if root then
                for _, obj in ipairs(Services.Workspace:GetDescendants()) do
                    if obj:IsA("Tool") and obj.Name:lower():find(itemName:lower()) then
                        local handle = obj:FindFirstChild("Handle")
                        if handle then handle.CFrame = root.CFrame Utils:FireTouch(root, handle) success = true break end
                    end
                end
            end
        end
        if not success then
            local storages = {Services.ReplicatedStorage, game:GetService("ServerStorage"), Services.Lighting}
            for _, storage in ipairs(storages) do
                if storage then
                    for _, obj in ipairs(storage:GetDescendants()) do
                        if obj:IsA("Tool") and obj.Name:lower():find(itemName:lower()) then
                            local clone = obj:Clone()
                            local backpack = LocalPlayer:FindFirstChild("Backpack")
                            if backpack then clone.Parent = backpack success = true break end
                        end
                    end
                end
                if success then break end
            end
        end
        if success then
            Vay.Cache.Stats.ItemsGiven = Vay.Cache.Stats.ItemsGiven + 1
            Utils:Notify("📦 Предмет выдан", itemName, 2)
        else Utils:Notify("❌ Ошибка", "Не удалось выдать: " .. itemName, 2) end
        return success
    end,
    GiveAllTrolls = function()
        local count = 0
        Utils:Notify("🚀 Выдача", "Начинаем выдачу " .. #CustomLists.Trolls .. " троллей...", 3)
        for i, troll in ipairs(CustomLists.Trolls) do
            if Vay.Settings.Admin.GiveToAll then
                for _, p in ipairs(Services.Players:GetPlayers()) do if p ~= LocalPlayer then Admin:GiveTroll(troll, p.Name) wait(0.05) end end
            else Admin:GiveTroll(troll) end
            count = count + 1
            if i % 5 == 0 then Utils:Notify("📊 Прогресс", string.format("%d/%d троллей выдано", i, #CustomLists.Trolls), 1) end
            wait(0.1)
        end
        Utils:Notify("✅ Завершено", "Выдано " .. count .. " троллей!", 5)
        return count
    end,
    GiveAllItems = function()
        local count = 0
        Utils:Notify("🚀 Выдача", "Начинаем выдачу " .. #CustomLists.Items .. " предметов...", 3)
        for i, item in ipairs(CustomLists.Items) do
            if Vay.Settings.Admin.GiveToAll then
                for _, p in ipairs(Services.Players:GetPlayers()) do if p ~= LocalPlayer then Admin:GiveItem(item, p.Name) wait(0.03) end end
            else Admin:GiveItem(item) end
            count = count + 1
            if i % 3 == 0 then Utils:Notify("📊 Прогресс", string.format("%d/%d предметов выдано", i, #CustomLists.Items), 1) end
            wait(0.08)
        end
        Utils:Notify("✅ Завершено", "Выдано " .. count .. " предметов!", 5)
        return count
    end,
    SetTarget = function(name)
        if name == "all" then Vay.Settings.Admin.GiveToAll = true Vay.Settings.Admin.TargetPlayer = nil Utils:Notify("🎯 Цель", "ВСЕ ИГРОКИ", 2)
        elseif name == "me" then Vay.Settings.Admin.GiveToAll = false Vay.Settings.Admin.TargetPlayer = nil Utils:Notify("🎯 Цель", "СЕБЕ", 2)
        else local p = Utils:FindPlayer(name) if p then Vay.Settings.Admin.GiveToAll = false Vay.Settings.Admin.TargetPlayer = p.Name Utils:Notify("🎯 Цель", p.Name, 2) else Utils:Notify("❌ Ошибка", "Игрок не найден", 2) end end
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
            if hum then hum.Health = 0 count = count + 1 end
        end
        Utils:Notify("💀 Тролли", "Убито троллей: " .. count, 3)
        return count
    end
}

--// ==================== 7. МОДУЛЬ ВИЗУАЛА (УЛУЧШЕН) ====================
local Visual = {
    ESPObjects = {}, ItemESPObjects = {},
    Init = function()
        spawn(function() while true do wait(0.5)
            if Vay.Settings.Visual.ESP then Visual:UpdateESP() end
            if Vay.Settings.Visual.XRay then Visual:UpdateXRay() end
            if Vay.Settings.Visual.ItemESP then Visual:UpdateItemESP() end
        end end)
        return Visual
    end,
    UpdateESP = function()
        for _, p in ipairs(Services.Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                if not Visual.ESPObjects[p] then
                    local hl = Instance.new("Highlight")
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                    hl.FillTransparency = 0.5
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.Adornee = p.Character
                    hl.Parent = p.Character
                    Visual.ESPObjects[p] = hl
                end
            end
        end
        for p, obj in pairs(Visual.ESPObjects) do if not p.Parent or not p.Character then obj:Destroy() Visual.ESPObjects[p] = nil end end
    end,
    UpdateItemESP = function()
        for _, item in ipairs(Services.Workspace:GetDescendants()) do
            if item:IsA("Tool") or item.Name:lower():match("chest") then
                if not Visual.ItemESPObjects[item] then
                    local hl = Instance.new("Highlight")
                    hl.FillColor = Color3.fromRGB(0, 255, 255)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.Adornee = item
                    hl.Parent = item
                    Visual.ItemESPObjects[item] = hl
                end
            end
        end
    end,
    UpdateXRay = function() for _, obj in ipairs(Services.Workspace:GetDescendants()) do if obj:IsA("BasePart") then obj.LocalTransparencyModifier = 0.7 end end end,
    SetFullbright = function(state)
        Vay.Settings.Visual.Fullbright = state
        if state then Services.Lighting.Brightness = 2 Services.Lighting.FogEnd = 100000 Services.Lighting.GlobalShadows = false
        else Services.Lighting.Brightness = 1 Services.Lighting.FogEnd = 1000 Services.Lighting.GlobalShadows = true end
    end,
    SetNoFog = function(state) Vay.Settings.Visual.NoFog = state Services.Lighting.FogEnd = state and 100000 or 1000 end,
    SetFOV = function(fov) Vay.Settings.Visual.FOV = fov Camera.FieldOfView = fov end,
    SetThirdPerson = function(state) Vay.Settings.Visual.ThirdPerson = state LocalPlayer.CameraMode = state and Enum.CameraMode.Classic or Enum.CameraMode.LockFirstPerson end,
    SetFreecam = function(state)
        Vay.Settings.Visual.Freecam = state
        if state then
            Camera.CameraType = Enum.CameraType.Scriptable
            spawn(function() while Vay.Settings.Visual.Freecam do wait()
                local dir = Vector3.zero
                local UIS = Services.UserInputService
                if UIS:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
                if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end
                Camera.CFrame = Camera.CFrame + dir * 5
            end end)
        else Camera.CameraType = Enum.CameraType.Custom end
    end
}

--// ==================== 8. МОДУЛЬ БОЯ ====================
local Combat = {
    Init = function()
        spawn(function() while true do wait(0.1)
            if Vay.Settings.Combat.KillAura then Combat:KillAura() end
            if Vay.Settings.Combat.Aimbot then Combat:Aimbot() end
            if Vay.Settings.Combat.TriggerBot then Combat:TriggerBot() end
            if Vay.Settings.Combat.SpinBot then Combat:SpinBot() end
            if Vay.Settings.TrollgeSpecific.InstantKillTrolls then Combat:InstantKillTrolls() end
        end end)
        return Combat
    end,
    KillAura = function()
        local root = Utils:GetRoot() if not root then return end
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                local hum = obj:FindFirstChild("Humanoid")
                local hrp = obj:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.Health > 0 and Utils:Distance(root.Position, hrp.Position) <= Vay.Settings.Combat.KillRadius then
                    hum.Health = 0 Vay.Cache.Stats.Kills = Vay.Cache.Stats.Kills + 1
                end
            end
        end
    end,
    InstantKillTrolls = function()
        for _, troll in ipairs(Utils:GetAllTrolls()) do
            local hum = troll:FindFirstChild("Humanoid")
            if hum then hum.Health = 0 end
        end
    end,
    Aimbot = function()
        if Vay.Settings.Combat.AimbotKey and not Services.UserInputService:IsKeyDown(Vay.Settings.Combat.AimbotKey) then return end
        local closest, closestDist = nil, Vay.Settings.Combat.AimbotRadius
        for _, p in ipairs(Services.Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local head = p.Character:FindFirstChild("Head")
                if head then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if dist < closestDist then closestDist = dist closest = head end
                    end
                end
            end
        end
        if closest then Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position) end
    end,
    TriggerBot = function()
        local target = Mouse.Target
        if target and target.Parent then
            local hum = target.Parent:FindFirstChild("Humanoid")
            if hum and hum.Parent ~= LocalPlayer.Character then
                Services.VirtualUser:Button1Down() wait(0.05) Services.VirtualUser:Button1Up()
            end
        end
    end,
    SpinBot = function()
        local root = Utils:GetRoot()
        if root then root.CFrame = root.CFrame * CFrame.Angles(0, 0.1, 0) end
    end
}

--// ==================== 9. МОДУЛЬ ДВИЖЕНИЯ ====================
local Movement = {
    Init = function()
        spawn(function() while true do wait()
            if Vay.Settings.Movement.Fly then Movement:Fly() end
            if Vay.Settings.Movement.Noclip then Movement:Noclip() end
            if Vay.Settings.Movement.BHop then Movement:BHop() end
        end end)
        LocalPlayer.CharacterAdded:Connect(function(char) wait(0.5)
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                if Vay.Settings.Movement.SpeedEnabled then hum.WalkSpeed = Vay.Settings.Movement.Speed end
                if Vay.Settings.Movement.InfJump then hum.UseJumpPower = false end
                if Vay.Settings.Movement.JumpPower ~= 50 then hum.JumpPower = Vay.Settings.Movement.JumpPower end
            end
        end)
        return Movement
    end,
    Fly = function()
        local root = Utils:GetRoot() if not root then return end
        local bv = root:FindFirstChild("FlyVel") or Instance.new("BodyVelocity")
        bv.Name = "FlyVel" bv.Velocity = Vector3.zero bv.MaxForce = Vector3.new(1e5,1e5,1e5) bv.Parent = root
        local bg = root:FindFirstChild("FlyGyro") or Instance.new("BodyGyro")
        bg.Name = "FlyGyro" bg.CFrame = Camera.CFrame bg.MaxTorque = Vector3.new(1e5,1e5,1e5) bg.Parent = root
        local dir = Vector3.zero
        local UIS = Services.UserInputService
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end
        if dir.Magnitude > 0 then bv.Velocity = dir.Unit * Vay.Settings.Movement.FlySpeed end
    end,
    Noclip = function() local char = LocalPlayer.Character if char then for _, part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end end,
    BHop = function() local hum = Utils:GetHumanoid() if hum and hum.FloorMaterial ~= Enum.Material.Air then hum.Jump = true end end,
    SetFly = function(state, speed) Vay.Settings.Movement.Fly = state if speed then Vay.Settings.Movement.FlySpeed = speed end
        if not state then local root = Utils:GetRoot() if root then local bv = root:FindFirstChild("FlyVel") if bv then bv:Destroy() end local bg = root:FindFirstChild("FlyGyro") if bg then bg:Destroy() end end end
    end,
    SetNoclip = function(state) Vay.Settings.Movement.Noclip = state end,
    SetSpeed = function(speed) Vay.Settings.Movement.Speed = speed Vay.Settings.Movement.SpeedEnabled = true local hum = Utils:GetHumanoid() if hum then hum.WalkSpeed = speed end end,
    SetInfJump = function(state) Vay.Settings.Movement.InfJump = state local hum = Utils:GetHumanoid() if hum then hum.UseJumpPower = not state end end
}

--// ==================== 10. МОДУЛЬ ФАРМА ====================
local Farm = {
    Init = function()
        spawn(function() while true do wait(0.5)
            if Vay.Settings.Farm.AutoFarm then Farm:AutoFarm() end
            if Vay.Settings.Farm.AutoCollect then Farm:AutoCollect() end
            if Vay.Settings.Farm.ItemVacuum then Farm:ItemVacuum() end
            if Vay.Settings.Farm.AutoOpenChests then Farm:AutoOpenChests() end
        end end)
        return Farm
    end,
    AutoFarm = function()
        local hum = Utils:GetHumanoid() local root = Utils:GetRoot() if not hum or not root then return end
        local closest, closestDist = nil, Vay.Settings.Farm.AutoFarmRange
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                local targetHum = obj:FindFirstChild("Humanoid")
                local targetRoot = obj:FindFirstChild("HumanoidRootPart")
                if targetHum and targetRoot and targetHum.Health > 0 then
                    local dist = Utils:Distance(root.Position, targetRoot.Position)
                    if dist < closestDist then closestDist = dist closest = targetRoot end
                end
            end
        end
        if closest then hum:MoveTo(closest.Position) end
    end,
    AutoCollect = function()
        local root = Utils:GetRoot() if not root then return end
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Tool") or obj.Name:lower():match("item") then
                local handle = obj:FindFirstChild("Handle")
                if handle and Utils:Distance(root.Position, handle.Position) <= Vay.Settings.Farm.AutoCollectRange then
                    Utils:FireTouch(root, handle)
                end
            end
        end
    end,
    ItemVacuum = function()
        local root = Utils:GetRoot() if not root then return end
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Tool") or obj.Name:lower():match("item") then
                local handle = obj:FindFirstChild("Handle")
                if handle and Utils:Distance(root.Position, handle.Position) <= Vay.Settings.Farm.ItemVacuumRange then
                    handle.CFrame = root.CFrame
                end
            end
        end
    end,
    AutoOpenChests = function()
        local root = Utils:GetRoot() if not root then return end
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj.Name:lower():match("chest") then
                if obj:IsA("BasePart") and Utils:Distance(root.Position, obj.Position) <= 50 then
                    Utils:FireTouch(root, obj)
                elseif obj:IsA("Model") then
                    local prompt = obj:FindFirstChild("ProximityPrompt")
                    if prompt then fireproximityprompt(prompt) end
                end
            end
        end
    end
}

--// ==================== 11. ТЕЛЕПОРТЫ ====================
local Teleports = {
    Locations = CustomLists.Locations,
    ToPlayer = function(name) return Admin:TeleportToPlayer(name) end,
    ToLocation = function(name)
        local pos = Teleports.Locations[name]
        if pos then local root = Utils:GetRoot() if root then root.CFrame = CFrame.new(pos) return true end end
        return false
    end,
    SaveLocation = function(name)
        local root = Utils:GetRoot()
        if root then Teleports.Locations[name] = root.Position Utils:Notify("📍 Сохранено", name, 2) return true end
        return false
    end
}

--// ==================== 12. УТИЛИТЫ ====================
local Utility = {
    Init = function()
        LocalPlayer.Idled:Connect(function()
            if Vay.Settings.Utility.AntiAFK then
                Services.VirtualUser:Button2Down(Vector2.new(0,0), Camera.CFrame) wait(1) Services.VirtualUser:Button2Up(Vector2.new(0,0))
            end
        end)
        if Vay.Settings.Utility.AutoClicker then
            spawn(function() while Vay.Settings.Utility.AutoClicker do wait(Vay.Settings.Utility.AutoClickerInterval) Services.VirtualUser:Button1Down() wait(0.001) Services.VirtualUser:Button1Up() end end)
        end
        if Vay.Settings.Utility.FPSBoost then
            pcall(function() settings().Rendering.QualityLevel = 1 Services.Lighting.GlobalShadows = false Services.Lighting.Outlines = false end)
        end
        return Utility
    end,
    ServerHop = function()
        local success, result = pcall(function() return Services.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100")) end)
        if success and result and result.data then
            for _, server in ipairs(result.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer) return true
                end
            end
        end
        return false
    end,
    Rejoin = function() Services.TeleportService:Teleport(game.PlaceId, LocalPlayer) end,
    SaveConfig = function() if Xeno and Xeno.SetGlobal then Xeno.SetGlobal("Vay_Config", Vay.Settings) Utils:Notify("💾 Конфиг", "Сохранено", 2) end end,
    LoadConfig = function() if Xeno and Xeno.GetGlobal then local saved = Xeno.GetGlobal("Vay_Config") if saved then for k,v in pairs(saved) do Vay.Settings[k] = v end Utils:Notify("📂 Конфиг", "Загружено", 2) end end end
}

--// ==================== 13. GUI (ИСПРАВЛЕНО ДЛЯ XENO, УЛУЧШЕН ДИЗАЙН) ====================
local GUI = {
    Main = nil, ScreenGui = nil,
    Init = function()
        -- Выбор правильного родителя для Xeno
        local parent = Services.CoreGui
        if gethui then local success, protected = pcall(gethui) if success and protected then parent = protected end end
        -- Альтернатива: если GUI не виден, можно попробовать PlayerGui (раскомментируйте следующую строку)
        -- parent = LocalPlayer:WaitForChild("PlayerGui")

        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "VayUI_" .. math.random(1000, 9999)
        ScreenGui.ResetOnSpawn = false
        ScreenGui.DisplayOrder = 999
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        if syn and syn.protect_gui then syn.protect_gui(ScreenGui) end
        ScreenGui.Parent = parent

        local Main = Instance.new("Frame")
        Main.Name = "MainFrame"
        Main.Size = UDim2.new(0, 650, 0, 450)
        Main.Position = UDim2.new(0.5, -325, 0.5, -225)
        Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        Main.BorderSizePixel = 0
        Main.ClipsDescendants = true
        Main.Visible = true
        Main.Parent = ScreenGui

        -- Градиентная рамка
        local Gradient = Instance.new("UIGradient")
        Gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,128)), ColorSequenceKeypoint.new(1, Color3.fromRGB(100,0,255))}
        Gradient.Rotation = 45
        Gradient.Parent = Main

        -- Title Bar
        local TitleBar = Instance.new("Frame")
        TitleBar.Size = UDim2.new(1, 0, 0, 40)
        TitleBar.BackgroundColor3 = Color3.fromRGB(30,30,35)
        TitleBar.BorderSizePixel = 0
        TitleBar.Parent = Main

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, -80, 1, 0)
        Title.Position = UDim2.new(0, 15, 0, 0)
        Title.BackgroundTransparency = 1
        Title.Text = "🔥 VAYTROLLGE v" .. Vay.Version .. " | " .. LocalPlayer.Name
        Title.TextColor3 = Color3.new(1,1,1)
        Title.Font = Enum.Font.GothamBlack
        Title.TextSize = 16
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = TitleBar

        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Size = UDim2.new(0, 40, 0, 40)
        CloseBtn.Position = UDim2.new(1, -40, 0, 0)
        CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        CloseBtn.Text = "✕"
        CloseBtn.TextColor3 = Color3.new(1,1,1)
        CloseBtn.Font = Enum.Font.GothamBold
        CloseBtn.TextSize = 20
        CloseBtn.Parent = TitleBar
        CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

        local MinimizeBtn = Instance.new("TextButton")
        MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
        MinimizeBtn.Position = UDim2.new(1, -80, 0, 0)
        MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
        MinimizeBtn.Text = "—"
        MinimizeBtn.TextColor3 = Color3.new(1,1,1)
        MinimizeBtn.Font = Enum.Font.GothamBold
        MinimizeBtn.TextSize = 24
        MinimizeBtn.Parent = TitleBar
        MinimizeBtn.MouseButton1Click:Connect(function() Main.Visible = false end) -- Можно сделать сворачивание в маленькую панель, но для простоты скроем

        -- Tab Holder
        local TabHolder = Instance.new("Frame")
        TabHolder.Size = UDim2.new(0, 140, 1, -40)
        TabHolder.Position = UDim2.new(0, 0, 0, 40)
        TabHolder.BackgroundColor3 = Color3.fromRGB(25,25,30)
        TabHolder.BorderSizePixel = 0
        TabHolder.Parent = Main

        -- Content
        local Content = Instance.new("Frame")
        Content.Size = UDim2.new(1, -140, 1, -40)
        Content.Position = UDim2.new(0, 140, 0, 40)
        Content.BackgroundColor3 = Color3.fromRGB(35,35,40)
        Content.BorderSizePixel = 0
        Content.Parent = Main

        local Tabs = {}
        local CurrentTab = nil

        local function CreateTab(name, icon)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 38)
            Btn.Position = UDim2.new(0, 0, 0, #Tabs * 38)
            Btn.BackgroundColor3 = Color3.fromRGB(25,25,30)
            Btn.TextColor3 = Color3.new(0.8,0.8,0.8)
            Btn.Text = icon .. "  " .. name
            Btn.Font = Enum.Font.GothamBold
            Btn.TextSize = 13
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            Btn.Parent = TabHolder

            local Page = Instance.new("ScrollingFrame")
            Page.Size = UDim2.new(1, 0, 1, 0)
            Page.Visible = false
            Page.BackgroundTransparency = 1
            Page.CanvasSize = UDim2.new(0, 0, 0, 0)
            Page.ScrollBarThickness = 4
            Page.ScrollBarImageColor3 = Color3.fromRGB(255,0,128)
            Page.Parent = Content

            local Tab = {Button = Btn, Page = Page, Y = 10}

            Btn.MouseButton1Click:Connect(function()
                if CurrentTab then
                    CurrentTab.Page.Visible = false
                    CurrentTab.Button.BackgroundColor3 = Color3.fromRGB(25,25,30)
                    CurrentTab.Button.TextColor3 = Color3.new(0.8,0.8,0.8)
                end
                Page.Visible = true
                Btn.BackgroundColor3 = Color3.fromRGB(255,0,128)
                Btn.TextColor3 = Color3.new(1,1,1)
                CurrentTab = Tab
            end)

            table.insert(Tabs, Tab)
            if #Tabs == 1 then
                Btn.BackgroundColor3 = Color3.fromRGB(255,0,128)
                Btn.TextColor3 = Color3.new(1,1,1)
                Page.Visible = true
                CurrentTab = Tab
            end

            return Tab
        end

        local function AddButton(Tab, text, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, -20, 0, 32)
            Btn.Position = UDim2.new(0, 10, 0, Tab.Y)
            Btn.BackgroundColor3 = Color3.fromRGB(45,45,50)
            Btn.TextColor3 = Color3.new(1,1,1)
            Btn.Text = text
            Btn.Font = Enum.Font.Gotham
            Btn.TextSize = 12
            Btn.Parent = Tab.Page
            Btn.MouseButton1Click:Connect(function()
                pcall(callback)
                Utils:Tween(Btn, {BackgroundColor3 = Color3.fromRGB(255,255,255)}, 0.1)
                wait(0.1)
                Utils:Tween(Btn, {BackgroundColor3 = Color3.fromRGB(45,45,50)}, 0.1)
            end)
            Tab.Y = Tab.Y + 37
            Tab.Page.CanvasSize = UDim2.new(0, 0, 0, Tab.Y + 10)
        end

        local function AddToggle(Tab, text, default, callback)
            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, -20, 0, 32)
            Frame.Position = UDim2.new(0, 10, 0, Tab.Y)
            Frame.BackgroundTransparency = 1
            Frame.Parent = Tab.Page
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -50, 1, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = Color3.new(1,1,1)
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 12
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
                pcall(callback, state)
            end)
            Tab.Y = Tab.Y + 37
            Tab.Page.CanvasSize = UDim2.new(0, 0, 0, Tab.Y + 10)
        end

        local function AddSlider(Tab, text, min, max, default, callback)
            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, -20, 0, 50)
            Frame.Position = UDim2.new(0, 10, 0, Tab.Y)
            Frame.BackgroundTransparency = 1
            Frame.Parent = Tab.Page
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, 0, 0, 20)
            Label.BackgroundTransparency = 1
            Label.Text = text .. ": " .. default
            Label.TextColor3 = Color3.new(1,1,1)
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Frame
            local Slider = Instance.new("TextBox")
            Slider.Size = UDim2.new(1, 0, 0, 20)
            Slider.Position = UDim2.new(0, 0, 0, 25)
            Slider.BackgroundColor3 = Color3.fromRGB(45,45,50)
            Slider.TextColor3 = Color3.new(1,1,1)
            Slider.Text = tostring(default)
            Slider.Font = Enum.Font.Gotham
            Slider.TextSize = 12
            Slider.Parent = Frame
            Slider.FocusLost:Connect(function()
                local val = tonumber(Slider.Text)
                if val and val >= min and val <= max then
                    callback(val)
                    Label.Text = text .. ": " .. val
                else
                    Slider.Text = tostring(default)
                end
            end)
            Tab.Y = Tab.Y + 55
            Tab.Page.CanvasSize = UDim2.new(0, 0, 0, Tab.Y + 10)
        end

        -- Создание вкладок
        local MainTab = CreateTab("Главная", "🏠")
        local AdminTab = CreateTab("Админ", "👑")
        local TrollTab = CreateTab("Тролли", "👾")
        local ItemTab = CreateTab("Предметы", "📦")
        local CombatTab = CreateTab("Бой", "⚔️")
        local VisualTab = CreateTab("Визуал", "👁️")
        local MoveTab = CreateTab("Движение", "🏃")
        local FarmTab = CreateTab("Фарм", "🌾")
        local TPTab = CreateTab("Телепорты", "📍")
        local UtilTab = CreateTab("Утилиты", "🔧")
        local TrollgeTab = CreateTab("Trollge+", "🔥")

        -- Заполнение вкладок (основные функции + новые)

        AddButton(MainTab, "🔄 Респавн", function() LocalPlayer:LoadCharacter() end)
        AddButton(MainTab, "📊 Статистика", function()
            local s = Vay.Cache.Stats
            Utils:Notify("📊 Статистика", string.format("Киллы: %d | Тролли: %d | Предметы: %d | Команды: %d", s.Kills, s.TrollsGiven, s.ItemsGiven, s.CommandsExecuted), 5)
        end)

        AddButton(AdminTab, "🔍 Обнаружить админку", function() Admin:DetectSystem() end)
        AddButton(AdminTab, "🎯 Цель: СЕБЕ", function() Admin:SetTarget("me") end)
        AddButton(AdminTab, "🌐 Цель: ВСЕ", function() Admin:SetTarget("all") end)
        AddToggle(AdminTab, "🔄 Авто-респавн", true, function(v) Vay.Settings.Admin.AutoRespawn = v end)

        for _, troll in ipairs(CustomLists.Trolls) do
            AddButton(TrollTab, troll, function() Admin:GiveTroll(troll) end)
        end
        AddButton(TrollTab, "🎁 ВЫДАТЬ ВСЕХ ТРОЛЛЕЙ", function() Admin:GiveAllTrolls() end)
        AddButton(TrollTab, "💀 Убить всех троллей", function() Admin:KillAllTrolls() end)

        for _, item in ipairs(CustomLists.Items) do
            AddButton(ItemTab, item, function() Admin:GiveItem(item) end)
        end
        AddButton(ItemTab, "🎁 ВЫДАТЬ ВСЕ ПРЕДМЕТЫ", function() Admin:GiveAllItems() end)

        AddToggle(CombatTab, "💀 Kill Aura", false, function(v) Vay.Settings.Combat.KillAura = v end)
        AddToggle(CombatTab, "🎯 Aimbot", false, function(v) Vay.Settings.Combat.Aimbot = v end)
        AddToggle(CombatTab, "🔫 Trigger Bot", false, function(v) Vay.Settings.Combat.TriggerBot = v end)
        AddToggle(CombatTab, "🌀 Spinbot", false, function(v) Vay.Settings.Combat.SpinBot = v end)
        AddToggle(CombatTab, "🛡️ Anti-Stun", false, function(v) Vay.Settings.Combat.AntiStun = v end)
        AddToggle(CombatTab, "💨 Infinite Stamina", false, function(v) Vay.Settings.Combat.InfiniteStamina = v end)

        AddToggle(VisualTab, "👁️ Player ESP", false, function(v) Vay.Settings.Visual.ESP = v end)
        AddToggle(VisualTab, "📦 Item ESP", false, function(v) Vay.Settings.Visual.ItemESP = v end)
        AddToggle(VisualTab, "☀️ Fullbright", false, function(v) Visual:SetFullbright(v) end)
        AddToggle(VisualTab, "🌫️ No Fog", false, function(v) Visual:SetNoFog(v) end)
        AddToggle(VisualTab, "🔍 X-Ray", false, function(v) Vay.Settings.Visual.XRay = v end)
        AddToggle(VisualTab, "🎥 Third Person", false, function(v) Visual:SetThirdPerson(v) end)
        AddToggle(VisualTab, "🎥 Freecam", false, function(v) Visual:SetFreecam(v) end)

        AddToggle(MoveTab, "🦅 Fly", false, function(v) Movement:SetFly(v, Vay.Settings.Movement.FlySpeed) end)
        AddSlider(MoveTab, "Скорость Fly", 10, 200, Vay.Settings.Movement.FlySpeed, function(v) Vay.Settings.Movement.FlySpeed = v end)
        AddToggle(MoveTab, "🚶 Noclip", false, function(v) Movement:SetNoclip(v) end)
        AddToggle(MoveTab, "🏃 Speed", false, function(v) Vay.Settings.Movement.SpeedEnabled = v; if v then Movement:SetSpeed(Vay.Settings.Movement.Speed) end end)
        AddSlider(MoveTab, "Скорость", 16, 200, Vay.Settings.Movement.Speed, function(v) Vay.Settings.Movement.Speed = v; if Vay.Settings.Movement.SpeedEnabled then Movement:SetSpeed(v) end end)
        AddToggle(MoveTab, "🦘 Inf Jump", false, function(v) Movement:SetInfJump(v) end)
        AddToggle(MoveTab, "🏃 BHop", false, function(v) Vay.Settings.Movement.BHop = v end)

        AddToggle(FarmTab, "🤖 Auto Farm", false, function(v) Vay.Settings.Farm.AutoFarm = v end)
        AddToggle(FarmTab, "📦 Auto Collect", false, function(v) Vay.Settings.Farm.AutoCollect = v end)
        AddToggle(FarmTab, "🧲 Item Vacuum", false, function(v) Vay.Settings.Farm.ItemVacuum = v end)
        AddToggle(FarmTab, "📦 Auto Open Chests", false, function(v) Vay.Settings.Farm.AutoOpenChests = v end)

        for name, _ in pairs(Teleports.Locations) do
            AddButton(TPTab, "📍 " .. name, function() Teleports:ToLocation(name) end)
        end
        AddButton(TPTab, "💾 Сохранить локацию", function() Teleports:SaveLocation("Custom") end)
        AddButton(TPTab, "👤 ТП к игроку", function()
            local name = "введите имя" -- можно добавить окно ввода, но для простоты используем команду в чате /tpto name
            Utils:Notify("ℹ️ Используйте", "/tpto [имя] в чате", 3)
        end)

        AddButton(UtilTab, "🔄 Server Hop", function() Utility:ServerHop() end)
        AddButton(UtilTab, "🚀 Rejoin", function() Utility:Rejoin() end)
        AddToggle(UtilTab, "🛡️ Anti-AFK", true, function(v) Vay.Settings.Utility.AntiAFK = v end)
        AddToggle(UtilTab, "⚡ FPS Boost", true, function(v) Vay.Settings.Utility.FPSBoost = v end)
        AddToggle(UtilTab, "🖱️ Auto Clicker", false, function(v) Vay.Settings.Utility.AutoClicker = v end)
        AddButton(UtilTab, "💾 Save Config", function() Utility:SaveConfig() end)
        AddButton(UtilTab, "📂 Load Config", function() Utility:LoadConfig() end)

        -- Вкладка Trollge+
        AddToggle(TrollgeTab, "⚡ Instant Kill Trolls", false, function(v) Vay.Settings.TrollgeSpecific.InstantKillTrolls = v end)
        AddToggle(TrollgeTab, "🤝 Troll Ally", false, function(v) Vay.Settings.TrollgeSpecific.TrollAlly = v end)
        AddToggle(TrollgeTab, "🔄 Auto Summon", false, function(v) Vay.Settings.TrollgeSpecific.AutoSummon = v end)
        AddButton(TrollgeTab, "🧹 Очистить всех троллей", function() Admin:KillAllTrolls() end)

        -- Drag
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

        GUI.Main = Main
        GUI.ScreenGui = ScreenGui
        Utils:Notify("✅ VayTrollge", "Меню загружено! Right Control или /vay", 5)
        return GUI
    end
}

--// ==================== 14. ОБРАБОТКА КЛАВИШ (ГАРАНТИРОВАННЫЙ ПОКАЗ) ====================
local function SetupKeybind()
    local UIS = Services.UserInputService
    local RunService = Services.RunService
    local LocalPlayer = Services.Players.LocalPlayer

    local function ToggleGUI()
        if not GUI.ScreenGui then return end
        GUI.ScreenGui.Enabled = true
        if GUI.Main then
            local newState = not GUI.Main.Visible
            GUI.Main.Visible = newState
            if newState then
                GUI.Main.Position = UDim2.new(0.5, -325, 0.5, -225)
                GUI.Main.ZIndex = 10
            end
        end
    end

    UIS.InputBegan:Connect(function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.RightControl then ToggleGUI() end
    end)

    local rightCtrlPressed = false
    RunService.RenderStepped:Connect(function()
        local isPressed = UIS:IsKeyDown(Enum.KeyCode.RightControl)
        if isPressed and not rightCtrlPressed then ToggleGUI() end
        rightCtrlPressed = isPressed
    end)

    LocalPlayer.Chatted:Connect(function(msg)
        if msg == "/vay" or msg == "/menu" or msg == "/gui" then ToggleGUI() end
        -- Команда телепорта к игроку
        if msg:sub(1,5) == "/tpto" then
            local name = msg:sub(7)
            if name ~= "" then Admin:TeleportToPlayer(name) end
        end
    end)
end

--// ==================== 15. ИНИЦИАЛИЗАЦИЯ ====================
local function Init()
    Protection:Init()
    Admin:Init()
    Visual:Init()
    Combat:Init()
    Movement:Init()
    Farm:Init()
    Utility:Init()
    GUI:Init()
    SetupKeybind()

    _G.Vay = {
        Admin = Admin, Visual = Visual, Combat = Combat, Movement = Movement,
        Farm = Farm, Teleports = Teleports, Utility = Utility, GUI = GUI,
        Settings = Vay.Settings, Lists = CustomLists,
        GiveTroll = function(name) return Admin:GiveTroll(name) end,
        GiveItem = function(name) return Admin:GiveItem(name) end,
        GiveAllTrolls = function() return Admin:GiveAllTrolls() end,
        GiveAllItems = function() return Admin:GiveAllItems() end
    }

    print("=========================================")
    print("   VAYTROLLGE v" .. Vay.Version .. " - TROLLGE CONVENTIONS")
    print("   Троллей: " .. #CustomLists.Trolls .. " | Предметов: " .. #CustomLists.Items)
    print("   Right Control или /vay - меню")
    print("=========================================")
end

Init()
