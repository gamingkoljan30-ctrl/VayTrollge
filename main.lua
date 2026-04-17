--[[
    🔥 VAYTROLLGE - FINAL EDITION
    📦 Версия: 28.0.0
    ✅ Все модули + Nova обход + Автовыдача + Полная автоматизация
    ⚙️ Xeno Executor Ready
]]

-- 1. Загрузка библиотек
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 2. Службы
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

-- 3. База данных (ОБНОВЛЕННАЯ - ДОПОЛНИ СВОИМИ ДАННЫМИ ИЗ DEX)
local CustomLists = {
    Trolls = {
        "Foxy", "Chica", "Golden Freddy", "Puppet", "Cursed Guardian", "The Maw", "True Weeping God",
        "Cursed Child", "Gojo", "Weeping God", "Voices Love", "Voices Mind", "Voices Reality", "Voices Soul",
        "Voices Time", "Lord Of Darkness", "Lucifer", "Soul Reaper", "Error God", "Trollge", "Trollge 2",
        "Trollge 2.5", "Trollge GF", "True Troll Warrior", "Universe eater", "Asriel", "Day 17", "Luffy",
        "Luffy Gear 2", "Luffy Gear 3", "Sonic", "Aurora Sus", "Troll", "Trollina", "Alone World",
        "Ancient Whisperer", "Arch", "Ascend Mp4", "Behemoth", "Bender Of Reality", "Bendy", "Bloodier Trollge",
        "Brother", "Cave Crawler", "Centi", "Chrono", "Derp God", "Drip Troll", "Father", "Fear", "Fish",
        "Forest Catastrophe", "Hang Man", "Hatchling", "Insane One", "Leviathan", "Sans", "Seek", "Shadow God",
        "Skeleton Troll", "Solar God", "Sorrowful Nightmare", "Space Beast", "Space Eater", "Space Troll",
        "Tall Guy", "Tarnished", "The Tell-Tale Heart", "The Voices", "Time Breaker", "Troll-096", "Troll-106",
        "Troll-999", "Trollmungandr", "Trolltoon Cat", "Trollzilla", "Twisted Terror", "Vicious Trollgo",
        "Wano Arc Zoro", "Water's Corruption", "Wrath Demon", "Zoro"
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
    SpecialItems = {"Sixth Eye", "Omniversal Cup", "Paper of Troll-096 Face", "Burning Memories"},
    
    -- КЛЮЧЕВОЙ МОМЕНТ: СЮДА ТЫ ДОЛЖЕН ВСТАВИТЬ НАЗВАНИЯ REMOTE ИЗ DEX
    RemoteNames = {
        Give = {"GiveItem", "GrantTroll", "Award"},
        Chest = {"OpenChest", "LootChest"},
        Cup = {"UseCup", "Drink"},
        Admin = {"AdminCommand", "Cmd"}
    }
}

-- 4. Утилиты
local Utils = {}
function Utils:Notify(title, msg, duration)
    Rayfield:Notify({ Title = title or "VayTrollge", Content = msg, Duration = duration or 3, Image = "check" })
end
function Utils:Tween(obj, props, duration, easing)
    local tween = Services.TweenService:Create(obj, TweenInfo.new(duration or 0.2, easing or Enum.EasingStyle.Quad), props)
    tween:Play()
    return tween
end
function Utils:Distance(pos1, pos2) return (pos1 - pos2).Magnitude end
function Utils:FindPlayer(name)
    name = name:lower()
    for _, p in ipairs(Services.Players:GetPlayers()) do
        if p.Name:lower():find(name) then return p end
    end
    return nil
end
function Utils:GetRoot()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end
function Utils:GetHumanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("Humanoid")
end
function Utils:FireTouch(p1, p2) firetouchinterest(p1, p2, 0) firetouchinterest(p1, p2, 1) end
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

-- 5. ОБХОД NOVA ЗАЩИТЫ (НОВЫЙ МОДУЛЬ)
local NovaBypass = {
    Unlocked = false,
    HiddenRemotes = {},
    
    Execute = function()
        print("🛠️ Пытаемся обойти NovaReplicatedStorage...")
        
        -- Метод 1: Перехват __index
        pcall(function()
            local mt = getrawmetatable(game)
            local old = mt.__index
            setreadonly(mt, false)
            mt.__index = function(self, key)
                if key == "ReplicatedStorage" then
                    local nova = old(self, "NovaReplicatedStorage")
                    if nova then return nova end
                end
                return old(self, key)
            end
            setreadonly(mt, true)
            print("✅ Метод 1: Хук __index установлен")
        end)
        
        -- Метод 2: Прямой поиск RemoteEvent в памяти (через getgc)
        pcall(function()
            for _, v in pairs(getgc(true)) do
                if typeof(v) == "Instance" and (v:IsA("RemoteEvent") or v:IsA("RemoteFunction")) then
                    local parent = v.Parent
                    if parent and tostring(parent):find("Nova") then
                        table.insert(NovaBypass.HiddenRemotes, v)
                        print("🔓 Найден скрытый ремот: " .. v.Name .. " в " .. parent:GetFullName())
                    end
                end
            end
        end)
        
        NovaBypass.Unlocked = true
        Utils:Notify("🛡️ Nova Bypass", "Найдено скрытых ремотов: " .. #NovaBypass.HiddenRemotes, 5)
        return NovaBypass.HiddenRemotes
    end,
    
    FireHiddenRemote = function(remoteName, ...)
        for _, remote in ipairs(NovaBypass.HiddenRemotes) do
            if remote.Name == remoteName then
                pcall(function()
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer(...)
                    else
                        remote:InvokeServer(...)
                    end
                end)
                return true
            end
        end
        return false
    end
}

-- 6. Админ-панель
local Admin = {
    Detected = false, Type = "None", Prefix = ":", Remotes = {}, Functions = {},
    Init = function()
        Admin:DetectSystem(); Admin:ScanFunctions(); Admin:AntiKick()
        if Admin.Detected then Utils:Notify("✅ Админка найдена", Admin.Type .. " | Префикс: " .. Admin.Prefix, 5)
        else Utils:Notify("⚠️ Админка не найдена", "Используется ручной режим", 3) end
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
                Admin.Detected = true; Admin.Type = sys.Name; Admin.Prefix = sys.Prefix
                return true
            end
        end
        for _, obj in ipairs(rs:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                local name = obj.Name:lower()
                if name:match("admin") or name:match("command") then
                    table.insert(Admin.Remotes, obj); Admin.Detected = true; Admin.Type = "RemoteBased"
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
                    local nl = info.name:lower()
                    if nl:match("give") or nl:match("troll") or nl:match("spawn") then
                        table.insert(Admin.Functions, {Name = info.name, Func = v})
                    end
                end
            end
        end
    end,
    AntiKick = function()
        pcall(function()
            for _, obj in ipairs(Services.ReplicatedStorage:GetDescendants()) do
                if obj:IsA("RemoteEvent") and obj.Name:lower():match("kick") then obj.Parent = nil end
            end
        end)
    end,
    ExecuteCommand = function(cmd)
        local fullCmd = Admin.Prefix .. cmd
        local success = false
        pcall(function()
            local chat = Services.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
            if chat then local say = chat:FindFirstChild("SayMessageRequest") if say then say:FireServer(fullCmd, "All") success = true end end
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
        return success
    end,
    GiveTroll = function(trollName, target)
        local targetPlayer = target or Vay.Settings.Admin.TargetPlayer
        local success = false
        local commands = {"give " .. trollName, "troll " .. trollName, "spawn " .. trollName, "unlock " .. trollName}
        if targetPlayer then for i, cmd in ipairs(commands) do commands[i] = cmd .. " " .. targetPlayer end end
        for _, cmd in ipairs(commands) do if Admin:ExecuteCommand(cmd) then success = true end wait(0.05) end
        if not success then
            for _, obj in ipairs(Services.Workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") and obj.Parent and obj.Parent.Name:lower():find(trollName:lower()) then
                    fireproximityprompt(obj); success = true; break
                end
            end
        end
        if success then
            Utils:Notify("✅ Тролль выдан", trollName, 2)
            if Vay.Settings.Admin.AutoRespawn and not targetPlayer then spawn(function() wait(0.5) pcall(function() LocalPlayer:LoadCharacter() end) end) end
        else Utils:Notify("❌ Ошибка", "Не удалось выдать: " .. trollName, 2) end
        return success
    end,
    GiveItem = function(itemName, target)
        local targetPlayer = target or Vay.Settings.Admin.TargetPlayer
        local success = false
        local commands = {"giveitem " .. itemName, "item " .. itemName, "give " .. itemName}
        if targetPlayer then for i, cmd in ipairs(commands) do commands[i] = cmd .. " " .. targetPlayer end end
        for _, cmd in ipairs(commands) do if Admin:ExecuteCommand(cmd) then success = true end wait(0.05) end
        if not success then
            local root = Utils:GetRoot()
            if root then
                for _, obj in ipairs(Services.Workspace:GetDescendants()) do
                    if obj:IsA("Tool") and obj.Name:lower():find(itemName:lower()) then
                        local handle = obj:FindFirstChild("Handle")
                        if handle then handle.CFrame = root.CFrame; Utils:FireTouch(root, handle); success = true; break end
                    end
                end
            end
        end
        if success then Utils:Notify("📦 Предмет выдан", itemName, 2)
        else Utils:Notify("❌ Ошибка", "Не удалось выдать: " .. itemName, 2) end
        return success
    end,
    GiveAllTrolls = function()
        local count = 0
        for i, troll in ipairs(CustomLists.Trolls) do
            if Vay.Settings.Admin.GiveToAll then
                for _, p in ipairs(Services.Players:GetPlayers()) do if p ~= LocalPlayer then Admin:GiveTroll(troll, p.Name) wait(0.05) end end
            else Admin:GiveTroll(troll) end
            count = count + 1
            wait(0.1)
        end
        Utils:Notify("✅ Завершено", "Выдано " .. count .. " троллей!", 5)
        return count
    end,
    GiveAllItems = function()
        local items = {}
        for _, v in ipairs(CustomLists.BossSummonItems) do table.insert(items, v) end
        for _, v in ipairs(CustomLists.SpecialItems) do table.insert(items, v) end
        for _, v in ipairs(CustomLists.Cups) do table.insert(items, v) end
        local count = 0
        for i, item in ipairs(items) do
            if Vay.Settings.Admin.GiveToAll then
                for _, p in ipairs(Services.Players:GetPlayers()) do if p ~= LocalPlayer then Admin:GiveItem(item, p.Name) wait(0.03) end end
            else Admin:GiveItem(item) end
            count = count + 1
            wait(0.08)
        end
        Utils:Notify("✅ Завершено", "Выдано " .. count .. " предметов!", 5)
        return count
    end,
    SetTarget = function(name)
        if name == "all" then Vay.Settings.Admin.GiveToAll = true; Vay.Settings.Admin.TargetPlayer = nil
        elseif name == "me" then Vay.Settings.Admin.GiveToAll = false; Vay.Settings.Admin.TargetPlayer = nil
        else local p = Utils:FindPlayer(name) if p then Vay.Settings.Admin.GiveToAll = false; Vay.Settings.Admin.TargetPlayer = p.Name end end
    end
}

-- 7. Визуал
local Visual = {
    ESPObjects = {}, ItemESPObjects = {},
    Init = function()
        spawn(function() while true do wait(0.5)
            if Vay.Settings.Visual.ESP then Visual:UpdateESP() end
            if Vay.Settings.Visual.XRay then Visual:UpdateXRay() end
        end end)
        return Visual
    end,
    UpdateESP = function()
        for _, p in ipairs(Services.Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                if not Visual.ESPObjects[p] then
                    local hl = Instance.new("Highlight")
                    hl.FillColor = Color3.fromRGB(255, 0, 0); hl.FillTransparency = 0.5
                    hl.Adornee = p.Character; hl.Parent = p.Character
                    Visual.ESPObjects[p] = hl
                end
            end
        end
        for p, obj in pairs(Visual.ESPObjects) do if not p.Parent or not p.Character then obj:Destroy(); Visual.ESPObjects[p] = nil end end
    end,
    UpdateXRay = function()
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("BasePart") then obj.LocalTransparencyModifier = 0.7 end
        end
    end,
    SetFullbright = function(state)
        Vay.Settings.Visual.Fullbright = state
        if state then Services.Lighting.Brightness = 2; Services.Lighting.FogEnd = 100000; Services.Lighting.GlobalShadows = false
        else Services.Lighting.Brightness = 1; Services.Lighting.FogEnd = 1000; Services.Lighting.GlobalShadows = true end
    end,
    SetFOV = function(fov) Vay.Settings.Visual.FOV = fov; Camera.FieldOfView = fov end,
    SetFreecam = function(state)
        Vay.Settings.Visual.Freecam = state
        if state then
            Camera.CameraType = Enum.CameraType.Scriptable
            spawn(function() while Vay.Settings.Visual.Freecam do wait()
                local dir = Vector3.zero; local UIS = Services.UserInputService
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

-- 8. Бой
local Combat = {
    Init = function()
        spawn(function() while true do wait(0.1)
            if Vay.Settings.Combat.KillAura then Combat:KillAura() end
            if Vay.Settings.Combat.Aimbot then Combat:Aimbot() end
            if Vay.Settings.Combat.SpinBot then Combat:SpinBot() end
        end end)
        return Combat
    end,
    KillAura = function()
        local root = Utils:GetRoot(); if not root then return end
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                local hum = obj:FindFirstChild("Humanoid"); local hrp = obj:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.Health > 0 and Utils:Distance(root.Position, hrp.Position) <= Vay.Settings.Combat.KillRadius then
                    hum.Health = 0
                end
            end
        end
    end,
    Aimbot = function()
        local closest, closestDist = nil, Vay.Settings.Combat.AimbotRadius
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
    SpinBot = function()
        local root = Utils:GetRoot()
        if root then root.CFrame = root.CFrame * CFrame.Angles(0, 0.1, 0) end
    end
}

-- 9. Движение
local Movement = {
    Init = function()
        spawn(function() while true do wait()
            if Vay.Settings.Movement.Fly then Movement:Fly() end
            if Vay.Settings.Movement.Noclip then Movement:Noclip() end
        end end)
        LocalPlayer.CharacterAdded:Connect(function(char) wait(0.5)
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                if Vay.Settings.Movement.SpeedEnabled then hum.WalkSpeed = Vay.Settings.Movement.Speed end
                if Vay.Settings.Movement.InfJump then hum.UseJumpPower = false end
            end
        end)
        return Movement
    end,
    Fly = function()
        local root = Utils:GetRoot(); if not root then return end
        local bv = root:FindFirstChild("FlyVel") or Instance.new("BodyVelocity")
        bv.Name = "FlyVel"; bv.Velocity = Vector3.zero; bv.MaxForce = Vector3.new(1e5,1e5,1e5); bv.Parent = root
        local bg = root:FindFirstChild("FlyGyro") or Instance.new("BodyGyro")
        bg.Name = "FlyGyro"; bg.CFrame = Camera.CFrame; bg.MaxTorque = Vector3.new(1e5,1e5,1e5); bg.Parent = root
        local dir = Vector3.zero; local UIS = Services.UserInputService
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end
        if dir.Magnitude > 0 then bv.Velocity = dir.Unit * Vay.Settings.Movement.FlySpeed end
    end,
    Noclip = function()
        local char = LocalPlayer.Character; if not char then return end
        for _, part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
    end,
    SetFly = function(state, speed)
        Vay.Settings.Movement.Fly = state; if speed then Vay.Settings.Movement.FlySpeed = speed end
        if not state then
            local root = Utils:GetRoot()
            if root then
                local bv = root:FindFirstChild("FlyVel"); if bv then bv:Destroy() end
                local bg = root:FindFirstChild("FlyGyro"); if bg then bg:Destroy() end
            end
        end
    end,
    SetNoclip = function(state) Vay.Settings.Movement.Noclip = state end,
    SetSpeed = function(speed) Vay.Settings.Movement.Speed = speed; Vay.Settings.Movement.SpeedEnabled = true; local hum = Utils:GetHumanoid(); if hum then hum.WalkSpeed = speed end end,
    SetInfJump = function(state) Vay.Settings.Movement.InfJump = state; local hum = Utils:GetHumanoid(); if hum then hum.UseJumpPower = not state end end
}

-- 10. Фарм
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
        local hum = Utils:GetHumanoid(); local root = Utils:GetRoot(); if not hum or not root then return end
        local closest, closestDist = nil, Vay.Settings.Farm.AutoFarmRange
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                local targetHum = obj:FindFirstChild("Humanoid"); local targetRoot = obj:FindFirstChild("HumanoidRootPart")
                if targetHum and targetRoot and targetHum.Health > 0 then
                    local dist = Utils:Distance(root.Position, targetRoot.Position)
                    if dist < closestDist then closestDist = dist; closest = targetRoot end
                end
            end
        end
        if closest then hum:MoveTo(closest.Position) end
    end,
    AutoCollect = function()
        local root = Utils:GetRoot(); if not root then return end
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
        local root = Utils:GetRoot(); if not root then return end
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
        local root = Utils:GetRoot(); if not root then return end
        for _, obj in ipairs(Services.Workspace:GetDescendants()) do
            for _, chestName in ipairs(CustomLists.Chests) do
                if obj.Name:lower():find(chestName:lower()) then
                    if obj:IsA("BasePart") and Utils:Distance(root.Position, obj.Position) <= 50 then
                        Utils:FireTouch(root, obj)
                    elseif obj:IsA("Model") then
                        local prompt = obj:FindFirstChild("ProximityPrompt")
                        if prompt then fireproximityprompt(prompt) end
                    end
                end
            end
        end
    end
}

-- 11. Автоиспользование кружек
local AutoCups = {
    Enabled = false,
    Start = function(self)
        self.Enabled = true
        spawn(function()
            while self.Enabled do
                local char = LocalPlayer.Character
                if char then
                    local backpack = LocalPlayer:FindFirstChild("Backpack")
                    for _, cupName in ipairs(CustomLists.Cups) do
                        local cup = char:FindFirstChild(cupName) or (backpack and backpack:FindFirstChild(cupName))
                        if cup then
                            cup.Parent = char
                            wait(0.3)
                            pcall(function() cup:Activate() end)
                            print("🥤 Использована кружка: " .. cupName)
                            break
                        end
                    end
                end
                wait(2)
            end
        end)
    end,
    Stop = function(self) self.Enabled = false end
}

-- 12. Глобальные настройки
Vay = {
    Version = "28.0.0",
    Settings = {
        Admin = { GiveToAll = false, TargetPlayer = nil, AutoRespawn = true },
        Visual = { ESP = false, Fullbright = false, FOV = 70, Freecam = false, XRay = false },
        Combat = { KillAura = false, KillRadius = 100, Aimbot = false, AimbotRadius = 200, SpinBot = false },
        Movement = { Fly = false, FlySpeed = 50, Noclip = false, Speed = 50, SpeedEnabled = false, InfJump = false },
        Farm = { AutoFarm = false, AutoFarmRange = 500, AutoCollect = false, AutoCollectRange = 50, ItemVacuum = false, ItemVacuumRange = 100, AutoOpenChests = false }
    }
}

-- 13. Инициализация и запуск
NovaBypass.Execute()
Admin.Init()
Visual.Init()
Combat.Init()
Movement.Init()
Farm.Init()

-- 14. GUI Rayfield
local Window = Rayfield:CreateWindow({
   Name = "VayTrollge Hub | " .. LocalPlayer.Name,
   Icon = 0,
   LoadingTitle = "VayTrollge Hub",
   LoadingSubtitle = "Trollge Conventions",
   Theme = "Default",
   ConfigurationSaving = { Enabled = true, FolderName = "VayTrollgeHub", FileName = "Config" }
})

local MainTab = Window:CreateTab("🏠 Главная", nil)
local AdminTab = Window:CreateTab("👑 Админ", nil)
local TrollTab = Window:CreateTab("👾 Тролли", nil)
local ItemTab = Window:CreateTab("📦 Предметы", nil)
local CombatTab = Window:CreateTab("⚔️ Бой", nil)
local VisualTab = Window:CreateTab("👁️ Визуал", nil)
local MoveTab = Window:CreateTab("🏃 Движение", nil)
local FarmTab = Window:CreateTab("🌾 Фарм", nil)

MainTab:CreateButton({ Name = "🔄 Респавн", Callback = function() LocalPlayer:LoadCharacter() end })

AdminTab:CreateButton({ Name = "🎯 Цель: СЕБЕ", Callback = function() Admin:SetTarget("me") end })
AdminTab:CreateButton({ Name = "🌐 Цель: ВСЕ", Callback = function() Admin:SetTarget("all") end })

for _, troll in ipairs(CustomLists.Trolls) do
    TrollTab:CreateButton({ Name = troll, Callback = function() Admin:GiveTroll(troll) end })
end
TrollTab:CreateButton({ Name = "🎁 ВЫДАТЬ ВСЕХ", Callback = function() Admin:GiveAllTrolls() end })

local allItems = {}
for _, v in ipairs(CustomLists.BossSummonItems) do table.insert(allItems, v) end
for _, v in ipairs(CustomLists.SpecialItems) do table.insert(allItems, v) end
for _, v in ipairs(CustomLists.Cups) do table.insert(allItems, v) end
for _, item in ipairs(allItems) do
    ItemTab:CreateButton({ Name = item, Callback = function() Admin:GiveItem(item) end })
end
ItemTab:CreateButton({ Name = "🎁 ВЫДАТЬ ВСЕ", Callback = function() Admin:GiveAllItems() end })

CombatTab:CreateToggle({ Name = "💀 Kill Aura", CurrentValue = false, Callback = function(v) Vay.Settings.Combat.KillAura = v end })
CombatTab:CreateToggle({ Name = "🎯 Aimbot", CurrentValue = false, Callback = function(v) Vay.Settings.Combat.Aimbot = v end })
CombatTab:CreateToggle({ Name = "🌀 Spinbot", CurrentValue = false, Callback = function(v) Vay.Settings.Combat.SpinBot = v end })

VisualTab:CreateToggle({ Name = "👁️ ESP", CurrentValue = false, Callback = function(v) Vay.Settings.Visual.ESP = v end })
VisualTab:CreateToggle({ Name = "☀️ Fullbright", CurrentValue = false, Callback = function(v) Visual:SetFullbright(v) end })
VisualTab:CreateToggle({ Name = "🔍 X-Ray", CurrentValue = false, Callback = function(v) Vay.Settings.Visual.XRay = v end })
VisualTab:CreateToggle({ Name = "🎥 Freecam", CurrentValue = false, Callback = function(v) Visual:SetFreecam(v) end })

MoveTab:CreateToggle({ Name = "🦅 Fly", CurrentValue = false, Callback = function(v) Movement:SetFly(v, Vay.Settings.Movement.FlySpeed) end })
MoveTab:CreateToggle({ Name = "🚶 Noclip", CurrentValue = false, Callback = function(v) Movement:SetNoclip(v) end })
MoveTab:CreateToggle({ Name = "🏃 Speed", CurrentValue = false, Callback = function(v) Vay.Settings.Movement.SpeedEnabled = v; if v then Movement:SetSpeed(Vay.Settings.Movement.Speed) else local hum = Utils:GetHumanoid(); if hum then hum.WalkSpeed = 16 end end end })
MoveTab:CreateToggle({ Name = "🦘 Inf Jump", CurrentValue = false, Callback = function(v) Movement:SetInfJump(v) end })

FarmTab:CreateToggle({ Name = "🤖 Auto Farm", CurrentValue = false, Callback = function(v) Vay.Settings.Farm.AutoFarm = v end })
FarmTab:CreateToggle({ Name = "📦 Auto Collect", CurrentValue = false, Callback = function(v) Vay.Settings.Farm.AutoCollect = v end })
FarmTab:CreateToggle({ Name = "🧲 Item Vacuum", CurrentValue = false, Callback = function(v) Vay.Settings.Farm.ItemVacuum = v end })
FarmTab:CreateToggle({ Name = "📦 Auto Open Chests", CurrentValue = false, Callback = function(v) Vay.Settings.Farm.AutoOpenChests = v end })
FarmTab:CreateToggle({ Name = "🥤 Auto Use Cups", CurrentValue = false, Callback = function(v) if v then AutoCups:Start() else AutoCups:Stop() end end })

Rayfield:LoadConfiguration()
Utils:Notify("✅ VayTrollge", "Скрипт v" .. Vay.Version .. " загружен!", 5)
print("VayTrollge Final Edition готов!")
