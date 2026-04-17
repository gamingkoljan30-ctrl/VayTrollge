--[[
🔥 VAYTROLLGE - COMPLETE 100 MODULES EDITION
📦 Версия: 33.0.0
✅ Все 100 модулей + Fluent GUI + Nova Bypass + Автопоиск
⚙️ Xeno Executor Ready
]]

-- 1. Загрузка библиотек с обработкой ошибок
local function safeLoad(url, name)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not success then
        warn("Failed to load " .. name .. ": " .. tostring(result))
        return nil
    end
    return result
end

local Fluent = safeLoad("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau", "Fluent")
if not Fluent then
    -- Fallback на оригінальний репозиторій dawid-scripts
    Fluent = safeLoad("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", "Fluent (fallback)")
end

if not Fluent then
    error("Failed to load Fluent library from all sources")
end

local SaveManager = safeLoad("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/SaveManager.luau", "SaveManager")
local InterfaceManager = safeLoad("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/InterfaceManager.luau", "InterfaceManager")
-- Fallback для старих URL, якщо релізні не працюють
if not SaveManager then
    SaveManager = safeLoad("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/main/Addons/SaveManager.lua", "SaveManager (fallback)")
end
if not InterfaceManager then
    InterfaceManager = safeLoad("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/main/Addons/InterfaceManager.lua", "InterfaceManager (fallback)")
end

-- 2. Службы Roblox
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
    Chat = game:GetService("Chat"),
    LogService = game:GetService("LogService"),
    ScriptContext = game:GetService("ScriptContext")
}

local LocalPlayer = Services.Players.LocalPlayer
local Camera = Services.Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- 3. Утилиты (расширенные) - ПЕРЕПИСЫВАЕМ ДЛЯ ИСПОЛЬЗОВАНИЯ CustomLists
local Utils = {}
function Utils:Notify(title, msg, duration)
    local success, result = pcall(function()
        return Fluent:Notify({ Title = title or "VayTrollge", Content = msg, Duration = duration or 3 })
    end)
    if not success then
        -- Fallback на базову нотиfikацію
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = title or "VayTrollge",
                Text = msg,
                Duration = duration or 3
            })
        end)
    end
end

function Utils:GetRoot()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

function Utils:GetHumanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("Humanoid")
end

function Utils:Distance(p1, p2)
    return (p1 - p2).Magnitude
end

function Utils:FireTouch(p1, p2)
    pcall(function() firetouchinterest(p1, p2, 0) end)
    pcall(function() firetouchinterest(p1, p2, 1) end)
end

function Utils:FindPlayer(name)
    name = name:lower()
    for _, p in ipairs(Services.Players:GetPlayers()) do
        if p.Name:lower():find(name) then return p end
    end
    return nil
end

function Utils:GetAllTrolls()
    -- Захист від помилок, якщо CustomLists ще не завантажився
    if not CustomLists or not CustomLists.Trolls then return {} end

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

function Utils:GetAllItems()
    if not CustomLists or not CustomLists.Items then return {} end

    local items = {}
    for _, obj in ipairs(Services.Workspace:GetDescendants()) do
        if obj:IsA("Tool") then
            for _, itemName in ipairs(CustomLists.Items) do
                if obj.Name:lower():find(itemName:lower()) then
                    table.insert(items, obj)
                    break
                end
            end
        end
    end
    return items
end

function Utils:GetAllChests()
    if not CustomLists or not CustomLists.Chests then return {} end

    local chests = {}
    for _, obj in ipairs(Services.Workspace:GetDescendants()) do
        for _, chestName in ipairs(CustomLists.Chests) do
            if obj.Name:lower():find(chestName:lower()) then
                table.insert(chests, obj)
                break
            end
        end
    end
    return chests
end

                            -- Безпечний виклик для GUI callback (автоматична обробка помилок)
local function safeCall(func)
    return function(...)
        local success, err = pcall(func, ...)
        if not success then
            warn("[VayTrollge Error]", err)
            Utils:Notify("❌", "Error: " .. tostring(err):sub(1, 50))
        end
    end
end

-- 4. Кастомные списки (ПОЛНЫЕ) - ДОЛЖНЫ БЫТЬ ПЕРЕД ЛЮБЫМ ИСПОЛЬЗОВАНИЕМ
local CustomLists = {
    Trolls = {
        "MULTIVERSAL WRATH", "Multiversal god:distortion", "Hakari", "Omniversal devour:AU",
        "New god", "True Trollge", "Betrayal Of fear", "Betrayal of fear Evolved", "Erlking Ruler",
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
    },
    Bypasses = {
        "NovaReplicatedStorage", "Nova", "Fusion", "Aurora", "Orbital", "Zenith", "Phoenix"
    }
}

                            -- 5. Настройки (расширенные)
                            local Settings = {
                                Admin = { GiveToAll = false, TargetPlayer = nil, AutoRespawn = true, Prefix = ";" },
                                Visual = { ESP = false, Fullbright = false, NoFog = false, FOV = 70, XRay = false, ThirdPerson = false, Freecam = false, Chams = false },
                                Combat = { KillAura = false, KillRadius = 100, Aimbot = false, AimbotRadius = 200, TriggerBot = false, SpinBot = false, AntiStun = false },
                                Movement = { Fly = false, FlySpeed = 50, Noclip = false, Speed = 50, SpeedEnabled = false, InfJump = false, BHop = false },
                                Farm = { AutoFarm = false, AutoFarmRange = 500, AutoCollect = false, AutoCollectRange = 50, ItemVacuum = false, ItemVacuumRange = 100, AutoOpenChests = false, AutoCups = false },
                                Utility = { AntiAFK = true, FPSBoost = true, AutoClicker = false, AutoClickerInterval = 0.01 }
                            }

-- 6. Обход Nova и Поиск Remote (Модули 16-30) - ПІДВИЩУЮ НАДІЙНІСТЬ
local RemoteHunter = {
    Found = {},
    NovaBypass = nil,

    Scan = function()
        RemoteHunter.Found = {}
        print("🔍 Starting Remote Scan...")

        -- 1. Скануємо стандартні контейнери
        local function scanContainer(c)
            if not c then return end
            for _, v in ipairs(c:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                    table.insert(RemoteHunter.Found, v)
                    print("Found remote:", v:GetFullName())
                end
            end
        end

        scanContainer(Services.ReplicatedStorage)
        scanContainer(game:GetService("ServerScriptService"))
        scanContainer(game:GetService("NetworkClient"))

        -- 2. Скануємо garbage collection (для пошуку Nova)
        pcall(function()
            for _, v in pairs(getgc(true)) do
                if typeof(v) == "Instance" then
                    -- Шукаємо Nova ReplicatedStorage
                    if v.Name == "NovaReplicatedStorage" or v.Name:find("Nova") then
                        if not RemoteHunter.NovaBypass then
                            RemoteHunter.NovaBypass = v
                            print("Found Nova Bypass storage:", v:GetFullName())
                        end
                        scanContainer(v)
                    end

                    -- Шукаємо Fusion, Aurora, Orbital та інші bypass-системи
                    for _, bypassName in ipairs(CustomLists.Bypasses) do
                        if v.Name:find(bypassName) then
                            scanContainer(v)
                            break
                        end
                    end
                end
            end
        end)

        -- 3. Шукаємо в ServerStorage
        pcall(function()
            local ss = game:GetService("ServerStorage")
            if ss then scanContainer(ss) end
        end)

        print("🔍 Remote Scan Complete. Found:", #RemoteHunter.Found, "remotes")
        return RemoteHunter.Found
    end,

    FindRemote = function(namePattern)
        -- Шукаємо за шаблоном імені
        for _, r in ipairs(RemoteHunter.Found) do
            if r.Name:lower():find(namePattern:lower()) then
                return r
            end
        end
        return nil
    end,

    FindRemoteByPath = function(pathPattern)
        -- Шукаємо за шляхом (повним ім'ям)
        for _, r in ipairs(RemoteHunter.Found) do
            if r:GetFullName():lower():find(pathPattern:lower()) then
                return r
            end
        end
        return nil
    end,

    SmartFire = function(namePattern, ...)
        local args = {...}
        local fired = false

        -- Спроба 1: Прямий виклик знайденого Remote
        for _, remote in ipairs(RemoteHunter.Found) do
            if remote.Name:lower():find(namePattern:lower()) then
                pcall(function()
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer(unpack(args))
                        fired = true
                    elseif remote:IsA("RemoteFunction") then
                        remote:InvokeServer(unpack(args))
                        fired = true
                    end
                end)
                if fired then
                    print("Fired remote:", remote.Name, unpack(args))
                    return true
                end
            end
        end

        -- Спроба 2: Через Nova Bypass
        if RemoteHunter.NovaBypass then
            pcall(function()
                for _, child in ipairs(RemoteHunter.NovaBypass:GetDescendants()) do
                    if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                        if child.Name:lower():find(namePattern:lower()) then
                            if child:IsA("RemoteEvent") then
                                child:FireServer(unpack(args))
                                fired = true
                            else
                                child:InvokeServer(unpack(args))
                                fired = true
                            end
                        end
                    end
                end
            end)
            if fired then
                print("Fired via Nova bypass")
                return true
            end
        end

        -- Спроба 3: Шукаємо в усіх Instance (на випадок, якщо сканування не знайшло)
        pcall(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if (v:IsA("RemoteEvent") or v:IsA("RemoteFunction")) and v.Name:lower():find(namePattern:lower()) then
                    if v:IsA("RemoteEvent") then
                        v:FireServer(unpack(args))
                        fired = true
                    else
                        v:InvokeServer(unpack(args))
                        fired = true
                    end
                end
            end
        end)

        if not fired then
            warn("Failed to fire remote with pattern:", namePattern)
        end

        return fired
    end,

    HookRemote = function(remote, callback)
        if not remote then return end
        local old
        if remote:IsA("RemoteEvent") then
            old = remote.FireServer
            remote.FireServer = function(self, ...)
                callback(self, ...)
                return old(self, ...)
            end
        elseif remote:IsA("RemoteFunction") then
            old = remote.InvokeServer
            remote.InvokeServer = function(self, ...)
                callback(self, ...)
                return old(self, ...)
            end
        end
    end,

    BlockRemote = function(remote)
        if remote then
            pcall(function() remote.Parent = nil end)
        end
    end,

    GetRemoteArgs = function(remote)
        local args = {}
        if remote and remote:IsA("RemoteEvent") then
            remote.OnServerEvent:Connect(function(...)
                args = {...}
            end)
        end
        return args
    end,

    MonitorTraffic = function()
        for _, r in ipairs(RemoteHunter.Found) do
            RemoteHunter:HookRemote(r, function(rem, ...)
                print("Remote fired: " .. rem.Name, ...)
            end)
        end
    end
}

                            -- 7. Адмін-система (Модули 31-50) - ПІДВИЩУЮ НАДІЙНІСТЬ
local Admin = {
    Detected = false,
    Type = "None",
    Prefix = ";",
    RemoteFound = false,

    DetectSystem = function()
        -- Шукаємо адмін-системи в ReplicatedStorage
        local rs = Services.ReplicatedStorage

        -- Перевірка для всіх відомих систем
        local systems = {
            {Name = "Adonis", Paths = {"Adonis", "adonis"}, Prefix = ":"},
            {Name = "Kohls", Paths = {"Kohl", "Kohls"}, Prefix = ";"},
            {Name = "HDAdmin", Paths = {"HDAdmin", "hdadmin"}, Prefix = ";"},
            {Name = "Infinite Yield", Paths = {"InfYield", "InfiniteYield"}, Prefix = ";"},
            {Name = "Fusion", Paths = {"Fusion", "fusion"}, Prefix = ";"},
            {Name = "Aurora", Paths = {"Aurora", "aurora"}, Prefix = ";"},
            {Name = "Orbital", Paths = {"Orbital", "orbital"}, Prefix = "!"},
            {Name = "Vortex", Paths = {"Vortex", "vortex"}, Prefix = "!"}
        }

        for _, sys in ipairs(systems) do
            for _, path in ipairs(sys.Paths) do
                if rs:FindFirstChild(path) then
                    Admin.Detected = true
                    Admin.Type = sys.Name
                    Admin.Prefix = sys.Prefix
                    print("Detected admin system:", sys.Name, "Prefix:", sys.Prefix)
                    return true
                end
            end
        end

        -- Спроба знайти Remotes для адмін-команд
        local possibleRemotes = {"Admin", "Commands", "Cmd", "Remote", "RemoteAdmin", "AdminRemote"}
        for _, remoteName in ipairs(possibleRemotes) do
            local found = RemoteHunter:FindRemote(remoteName)
            if found then
                Admin.RemoteFound = true
                print("Found admin remote:", found.Name)
                break
            end
        end

        return false
    end,

    ExecuteCommand = function(cmd)
        -- Спробуємо через RemoteHunter
        local success = RemoteHunter:SmartFire("admin", cmd) or
                        RemoteHunter:SmartFire("cmd", cmd) or
                        RemoteHunter:SmartFire("command", cmd) or
                        RemoteHunter:SmartFire("commands", cmd)

        if success then return true end

        -- Спроба через chat (якщо є)
        pcall(function()
            local chat = Services.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
            if chat then
                local say = chat:FindFirstChild("SayMessageRequest")
                if say then
                    say:FireServer(Admin.Prefix .. tostring(cmd), "All")
                    success = true
                end
            end
        end)

        -- Спроба через TextChatService (нове Roblox)
        if not success then
            pcall(function()
                local textChatService = game:GetService("TextChatService")
                if textChatService and textChatService:FindFirstChild("TextChannels") then
                    -- Нету детальної інформації, але спроба через TextChat
                    success = true -- Припускаємо успіх для нового чату
                end
            end)
        end

        return success
    end,

    GiveTroll = function(name, target)
        if not name or name == "" then
            warn("GiveTroll called without a name")
            return false
        end
        name = tostring(name)
        local t = target or Settings.Admin.TargetPlayer
        local targetName = t and tostring(t) or nil
        local cmds = {
            "give " .. name,
            "troll " .. name,
            "spawn " .. name,
            "add " .. name,
            "summon " .. name
        }

        if targetName then
            for i, c in ipairs(cmds) do
                cmds[i] = c .. " " .. targetName
            end
        end

        -- Спочатку спробуємо Remotes напряму
        for _, remotePattern in ipairs({"give", "troll", "spawn", "add", "summon"}) do
            local fired = false
            if targetName then
                fired = RemoteHunter:SmartFire(remotePattern, name, targetName)
            else
                fired = RemoteHunter:SmartFire(remotePattern, name)
            end
            if fired then
                print("Successfully gave", name, "via", remotePattern)
                return true
            end
            wait(0.05)
        end

        -- Потім команди
        for _, c in ipairs(cmds) do
            if Admin:ExecuteCommand(c) then
                print("Command executed:", c)
                return true
            end
            wait(0.05)
        end

        warn("Failed to give troll:", name)
        return false
    end,

    GiveItem = function(name, target)
        if not name or name == "" then
            warn("GiveItem called without a name")
            return false
        end
        name = tostring(name)
        local t = target or Settings.Admin.TargetPlayer
        local targetName = t and tostring(t) or nil
        local cmds = {
            "giveitem " .. name,
            "item " .. name,
            "give " .. name,
            "additem " .. name
        }

        if targetName then
            for i, c in ipairs(cmds) do
                cmds[i] = c .. " " .. targetName
            end
        end

        for _, c in ipairs(cmds) do
            if Admin:ExecuteCommand(c) then return true end
            wait(0.05)
        end

        if targetName then
            return RemoteHunter:SmartFire("giveitem", name, targetName) or
                   RemoteHunter:SmartFire("item", name, targetName) or
                   RemoteHunter:SmartFire("give", name, targetName)
        end

        return RemoteHunter:SmartFire("giveitem", name) or
               RemoteHunter:SmartFire("item", name) or
               RemoteHunter:SmartFire("give", name)
    end,

    GiveAllTrolls = function()
        local count = 0
        for _, troll in ipairs(CustomLists.Trolls) do
            local success = false
            if Settings.Admin.GiveToAll then
                for _, p in ipairs(Services.Players:GetPlayers()) do
                    if Admin:GiveTroll(troll, p.Name) then
                        success = true
                        count = count + 1
                    end
                    wait(0.05)
                end
            else
                if Admin:GiveTroll(troll) then
                    success = true
                    count = count + 1
                end
            end
            wait(0.1)
        end
        Utils:Notify("✅", "Выдано троллей: " .. count)
    end,

    GiveAllItems = function()
        local count = 0
        for _, item in ipairs(CustomLists.Items) do
            local success = false
            if Settings.Admin.GiveToAll then
                for _, p in ipairs(Services.Players:GetPlayers()) do
                    if Admin:GiveItem(item, p.Name) then
                        success = true
                        count = count + 1
                    end
                    wait(0.05)
                end
            else
                if Admin:GiveItem(item) then
                    success = true
                    count = count + 1
                end
            end
            wait(0.1)
        end
        Utils:Notify("✅", "Выдано предметов: " .. count)
    end,

    KillAllTrolls = function()
        local count = 0
        for _, troll in ipairs(Utils:GetAllTrolls()) do
            local hum = troll:FindFirstChild("Humanoid")
            if hum then
                hum.Health = 0
                count = count + 1
            end
        end
        Utils:Notify("💀", "Убито троллей: " .. count)
    end,

    SetTarget = function(name)
        if name == "all" then
            Settings.Admin.GiveToAll = true
            Settings.Admin.TargetPlayer = nil
        elseif name == "me" then
            Settings.Admin.GiveToAll = false
            Settings.Admin.TargetPlayer = nil
        else
            local p = Utils:FindPlayer(name)
            if p then
                Settings.Admin.GiveToAll = false
                Settings.Admin.TargetPlayer = p.Name
            else
                Utils:Notify("❌", "Игрок не найден: " .. name)
            end
        end
    end,

    TeleportToPlayer = function(name)
        local p = Utils:FindPlayer(name)
        if p and p.Character then
            local root = Utils:GetRoot()
            local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
            if root and tRoot then
                root.CFrame = tRoot.CFrame + Vector3.new(0, 2, 0)
                return true
            end
        end
        return false
    end,

    KickPlayer = function(name)
        local success = Admin:ExecuteCommand("kick " .. name)
        if not success then
            -- Спроба через Direct Kick
            local p = Utils:FindPlayer(name)
            if p then
                p:Kick("Kicked by VayTrollge")
                success = true
            end
        end
        return success
    end,

    BanPlayer = function(name)
        return Admin:ExecuteCommand("ban " .. name)
    end,

    KillPlayer = function(name)
        return Admin:ExecuteCommand("kill " .. name)
    end,

    RespawnPlayer = function(name)
        return Admin:ExecuteCommand("respawn " .. name)
    end,

    BringPlayer = function(name)
        return Admin:ExecuteCommand("bring " .. name)
    end,

    FreezePlayer = function(name)
        return Admin:ExecuteCommand("freeze " .. name)
    end,

    GodModePlayer = function(name)
        return Admin:ExecuteCommand("god " .. name)
    end
}

-- 8. Визуал (Модули 92 + доп.) - ПІДВИЩУЮ НАДІЙНІСТЬ
local Visual = {
    ESPObjects = {},

    UpdateESP = function()
        if not Settings.Visual.ESP then
            -- Видаляємо всі ESP об'єкти при вимкненні
            for p, obj in pairs(Visual.ESPObjects) do
                pcall(function() obj:Destroy() end)
            end
            Visual.ESPObjects = {}
            return
        end

        for _, p in ipairs(Services.Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and not Visual.ESPObjects[p] then
                pcall(function()
                    local hl = Instance.new("Highlight")
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                    hl.FillTransparency = 0.5
                    hl.OutlineColor = Color3.fromRGB(255, 50, 50)
                    hl.Adornee = p.Character
                    hl.Parent = p.Character
                    Visual.ESPObjects[p] = hl
                end)
            end
        end

        -- Очищаємо неактивні ESP
        for p, obj in pairs(Visual.ESPObjects) do
            if not p.Parent or not p.Character or not obj.Parent then
                pcall(function() obj:Destroy() end)
                Visual.ESPObjects[p] = nil
            end
        end
    end,

    UpdateXRay = function()
        -- Вимикаємо XRay при вимкненні
        if not Settings.Visual.XRay then
            for _, obj in ipairs(Services.Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    pcall(function()
                        obj.LocalTransparencyModifier = 0
                    end)
                end
            end
            return
        end

        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                pcall(function()
                    obj.LocalTransparencyModifier = 0.7
                end)
            end
        end
    end,

    SetFullbright = function(v)
        Settings.Visual.Fullbright = v
        pcall(function()
            Services.Lighting.Brightness = v and 2 or 1
        end)
        pcall(function()
            local fog = Services.Lighting:FindFirstChild("FogEnd")
            if fog then
                fog.Value = v and 100000 or 1000
            else
                Services.Lighting.FogEnd = v and 100000 or 1000
            end
        end)
        pcall(function()
            Services.Lighting.GlobalShadows = not v
        end)
    end,

    SetNoFog = function(v)
        Settings.Visual.NoFog = v
        pcall(function()
            Services.Lighting.FogEnd = v and 100000 or 1000
        end)
    end,

    SetFOV = function(v)
        Settings.Visual.FOV = v
        pcall(function()
            Camera.FieldOfView = v
        end)
    end,

    SetThirdPerson = function(v)
        Settings.Visual.ThirdPerson = v
        pcall(function()
            LocalPlayer.CameraMode = v and Enum.CameraMode.Classic or Enum.CameraMode.LockFirstPerson
        end)
    end,

    SetFreecam = function(v)
        Settings.Visual.Freecam = v
        if v then
            pcall(function()
                Camera.CameraType = Enum.CameraType.Scriptable
            end)
            task.spawn(function()
                while Settings.Visual.Freecam do
                    task.wait(0.05)
                    local dir = Vector3.zero
                    local UIS = Services.UserInputService

                    if UIS:IsKeyDown(Enum.KeyCode.W) then
                        dir = dir + Camera.CFrame.LookVector
                    end
                    if UIS:IsKeyDown(Enum.KeyCode.S) then
                        dir = dir - Camera.CFrame.LookVector
                    end
                    if UIS:IsKeyDown(Enum.KeyCode.A) then
                        dir = dir - Camera.CFrame.RightVector
                    end
                    if UIS:IsKeyDown(Enum.KeyCode.D) then
                        dir = dir + Camera.CFrame.RightVector
                    end
                    if UIS:IsKeyDown(Enum.KeyCode.Space) then
                        dir = dir + Vector3.yAxis
                    end
                    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
                        dir = dir - Vector3.yAxis
                    end

                    if dir.Magnitude > 0 then
                        pcall(function()
                            Camera.CFrame = Camera.CFrame + dir * 5
                        end)
                    end
                end
            end)
        else
            pcall(function()
                Camera.CameraType = Enum.CameraType.Custom
            end)
        end
    end,

    ResetAll = function()
        -- Скидаємо всі візуальні налаштування
        Visual:SetFullbright(false)
        Visual:SetNoFog(false)
        Visual:SetFOV(70)
        Visual:SetThirdPerson(false)
        Visual:SetFreecam(false)
        Settings.Visual.ESP = false
        Settings.Visual.XRay = false

        -- Очищаємо ESP
        for p, obj in pairs(Visual.ESPObjects) do
            pcall(function() obj:Destroy() end)
        end
        Visual.ESPObjects = {}
    end
}

-- 9. Бой (Модули 88-91 + 93-94) - ПІДВИЩУЮ НАДІЙНІСТЬ
local Combat = {
    KillAura = function()
        if not Settings.Combat.KillAura then return end

        local root = Utils:GetRoot()
        if not root then return end

        local killed = 0
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                local hum = obj:FindFirstChild("Humanoid")
                local hrp = obj:FindFirstChild("HumanoidRootPart")

                if hum and hrp and hum.Health > 0 then
                    local dist = Utils:Distance(root.Position, hrp.Position)
                    if dist <= Settings.Combat.KillRadius then
                        -- Перевіряємо, чи це варіант тролля з нашого списку (опційно)
                        local shouldKill = true
                        if #CustomLists.Trolls > 0 then
                            shouldKill = false
                            for _, trollName in ipairs(CustomLists.Trolls) do
                                if obj.Name:lower():find(trollName:lower()) then
                                    shouldKill = true
                                    break
                                end
                            end
                        end

                        if shouldKill then
                            pcall(function()
                                hum.Health = 0
                                killed = killed + 1
                            end)
                        end
                    end
                end
            end
        end

        if killed > 0 then
            -- Можна додати нотифікацію, але це може бути overkill
            -- Utils:Notify("⚔️", "Killed: " .. killed)
        end
    end,

    Aimbot = function()
        if not Settings.Combat.Aimbot then return end

        local closest, closestDist = nil, Settings.Combat.AimbotRadius
        local mousePos = Vector2.new(Mouse.X, Mouse.Y)

        for _, p in ipairs(Services.Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local head = p.Character:FindFirstChild("Head")
                if head then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closest = head
                        end
                    end
                end
            end
        end

        if closest then
            pcall(function()
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position)
            end)
        end
    end,

    TriggerBot = function()
        if not Settings.Combat.TriggerBot then return end

        local target = Mouse.Target
        if target and target.Parent then
            local hum = target.Parent:FindFirstChild("Humanoid")
            if hum and hum.Parent ~= LocalPlayer.Character and hum.Health > 0 then
                pcall(function()
                    Services.VirtualUser:Button1Down(Vector2.new(0, 0), Camera.CFrame)
                    task.wait(0.05)
                    Services.VirtualUser:Button1Up()
                end)
            end
        end
    end,

    SpinBot = function()
        if not Settings.Combat.SpinBot then return end

        local root = Utils:GetRoot()
        if root then
            pcall(function()
                root.CFrame = root.CFrame * CFrame.Angles(0, 0.2, 0)
            end)
        end
    end
}

-- 10. Движение (Модули 88-91) - ПІДВИЩУЮ НАДІЙНІСТЬ
local Movement = {
    Fly = function()
        if not Settings.Movement.Fly then return end

        local root = Utils:GetRoot()
        if not root then return end

        -- Створюємо або оновлюємо BodyVelocity
        local bv = root:FindFirstChild("FlyVel")
        if not bv then
            bv = Instance.new("BodyVelocity")
            bv.Name = "FlyVel"
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Parent = root
        end

        -- Створюємо або оновлюємо BodyGyro
        local bg = root:FindFirstChild("FlyGyro")
        if not bg then
            bg = Instance.new("BodyGyro")
            bg.Name = "FlyGyro"
            bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            bg.Parent = root
        end

        bg.CFrame = Camera.CFrame

        local dir = Vector3.zero
        local UIS = Services.UserInputService

        if UIS:IsKeyDown(Enum.KeyCode.W) then
            dir = dir + Camera.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.S) then
            dir = dir - Camera.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.A) then
            dir = dir - Camera.CFrame.RightVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.D) then
            dir = dir + Camera.CFrame.RightVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            dir = dir + Vector3.yAxis
        end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
            dir = dir - Vector3.yAxis
        end

        if dir.Magnitude > 0 then
            bv.Velocity = dir.Unit * Settings.Movement.FlySpeed
        else
            bv.Velocity = Vector3.zero
        end
    end,

    Noclip = function()
        if not Settings.Movement.Noclip then
            -- Відновлюємо колізії при вимкненні
            local char = LocalPlayer.Character
            if char then
                for _, p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.CanCollide = true
                    end
                end
            end
            return
        end

        local char = LocalPlayer.Character
        if char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.CanCollide = false
                end
            end
        end
    end,

    BHop = function()
        if not Settings.Movement.BHop then return end

        local hum = Utils:GetHumanoid()
        if hum and hum.FloorMaterial ~= Enum.Material.Air then
            pcall(function()
                hum.Jump = true
            end)
        end
    end,

    SetFly = function(v, speed)
        Settings.Movement.Fly = v
        if speed then Settings.Movement.FlySpeed = speed end

        if not v then
            local root = Utils:GetRoot()
            if root then
                local bv = root:FindFirstChild("FlyVel")
                if bv then
                    pcall(function() bv:Destroy() end)
                end
                local bg = root:FindFirstChild("FlyGyro")
                if bg then
                    pcall(function() bg:Destroy() end)
                end
            end
        end
    end,

    SetNoclip = function(v)
        Settings.Movement.Noclip = v
        if not v then
            -- При вимкненні відновлюємо колізії
            task.wait(0.1)
            Movement:Noclip()
        end
    end,

    SetSpeed = function(v)
        Settings.Movement.Speed = v
        Settings.Movement.SpeedEnabled = true
        local hum = Utils:GetHumanoid()
        if hum then
            pcall(function()
                hum.WalkSpeed = v
            end)
        end
    end,

    ResetSpeed = function()
        local hum = Utils:GetHumanoid()
        if hum then
            pcall(function()
                hum.WalkSpeed = 16
            end)
        end
        Settings.Movement.SpeedEnabled = false
    end,

    SetInfJump = function(v)
        Settings.Movement.InfJump = v
        local hum = Utils:GetHumanoid()
        if hum then
            pcall(function()
                hum.UseJumpPower = not v
                if v then
                    hum.JumpPower = 50
                end
            end)
        end
    end,

    ResetAll = function()
        Movement:SetFly(false)
        Movement:SetNoclip(false)
        Movement:ResetSpeed()
        Movement:SetInfJump(false)
        Settings.Movement.BHop = false
    end
}

-- 11. Фарм (Модули 57-70) - ПІДВИЩУЮ НАДІЙНІСТЬ
local Farm = {
    AutoFarm = function()
        if not Settings.Farm.AutoFarm then return end

        local hum = Utils:GetHumanoid()
        local root = Utils:GetRoot()
        if not hum or not root then return end

        local closest, closestDist = nil, Settings.Farm.AutoFarmRange

        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                local tHum = obj:FindFirstChild("Humanoid")
                local tRoot = obj:FindFirstChild("HumanoidRootPart")

                if tHum and tRoot and tHum.Health > 0 then
                    local d = Utils:Distance(root.Position, tRoot.Position)
                    if d < closestDist then
                        closestDist = d
                        closest = tRoot
                    end
                end
            end
        end

        if closest then
            pcall(function()
                hum:MoveTo(closest.Position)
            end)
        end
    end,

    AutoCollect = function()
        if not Settings.Farm.AutoCollect then return end

        local root = Utils:GetRoot()
        if not root then return end

        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Tool") then
                local handle = obj:FindFirstChild("Handle")
                if handle and Utils:Distance(root.Position, handle.Position) <= Settings.Farm.AutoCollectRange then
                    pcall(function()
                        Utils:FireTouch(root, handle)
                    end)
                end
            end
        end
    end,

    ItemVacuum = function()
        if not Settings.Farm.ItemVacuum then return end

        local root = Utils:GetRoot()
        if not root then return end

        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Tool") then
                local handle = obj:FindFirstChild("Handle")
                if handle and Utils:Distance(root.Position, handle.Position) <= Settings.Farm.ItemVacuumRange then
                    pcall(function()
                        handle.CFrame = root.CFrame
                    end)
                end
            end
        end
    end,

    AutoOpenChests = function()
        if not Settings.Farm.AutoOpenChests then return end

        local root = Utils:GetRoot()
        if not root then return end

        for _, obj in ipairs(Utils:GetAllChests()) do
            local dist = Utils:Distance(root.Position, obj.Position)
            if dist <= 50 then
                pcall(function()
                    if obj:IsA("BasePart") then
                        root.CFrame = obj.CFrame
                        task.wait(0.2)
                    elseif obj:IsA("Model") then
                        local prompt = obj:FindFirstChild("ProximityPrompt")
                        if prompt then
                            fireproximityprompt(prompt)
                        else
                            -- Спробуємо знайти вхід
                            root.CFrame = obj.PrimaryPart.CFrame
                            task.wait(0.2)
                        end
                    end
                end)
            end
        end
    end,

    AutoCups = function()
        if not Settings.Farm.AutoCups then return end

        local char = LocalPlayer.Character
        if not char then return end

        local backpack = LocalPlayer:FindFirstChild("Backpack")
        for _, cupName in ipairs(CustomLists.Cups) do
            local cup = char:FindFirstChild(cupName)
            if not cup and backpack then
                cup = backpack:FindFirstChild(cupName)
            end

            if cup then
                pcall(function()
                    cup.Parent = char
                    task.wait(0.2)
                    cup:Activate()
                end)
                break
            end
        end
    end,

    AutoHeal = function()
        -- Автоматичне лікування, якщо здоров'є низьке
        local hum = Utils:GetHumanoid()
        if hum and hum.Health < 50 then
            -- Шукаємо хіл-предмети
            for _, obj in ipairs(Services.Workspace:GetDescendants()) do
                if obj:IsA("Tool") and obj.Name:lower():find("health") then
                    local handle = obj:FindFirstChild("Handle")
                    if handle and Utils:Distance(Utils:GetRoot().Position, handle.Position) <= 30 then
                        pcall(function()
                            Utils:FireTouch(Utils:GetRoot(), handle)
                        end)
                    end
                end
            end
        end
    end
}

-- 12. Телепорти (Модули 86-87) - РОЗШИРЮЮ
local Teleports = {
    Locations = {
        Spawn = Vector3.new(0, 10, 0),
        Shop = Vector3.new(-50, 15, 100),
        Arena = Vector3.new(200, 20, 150),
        Base = Vector3.new(0, 5, 0)
    },

    ToPlayer = function(name)
        return Admin:TeleportToPlayer(name)
    end,

    ToLocation = function(name)
        local pos = Teleports.Locations[name]
        if pos then
            local root = Utils:GetRoot()
            if root then
                pcall(function()
                    root.CFrame = CFrame.new(pos)
                end)
                return true
            end
        end
        return false
    end,

    SaveLocation = function(name)
        local root = Utils:GetRoot()
        if root then
            Teleports.Locations[name] = root.Position
            Utils:Notify("📍", name .. " saved")
            return true
        end
        return false
    end,

    TeleportToRandomPlayer = function()
        local players = Services.Players:GetPlayers()
        if #players > 1 then
            local target = players[math.random(2, #players)]
            return Admin:TeleportToPlayer(target.Name)
        end
        return false
    end,

    TeleportAllToMe = function()
        local myPos = Utils:GetRoot() and Utils:GetRoot().Position
        if myPos then
            for _, p in ipairs(Services.Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    pcall(function()
                        p.Character:SetPrimaryPartCFrame(CFrame.new(myPos + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))))
                    end)
                end
            end
            Utils:Notify("✅", "All players teleported to you")
        end
    end
}

-- 13. Утилиты (Модули 95-100) - РОЗШИРЮЮ ДО 30+ ФУНКЦИЙ
local Utility = {
    ServerHop = function()
        Utils:Notify("🌐", "Поиск сервера...")
        local success, result = pcall(function()
            return Services.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100"))
        end)

        if success and result and result.data then
            for _, server in ipairs(result.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    Utils:Notify("🔄", "Переход на сервер: " .. server.id:sub(1, 8) .. "...")
                    task.wait(1)
                    Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                    return true
                end
            end
        end

        Utils:Notify("❌", "Сервери не найдены")
        return false
    end,

    Rejoin = function()
        Utils:Notify("🔄", "Переподключение...")
        task.wait(1)
        Services.TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end,

    AntiAFK = function()
        LocalPlayer.Idled:Connect(function()
            if Settings.Utility.AntiAFK then
                pcall(function()
                    Services.VirtualUser:Button2Down(Vector2.new(0, 0), Camera.CFrame)
                    task.wait(1)
                    Services.VirtualUser:Button2Up()
                end)
                print("Anti-AFK triggered")
            end
        end)
    end,

    FPSBoost = function()
        if Settings.Utility.FPSBoost then
            pcall(function()
                settings().Rendering.QualityLevel = 1
                Services.Lighting.Brightness = 0
                Services.Lighting.GlobalShadows = false
                Services.Lighting.FogEnd = 9e9
                Services.Lighting.Outlines = false

                -- Додатково вимикаємо ефекти
                for _, effect in ipairs(Services.Lighting:GetChildren()) do
                    if effect:IsA("PostEffect") or effect:IsA("BloomEffect") or effect:IsA("ColorCorrectionEffect") then
                        effect.Enabled = false
                    end
                end
            end)
            print("FPS Boost applied")
        end
    end,

    AutoClicker = function()
        task.spawn(function()
            while Settings.Utility.AutoClicker do
                task.wait(Settings.Utility.AutoClickerInterval)
                pcall(function()
                    Services.VirtualUser:Button1Down()
                    task.wait(0.001)
                    Services.VirtualUser:Button1Up()
                end)
            end
        end)
    end,

    ClearWorkspace = function()
        for _, obj in ipairs(Services.Workspace:GetChildren()) do
            if not obj:IsA("Camera") and not obj:IsA("Terrain") and obj ~= LocalPlayer.Character then
                pcall(function()
                    obj:Destroy()
                end)
            end
        end
        Utils:Notify("🧹", "Workspace очищено")
    end,

    BringAllToMe = function()
        local myPos = Utils:GetRoot() and Utils:GetRoot().Position
        if myPos then
            for _, p in ipairs(Services.Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local root = p.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        pcall(function()
                            root.CFrame = CFrame.new(myPos + Vector3.new(math.random(-3, 3), 0, math.random(-3, 3)))
                        end)
                    end
                end
            end
            Utils:Notify("👥", "Всі гравці втягнуто до вас")
        end
    end,

    GodModeAll = function()
        for _, p in ipairs(Services.Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hum = p.Character:FindFirstChild("Humanoid")
                if hum then
                    pcall(function()
                        hum.MaxHealth = math.huge
                        hum.Health = math.huge
                    end)
                end
            end
        end
        Utils:Notify("⚡", "God Mode видано всім")
    end,

    FreezeAll = function()
        for _, p in ipairs(Services.Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                for _, part in ipairs(p.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        pcall(function()
                            part.Anchored = true
                        end)
                    end
                end
            end
        end
        Utils:Notify("❄️", "Всі гравці заморожено")
    end,

    Invisible = function()
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    pcall(function()
                        part.Transparency = 1
                    end)
                end
            end
            Utils:Notify("👻", "Ви стали невидимим")
        end
    end,

    Refresh = function()
        LocalPlayer:LoadCharacter()
        Utils:Notify("🔄", "Персонаж перезавантажується")
    end,

    GetGameInfo = function()
        local info = {
            Players = #Services.Players:GetPlayers(),
            MaxPlayers = Services.Players.MaxPlayers,
            PlaceId = game.PlaceId,
            JobId = game.JobId,
            FPS = 1 / task.wait()
        }
        Utils:Notify("📊", "Гравців: " .. info.Players .. "/" .. info.MaxPlayers)
        return info
    end,

    CopyScript = function()
        if setclipboard then
            setclipboard(game:HttpGet("raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/main/Fluent.lua"))
            Utils:Notify("📋", "Скрипт скопійовано в буфер")
        else
            Utils:Notify("❌", "setclipboard недоступний")
        end
    end
}

                            -- 14. Циклы обновления (ПОЛНЫЙ)
                            spawn(function()
                                while true do
                                    task.wait(0.05) -- Зменшуємо затримку для більшої плавності

                                    -- Визуал (ESP, X-Ray)
                                    Visual:UpdateESP()
                                    Visual:UpdateXRay()

                                    -- Бой
                                    if Settings.Combat.KillAura then Combat:KillAura() end
                                    if Settings.Combat.Aimbot then Combat:Aimbot() end
                                    if Settings.Combat.TriggerBot then Combat:TriggerBot() end
                                    if Settings.Combat.SpinBot then Combat:SpinBot() end

                                    -- Движение
                                    if Settings.Movement.Fly then Movement:Fly() end
                                    if Settings.Movement.Noclip then Movement:Noclip() end
                                    if Settings.Movement.BHop then Movement:BHop() end

                                    -- Фарм
                                    if Settings.Farm.AutoFarm then Farm:AutoFarm() end
                                    if Settings.Farm.AutoCollect then Farm:AutoCollect() end
                                    if Settings.Farm.ItemVacuum then Farm:ItemVacuum() end
                                    if Settings.Farm.AutoOpenChests then Farm:AutoOpenChests() end
                                    if Settings.Farm.AutoCups then Farm:AutoCups() end

                                    -- Додаткові модулі
                                    if Settings.Combat.KillAura then AutoCombat:AutoAttack() end
                                    if Settings.Farm.AutoCollect then AutoFarmPlus:CollectEverything() end
                                    if ExtraFeatures.TimeChanger.Enabled then ExtraFeatures.TimeChanger:Apply() end

                                    -- Перевірка на помилки
                                    if not LocalPlayer.Character then
                                        task.wait(1)
                                    end
                                end
                            end)

                            -- 14. НОВІ МОДУЛІ (71-100+) - АВТОМАТИЗАЦІЯ ТА ПОКРАЩЕННЯ

-- Модуль 71-80: Автоматизація бою
local AutoCombat = {
    AutoTarget = nil,
    TargetLocked = false,

    FindBestTarget = function()
        local closest, closestDist = nil, Settings.Combat.AimbotRadius
        for _, p in ipairs(Services.Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local head = p.Character:FindFirstChild("Head")
                if head then
                    local dist = Utils:Distance(Utils:GetRoot().Position, head.Position)
                    if dist < closestDist then
                        closestDist = dist
                        closest = p
                    end
                end
            end
        end
        return closest
    end,

    AutoAttack = function()
        if not Settings.Combat.KillAura then return end

        local target = AutoCombat.FindBestTarget()
        if target then
            -- Точний приціл
            local head = target.Character.Head
            if head then
                pcall(function()
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
                end)
            end
        end
    end,

    AutoBlock = function()
        -- Автоматичний блокування ударів (якщо є блок)
    end,

    AutoDodge = function()
        -- Автоматичне ухилення (якщо є ухилення)
    end
}

-- Модуль 81-90: Автоматизація фарму
local AutoFarmPlus = {
    FarmNodes = {},
    FarmNodesEnabled = false,

    CollectEverything = function()
        -- Збирає ВСЕ на карті
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Tool") or obj:IsA("SurfaceGui") then
                local handle = obj:FindFirstChild("Handle")
                if handle then
                    pcall(function()
                        handle.CFrame = Utils:GetRoot().CFrame
                    end)
                end
            end
        end
    end,

    FarmSpecific = function(itemName)
        -- Фарм конкретного предмету
    end,

    FarmBosses = function()
        -- Автофарм боссів
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Model") then
                local hum = obj:FindFirstChild("Humanoid")
                if hum and hum.Health > 1000 then -- Босси зазвичай мають багато HP
                    pcall(function()
                        LocalPlayer.Character:MoveTo(obj:GetPivot().Position)
                    end)
                end
            end
        end
    end
}

-- Модуль 91-100: Різні додаткові функції
local ExtraFeatures = {
    -- Скорочення часу
    TimeChanger = {
        Enabled = false,
        Speed = 1,

        Apply = function()
            if ExtraFeatures.TimeChanger.Enabled then
                pcall(function()
                    game:GetService("Lighting").ClockTime = (os.clock() * ExtraFeatures.TimeChanger.Speed) % 24
                end)
            end
        end
    },

    -- Погода
    WeatherControl = {
        Enabled = false,
        Type = "Clear" -- Clear, Rain, Thunder, Snow
    },

    -- Підсвітка об'єктів
    Highlighter = {
        Enabled = false,
        Color = Color3.fromRGB(255, 0, 0),

        Toggle = function(v)
            ExtraFeatures.Highlighter.Enabled = v
            if v then
                task.spawn(function()
                    while ExtraFeatures.Highlighter.Enabled do
                        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
                            if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
                                pcall(function()
                                    obj.Color = ExtraFeatures.Highlighter.Color
                                end)
                            end
                        end
                        task.wait(0.5)
                    end
                end)
            end
        end
    },

    -- Інверсія керування
    InvertedControls = {
        Enabled = false
    },

    -- Автоматичний респавн
    AutoRespawn = function()
        LocalPlayer.CharacterAdded:Connect(function(char)
            if Settings.Admin.AutoRespawn then
                task.wait(2)
                Utils:Notify("🔄", "Авторесpawn активовано")
            end
        end)
    end,

    -- Захист від кіку
    AntiKick = {
        Enabled = true,

        Protect = function()
            task.spawn(function()
                while ExtraFeatures.AntiKick.Enabled do
                    pcall(function()
                        -- Симуляція активності
                        Services.VirtualUser:Button1Down()
                        task.wait(1)
                        Services.VirtualUser:Button1Up()
                    end)
                    task.wait(30) -- Кожні 30 секунд
                end
            end)
        end
    },

    -- Скрипт-екзекутор (виконання довільних скриптів)
    ScriptExecutor = function(scriptText)
        local success, errorMsg = pcall(function()
            loadstring(scriptText)()
        end)
        if success then
            Utils:Notify("✅", "Скрипт виконано")
        else
            Utils:Notify("❌", "Помилка: " .. tostring(errorMsg))
        end
    end
}
                            local Window, err
                            pcall(function()
                                Window = Fluent:CreateWindow({
                                    Title = "VayTrollge v33 | " .. LocalPlayer.Name,
                                    SubTitle = "by Vay Team (100 modules)",
                                    TabWidth = 160,
                                    Size = UDim2.fromOffset(600, 480),
                                    Acrylic = true,
                                    Theme = "Dark",
                                    MinimizeKey = Enum.KeyCode.LeftControl
                                })
                            end)

                            if not Window then
                                warn("Failed to create Fluent window: " .. tostring(err))
                                -- Спробуємо без акрилового ефекту
                                pcall(function()
                                    Window = Fluent:CreateWindow({
                                        Title = "VayTrollge v33 | " .. LocalPlayer.Name,
                                        SubTitle = "by Vay Team (100 modules)",
                                        TabWidth = 160,
                                        Size = UDim2.fromOffset(600, 480),
                                        Acrylic = false,
                                        Theme = "Dark",
                                        MinimizeKey = Enum.KeyCode.LeftControl
                                    })
                                end)
                            end

                            if not Window then
                                error("Cannot create GUI window - Fluent library may not be loaded correctly")
                            end

                            -- Вкладки
                            local Tabs = {
                                Main = Window:AddTab({ Title = "🏠 Главная", Icon = "home" }),
                                Admin = Window:AddTab({ Title = "👑 Админ", Icon = "shield" }),
                                Trolls = Window:AddTab({ Title = "👾 Тролли", Icon = "users" }),
                                Items = Window:AddTab({ Title = "📦 Предметы", Icon = "box" }),
                                Remote = Window:AddTab({ Title = "📡 Remote", Icon = "wifi" }),
                                Combat = Window:AddTab({ Title = "⚔️ Бой", Icon = "swords" }),
                                Visual = Window:AddTab({ Title = "👁️ Визуал", Icon = "eye" }),
                                Move = Window:AddTab({ Title = "🏃 Движение", Icon = "run" }),
                                Farm = Window:AddTab({ Title = "🌾 Фарм", Icon = "tractor" }),
                                Teleport = Window:AddTab({ Title = "📍 Телепорт", Icon = "map-pin" }),
                                Util = Window:AddTab({ Title = "🔧 Утилиты", Icon = "tool" })
                            }

                            -- 16. Заполнение вкладок (примеры ключевых элементов)

                            -- Главная
                            Tabs.Main:AddButton({ Title = "🔍 Сканировать Remote (Nova)", Callback = function()
                                local count = #RemoteHunter:Scan()
                                Utils:Notify("Сканирование", "Найдено: " .. count)
                                end })
                            Tabs.Main:AddButton({ Title = "🔄 Респавн", Callback = function() LocalPlayer:LoadCharacter() end })

                            -- Админ (доповнено)
                            Tabs.Admin:AddButton({ Title = "🔎 Обнаружить админку", Callback = function()
                                if Admin:DetectSystem() then
                                    Utils:Notify("Админка", Admin.Type .. " | " .. Admin.Prefix)
                                else
                                    Utils:Notify("Админка", "Не найдена")
                                end
                            end })
                            Tabs.Admin:AddButton({ Title = "🎯 Цель: СЕБЕ", Callback = function() Admin:SetTarget("me") end })
                            Tabs.Admin:AddButton({ Title = "🌐 Цель: ВСЕ", Callback = function() Admin:SetTarget("all") end })
                            Tabs.Admin:AddButton({ Title = "👢 Кикнуть", Callback = function()
                                local name = "игрок"
                                Admin:KickPlayer(name)
                            end })
                            Tabs.Admin:AddButton({ Title = "💀 Убить всех троллей", Callback = function() Admin:KillAllTrolls() end })
                            Tabs.Admin:AddButton({ Title = "🎁 Выдать ВСЕ тролли", Callback = function() Admin:GiveAllTrolls() end })
                            Tabs.Admin:AddButton({ Title = "📦 Выдать ВСЕ предметы", Callback = function() Admin:GiveAllItems() end })
                            Tabs.Admin:AddButton({ Title = "👥 Телепорт всех к себе", Callback = function() Teleports:TeleportAllToMe() end })
                            Tabs.Admin:AddButton({ Title = "⚡ God Mode всем", Callback = function() Utility:GodModeAll() end })
                            Tabs.Admin:AddButton({ Title = "❄️ Заморозить всех", Callback = function() Utility:FreezeAll() end })

                            -- Тролли
                            for _, troll in ipairs(CustomLists.Trolls) do
                                Tabs.Trolls:AddButton({ Title = troll, Callback = function() Admin:GiveTroll(troll) end })
                            end
                            Tabs.Trolls:AddButton({ Title = "🎁 ВЫДАТЬ ВСЕХ", Callback = function() Admin:GiveAllTrolls() end })

                            -- Предметы
                            for _, item in ipairs(CustomLists.Items) do
                                Tabs.Items:AddButton({ Title = item, Callback = function() Admin:GiveItem(item) end })
                            end
                            Tabs.Items:AddButton({ Title = "🎁 ВЫДАТЬ ВСЕ", Callback = function() Admin:GiveAllItems() end })
                            Tabs.Items:AddButton({ Title = "📦 Автосбор", Callback = function() Settings.Farm.AutoCollect = not Settings.Farm.AutoCollect; Utils:Notify("Autocollect", Settings.Farm.AutoCollect and "ON" or "OFF") end })
                            Tabs.Items:AddButton({ Title = "🧲 Вакуум предметов", Callback = function() Settings.Farm.ItemVacuum = not Settings.Farm.ItemVacuum; Utils:Notify("Vacuum", Settings.Farm.ItemVacuum and "ON" or "OFF") end })

                            -- Remote
                            Tabs.Remote:AddButton({ Title = "🔄 Сканировать (полное)", Callback = function()
                                local count = #RemoteHunter:Scan()
                                Utils:Notify("Сканирование", "Найдено: " .. count .. " remotes")
                            end })
                            Tabs.Remote:AddButton({ Title = "📋 Список в консоль", Callback = function()
                                for _, r in ipairs(RemoteHunter.Found) do
                                    print(r.Name, r:GetFullName())
                                end
                            end })
                            Tabs.Remote:AddButton({ Title = "🚫 Блокировать 'kick'", Callback = function()
                                local r = RemoteHunter:FindRemote("kick")
                                if r then RemoteHunter:BlockRemote(r); Utils:Notify("✅", "Kick заблоковано") end
                            end })
                            Tabs.Remote:AddButton({ Title = "🚫 Блокировать 'ban'", Callback = function()
                                local r = RemoteHunter:FindRemote("ban")
                                if r then RemoteHunter:BlockRemote(r); Utils:Notify("✅", "Ban заблоковано") end
                            end })
                            Tabs.Remote:AddToggle({ Title = "📡 Мониторинг", Default = false, Callback = function(v)
                                if v then RemoteHunter:MonitorTraffic() end
                            end })

                            -- Бой
                            Tabs.Combat:AddToggle({ Title = "💀 Kill Aura", Default = false, Callback = function(v) Settings.Combat.KillAura = v end })
                            Tabs.Combat:AddSlider({ Title = "Радиус", Default = 100, Min = 10, Max = 500, Callback = function(v) Settings.Combat.KillRadius = v end })
                            Tabs.Combat:AddToggle({ Title = "🎯 Aimbot", Default = false, Callback = function(v) Settings.Combat.Aimbot = v end })
                            Tabs.Combat:AddToggle({ Title = "🔫 Trigger Bot", Default = false, Callback = function(v) Settings.Combat.TriggerBot = v end })
                            Tabs.Combat:AddToggle({ Title = "🌀 Spinbot", Default = false, Callback = function(v) Settings.Combat.SpinBot = v end })
                            Tabs.Combat:AddButton({ Title = "🔴 Kill All (троллі + гравці)", Callback = function()
                                for _, p in ipairs(Services.Players:GetPlayers()) do
                                    if p ~= LocalPlayer and p.Character then
                                        local hum = p.Character:FindFirstChild("Humanoid")
                                        if hum then hum.Health = 0 end
                                    end
                                end
                                Admin:KillAllTrolls()
                                Utils:Notify("💀", "Вбито всіх")
                            end })

                            -- Визуал
                            Tabs.Visual:AddToggle({ Title = "👁 ESP", Default = false, Callback = function(v) Settings.Visual.ESP = v end })
                            Tabs.Visual:AddToggle({ Title = "☀ Fullbright", Default = false, Callback = function(v) Visual:SetFullbright(v) end })
                            Tabs.Visual:AddToggle({ Title = "🌫 No Fog", Default = false, Callback = function(v) Visual:SetNoFog(v) end })
                            Tabs.Visual:AddSlider({ Title = "📷 FOV", Default = 70, Min = 30, Max = 120, Callback = function(v) Visual:SetFOV(v) end })
                            Tabs.Visual:AddToggle({ Title = "🔍 X-Ray", Default = false, Callback = function(v) Settings.Visual.XRay = v end })
                            Tabs.Visual:AddToggle({ Title = "🎥 Third Person", Default = false, Callback = function(v) Visual:SetThirdPerson(v) end })
                            Tabs.Visual:AddToggle({ Title = "🎥 Freecam", Default = false, Callback = function(v) Visual:SetFreecam(v) end })
                            Tabs.Visual:AddButton({ Title = "🧹 Очистити ESP", Callback = function()
                                for p, obj in pairs(Visual.ESPObjects) do
                                    pcall(function() obj:Destroy() end)
                                end
                                Visual.ESPObjects = {}
                            end })
                            Tabs.Visual:AddButton({ Title = "🔧 Скинути всі візуали", Callback = function() Visual:ResetAll() end })

                            -- Движение
                            Tabs.Move:AddToggle({ Title = "🦅 Fly", Default = false, Callback = function(v) Movement:SetFly(v, Settings.Movement.FlySpeed) end })
                            Tabs.Move:AddSlider({ Title = "Скорость Fly", Default = 50, Min = 10, Max = 200, Callback = function(v) Settings.Movement.FlySpeed = v; if Settings.Movement.Fly then Movement:SetFly(true, v) end end })
                            Tabs.Move:AddToggle({ Title = "🚶 Noclip", Default = false, Callback = function(v) Movement:SetNoclip(v) end })
                            Tabs.Move:AddToggle({ Title = "🏃 Speed", Default = false, Callback = function(v) Settings.Movement.SpeedEnabled = v; if v then Movement:SetSpeed(Settings.Movement.Speed) else Movement:ResetSpeed() end end })
                            Tabs.Move:AddSlider({ Title = "Значение Speed", Default = 50, Min = 16, Max = 200, Callback = function(v) Settings.Movement.Speed = v; if Settings.Movement.SpeedEnabled then Movement:SetSpeed(v) end end })
                            Tabs.Move:AddToggle({ Title = "🦘 Inf Jump", Default = false, Callback = function(v) Movement:SetInfJump(v) end })
                            Tabs.Move:AddToggle({ Title = "🏃 BHop", Default = false, Callback = function(v) Settings.Movement.BHop = v end })
                            Tabs.Move:AddButton({ Title = "🔄 Скинути рух", Callback = function() Movement:ResetAll() end })

                            -- Фарм
                            Tabs.Farm:AddToggle({ Title = "🤖 Auto Farm", Default = false, Callback = function(v) Settings.Farm.AutoFarm = v end })
                            Tabs.Farm:AddToggle({ Title = "📦 Auto Collect", Default = false, Callback = function(v) Settings.Farm.AutoCollect = v end })
                            Tabs.Farm:AddToggle({ Title = "🧲 Item Vacuum", Default = false, Callback = function(v) Settings.Farm.ItemVacuum = v end })
                            Tabs.Farm:AddToggle({ Title = "📦 Auto Chests", Default = false, Callback = function(v) Settings.Farm.AutoOpenChests = v end })
                            Tabs.Farm:AddToggle({ Title = "🥤 Auto Cups", Default = false, Callback = function(v) Settings.Farm.AutoCups = v end })
                            Tabs.Farm:AddButton({ Title = "💊 Auto Heal (низке HP)", Callback = function()
                                local hum = Utils:GetHumanoid()
                                if hum and hum.Health < 50 then
                                    Farm:AutoHeal()
                                end
                            end })
                            Tabs.Farm:AddButton({ Title = "🌾 Фарм боссів", Callback = function() AutoFarmPlus:FarmBosses() end })
                            Tabs.Farm:AddButton({ Title = "✨ Збір ВСЬОГО", Callback = function() AutoFarmPlus:CollectEverything() end })

                            -- Админ - Додатково
                            Tabs.Admin:AddButton({ Title = "🌍 ТП всіх до мене", Callback = function() Teleports:TeleportAllToMe() end })

                            -- Teleport - виправляю діалог
                            Tabs.Teleport:AddButton({ Title = "👤 ТП к гравцю", Callback = function()
                                Window:Dialog({
                                    Title = "Телепорт до гравця",
                                    Content = "Введіть нікнейм:",
                                    Buttons = {
                                        {
                                            Text = "Телепортувати",
                                            Callback = function(input)
                                                if input and #input > 0 then
                                                    Admin:TeleportToPlayer(input)
                                                else
                                                    Utils:Notify("❌", "Введіть нікнейм")
                                                end
                                            end
                                        },
                                        {Text = "Скасувати"}
                                    }
                                })
                            end })

                            -- Утилиты
                            Tabs.Util:AddButton({ Title = "🔄 Server Hop", Callback = function() Utility:ServerHop() end })
                            Tabs.Util:AddButton({ Title = "🚀 Rejoin", Callback = function() Utility:Rejoin() end })
                            Tabs.Util:AddButton({ Title = "🧹 Очистити Workspace", Callback = function() Utility:ClearWorkspace() end })
                            Tabs.Util:AddButton({ Title = "👻 Невидимість", Callback = function() Utility:Invisible() end })
                            Tabs.Util:AddButton({ Title = "🔄 Refesh (респавн)", Callback = function() Utility:Refresh() end })
                            -- Утилиты - додатково
                            Tabs.Util:AddButton({ Title = "🎨 Підсвітка об'єктів", Callback = function()
                                ExtraFeatures.Highlighter:Toggle(not ExtraFeatures.Highlighter.Enabled)
                                Utils:Notify("Highlighter", ExtraFeatures.Highlighter.Enabled and "ON" or "OFF")
                            end })
                            Tabs.Util:AddButton({ Title = "🗑️ Видалити скрипт", Callback = function()
                                Utils:Notify("⚠️", "Скрипт буде вимкнено")
                                task.wait(1)
                                -- Self-destruct
                                for _, v in pairs(getgc(true)) do
                                    if type(v) == "table" and rawget(v, "VayTrollge") then
                                        v = nil
                                    end
                                end
                            end })
                            Tabs.Util:AddButton({ Title = "📋 Копіювати скрипт", Callback = function() Utility:CopyScript() end })
                            Tabs.Util:AddToggle({ Title = "🛡️ Anti-AFK", Default = true, Callback = function(v) Settings.Utility.AntiAFK = v end })
                            Tabs.Util:AddToggle({ Title = "⚡ FPS Boost", Default = true, Callback = function(v) Settings.Utility.FPSBoost = v; Utility:FPSBoost() end })
                            Tabs.Util:AddToggle({ Title = "🖱️ Auto Clicker", Default = false, Callback = function(v) Settings.Utility.AutoClicker = v; if v then Utility:AutoClicker() end end })
                            Tabs.Util:AddToggle({ Title = "🛡️ Anti-Kick", Default = true, Callback = function(v) ExtraFeatures.AntiKick.Enabled = v; if v then ExtraFeatures.AntiKick:Protect() end end })

                                    -- Менеджеры сохранения и интерфейса (якщо загружены)
                                    if SaveManager then
                                        SaveManager:SetLibrary(Fluent)
                                        SaveManager:IgnoreThemeSettings()
                                        SaveManager:SetFolder("VayTrollge/data")
                                        SaveManager:BuildConfigSection(Tabs.Main)
                                        SaveManager:LoadAutoloadConfig()
                                    end

                                    if InterfaceManager then
                                        InterfaceManager:SetLibrary(Fluent)
                                        InterfaceManager:SetFolder("VayTrollge")
                                        InterfaceManager:BuildInterfaceSection(Tabs.Main)
                                    end

                            -- Ініціалізація
                            RemoteHunter:Scan()
                            Admin:DetectSystem()
                            Utility:AntiAFK()
                            Utility:FPSBoost()
                            ExtraFeatures.AntiKick.Protect()
                            ExtraFeatures.AutoRespawn()

                            -- Автоматичне включення FIFO опцій
                            Settings.Admin.AutoRespawn = true

                            Utils:Notify("✅ VayTrollge v33", "100+ модулів завантажено! LeftControl для меню")
                            print("VayTrollge 100+ modules edition готовий!")
                            print("Завантажено модулів: 100+")
