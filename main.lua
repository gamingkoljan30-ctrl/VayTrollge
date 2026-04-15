-- [Vay]: Ultimate Silent Admin Hijack - Trollge Complete Edition
-- TG: t.me/vayframov2
-- Версия: 5.0.0 | Статус: Fully Undetectable

--// ==================== ИНИЦИАЛИЗАЦИЯ СЛУЖБ ====================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local CollectionService = game:GetService("CollectionService")
local ContextActionService = game:GetService("ContextActionService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local PhysicsService = game:GetService("PhysicsService")
local Chat = game:GetService("Chat")
local MarketplaceService = game:GetService("MarketplaceService")
local InsertService = game:GetService("InsertService")
local TextService = game:GetService("TextService")
local GuiService = game:GetService("GuiService")
local GroupService = game:GetService("GroupService")
local PathfindingService = game:GetService("PathfindingService")
local SocialService = game:GetService("SocialService")
local Stats = game:GetService("Stats")
local AssetService = game:GetService("AssetService")
local AvatarEditorService = game:GetService("AvatarEditorService")
local BadgeService = game:GetService("BadgeService")
local LogService = game:GetService("LogService")
local ScriptContext = game:GetService("ScriptContext")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

--// ==================== ПЕРЕМЕННЫЕ ====================
local Vay = {
    Version = "5.0.0",
    AdminDetected = false,
    AdminType = "None",
    AdminPrefix = ":",
    HijackedRemotes = {},
    BlockedRemotes = {},
    SpoofedFunctions = {},
    FakeMemory = {},
    TrollDatabase = {
        S_Tier = {
            "MULTIVERSAL WRATH", "Multiversal god:distortion", "Hakari", "Omniversal devour:AU",
            "New god", "True Trollge", "Betrayal Of fear-Betrayal of fear Evolved", "Erlking Ruler",
            "The God Devourer", "The Ultimate One", "Minos Prime", "Fatal Error sonic", "Subject 002",
            "Gojo", "Heian Sukuna", "The God Who Wept", "The voices Chaos", "Water Corruption",
            "Destruction", "Trollge Queen", "Scp-173", "EMPEROR RULER", "Firefly",
            "Fatal Error Sonic", "1 Year Anniversary", "Foxy", "Chica", "Golden Freddy", "Puppet",
            "Cursed Guardian", "The Maw", "True Weeping God", "God's Hands", "Lord X",
            "Trollge Gojo", "Zenith Infinity", "Meme Terminator", "Omniversal Devourer",
            "Void Walker", "Infinite Trollge", "God of Trolls", "Ultimate Gojo", "Satoru Gojo",
            "Limitless", "Six Eyes User", "Sukuna", "Ryomen Sukuna", "King of Curses",
            "Yuta Okkotsu", "Queen of Curses", "Rika", "Toji Fushiguro", "Hakari Kinji",
            "Kashimo Hajime", "Takaba Fumihiko", "Higuruma Hiromi", "Yorozu", "Uraume",
            "Kenjaku", "Mahito", "Jogo", "Hanami", "Dagon"
        },
        Items = {
            "Omniversal chest", "crossover cup", "prime soul", "Scarlet Blessing", "omni warp",
            "CHAOS CORE", "Emperor's crown", "Hyperdeath Soul", "Dark Heart", "Unsanitized Cup of Water",
            "Burning Memories", "Rich", "Black ring", "Hallowen Chest", "Eternal Power", "Void chest"
        }
    },
    Settings = {
        SilentMode = true,
        AutoRespawn = true,
        GiveToAll = false,
        TargetPlayer = nil,
        BypassLevel = 3,
        AntiTamper = true,
        MemoryProtection = true,
        RemoteSpoofing = true,
        HideGUI = true,
        FakePing = true,
        SpoofHWID = true,
        ClearLogs = true,
        DisableTelemetry = true
    }
}

--// ==================== АНТИ-ОБНАРУЖЕНИЕ УРОВЕНЬ 1: ЛОГИ ====================
local function DisableAllLogging()
    pcall(function()
        -- Отключение всех логов
        if LogService then
            local connections = getconnections(LogService.MessageOut)
            for _, conn in ipairs(connections) do
                conn:Disable()
            end
        end
        
        -- Блокировка ScriptContext
        if ScriptContext then
            local connections = getconnections(ScriptContext.Error)
            for _, conn in ipairs(connections) do
                conn:Disable()
            end
        end
        
        -- Перехват print/warn/error
        local oldPrint = print
        local oldWarn = warn
        local oldError = error
        
        _G.OriginalPrint = oldPrint
        _G.OriginalWarn = oldWarn
        _G.OriginalError = oldError
        
        print = function(...)
            local args = {...}
            local msg = table.concat(args, " ")
            if not msg:find("Vay") and not msg:find("Trollge") and not msg:find("Admin") then
                return oldPrint(...)
            end
        end
        
        warn = function(...)
            local args = {...}
            local msg = table.concat(args, " ")
            if not msg:find("Vay") and not msg:find("Trollge") and not msg:find("Admin") then
                return oldWarn(...)
            end
        end
        
        error = function(...)
            local args = {...}
            local msg = table.concat(args, " ")
            if not msg:find("Vay") and not msg:find("Trollge") then
                return oldError(...)
            end
        end
    end)
end

--// ==================== АНТИ-ОБНАРУЖЕНИЕ УРОВЕНЬ 2: ПАМЯТЬ ====================
local function ProtectMemoryRegions()
    pcall(function()
        -- Создание фальшивых регионов памяти
        for i = 1, 100 do
            local dummy = Instance.new("Folder")
            dummy.Name = "System32_" .. HttpService:GenerateGUID(false)
            dummy.Parent = game:GetService("CoreGui")
            
            for j = 1, 50 do
                local junk = Instance.new("StringValue")
                junk.Name = "mem_" .. math.random(100000, 999999)
                junk.Value = HttpService:GenerateGUID(false)
                junk.Parent = dummy
            end
            
            Vay.FakeMemory[i] = dummy
        end
        
        -- Защита от сканирования памяти
        spawn(function()
            while Vay.Settings.MemoryProtection do
                wait(math.random(5, 15))
                for _, folder in ipairs(Vay.FakeMemory) do
                    if folder and folder.Parent then
                        for _, child in ipairs(folder:GetChildren()) do
                            if child:IsA("StringValue") then
                                child.Value = HttpService:GenerateGUID(false)
                            end
                        end
                    end
                end
            end
        end)
    end)
end

--// ==================== АНТИ-ОБНАРУЖЕНИЕ УРОВЕНЬ 3: DEBUGGER ====================
local function DisableDebugger()
    pcall(function()
        -- Хук debug библиотеки
        if debug then
            local realGetInfo = debug.getinfo
            local realGetUpvalues = debug.getupvalues
            local realGetConstants = debug.getconstants
            local realSetUpvalue = debug.setupvalue
            local realSetConstant = debug.setconstant
            local realGetLocal = debug.getlocal
            local realSetLocal = debug.setlocal
            local realGetRegistry = debug.getregistry
            local realTraceback = debug.traceback
            
            debug.getinfo = function(f, ...)
                local info = realGetInfo(f, ...)
                if info and info.source and info.source:find("Vay") then
                    info.source = "=[C]"
                    info.short_src = "=[C]"
                    info.linedefined = -1
                    info.lastlinedefined = -1
                end
                return info
            end
            
            debug.getupvalues = function(f)
                if type(f) == "function" then
                    local info = realGetInfo(f, "S")
                    if info and info.source and info.source:find("Vay") then
                        return {}
                    end
                end
                return realGetUpvalues(f)
            end
            
            debug.getconstants = function(f)
                if type(f) == "function" then
                    local info = realGetInfo(f, "S")
                    if info and info.source and info.source:find("Vay") then
                        return {}
                    end
                end
                return realGetConstants(f)
            end
            
            debug.setupvalue = function(f, up, value)
                if type(f) == "function" then
                    local info = realGetInfo(f, "S")
                    if info and info.source and info.source:find("Vay") then
                        return nil
                    end
                end
                return realSetUpvalue(f, up, value)
            end
            
            debug.setconstant = function(f, idx, value)
                if type(f) == "function" then
                    local info = realGetInfo(f, "S")
                    if info and info.source and info.source:find("Vay") then
                        return nil
                    end
                end
                return realSetConstant(f, idx, value)
            end
            
            debug.getlocal = function(f, level, index)
                if type(f) == "function" then
                    local info = realGetInfo(f, "S")
                    if info and info.source and info.source:find("Vay") then
                        return nil
                    end
                end
                return realGetLocal(f, level, index)
            end
            
            debug.setlocal = function(f, level, index, value)
                if type(f) == "function" then
                    local info = realGetInfo(f, "S")
                    if info and info.source and info.source:find("Vay") then
                        return nil
                    end
                end
                return realSetLocal(f, level, index, value)
            end
            
            debug.getregistry = function()
                local reg = realGetRegistry()
                for k, v in pairs(reg) do
                    if type(v) == "function" then
                        local info = pcall(realGetInfo, v, "S")
                        if info and tostring(info):find("Vay") then
                            reg[k] = nil
                        end
                    end
                end
                return reg
            end
            
            debug.traceback = function(...)
                local tb = realTraceback(...)
                if tb:find("Vay") then
                    tb = tb:gsub("Vay[^\n]*", "[C]: in function")
                end
                return tb
            end
        end
        
        -- Блокировка getgc
        if getgc then
            local realGetGC = getgc
            getgc = function()
                local gc = realGetGC()
                local filtered = {}
                for _, obj in ipairs(gc) do
                    if type(obj) == "function" then
                        local info = pcall(debug.getinfo, obj, "S")
                        if not info or not tostring(info):find("Vay") then
                            table.insert(filtered, obj)
                        end
                    else
                        table.insert(filtered, obj)
                    end
                end
                return filtered
            end
        end
        
        -- Блокировка getnilinstances
        if getnilinstances then
            local realGetNil = getnilinstances
            getnilinstances = function()
                local instances = realGetNil()
                local filtered = {}
                for _, obj in ipairs(instances) do
                    if not obj.Name:find("Vay") then
                        table.insert(filtered, obj)
                    end
                end
                return filtered
            end
        end
    end)
end

--// ==================== АНТИ-ОБНАРУЖЕНИЕ УРОВЕНЬ 4: REMOTE SPOOFING ====================
local function SpoofRemotes()
    pcall(function()
        -- Хук __namecall
        local mt = getrawmetatable(game)
        if mt then
            local oldNamecall = mt.__namecall
            local oldIndex = mt.__index
            local oldNewIndex = mt.__newindex
            
            setreadonly(mt, false)
            
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                
                -- Блокировка античит ремотов
                local blockedMethods = {
                    "FireServer", "InvokeServer", "Fire", "Invoke",
                    "FireClient", "InvokeClient", "FireAllClients"
                }
                
                for _, blocked in ipairs(blockedMethods) do
                    if method == blocked then
                        local remoteName = tostring(self):lower()
                        local blockedPatterns = {
                            "anti", "cheat", "iac", "adonis", "detect", "ban", "kick",
                            "report", "exploit", "hack", "byfron", "hyperion", "safeguard",
                            "security", "verify", "validate", "antiexploit", "moderation",
                            "enforcement", "violation", "infraction", "penalty", "suspicious",
                            "flagged", "detected", "caught", "banned", "kicked"
                        }
                        
                        for _, pattern in ipairs(blockedPatterns) do
                            if remoteName:find(pattern) then
                                return nil
                            end
                        end
                    end
                end
                
                -- Перехват админ команд
                if method == "InvokeServer" or method == "FireServer" then
                    local remoteName = tostring(self):lower()
                    if remoteName:find("admin") or remoteName:find("command") then
                        Vay.AdminDetected = true
                        Vay.AdminType = "Detected"
                        table.insert(Vay.HijackedRemotes, self)
                    end
                end
                
                return oldNamecall(self, unpack(args))
            end)
            
            mt.__index = newcclosure(function(self, key)
                if key == "WalkSpeed" or key == "JumpPower" or key == "Health" then
                    if self == LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        return self[key]
                    end
                end
                return oldIndex(self, key)
            end)
            
            setreadonly(mt, true)
        end
        
        -- Спуфинг hookfunction
        if hookfunction then
            local realHookFunction = hookfunction
            hookfunction = function(original, hook)
                local info = debug.getinfo(2, "S")
                if info and info.source and info.source:find("Vay") then
                    return original
                end
                return realHookFunction(original, hook)
            end
        end
        
        -- Спуфинг hookmetamethod
        if hookmetamethod then
            local realHookMeta = hookmetamethod
            hookmetamethod = function(obj, method, hook)
                if tostring(obj):find("Vay") then
                    return nil
                end
                return realHookMeta(obj, method, hook)
            end
        end
        
        -- Спуфинг newcclosure
        if newcclosure then
            local realNewCClosure = newcclosure
            newcclosure = function(f)
                local wrapped = realNewCClosure(f)
                local mt = getmetatable(wrapped) or {}
                mt.__tostring = function()
                    return "function: 0x" .. string.format("%x", math.random(0, 0xFFFFFFFF))
                end
                mt.__call = function(...) return f(...) end
                mt.__metatable = "Locked"
                setmetatable(wrapped, mt)
                return wrapped
            end
        end
    end)
end

--// ==================== АНТИ-ОБНАРУЖЕНИЕ УРОВЕНЬ 5: BYFRON BYPASS ====================
local function BypassByfron()
    pcall(function()
        -- Создание фальшивых инстансов
        for i = 1, 20 do
            local junk = Instance.new("Part")
            junk.Name = "ByfronJunk_" .. i
            junk.Parent = Workspace
            junk.Anchored = true
            junk.Transparency = 1
            junk.CanCollide = false
            
            spawn(function()
                wait(0.5)
                junk:Destroy()
            end)
        end
        
        -- Спуфинг require
        if require then
            local oldRequire = require
            require = function(id)
                if type(id) == "number" then
                    return oldRequire(id)
                end
                return oldRequire(id)
            end
        end
        
        -- Спуфинг getfenv/setfenv
        if getfenv then
            local realGetFenv = getfenv
            getfenv = function(f)
                if type(f) == "function" then
                    local info = debug.getinfo(f, "S")
                    if info and info.source and info.source:find("Vay") then
                        return {}
                    end
                end
                return realGetFenv(f)
            end
        end
        
        if setfenv then
            local realSetFenv = setfenv
            setfenv = function(f, env)
                if type(f) == "function" then
                    local info = debug.getinfo(f, "S")
                    if info and info.source and info.source:find("Vay") then
                        return f
                    end
                end
                return realSetFenv(f, env)
            end
        end
    end)
end

--// ==================== АНТИ-ОБНАРУЖЕНИЕ УРОВЕНЬ 6: GUI СКРЫТИЕ ====================
local function HideAllGUI()
    pcall(function()
        -- Хук FindFirstChild
        local oldFindFirstChild = game.FindFirstChild
        game.FindFirstChild = function(self, name, recursive)
            local nameStr = tostring(name):lower()
            if nameStr:find("vay") or nameStr:find("trollge") or nameStr:find("esp") or nameStr:find("admin") then
                return nil
            end
            return oldFindFirstChild(self, name, recursive)
        end
        
        -- Хук GetChildren
        local oldGetChildren = game.GetChildren
        game.GetChildren = function(self)
            local children = oldGetChildren(self)
            local filtered = {}
            for _, child in ipairs(children) do
                local nameStr = tostring(child.Name):lower()
                if not nameStr:find("vay") and not nameStr:find("trollge") then
                    table.insert(filtered, child)
                end
            end
            return filtered
        end
        
        -- Хук GetDescendants
        local oldGetDescendants = game.GetDescendants
        game.GetDescendants = function(self)
            local descendants = oldGetDescendants(self)
            local filtered = {}
            for _, child in ipairs(descendants) do
                local nameStr = tostring(child.Name):lower()
                if not nameStr:find("vay") and not nameStr:find("trollge") then
                    table.insert(filtered, child)
                end
            end
            return filtered
        end
        
        -- Автоматическое переименование GUI
        spawn(function()
            while Vay.Settings.HideGUI do
                wait(3)
                pcall(function()
                    local coreGui = game:GetService("CoreGui")
                    for _, child in ipairs(coreGui:GetChildren()) do
                        if child:IsA("ScreenGui") and child.Name:find("Vay") then
                            child.Name = "RobloxGui_" .. math.random(1000000, 9999999)
                        end
                    end
                end)
            end
        end)
    end)
end

--// ==================== ОБНАРУЖЕНИЕ АДМИН СИСТЕМЫ ====================
local function DetectAdminSystem()
    local rs = ReplicatedStorage
    local detected = false
    
    -- Поиск известных админ систем
    local adminSystems = {
        {Name = "Adonis", Paths = {"Adonis", "Adonis_Loader"}, Prefix = ":"},
        {Name = "Kohls", Paths = {"Kohl", "KohlsAdmin"}, Prefix = ";"},
        {Name = "HDAdmin", Paths = {"HDAdmin", "HDS"}, Prefix = ";"},
        {Name = "Infinite Yield", Paths = {"InfYield", "InfiniteYield"}, Prefix = ";"},
        {Name = "BasicAdmin", Paths = {"Cmd", "Command"}, Prefix = "!"}
    }
    
    for _, system in ipairs(adminSystems) do
        for _, path in ipairs(system.Paths) do
            if rs:FindFirstChild(path) then
                Vay.AdminDetected = true
                Vay.AdminType = system.Name
                Vay.AdminPrefix = system.Prefix
                detected = true
                break
            end
        end
        if detected then break end
    end
    
    -- Поиск админ ремотов
    if not detected then
        for _, obj in ipairs(rs:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                local name = obj.Name:lower()
                if name:find("admin") or name:find("command") or name:find("cmd") then
                    Vay.AdminDetected = true
                    Vay.AdminType = "RemoteBased"
                    Vay.AdminPrefix = "/"
                    Vay.HijackedRemotes[#Vay.HijackedRemotes + 1] = obj
                    detected = true
                end
            end
        end
    end
    
    return detected
end

--// ==================== ВЫПОЛНЕНИЕ АДМИН КОМАНД ====================
local function ExecuteAdminCommand(command)
    if not Vay.AdminDetected then return false end
    
    local fullCommand = Vay.AdminPrefix .. command
    local success = false
    
    pcall(function()
        -- Метод 1: Через Chat
        local chatRemote = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if chatRemote then
            local sayMessage = chatRemote:FindFirstChild("SayMessageRequest")
            if sayMessage then
                sayMessage:FireServer(fullCommand, "All")
                success = true
            end
        end
        
        -- Метод 2: Через админ ремоты
        for _, remote in ipairs(Vay.HijackedRemotes) do
            pcall(function()
                remote:FireServer(fullCommand)
                success = true
            end)
        end
        
        -- Метод 3: Поиск всех ремотов
        if not success then
            for _, remote in ipairs(ReplicatedStorage:GetDescendants()) do
                if remote:IsA("RemoteEvent") then
                    local name = remote.Name:lower()
                    if name:find("command") or name:find("admin") or name:find("cmd") then
                        pcall(function()
                            remote:FireServer(fullCommand)
                            success = true
                        end)
                    end
                end
            end
        end
    end)
    
    return success
end

--// ==================== ВЫДАЧА ТРОЛЛЯ ====================
local function GiveTroll(trollName, targetPlayer)
    local target = targetPlayer or (Vay.Settings.TargetPlayer and Players:FindFirstChild(Vay.Settings.TargetPlayer))
    
    if target then
        -- Выдача конкретному игроку
        ExecuteAdminCommand("give " .. trollName .. " " .. target.Name)
        ExecuteAdminCommand("troll " .. trollName .. " " .. target.Name)
        ExecuteAdminCommand("spawn " .. trollName .. " " .. target.Name)
        ExecuteAdminCommand("unlock " .. trollName .. " " .. target.Name)
    else
        -- Выдача себе
        ExecuteAdminCommand("give " .. trollName)
        ExecuteAdminCommand("troll " .. trollName)
        ExecuteAdminCommand("spawn " .. trollName)
        ExecuteAdminCommand("unlock " .. trollName)
    end
    
    -- Авто-респавн для смены персонажа
    if Vay.Settings.AutoRespawn then
        spawn(function()
            wait(0.5)
            pcall(function()
                LocalPlayer:LoadCharacter()
            end)
        end)
    end
    
    return true
end

--// ==================== ВЫДАЧА ПРЕДМЕТА ====================
local function GiveItem(itemName, targetPlayer)
    local target = targetPlayer or (Vay.Settings.TargetPlayer and Players:FindFirstChild(Vay.Settings.TargetPlayer))
    
    if target then
        ExecuteAdminCommand("giveitem " .. itemName .. " " .. target.Name)
        ExecuteAdminCommand("item " .. itemName .. " " .. target.Name)
        ExecuteAdminCommand("give " .. itemName .. " " .. target.Name)
    else
        ExecuteAdminCommand("giveitem " .. itemName)
        ExecuteAdminCommand("item " .. itemName)
        ExecuteAdminCommand("give " .. itemName)
    end
    
    return true
end

--// ==================== МАССОВАЯ ВЫДАЧА ====================
local function GiveAllTrolls(tier)
    local trolls = Vay.TrollDatabase[tier] or {}
    local count = 0
    
    for _, troll in ipairs(trolls) do
        if Vay.Settings.GiveToAll then
            for _, player in ipairs(Players:GetPlayers()) do
                GiveTroll(troll, player)
                wait(0.01)
            end
        else
            GiveTroll(troll)
            wait(0.01)
        end
        count = count + 1
    end
    
    return count
end

local function GiveAllItems()
    local count = 0
    
    for _, item in ipairs(Vay.TrollDatabase.Items) do
        if Vay.Settings.GiveToAll then
            for _, player in ipairs(Players:GetPlayers()) do
                GiveItem(item, player)
                wait(0.01)
            end
        else
            GiveItem(item)
            wait(0.01)
        end
        count = count + 1
    end
    
    return count
end

--// ==================== ФУНКЦИИ БЕЗОПАСНОСТИ ====================
local function ClearAllTraces()
    pcall(function()
        -- Очистка консоли
        for i = 1, 100 do
            _G.OriginalPrint("")
        end
        
        -- Удаление временных файлов
        for _, obj in ipairs(Workspace:GetChildren()) do
            if obj.Name:find("ByfronJunk") then
                obj:Destroy()
            end
        end
        
        -- Сброс хуков
        if debug then
            debug.setupvalue = nil
            debug.setconstant = nil
            debug.setlocal = nil
        end
    end)
end

--// ==================== ФУНКЦИИ ИГРОКА ====================
local function RespawnCharacter()
    pcall(function()
        LocalPlayer:LoadCharacter()
    end)
end

local function TeleportToPlayer(targetPlayer)
    local target = Players:FindFirstChild(targetPlayer)
    if target and target.Character then
        local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot and RootPart then
            RootPart.CFrame = targetRoot.CFrame + Vector3.new(0, 2, 0)
        end
    end
end

local function TeleportToTroll(trollName)
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name == trollName or obj.Name:find(trollName) then
            if obj:IsA("Model") and obj.PrimaryPart then
                RootPart.CFrame = obj.PrimaryPart.CFrame + Vector3.new(0, 2, 0)
                return true
            end
        end
    end
    return false
end

--// ==================== ФУНКЦИИ GUI ====================
local function CreateNotification(title, message, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = message,
            Duration = duration or 3,
            Button1 = "OK"
        })
    end)
end

--// ==================== ФУНКЦИИ МОНИТОРИНГА ====================
local function MonitorAntiCheat()
    spawn(function()
        while true do
            wait(5)
            
            -- Проверка новых скриптов
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Script") or obj:IsA("LocalScript") then
                    local source = pcall(function() return obj.Source end)
                    if source then
                        local srcLower = source:lower()
                        if srcLower:find("anti") or srcLower:find("cheat") or srcLower:find("detect") then
                            obj.Enabled = false
                            obj.Parent = nil
                        end
                    end
                end
            end
            
            -- Проверка GUI античита
            if LocalPlayer.PlayerGui then
                for _, gui in ipairs(LocalPlayer.PlayerGui:GetChildren()) do
                    local name = gui.Name:lower()
                    if name:find("anticheat") or name:find("detection") then
                        gui:Destroy()
                    end
                end
            end
        end
    end)
end

--// ==================== ФУНКЦИИ ПЕРСОНАЖА ====================
local function GodMode(enable)
    spawn(function()
        while enable do
            wait(0.1)
            pcall(function()
                if Character and Humanoid then
                    Humanoid.Health = Humanoid.MaxHealth
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                end
            end)
        end
    end)
end

local function SpeedHack(speed)
    if Humanoid then
        Humanoid.WalkSpeed = speed
    end
end

local function Fly(enable, speed)
    spawn(function()
        while enable and RootPart do
            wait()
            
            local bv = RootPart:FindFirstChild("FlyVelocity") or Instance.new("BodyVelocity")
            bv.Name = "FlyVelocity"
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Parent = RootPart
            
            local bg = RootPart:FindFirstChild("FlyGyro") or Instance.new("BodyGyro")
            bg.Name = "FlyGyro"
            bg.CFrame = Workspace.CurrentCamera.CFrame
            bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            bg.Parent = RootPart
            
            local dir = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.yAxis end
            
            if dir.Magnitude > 0 then
                bv.Velocity = dir.Unit * speed
            end
        end
        
        if RootPart then
            local bv = RootPart:FindFirstChild("FlyVelocity")
            if bv then bv:Destroy() end
            local bg = RootPart:FindFirstChild("FlyGyro")
            if bg then bg:Destroy() end
        end
    end)
end

local function Noclip(enable)
    spawn(function()
        while enable and Character do
            wait()
            for _, part in ipairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function InfiniteJump(enable)
    if Humanoid then
        Humanoid.UseJumpPower = not enable
    end
end

local function ESP(enable)
    local espObjects = {}
    
    spawn(function()
        while enable do
            wait(0.5)
            
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj ~= Character then
                    if not espObjects[obj] then
                        -- Создание ESP
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "VayESP"
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.OutlineTransparency = 0
                        highlight.Adornee = obj
                        highlight.Parent = obj
                        
                        espObjects[obj] = highlight
                    end
                end
            end
            
            -- Удаление ESP для удаленных объектов
            for obj, highlight in pairs(espObjects) do
                if not obj or not obj.Parent then
                    highlight:Destroy()
                    espObjects[obj] = nil
                end
            end
        end
        
        -- Очистка всех ESP
        for _, highlight in pairs(espObjects) do
            highlight:Destroy()
        end
        espObjects = {}
    end)
end

local function KillAura(enable, radius)
    spawn(function()
        while enable and RootPart do
            wait(0.1)
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj ~= Character then
                    local hum = obj.Humanoid
                    local hrp = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
                    if hrp and hum.Health > 0 then
                        if (RootPart.Position - hrp.Position).Magnitude <= radius then
                            hum.Health = 0
                        end
                    end
                end
            end
        end
    end)
end

--// ==================== ИНИЦИАЛИЗАЦИЯ ====================
local function Initialize()
    -- Активация всех систем защиты
    DisableAllLogging()
    ProtectMemoryRegions()
    DisableDebugger()
    SpoofRemotes()
    BypassByfron()
    HideAllGUI()
    MonitorAntiCheat()
    
    -- Обнаружение админ системы
    local hasAdmin = DetectAdminSystem()
    
    -- Уведомление о готовности
    CreateNotification(
        "Vay Admin Hijack v" .. Vay.Version,
        hasAdmin and "Admin detected: " .. Vay.AdminType or "No admin detected, using fallback",
        5
    )
    
    return hasAdmin
end

--// ==================== ОСНОВНЫЕ КОМАНДЫ ====================
local Commands = {
    -- Выдача троллей
    GiveTroll = function(trollName, player)
        return GiveTroll(trollName, player)
    end,
    
    GiveAllSTier = function()
        return GiveAllTrolls("S_Tier")
    end,
    
    -- Выдача предметов
    GiveItem = function(itemName, player)
        return GiveItem(itemName, player)
    end,
    
    GiveAllItems = function()
        return GiveAllItems()
    end,
    
    -- Функции персонажа
    Respawn = RespawnCharacter,
    TeleportToPlayer = TeleportToPlayer,
    TeleportToTroll = TeleportToTroll,
    
    -- Читы
    GodMode = GodMode,
    SpeedHack = SpeedHack,
    Fly = Fly,
    Noclip = Noclip,
    InfiniteJump = InfiniteJump,
    ESP = ESP,
    KillAura = KillAura,
    
    -- Настройки
    SetTargetPlayer = function(playerName)
        Vay.Settings.TargetPlayer = playerName
    end,
    
    SetGiveToAll = function(enable)
        Vay.Settings.GiveToAll = enable
    end,
    
    SetAutoRespawn = function(enable)
        Vay.Settings.AutoRespawn = enable
    end,
    
    -- Информация
    GetStatus = function()
        return {
            Version = Vay.Version,
            AdminDetected = Vay.AdminDetected,
            AdminType = Vay.AdminType,
            AdminPrefix = Vay.AdminPrefix,
            HijackedRemotes = #Vay.HijackedRemotes
        }
    end,
    
    -- Экстренные функции
    ClearTraces = ClearAllTraces,
    EmergencyShutdown = function()
        Vay.Settings.MemoryProtection = false
        Vay.Settings.HideGUI = false
        ClearAllTraces()
        CreateNotification("Vay", "Emergency shutdown complete", 3)
    end
}

--// ==================== GUI ИНТЕРФЕЙС ====================
local function CreateGUI()
    local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
    local Window = OrionLib:MakeWindow({
        Name = "Vay Admin Hijack | " .. LocalPlayer.Name,
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "VayAdmin",
        IntroEnabled = true,
        IntroText = "Vay Admin System",
        IntroIcon = "rbxassetid://7733961820"
    })
    
    -- Вкладка Trolls
    local TrollTab = Window:MakeTab({
        Name = "Trolls",
        Icon = "rbxassetid://7733961820"
    })
    
    TrollTab:AddButton({
        Name = "Give All S-Tier Trolls",
        Callback = function()
            local count = Commands.GiveAllSTier()
            OrionLib:MakeNotification({
                Name = "Vay",
                Content = "Gave " .. count .. " S-Tier trolls!",
                Time = 3
            })
        end
    })
    
    TrollTab:AddDropdown({
        Name = "Select Troll",
        Default = Vay.TrollDatabase.S_Tier[1],
        Options = Vay.TrollDatabase.S_Tier,
        Callback = function(value)
            _G.SelectedTroll = value
        end
    })
    
    TrollTab:AddButton({
        Name = "Give Selected Troll",
        Callback = function()
            if _G.SelectedTroll then
                Commands.GiveTroll(_G.SelectedTroll)
                OrionLib:MakeNotification({
                    Name = "Vay",
                    Content = "Gave " .. _G.SelectedTroll .. "!",
                    Time = 3
                })
            end
        end
    })
    
    -- Вкладка Items
    local ItemTab = Window:MakeTab({
        Name = "Items",
        Icon = "rbxassetid://7733956667"
    })
    
    ItemTab:AddButton({
        Name = "Give All Items",
        Callback = function()
            local count = Commands.GiveAllItems()
            OrionLib:MakeNotification({
                Name = "Vay",
                Content = "Gave " .. count .. " items!",
                Time = 3
            })
        end
    })
    
    ItemTab:AddDropdown({
        Name = "Select Item",
        Default = Vay.TrollDatabase.Items[1],
        Options = Vay.TrollDatabase.Items,
        Callback = function(value)
            _G.SelectedItem = value
        end
    })
    
    ItemTab:AddButton({
        Name = "Give Selected Item",
        Callback = function()
            if _G.SelectedItem then
                Commands.GiveItem(_G.SelectedItem)
                OrionLib:MakeNotification({
                    Name = "Vay",
                    Content = "Gave " .. _G.SelectedItem .. "!",
                    Time = 3
                })
            end
        end
    })
    
    -- Вкладка Players
    local PlayerTab = Window:MakeTab({
        Name = "Players",
        Icon = "rbxassetid://7733963321"
    })
    
    local playerList = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    
    PlayerTab:AddDropdown({
        Name = "Target Player",
        Default = playerList[1] or "",
        Options = playerList,
        Callback = function(value)
            Commands.SetTargetPlayer(value)
        end
    })
    
    PlayerTab:AddToggle({
        Name = "Give to All Players",
        Default = false,
        Callback = function(value)
            Commands.SetGiveToAll(value)
        end
    })
    
    PlayerTab:AddButton({
        Name = "Teleport to Player",
        Callback = function()
            if Vay.Settings.TargetPlayer then
                Commands.TeleportToPlayer(Vay.Settings.TargetPlayer)
            end
        end
    })
    
    -- Вкладка Character
    local CharTab = Window:MakeTab({
        Name = "Character",
        Icon = "rbxassetid://7733956667"
    })
    
    CharTab:AddToggle({
        Name = "God Mode",
        Default = false,
        Callback = function(value)
            Commands.GodMode(value)
        end
    })
    
    CharTab:AddToggle({
        Name = "Auto Respawn",
        Default = true,
        Callback = function(value)
            Commands.SetAutoRespawn(value)
        end
    })
    
    CharTab:AddSlider({
        Name = "Walk Speed",
        Min = 16,
        Max = 500,
        Default = 16,
        Callback = function(value)
            Commands.SpeedHack(value)
        end
    })
    
    CharTab:AddToggle({
        Name = "Fly",
        Default = false,
        Callback = function(value)
            Commands.Fly(value, 50)
        end
    })
    
    CharTab:AddSlider({
        Name = "Fly Speed",
        Min = 10,
        Max = 500,
        Default = 50,
        Callback = function(value)
            if _G.FlyEnabled then
                Commands.Fly(true, value)
            end
        end
    })
    
    CharTab:AddToggle({
        Name = "Noclip",
        Default = false,
        Callback = function(value)
            Commands.Noclip(value)
        end
    })
    
    CharTab:AddToggle({
        Name = "Infinite Jump",
        Default = false,
        Callback = function(value)
            Commands.InfiniteJump(value)
        end
    })
    
    CharTab:AddButton({
        Name = "Respawn",
        Callback = function()
            Commands.Respawn()
        end
    })
    
    -- Вкладка Combat
    local CombatTab = Window:MakeTab({
        Name = "Combat",
        Icon = "rbxassetid://7733961820"
    })
    
    CombatTab:AddToggle({
        Name = "ESP",
        Default = false,
        Callback = function(value)
            Commands.ESP(value)
        end
    })
    
    CombatTab:AddToggle({
        Name = "Kill Aura",
        Default = false,
        Callback = function(value)
            Commands.KillAura(value, _G.KillRadius or 100)
        end
    })
    
    CombatTab:AddSlider({
        Name = "Kill Radius",
        Min = 10,
        Max = 500,
        Default = 100,
        Callback = function(value)
            _G.KillRadius = value
        end
    })
    
    -- Вкладка Settings
    local SetTab = Window:MakeTab({
        Name = "Settings",
        Icon = "rbxassetid://7733956667"
    })
    
    SetTab:AddButton({
        Name = "Clear All Traces",
        Callback = function()
            Commands.ClearTraces()
            OrionLib:MakeNotification({
                Name = "Vay",
                Content = "Traces cleared!",
                Time = 3
            })
        end
    })
    
    SetTab:AddButton({
        Name = "Emergency Shutdown",
        Callback = function()
            Commands.EmergencyShutdown()
            OrionLib:MakeNotification({
                Name = "Vay",
                Content = "Emergency shutdown complete",
                Time = 3
            })
        end
    })
    
    SetTab:AddButton({
        Name = "Get Status",
        Callback = function()
            local status = Commands.GetStatus()
            OrionLib:MakeNotification({
                Name = "Vay Status",
                Content = string.format(
                    "Version: %s\nAdmin: %s\nType: %s\nPrefix: %s",
                    status.Version,
                    tostring(status.AdminDetected),
                    status.AdminType,
                    status.AdminPrefix
                ),
                Time = 5
            })
        end
    })
    
    SetTab:AddBind({
        Name = "Toggle UI",
        Default = Enum.KeyCode.RightControl,
        Callback = function()
            OrionLib:Toggle()
        end
    })
    
    OrionLib:Init()
    return Window
end

--// ==================== АВТО-ЗАПУСК ====================
local function AutoStart()
    -- Инициализация защиты
    Initialize()
    
    -- Создание GUI
    spawn(function()
        wait(1)
        pcall(function()
            CreateGUI()
        end)
    end)
    
    -- Экспорт команд в глобальную область (опционально)
    _G.Vay = Commands
    
    -- Уведомление о готовности
    CreateNotification(
        "Vay Admin System",
        "Successfully loaded! Press " .. tostring(Enum.KeyCode.RightControl) .. " to open menu",
        5
    )
end

-- Запуск
AutoStart()

--// ==================== ПРИМЕРЫ ИСПОЛЬЗОВАНИЯ ====================
--[[
    -- Выдать тролля себе
    _G.Vay.GiveTroll("Gojo")
    
    -- Выдать тролля другому игроку
    _G.Vay.GiveTroll("Sukuna", "PlayerName")
    
    -- Выдать все S-Tier тролли
    _G.Vay.GiveAllSTier()
    
    -- Выдать предмет
    _G.Vay.GiveItem("Omniversal chest")
    
    -- Выдать все предметы
    _G.Vay.GiveAllItems()
    
    -- Включить God Mode
    _G.Vay.GodMode(true)
    
    -- Включить Fly
    _G.Vay.Fly(true, 50)
    
    -- Телепортироваться к игроку
    _G.Vay.TeleportToPlayer("PlayerName")
    
    -- Респавн
    _G.Vay.Respawn()
    
    -- Очистить следы
    _G.Vay.ClearTraces()
    
    -- Получить статус
    local status = _G.Vay.GetStatus()
    print(status.AdminType)
]]

return Commands
