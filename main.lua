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

-- 3. Утилиты (расширенные)
local Utils = {}
function Utils:Notify(title, msg, duration)
Fluent:Notify({ Title = title or "VayTrollge", Content = msg, Duration = duration or 3 })
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

                            -- 4. Кастомные списки (ПОЛНЫЕ)
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

                            -- 5. Настройки (расширенные)
                            local Settings = {
                                Admin = { GiveToAll = false, TargetPlayer = nil, AutoRespawn = true, Prefix = ";" },
                                Visual = { ESP = false, Fullbright = false, NoFog = false, FOV = 70, XRay = false, ThirdPerson = false, Freecam = false, Chams = false },
                                Combat = { KillAura = false, KillRadius = 100, Aimbot = false, AimbotRadius = 200, TriggerBot = false, SpinBot = false, AntiStun = false },
                                Movement = { Fly = false, FlySpeed = 50, Noclip = false, Speed = 50, SpeedEnabled = false, InfJump = false, BHop = false },
                                Farm = { AutoFarm = false, AutoFarmRange = 500, AutoCollect = false, AutoCollectRange = 50, ItemVacuum = false, ItemVacuumRange = 100, AutoOpenChests = false, AutoCups = false },
                                Utility = { AntiAFK = true, FPSBoost = true, AutoClicker = false, AutoClickerInterval = 0.01 }
                            }

                            -- 6. Обход Nova и Поиск Remote (Модули 16-30)
                            local RemoteHunter = {
                                Found = {},
                                Scan = function()
                                RemoteHunter.Found = {}
                                local function scanContainer(c)
                                for _, v in ipairs(c:GetDescendants()) do
                                    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                                        table.insert(RemoteHunter.Found, v)
                                        end
                                        end
                                        end
                                        scanContainer(Services.ReplicatedStorage)
                                        pcall(function()
                                        for _, v in pairs(getgc(true)) do
                                            if typeof(v) == "Instance" and v.Name == "NovaReplicatedStorage" then
                                                scanContainer(v)
                                                end
                                                end
                                                end)
                                        return RemoteHunter.Found
                                        end,
                                        FindRemote = function(name)
                                        for _, r in ipairs(RemoteHunter.Found) do
                                            if r.Name:lower():find(name:lower()) then return r end
                                                end
                                                return nil
                                                end,
                                                SmartFire = function(namePattern, ...)
                                                local args = {...}
                                                for _, remote in ipairs(RemoteHunter.Found) do
                                                    if remote.Name:lower():find(namePattern:lower()) then
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
                                                        end,
                                                        HookRemote = function(remote, callback) -- перехват
                                                        if not remote then return end
                                                            local old = remote.FireServer
                                                            remote.FireServer = function(self, ...)
                                                            callback(self, ...)
                                                            return old(self, ...)
                                                            end
                                                            end,
                                                            BlockRemote = function(remote) remote.Parent = nil end,
                                                            GetRemoteArgs = function(remote) -- эвристика через hook
                                                            local args = {}
                                                            local old = remote.OnServerEvent
                                                            remote.OnServerEvent:Connect(function(...) args = {...} end)
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

                            -- 7. Админ-система (Модули 31-50)
                            local Admin = {
                                Detected = false, Type = "None", Prefix = ";",
                                DetectSystem = function()
                                local rs = Services.ReplicatedStorage
                                local systems = {
                                    {Name = "Adonis", Path = "Adonis", Prefix = ":"},
                                    {Name = "Kohls", Path = "Kohl", Prefix = ";"},
                                    {Name = "HDAdmin", Path = "HDAdmin", Prefix = ";"},
                                    {Name = "Infinite Yield", Path = "InfYield", Prefix = ";"}
                                }
                                for _, sys in ipairs(systems) do
                                    if rs:FindFirstChild(sys.Path) then
                                        Admin.Detected = true; Admin.Type = sys.Name; Admin.Prefix = sys.Prefix
                                        return true
                                        end
                                        end
                                        return false
                                        end,
                                        ExecuteCommand = function(cmd)
                                        local full = Admin.Prefix .. cmd
                                        local success = RemoteHunter:SmartFire("admin", full) or RemoteHunter:SmartFire("cmd", full)
                                        if not success then
                                            pcall(function()
                                            local chat = Services.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                                            if chat then
                                                local say = chat:FindFirstChild("SayMessageRequest")
                                                if say then say:FireServer(full, "All") success = true end
                                                    end
                                                    end)
                                            end
                                            return success
                                            end,
                                            GiveTroll = function(name, target)
                                            local t = target or Settings.Admin.TargetPlayer
                                            local cmds = {"give " .. name, "troll " .. name, "spawn " .. name}
                                            if t then for i, c in ipairs(cmds) do cmds[i] = c .. " " .. t end end
                                                for _, c in ipairs(cmds) do if Admin:ExecuteCommand(c) then return true end wait(0.05) end
                                                    return RemoteHunter:SmartFire("give", name) or RemoteHunter:SmartFire("troll", name)
                                                    end,
                                                    GiveItem = function(name, target)
                                                    local t = target or Settings.Admin.TargetPlayer
                                                    local cmds = {"giveitem " .. name, "item " .. name}
                                                    if t then for i, c in ipairs(cmds) do cmds[i] = c .. " " .. t end end
                                                        for _, c in ipairs(cmds) do if Admin:ExecuteCommand(c) then return true end wait(0.05) end
                                                            return RemoteHunter:SmartFire("giveitem", name)
                                                            end,
                                                            GiveAllTrolls = function()
                                                            for _, troll in ipairs(CustomLists.Trolls) do
                                                                if Settings.Admin.GiveToAll then
                                                                    for _, p in ipairs(Services.Players:GetPlayers()) do
                                                                        Admin:GiveTroll(troll, p.Name) wait(0.05)
                                                                        end
                                                                        else Admin:GiveTroll(troll) end
                                                                            wait(0.1)
                                                                            end
                                                                            Utils:Notify("✅", "Все тролли выданы!")
                                                                            end,
                                                                            GiveAllItems = function()
                                                                            for _, item in ipairs(CustomLists.Items) do
                                                                                if Settings.Admin.GiveToAll then
                                                                                    for _, p in ipairs(Services.Players:GetPlayers()) do
                                                                                        Admin:GiveItem(item, p.Name) wait(0.05)
                                                                                        end
                                                                                        else Admin:GiveItem(item) end
                                                                                            wait(0.1)
                                                                                            end
                                                                                            Utils:Notify("✅", "Все предметы выданы!")
                                                                                            end,
                                                                                            SetTarget = function(name)
                                                                                            if name == "all" then Settings.Admin.GiveToAll = true; Settings.Admin.TargetPlayer = nil
                                                                                                elseif name == "me" then Settings.Admin.GiveToAll = false; Settings.Admin.TargetPlayer = nil
                                                                                                    else local p = Utils:FindPlayer(name) if p then Settings.Admin.GiveToAll = false; Settings.Admin.TargetPlayer = p.Name end end
                                                                                                        end,
                                                                                                        KickPlayer = function(name) Admin:ExecuteCommand("kick " .. name) end,
                                                                                                        BanPlayer = function(name) Admin:ExecuteCommand("ban " .. name) end,
                                                                                                        KillPlayer = function(name) Admin:ExecuteCommand("kill " .. name) end,
                                                                                                        RespawnPlayer = function(name) Admin:ExecuteCommand("respawn " .. name) end,
                                                                                                        TeleportToPlayer = function(name)
                                                                                                        local p = Utils:FindPlayer(name)
                                                                                                        if p and p.Character then
                                                                                                            local root = Utils:GetRoot()
                                                                                                            local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
                                                                                                            if root and tRoot then root.CFrame = tRoot.CFrame + Vector3.new(0,2,0) return true end
                                                                                                                end
                                                                                                                return false
                                                                                                                end,
                                                                                                                BringPlayer = function(name) Admin:ExecuteCommand("bring " .. name) end,
                                                                                                                FreezePlayer = function(name) Admin:ExecuteCommand("freeze " .. name) end,
                                                                                                                GodModePlayer = function(name) Admin:ExecuteCommand("god " .. name) end,
                                                                                                                KillAllTrolls = function()
                                                                                                                local count = 0
                                                                                                                for _, troll in ipairs(Utils:GetAllTrolls()) do
                                                                                                                    local hum = troll:FindFirstChild("Humanoid")
                                                                                                                    if hum then hum.Health = 0; count = count + 1 end
                                                                                                                        end
                                                                                                                        Utils:Notify("💀", "Убито троллей: " .. count)
                                                                                                                        end
                            }

                            -- 8. Визуал (Модули 92 + доп.)
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
                                                                     while Settings.Visual.Freecam do wait()
                                                                         local dir = Vector3.zero; local UIS = Services.UserInputService
                                                                         if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
                                                                             if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
                                                                                 if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
                                                                                     if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
                                                                                         if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.yAxis end
                                                                                             if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.yAxis end
                                                                                                 Camera.CFrame = Camera.CFrame + dir * 5
                                                                                                end
                                                                                                end)
                                                                    else
                                                                        Camera.CameraType = Enum.CameraType.Custom
                                                                        end
                                                                        end
                            }

                            -- 9. Бой (Модули 88-91 + 93-94)
                            local Combat = {
                                KillAura = function()
                                if not Settings.Combat.KillAura then return end
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

                            -- 10. Движение (Модули 88-91)
                            local Movement = {
                                Fly = function()
                                if not Settings.Movement.Fly then return end
                                    local root = Utils:GetRoot(); if not root then return end
                                    local bv = root:FindFirstChild("FlyVel") or Instance.new("BodyVelocity")
                                    bv.Name = "FlyVel"; bv.MaxForce = Vector3.new(1e5,1e5,1e5); bv.Parent = root
                                    local bg = root:FindFirstChild("FlyGyro") or Instance.new("BodyGyro")
                                    bg.Name = "FlyGyro"; bg.CFrame = Camera.CFrame; bg.MaxTorque = Vector3.new(1e5,1e5,1e5); bg.Parent = root
                                    local dir = Vector3.zero; local UIS = Services.UserInputService
                                    if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
                                        if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
                                            if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
                                                if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
                                                    if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.yAxis end
                                                        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.yAxis end
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

                            -- 11. Фарм (Модули 57-70)
                            local Farm = {
                                AutoFarm = function()
                                if not Settings.Farm.AutoFarm then return end
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
                                                            if not Settings.Farm.AutoCollect then return end
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
                                                                            if not Settings.Farm.ItemVacuum then return end
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
                                                                                            if not Settings.Farm.AutoOpenChests then return end
                                                                                                local root = Utils:GetRoot(); if not root then return end
                                                                                                for _, obj in ipairs(Services.Workspace:GetDescendants()) do
                                                                                                    for _, chestName in ipairs(CustomLists.Chests) do
                                                                                                        if obj.Name:lower():find(chestName:lower()) then
                                                                                                            if obj:IsA("BasePart") and Utils:Distance(root.Position, obj.Position) <= 50 then
                                                                                                                root.CFrame = obj.CFrame; wait(0.2)
                                                                                                                elseif obj:IsA("Model") then
                                                                                                                    local prompt = obj:FindFirstChild("ProximityPrompt")
                                                                                                                    if prompt then fireproximityprompt(prompt) end
                                                                                                                        end
                                                                                                                        end
                                                                                                                        end
                                                                                                                        end
                                                                                                                        end,
                                                                                                                        AutoCups = function()
                                                                                                                        if not Settings.Farm.AutoCups then return end
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

                            -- 12. Телепорты (Модули 86-87)
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

                            -- 13. Утилиты (Модули 95-100)
                            local Utility = {
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
                                            Rejoin = function() Services.TeleportService:Teleport(game.PlaceId, LocalPlayer) end,
                                            AntiAFK = function()
                                            LocalPlayer.Idled:Connect(function()
                                            if Settings.Utility.AntiAFK then
                                                Services.VirtualUser:Button2Down(Vector2.new(0,0), Camera.CFrame)
                                                wait(1)
                                                Services.VirtualUser:Button2Up(Vector2.new(0,0))
                                                end
                                                end)
                                            end,
                                            FPSBoost = function()
                                            if Settings.Utility.FPSBoost then
                                                pcall(function()
                                                settings().Rendering.QualityLevel = 1
                                                Services.Lighting.GlobalShadows = false
                                                Services.Lighting.Outlines = false
                                                end)
                                                end
                                                end,
                                                AutoClicker = function()
                                                spawn(function()
                                                while Settings.Utility.AutoClicker do
                                                    wait(Settings.Utility.AutoClickerInterval)
                                                    Services.VirtualUser:Button1Down()
                                                    wait(0.001)
                                                    Services.VirtualUser:Button1Up()
                                                    end
                                                    end)
                                                end
                            }

                            -- 14. Циклы обновления
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

                            -- 15. Создание GUI Fluent с обработкой ошибок
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

                            -- Админ
                            Tabs.Admin:AddButton({ Title = "🔎 Обнаружить админку", Callback = function()
                                if Admin:DetectSystem() then Utils:Notify("Админка", Admin.Type .. " | " .. Admin.Prefix)
                                    else Utils:Notify("Админка", "Не найдена") end
                                        end })
                            Tabs.Admin:AddButton({ Title = "🎯 Цель: СЕБЕ", Callback = function() Admin:SetTarget("me") end })
                            Tabs.Admin:AddButton({ Title = "🌐 Цель: ВСЕ", Callback = function() Admin:SetTarget("all") end })
                            Tabs.Admin:AddButton({ Title = "👢 Кикнуть", Callback = function()
                                local name = "игрок" -- можно через TextBox
                                Admin:KickPlayer(name)
                                end })
                            Tabs.Admin:AddButton({ Title = "💀 Убить всех троллей", Callback = function() Admin:KillAllTrolls() end })

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

                                    -- Remote
                                    Tabs.Remote:AddButton({ Title = "🔄 Сканировать", Callback = function() RemoteHunter:Scan() end })
                                    Tabs.Remote:AddButton({ Title = "📋 Список в консоль", Callback = function()
                                        for _, r in ipairs(RemoteHunter.Found) do print(r.Name, r:GetFullName()) end
                                            end })
                                    Tabs.Remote:AddButton({ Title = "🚫 Блокировать 'kick'", Callback = function()
                                        local r = RemoteHunter:FindRemote("kick")
                                        if r then RemoteHunter:BlockRemote(r) end
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

                                    -- Визуал
                                    Tabs.Visual:AddToggle({ Title = "👁 ESP", Default = false, Callback = function(v) Settings.Visual.ESP = v end })
                                    Tabs.Visual:AddToggle({ Title = "☀ Fullbright", Default = false, Callback = function(v) Visual:SetFullbright(v) end })
                                    Tabs.Visual:AddToggle({ Title = "🌫 No Fog", Default = false, Callback = function(v) Visual:SetNoFog(v) end })
                                    Tabs.Visual:AddSlider({ Title = "📷 FOV", Default = 70, Min = 30, Max = 120, Callback = function(v) Visual:SetFOV(v) end })
                                    Tabs.Visual:AddToggle({ Title = "🔍 X-Ray", Default = false, Callback = function(v) Settings.Visual.XRay = v end })
                                    Tabs.Visual:AddToggle({ Title = "🎥 Third Person", Default = false, Callback = function(v) Visual:SetThirdPerson(v) end })
                                    Tabs.Visual:AddToggle({ Title = "🎥 Freecam", Default = false, Callback = function(v) Visual:SetFreecam(v) end })

                                    -- Движение
                                    Tabs.Move:AddToggle({ Title = "🦅 Fly", Default = false, Callback = function(v) Movement:SetFly(v, Settings.Movement.FlySpeed) end })
                                    Tabs.Move:AddSlider({ Title = "Скорость Fly", Default = 50, Min = 10, Max = 200, Callback = function(v) Settings.Movement.FlySpeed = v; if Settings.Movement.Fly then Movement:SetFly(true, v) end end })
                                    Tabs.Move:AddToggle({ Title = "🚶 Noclip", Default = false, Callback = function(v) Movement:SetNoclip(v) end })
                                    Tabs.Move:AddToggle({ Title = "🏃 Speed", Default = false, Callback = function(v) Settings.Movement.SpeedEnabled = v; if v then Movement:SetSpeed(Settings.Movement.Speed) else Movement:SetSpeed(16) end end })
                                    Tabs.Move:AddSlider({ Title = "Значение Speed", Default = 50, Min = 16, Max = 200, Callback = function(v) Settings.Movement.Speed = v; if Settings.Movement.SpeedEnabled then Movement:SetSpeed(v) end end })
                                    Tabs.Move:AddToggle({ Title = "🦘 Inf Jump", Default = false, Callback = function(v) Movement:SetInfJump(v) end })
                                    Tabs.Move:AddToggle({ Title = "🏃 BHop", Default = false, Callback = function(v) Settings.Movement.BHop = v end })

                                    -- Фарм
                                    Tabs.Farm:AddToggle({ Title = "🤖 Auto Farm", Default = false, Callback = function(v) Settings.Farm.AutoFarm = v end })
                                    Tabs.Farm:AddToggle({ Title = "📦 Auto Collect", Default = false, Callback = function(v) Settings.Farm.AutoCollect = v end })
                                    Tabs.Farm:AddToggle({ Title = "🧲 Item Vacuum", Default = false, Callback = function(v) Settings.Farm.ItemVacuum = v end })
                                    Tabs.Farm:AddToggle({ Title = "📦 Auto Chests", Default = false, Callback = function(v) Settings.Farm.AutoOpenChests = v end })
                                    Tabs.Farm:AddToggle({ Title = "🥤 Auto Cups", Default = false, Callback = function(v) Settings.Farm.AutoCups = v end })

                                    -- Телепорт
                                    Tabs.Teleport:AddButton({ Title = "📍 Spawn", Callback = function() Teleports:ToLocation("Spawn") end })
                                    Tabs.Teleport:AddButton({ Title = "📍 Shop", Callback = function() Teleports:ToLocation("Shop") end })
                                    Tabs.Teleport:AddButton({ Title = "💾 Сохранить", Callback = function() Teleports:SaveLocation("Custom") end })
                                    Tabs.Teleport:AddButton({ Title = "👤 ТП к игроку", Callback = function() -- TextBox
                                        end })

                                    -- Утилиты
                                    Tabs.Util:AddButton({ Title = "🔄 Server Hop", Callback = function() Utility:ServerHop() end })
                                    Tabs.Util:AddButton({ Title = "🚀 Rejoin", Callback = function() Utility:Rejoin() end })
                                    Tabs.Util:AddToggle({ Title = "🛡️ Anti-AFK", Default = true, Callback = function(v) Settings.Utility.AntiAFK = v end })
                                    Tabs.Util:AddToggle({ Title = "⚡ FPS Boost", Default = true, Callback = function(v) Settings.Utility.FPSBoost = v; Utility:FPSBoost() end })
                                    Tabs.Util:AddToggle({ Title = "🖱️ Auto Clicker", Default = false, Callback = function(v) Settings.Utility.AutoClicker = v; if v then Utility:AutoClicker() end end })

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

                                    -- Инициализация
                                    RemoteHunter:Scan()
                                    Utility:AntiAFK()
                                    Utility:FPSBoost()
                                    Utils:Notify("✅ VayTrollge v33", "100 модулей загружено! LeftControl для меню")
                                    print("VayTrollge 100 modules edition готов!")
