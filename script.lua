-- ============================================================
-- Zentryx Hub v4.4 CB (All-in-One: Key System + Full Cheat)
-- ============================================================
local ok, err = pcall(function()

task.wait(0.5)

-- ============================================================
-- SERVICES
-- ============================================================
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Players = game:GetService("Players")
local TWS = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CAS = game:GetService("ContextActionService")
local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    local tried = 0
    repeat task.wait(0.5) tried = tried + 1
        LocalPlayer = Players.LocalPlayer
    until LocalPlayer or tried >= 10
    if not LocalPlayer then return end
end

-- ============================================================
-- THEME & PALETTE
-- ============================================================
local C_BG         = Color3.fromRGB(15, 17, 23)
local C_CARD       = Color3.fromRGB(21, 24, 33)
local C_CARD_INNER = Color3.fromRGB(27, 31, 42)
local C_STROKE     = Color3.fromRGB(38, 44, 59)
local C_ACCENT     = Color3.fromRGB(88, 145, 255)
local C_TEXT       = Color3.fromRGB(240, 244, 252)
local C_TEXT_MUTED = Color3.fromRGB(120, 130, 150)
local C_SUCCESS    = Color3.fromRGB(56, 193, 114)
local C_DANGER     = Color3.fromRGB(245, 85, 85)
local C_WARNING    = Color3.fromRGB(250, 180, 50)

-- ============================================================
-- GUI ROOT
-- ============================================================
local parent
local huiOk, hui = pcall(gethui)
if huiOk and hui then parent = hui end
if not parent then local o, cg = pcall(function() return game:GetService("CoreGui") end); if o and cg then parent = cg end end
if not parent and LocalPlayer then parent = LocalPlayer:FindFirstChild("PlayerGui") end
if not parent then return end

local gui = Instance.new("ScreenGui")
gui.Name = "ZentryxHub_Master"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999999
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
if syn and syn.protect_gui then syn.protect_gui(gui) elseif protect_gui then protect_gui(gui) end
gui.Parent = parent

-- ============================================================
-- TOAST NOTIFICATIONS
-- ============================================================
local toastHolder = Instance.new("Frame")
toastHolder.Name = "ToastHolder"
toastHolder.Parent = gui
toastHolder.Size = UDim2.new(0, 270, 1, -40)
toastHolder.Position = UDim2.new(1, -285, 0, 20)
toastHolder.BackgroundTransparency = 1
toastHolder.ZIndex = 500

local toastLayout = Instance.new("UIListLayout")
toastLayout.Parent = toastHolder
toastLayout.SortOrder = Enum.SortOrder.LayoutOrder
toastLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
toastLayout.Padding = UDim.new(0, 8)

local toastCount = 0
local function toast(title, stateOrText, customColor)
    toastCount = toastCount + 1
    local isBool = type(stateOrText) == "boolean"
    local color = customColor or (isBool and (stateOrText and C_SUCCESS or C_DANGER) or C_ACCENT)
    local stateText = isBool and (stateOrText and "ENABLED" or "DISABLED") or tostring(stateOrText or "")

    local card = Instance.new("Frame")
    card.Name = "Toast_" .. toastCount
    card.Parent = toastHolder
    card.Size = UDim2.new(1, 0, 0, 38)
    card.BackgroundColor3 = C_CARD
    card.BorderSizePixel = 0
    card.LayoutOrder = toastCount
    card.ZIndex = 501
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke", card)
    stroke.Color = color
    stroke.Thickness = 1
    stroke.Transparency = 0.4

    local bar = Instance.new("Frame", card)
    bar.Size = UDim2.new(0, 3, 1, -12)
    bar.Position = UDim2.new(0, 6, 0, 6)
    bar.BackgroundColor3 = color
    bar.BorderSizePixel = 0
    bar.ZIndex = 502
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local icon = Instance.new("TextLabel", card)
    icon.Size = UDim2.new(0, 18, 0, 18)
    icon.Position = UDim2.new(0, 16, 0.5, -9)
    icon.BackgroundTransparency = 1
    icon.Text = isBool and (stateOrText and "✓" or "✕") or "ℹ"
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 13
    icon.TextColor3 = color
    icon.ZIndex = 503

    local titleLbl = Instance.new("TextLabel", card)
    titleLbl.Size = UDim2.new(1, -112, 1, 0)
    titleLbl.Position = UDim2.new(0, 38, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.Font = Enum.Font.GothamSemibold
    titleLbl.TextSize = 12
    titleLbl.TextColor3 = C_TEXT
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 502

    if stateText ~= "" then
        local pill = Instance.new("Frame", card)
        pill.Size = UDim2.new(0, 64, 0, 20)
        pill.Position = UDim2.new(1, -72, 0.5, -10)
        pill.BackgroundColor3 = color
        pill.BackgroundTransparency = 0.85
        pill.BorderSizePixel = 0
        pill.ZIndex = 502
        Instance.new("UICorner", pill).CornerRadius = UDim.new(0, 5)

        local pillLbl = Instance.new("TextLabel", pill)
        pillLbl.Size = UDim2.new(1, 0, 1, 0)
        pillLbl.BackgroundTransparency = 1
        pillLbl.Text = stateText
        pillLbl.Font = Enum.Font.GothamBold
        pillLbl.TextSize = 9
        pillLbl.TextColor3 = color
        pillLbl.ZIndex = 503
    end

    card.BackgroundTransparency = 1
    stroke.Transparency = 1
    titleLbl.TextTransparency = 1
    icon.TextTransparency = 1

    TWS:Create(card, TweenInfo.new(0.2), {BackgroundTransparency = 0.05}):Play()
    TWS:Create(stroke, TweenInfo.new(0.2), {Transparency = 0.4}):Play()
    TWS:Create(titleLbl, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
    TWS:Create(icon, TweenInfo.new(0.2), {TextTransparency = 0}):Play()

    task.delay(2.2, function()
        TWS:Create(card, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        TWS:Create(stroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
        TWS:Create(titleLbl, TweenInfo.new(0.2), {TextTransparency = 1}):Play()
        local out = TWS:Create(icon, TweenInfo.new(0.2), {TextTransparency = 1})
        out.Completed:Connect(function() card:Destroy() end)
        out:Play()
    end)
end

-- ============================================================
-- БАЗА КЛЮЧЕЙ (300 ШТУК + МАСТЕР КЛЮЧ)
-- ============================================================
local RegisteredKeys = {}

local KeyList = {
    "ZTX-DEV-FREE-PASS",
    "ZTX-06C0-FDE4-2A16", "ZTX-3701-0737-B3C3", "ZTX-6742-108A-3D70", "ZTX-9783-19DD-C71D", "ZTX-C7C4-2330-50CA",
    "ZTX-F805-2C83-DA77", "ZTX-2846-35D6-6424", "ZTX-5887-3F29-EDD1", "ZTX-88C8-487C-777E", "ZTX-B909-51CF-012B",
    "ZTX-E94A-5B22-8AD8", "ZTX-198B-6475-1485", "ZTX-49CC-6DC8-9E32", "ZTX-7A0D-771B-27DF", "ZTX-AA4E-806E-B18C",
    "ZTX-DA8F-89C1-3B39", "ZTX-0AD0-9314-C4E6", "ZTX-3B11-9C67-4E93", "ZTX-6B52-A5BA-D840", "ZTX-9B93-AF0D-61ED",
    "ZTX-CBD4-B860-EB9A", "ZTX-FC15-C1B3-7547", "ZTX-2C56-CB06-FEF4", "ZTX-5C97-D459-88A1", "ZTX-8CD8-DDAC-124E",
    "ZTX-BD19-E6FF-9BFB", "ZTX-ED5A-F052-25A8", "ZTX-1D9B-F9A5-AF55", "ZTX-4DDC-02F8-3902", "ZTX-7E1D-0C4B-C2AF",
    "ZTX-AE5E-159E-4C5C", "ZTX-DE9F-1EF1-D609", "ZTX-0EE0-2844-5FB6", "ZTX-3F21-3197-E963", "ZTX-6F62-3AEA-7310",
    "ZTX-9FA3-443D-FCBD", "ZTX-CFE4-4D90-866A", "ZTX-0025-56E3-1017", "ZTX-3066-6036-99C4", "ZTX-60A7-6989-2371",
    "ZTX-90E8-72DC-AD1E", "ZTX-C129-7C2F-36CB", "ZTX-F16A-8582-C078", "ZTX-21AB-8ED5-4A25", "ZTX-51EC-9828-D3D2",
    "ZTX-822D-A17B-5D7F", "ZTX-B26E-AACE-E72C", "ZTX-E2AF-B421-70D9", "ZTX-12F0-BD74-FA86", "ZTX-4331-C6C7-8433",
    "ZTX-7372-D01A-0DE0", "ZTX-A3B3-D96D-978D", "ZTX-D3F4-E2C0-213A", "ZTX-0435-EC13-AAE7", "ZTX-3476-F566-3494",
    "ZTX-64B7-FEB9-BE41", "ZTX-94F8-080C-47EE", "ZTX-C539-115F-D19B", "ZTX-F57A-1AB2-5B48", "ZTX-25BB-2405-E4F5",
    "ZTX-55FC-2D58-6EA2", "ZTX-863D-36AB-F84F", "ZTX-B67E-3FFE-81FC", "ZTX-E6BF-4951-0BA9", "ZTX-1700-52A4-9556",
    "ZTX-4741-5BF7-1F03", "ZTX-7782-654A-A8B0", "ZTX-A7C3-6E9D-325D", "ZTX-D804-77F0-BC0A", "ZTX-0845-8143-45B7",
    "ZTX-3886-8A96-CF64", "ZTX-68C7-93E9-5911", "ZTX-9908-9D3C-E2BE", "ZTX-C949-A68F-6C6B", "ZTX-F98A-AFE2-F618",
    "ZTX-29CB-B935-7FC5", "ZTX-5A0C-C288-0972", "ZTX-8A4D-CBDB-931F", "ZTX-BA8E-D52E-1CCC", "ZTX-EACF-DE81-A679",
    "ZTX-1B10-E7D4-3026", "ZTX-4B51-F127-B9D3", "ZTX-7B92-FA7A-4380", "ZTX-ABD3-03CD-CD2D", "ZTX-DC14-0D20-56DA",
    "ZTX-0C55-1673-E087", "ZTX-3C96-1FC6-6A34", "ZTX-6CD7-2919-F3E1", "ZTX-9D18-326C-7D8E", "ZTX-CD59-3BBF-073B",
    "ZTX-FD9A-4512-90E8", "ZTX-2DDB-4E65-1A95", "ZTX-5E1C-57B8-A442", "ZTX-8E5D-610B-2DEF", "ZTX-BE9E-6A5E-B79C",
    "ZTX-EEDF-73B1-4149", "ZTX-1F20-7D04-CAF6", "ZTX-4F61-8657-54A3", "ZTX-7FA2-8FAA-DE50", "ZTX-AFE3-98FD-67FD",
    "ZTX-E024-A250-F1AA", "ZTX-1065-ABA3-7B57", "ZTX-40A6-B4F6-0504", "ZTX-70E7-BE49-8EB1", "ZTX-A128-C79C-185E",
    "ZTX-D169-D0EF-A20B", "ZTX-01AA-DA42-2BB8", "ZTX-31EB-E395-B565", "ZTX-622C-ECE8-3F12", "ZTX-926D-F63B-C8BF",
    "ZTX-C2AE-FF8E-526C", "ZTX-F2EF-08E1-DC19", "ZTX-2330-1234-65C6", "ZTX-5371-1B87-EF73", "ZTX-83B2-24DA-7920",
    "ZTX-B3F3-2E2D-02CD", "ZTX-E434-3780-8C7A", "ZTX-1475-40D3-1627", "ZTX-44B6-4A26-9FD4", "ZTX-74F7-5379-2981",
    "ZTX-A538-5CCC-B32E", "ZTX-D579-661F-3CDB", "ZTX-05BA-6F72-C688", "ZTX-35FB-78C5-5035", "ZTX-663C-8218-D9E2",
    "ZTX-967D-8B6B-638F", "ZTX-C6BE-94BE-ED3C", "ZTX-F6FF-9E11-76E9", "ZTX-2740-A764-0096", "ZTX-5781-B0B7-8A43",
    "ZTX-87C2-BA0A-13F0", "ZTX-B803-C35D-9D9D", "ZTX-E844-CCB0-274A", "ZTX-1885-D603-B0F7", "ZTX-48C6-DF56-3AA4",
    "ZTX-7907-E8A9-C451", "ZTX-A948-F1FC-4DFE", "ZTX-D989-FB4F-D7AB", "ZTX-09CA-04A2-6158", "ZTX-3A0B-0DF5-EB05",
    "ZTX-6A4C-1748-74B2", "ZTX-9A8D-209B-FE5F", "ZTX-CACE-29EE-880C", "ZTX-FB0F-3341-11B9", "ZTX-2B50-3C94-9B66",
    "ZTX-5B91-45E7-2513", "ZTX-8BD2-4F3A-AEC0", "ZTX-BC13-588D-386D", "ZTX-EC54-61E0-C21A", "ZTX-1C95-6B33-4BC7",
    "ZTX-4CD6-7486-D574", "ZTX-7D17-7DD9-5F21", "ZTX-AD58-872C-E8CE", "ZTX-DD99-907F-727B", "ZTX-0DDA-99D2-FC28",
    "ZTX-3E1B-A325-85D5", "ZTX-6E5C-AC78-0F82", "ZTX-9E9D-B5CB-992F", "ZTX-CED4-BF1E-22DC", "ZTX-FF20-C871-AC89",
    "ZTX-2F61-D1C4-3636", "ZTX-5FA2-DB17-BFE3", "ZTX-8FE3-E46A-4990", "ZTX-C024-EDBD-D33D", "ZTX-F065-F710-5CEA",
    "ZTX-20A6-0063-E697", "ZTX-50E7-09B6-7044", "ZTX-8128-1309-F9F1", "ZTX-B169-1C5C-839E", "ZTX-E1AA-25AF-0D4B",
    "ZTX-11EB-2F02-96F8", "ZTX-422C-3855-20A5", "ZTX-726D-41A8-AA52", "ZTX-A2AE-4AFB-33FF", "ZTX-D2EF-544E-BDAC",
    "ZTX-0330-5DA1-4759", "ZTX-3371-66F4-D106", "ZTX-63B2-7047-5AB3", "ZTX-93F3-799A-E460", "ZTX-C434-82ED-6E0D",
    "ZTX-F475-8C40-F7BA", "ZTX-24B6-9593-8167", "ZTX-54F7-9EE6-0B14", "ZTX-8538-A839-94C1", "ZTX-B579-B18C-1E6E",
    "ZTX-E5BA-BADF-A81B", "ZTX-15FB-C432-31C8", "ZTX-463C-CD85-BB75", "ZTX-767D-D6D8-4522", "ZTX-A6BE-E02B-CECF",
    "ZTX-D6FF-E97E-587C", "ZTX-0740-F2D1-E229", "ZTX-3781-FC24-6BD6", "ZTX-67C2-0577-F583", "ZTX-9803-0ECA-7F30",
    "ZTX-C844-181D-08DD", "ZTX-F885-2170-928A", "ZTX-28C6-2AC3-1C37", "ZTX-5907-3416-A5E4", "ZTX-8948-3D69-2F91",
    "ZTX-B989-46BC-B93E", "ZTX-E9CA-500F-42EB", "ZTX-1A0B-5962-CC98", "ZTX-4A4C-62B5-5645", "ZTX-7A8D-6C08-DFF2",
    "ZTX-AACE-755B-699F", "ZTX-DB0F-7EAE-F34C", "ZTX-0B50-8801-7CF9", "ZTX-3B91-9154-06A6", "ZTX-6BD2-9AA7-9053",
    "ZTX-9C13-A3FA-1A00", "ZTX-CC54-AD4D-A3AD", "ZTX-FC95-B6A0-2D5A", "ZTX-2CD6-BFF3-B707", "ZTX-5D17-C946-40B4",
    "ZTX-8D58-D299-CA61", "ZTX-BD99-DBEC-540E", "ZTX-EDDA-E53F-DDBB", "ZTX-1E1B-EE92-6768", "ZTX-4E5C-F7E5-F115",
    "ZTX-7E9D-0138-7AC2", "ZTX-AEDE-0A8B-046F", "ZTX-DF1F-13DE-8E1C", "ZTX-0F60-1D31-17C9", "ZTX-3FA1-2684-A176",
    "ZTX-6FE2-2FD7-2B23", "ZTX-A023-392A-B4D0", "ZTX-D064-427D-3E7D", "ZTX-00A5-4BD0-C82A", "ZTX-30E6-5523-51D7",
    "ZTX-6127-5E76-DB84", "ZTX-9168-67C9-6531", "ZTX-C1A9-711C-EEDE", "ZTX-F1EA-7A6F-788B", "ZTX-222B-83C2-0238",
    "ZTX-526C-8D15-8BE5", "ZTX-82AD-9668-1592", "ZTX-B2EE-9FBB-9F3F", "ZTX-E32F-A90E-28EC", "ZTX-1370-B261-B299",
    "ZTX-43B1-BBB4-3C46", "ZTX-73F2-C507-C5F3", "ZTX-A433-CE5A-4FA0", "ZTX-D474-D7AD-D94D", "ZTX-04B5-E100-62FA",
    "ZTX-34F6-EA53-ECA7", "ZTX-6537-F3A6-7654", "ZTX-9578-FCF9-0001", "ZTX-C5B9-064C-89AE", "ZTX-F5FA-0F9F-135B",
    "ZTX-263B-18F2-9D08", "ZTX-567C-2245-26B5", "ZTX-86BD-2B98-B062", "ZTX-B6FE-34EB-3A0F", "ZTX-E73F-3E3E-C3BC",
    "ZTX-1780-4791-4D69", "ZTX-47C1-50E4-D716", "ZTX-7802-5A37-60C3", "ZTX-A843-638A-EA70", "ZTX-D884-6CDD-741D",
    "ZTX-08C5-7630-FDCA", "ZTX-3906-7F83-8777", "ZTX-6947-88D6-1124", "ZTX-9988-9229-9AD1", "ZTX-C9C9-9B7C-247E",
    "ZTX-FA0A-A4CF-AE2B", "ZTX-2A4B-AE22-37D8", "ZTX-5A8C-B775-C185", "ZTX-8ACD-C0C8-4B32", "ZTX-BB0E-CA1B-D4DF",
    "ZTX-EB4F-D36E-5E8C", "ZTX-1B90-DCC1-E839", "ZTX-4BD1-E614-71E6", "ZTX-7C12-EF67-FB93", "ZTX-AC53-F8BA-8540",
    "ZTX-DC94-020D-0EED", "ZTX-0CD5-0B60-989A", "ZTX-3D16-14B3-2247", "ZTX-6D57-1E06-ABF4", "ZTX-9D98-2759-35A1",
    "ZTX-CDD9-30AC-BF4E", "ZTX-FE1A-39FF-48FB", "ZTX-2E5B-4352-D2A8", "ZTX-5E9C-4CA5-5C55", "ZTX-8EDD-55F8-E602",
    "ZTX-BF1E-5F4B-6FAF", "ZTX-EF5F-689E-F95C", "ZTX-1FA0-71F1-8309", "ZTX-4FE1-7B44-0CB6", "ZTX-8022-8497-9663",
    "ZTX-B063-8DEA-2010", "ZTX-E0A4-973D-A9BD", "ZTX-10E5-A090-336A", "ZTX-4126-A9E3-BD17", "ZTX-7167-B336-46C4",
    "ZTX-A1A8-BC89-D071", "ZTX-D1E9-C5DC-5A1E", "ZTX-022A-CF2F-E3CB", "ZTX-326B-D882-6D78", "ZTX-62AC-E1D5-F725"
}

for _, key in ipairs(KeyList) do
    RegisteredKeys[key] = false
end

-- ============================================================
-- ЗАПУСК ВСЕГО ФУНКЦИОНАЛА ЧИТА (ZENTRYX HUB v4.2 CORE)
-- ============================================================
local function startZentryxHub()
    local S = {
        bindType = "keyboard",
        bindKey = Enum.KeyCode.F,
        bindMouse = Enum.UserInputType.MouseButton2,
        enabled = true,
        isBinding = false,
        keyHeld = false,
        radius = 150,
        aimSpeed = 0.35,
        overlayOffset = Vector2.new(0, -29),
        aimOnCursor = false,
        crosshairDetected = false,

        espEnabled = true,
        espColor = Color3.fromRGB(255, 80, 80),
        espRange = 5000,
        teamFilter = true,
        scanBusy = false,
        aimHasTarget = false,

        -- Визуал и Очистка
        viewAngles = true,
        viewAngleColor = Color3.fromRGB(255, 215, 0),
        antiFlash = true,
        antiSmoke = true,

        -- Движение
        bhopEnabled = true,
        bhopHolding = false,
        bhopSpeed = 1.8,
        bhopJumpPower = 50,
        bhopJumped = false,
        bhopBV = nil,
        bhopToggleKey = nil,
        bhopToggleStr = "None",
        bhopToggleHeld = false,
        bhopActive = false,

        -- Настройки тумана
        fogEnabled = false,
        fogDensity = 0.45,
        fogDistance = 350,
        fogBrightness = 2.0,
        fogColor = Color3.fromRGB(180, 190, 210),
        fogColorIdx = 1,
        fogAtmos = nil,

        myTeamName = nil,
        myTeamColor = nil,
        menuVisible = true,
        menuMinimized = false,

        playerHighlights = {},
        viewAngleAdorns = {},
        deathConnections = {},
        espConnections = {},
    }

    local origLighting = {
        FogEnd = Lighting.FogEnd,
        FogStart = Lighting.FogStart,
        FogColor = Lighting.FogColor,
        Brightness = Lighting.Brightness,
        ExposureCompensation = Lighting.ExposureCompensation
    }

    local function keyStr(k)
        local m = {LeftControl="L-CTRL",RightControl="R-CTRL",LeftShift="L-SHIFT",RightShift="R-SHIFT",LeftAlt="L-ALT",RightAlt="R-ALT",Return="ENTER",Backspace="BKSP",Space="SPACE",Escape="ESC",Tab="TAB",CapsLock="CAPS"}
        return m[tostring(k):gsub("Enum.KeyCode.","")] or tostring(k):gsub("Enum.KeyCode.","")
    end

    local function inputStr()
        if S.bindType == "mouse" then
            local ms = {[Enum.UserInputType.MouseButton1]="MB1",[Enum.UserInputType.MouseButton2]="MB2",[Enum.UserInputType.MouseButton3]="MB3"}
            return ms[S.bindMouse] or "MB?"
        end
        return keyStr(S.bindKey)
    end

    local function detectTeam(plr)
        local ok, t = pcall(function() return plr.Team end)
        if ok and t then
            local ok2, c = pcall(function() return t.TeamColor.Color end)
            return t.Name, ok2 and c or Color3.fromRGB(200,200,200)
        end
        for _, n in ipairs({"Team","TeamId","TeamColor"}) do
            local v = plr:FindFirstChild(n)
            if v and v:IsA("IntValue") then
                local cols = {[0]=Color3.fromRGB(255,80,80),[1]=Color3.fromRGB(80,80,255),[2]=Color3.fromRGB(80,255,80),[3]=Color3.fromRGB(255,200,50)}
                return tostring(v.Value), cols[v.Value] or Color3.fromRGB(200,200,200)
            end
        end
        for _, n in ipairs({"Team","TeamName"}) do
            local v = plr:FindFirstChild(n)
            if v and v:IsA("StringValue") and v.Value ~= "" then return v.Value, Color3.fromRGB(200,200,200) end
        end
        local char = plr.Character
        if char then
            local bc = char:FindFirstChild("BodyColors")
            if bc then
                local tc = bc:FindFirstChild("TorsoColor")
                if tc then
                    local ok3, c = pcall(function() return BrickColor.new(tc.Value).Color end)
                    if ok3 then
                        return ("C_%.0f_%.0f_%.0f"):format(c.R*255,c.G*255,c.B*255), c
                    end
                end
            end
        end
        return nil, nil
    end

    S.myTeamName, S.myTeamColor = detectTeam(LocalPlayer)
    if not S.myTeamName then S.teamFilter = false end

    local function isTeammate(plr)
        if not S.teamFilter or not S.myTeamName then return false end
        local t, _ = detectTeam(plr)
        return t == S.myTeamName
    end

    local function isAlive(plr)
        if not plr or not plr.Parent then return false end
        local char = plr.Character
        if not char or not char.Parent then return false end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then return false end
        if hum:GetState() == Enum.HumanoidStateType.Dead then return false end
        if not char:FindFirstChild("HumanoidRootPart") then return false end
        return true
    end

    local function isAliveSoft(plr)
        if not plr or not plr.Parent then return false end
        local char = plr.Character
        if not char or not char.Parent then return false end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return false end
        return hum.Health > 0
    end

    -- ============================================================
    -- AIM OVERLAY
    -- ============================================================
    local OV = {}
    OV.circle = Instance.new("Frame", gui)
    OV.circle.Size = UDim2.new(0,S.radius*2,0,S.radius*2)
    OV.circle.Position = UDim2.new(0.5,-S.radius,0.5,-S.radius)
    OV.circle.BackgroundTransparency = 1; OV.circle.BorderSizePixel = 0; OV.circle.ZIndex = 1
    OV.stroke = Instance.new("UIStroke", OV.circle)
    OV.stroke.Thickness = 1.5; OV.stroke.Color = Color3.fromRGB(88, 145, 255)
    Instance.new("UICorner", OV.circle).CornerRadius = UDim.new(1,0)

    OV.vL = Instance.new("Frame", gui); OV.vL.Size = UDim2.new(0,2,0,16); OV.vL.Position = UDim2.new(0.5,-1,0.5,-8); OV.vL.BackgroundColor3 = Color3.fromRGB(88, 145, 255); OV.vL.BorderSizePixel = 0; OV.vL.ZIndex = 1
    Instance.new("UICorner", OV.vL).CornerRadius = UDim.new(1,0)

    OV.hL = Instance.new("Frame", gui); OV.hL.Size = UDim2.new(0,16,0,2); OV.hL.Position = UDim2.new(0.5,-8,0.5,-1); OV.hL.BackgroundColor3 = Color3.fromRGB(88, 145, 255); OV.hL.BorderSizePixel = 0; OV.hL.ZIndex = 1
    Instance.new("UICorner", OV.hL).CornerRadius = UDim.new(1,0)

    OV.dt = Instance.new("Frame", gui); OV.dt.Size = UDim2.new(0,4,0,4); OV.dt.Position = UDim2.new(0.5,-2,0.5,-2); OV.dt.BackgroundColor3 = Color3.fromRGB(88, 145, 255); OV.dt.BorderSizePixel = 0; OV.dt.ZIndex = 1
    Instance.new("UICorner", OV.dt).CornerRadius = UDim.new(1,0)

    local function updOverlay()
        if S.aimOnCursor then
            OV.circle.Size = UDim2.new(0,S.radius*2,0,S.radius*2)
            return
        end
        local ox, oy = S.overlayOffset.X, S.overlayOffset.Y
        OV.circle.Position = UDim2.new(0.5,ox-S.radius,0.5,oy-S.radius)
        OV.circle.Size = UDim2.new(0,S.radius*2,0,S.radius*2)
        OV.vL.Position = UDim2.new(0.5,ox-1,0.5,oy-8)
        OV.hL.Position = UDim2.new(0.5,ox-8,0.5,oy-1)
        OV.dt.Position = UDim2.new(0.5,ox-2,0.5,oy-2)
    end

    -- ============================================================
    -- CROSSHAIR SCAN
    -- ============================================================
    local function scanCH()
        if S.scanBusy then return end
        S.scanBusy = true
        task.spawn(function()
            pcall(function()
                local cam = workspace.CurrentCamera
                if not cam then S.scanBusy = false; return end
                local vp = cam.ViewportSize; local vc = Vector2.new(vp.X/2,vp.Y/2)
                local found = false
                local function sc(inst, dep)
                    if dep > 4 then return end
                    pcall(function()
                        if (inst:IsA("ImageLabel") or inst:IsA("ImageButton")) and inst.Visible then
                            local sz, pos = inst.AbsoluteSize, inst.AbsolutePosition
                            local ctr = pos + sz/2; local dst = (ctr - vc).Magnitude
                            if sz.X<100 and sz.Y<100 and dst<200 then
                                local s = (1-dst/200)*0.5+(1-math.max(sz.X,sz.Y)/100)*0.3
                                if inst.BackgroundTransparency>0.5 then s=s+0.2 end
                                if s>0.5 then found=true end
                            end
                        end
                        for _, ch in ipairs(inst:GetChildren()) do sc(ch, dep+1) end
                    end)
                end
                local pg = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
                if pg then sc(pg,0) end
                local cg = game:GetService("CoreGui")
                if cg then sc(cg,0) end
                S.crosshairDetected = found
                updOverlay()
            end)
            S.scanBusy = false
        end)
    end
    task.spawn(function() task.wait(0.3); scanCH() end)

    -- ============================================================
    -- ESP LOGIC & PLAYER VIEW ANGLES
    -- ============================================================
    local function clearDeathConns(plr)
        if S.deathConnections[plr] then
            for _, c in ipairs(S.deathConnections[plr]) do pcall(function() c:Disconnect() end) end
            S.deathConnections[plr] = nil
        end
    end

    local function clearPlayerESP(plr)
        if S.playerHighlights[plr] then
            local d = S.playerHighlights[plr]
            pcall(function()
                if d.highlight then d.highlight:Destroy() end
                if d.nametag then d.nametag:Destroy() end
            end)
            S.playerHighlights[plr] = nil
        end
        if S.viewAngleAdorns[plr] then
            pcall(function() S.viewAngleAdorns[plr]:Destroy() end)
            S.viewAngleAdorns[plr] = nil
        end
        clearDeathConns(plr)
    end

    local function updateViewAngle(plr)
        if not S.viewAngles or not S.espEnabled or not plr or plr == LocalPlayer then
            if S.viewAngleAdorns[plr] then S.viewAngleAdorns[plr].Visible = false end
            return
        end
        local char = plr.Character
        if not char then return end
        local head = char:FindFirstChild("Head")
        if not head then return end

        local cam = workspace.CurrentCamera
        local camPos = cam and cam.CFrame.Position or Vector3.new()
        local distToCam = (head.Position - camPos).Magnitude

        if distToCam < 8 then
            if S.viewAngleAdorns[plr] then S.viewAngleAdorns[plr].Visible = false end
            return
        end

        local line = S.viewAngleAdorns[plr]
        if not line or line.Parent ~= head then
            if line then line:Destroy() end
            line = Instance.new("CylinderHandleAdornment")
            line.Name = "ViewAngle"
            line.Adornee = head
            line.Height = 8
            line.Radius = 0.05
            line.CFrame = CFrame.new(0, 0, -4)
            line.Color3 = S.viewAngleColor
            line.Transparency = 0.3
            line.AlwaysOnTop = true
            line.ZIndex = 2
            line.Parent = head
            S.viewAngleAdorns[plr] = line
        end

        local _, tc = detectTeam(plr)
        line.Color3 = S.teamFilter and (tc or S.viewAngleColor) or S.viewAngleColor
        line.Visible = isAliveSoft(plr)
    end

    local function addHighlight(plr)
        if not S.espEnabled or not plr or plr == LocalPlayer then return end
        if not isAliveSoft(plr) then return end
        local char = plr.Character
        if not char then return end
        clearPlayerESP(plr)

        pcall(function()
            local _, tc = detectTeam(plr)
            local h = Instance.new("Highlight", char)
            h.Adornee = char
            if S.teamFilter and tc then h.FillColor = tc; h.OutlineColor = tc
            else h.FillColor = S.espColor; h.OutlineColor = S.espColor end
            h.FillTransparency = 0.65; h.OutlineTransparency = 0
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

            local bgui, dist
            local head = char:FindFirstChild("Head")
            if head then
                bgui = Instance.new("BillboardGui", head)
                bgui.Name = "ESPName"
                bgui.Adornee = head
                bgui.Size = UDim2.new(0, 140, 0, 32)
                bgui.StudsOffset = Vector3.new(0, 3, 0)
                bgui.AlwaysOnTop = true

                local lbl = Instance.new("TextLabel", bgui)
                lbl.Size = UDim2.new(1, 0, 0.6, 0)
                lbl.BackgroundTransparency = 1
                lbl.Text = plr.Name
                lbl.TextColor3 = S.teamFilter and tc or S.espColor
                lbl.TextStrokeTransparency = 0.3
                lbl.Font = Enum.Font.GothamBold
                lbl.TextSize = 13

                dist = Instance.new("TextLabel", bgui)
                dist.Size = UDim2.new(1, 0, 0.4, 0)
                dist.Position = UDim2.new(0, 0, 0.6, 0)
                dist.BackgroundTransparency = 1
                dist.Text = ""
                dist.TextColor3 = Color3.fromRGB(220, 220, 220)
                dist.TextStrokeTransparency = 0.5
                dist.Font = Enum.Font.Gotham
                dist.TextSize = 10
            end

            S.playerHighlights[plr] = {highlight = h, nametag = bgui, distLabel = dist, char = char}
            updateViewAngle(plr)

            clearDeathConns(plr)
            local conns = {}
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                table.insert(conns, hum.Died:Connect(function() clearPlayerESP(plr) end))
                table.insert(conns, hum.HealthChanged:Connect(function(hp) if hp <= 0 then clearPlayerESP(plr) end end))
            end
            table.insert(conns, plr.CharacterRemoving:Connect(function() clearPlayerESP(plr) end))
            table.insert(conns, char.AncestryChanged:Connect(function(_, p) if not p then clearPlayerESP(plr) end end))
            S.deathConnections[plr] = conns
        end)
    end

    local function clearESP()
        for plr, _ in pairs(S.playerHighlights) do clearPlayerESP(plr) end
        S.playerHighlights = {}
        S.viewAngleAdorns = {}
        for plr, _ in pairs(S.deathConnections) do clearDeathConns(plr) end
    end

    local function updateESPRange()
        local cam = workspace.CurrentCamera
        if not cam then return end
        local camPos = cam.CFrame.Position
        for plr, d in pairs(S.playerHighlights) do
            if not isAliveSoft(plr) then
                clearPlayerESP(plr)
            else
                local char = plr.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
                    if root then
                        local dist = (root.Position - camPos).Magnitude
                        local inRange = dist <= S.espRange
                        if d.highlight then
                            d.highlight.FillTransparency = inRange and 0.65 or 1
                            d.highlight.OutlineTransparency = inRange and 0 or 1
                        end
                        if d.nametag then
                            d.nametag.Enabled = inRange
                            if d.distLabel and inRange then
                                d.distLabel.Text = ("%d studs"):format(math.floor(dist))
                            end
                        end
                        updateViewAngle(plr)
                    end
                end
            end
        end
    end

    local function rebuildESP()
        clearESP()
        if not S.espEnabled then return end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and isAliveSoft(plr) then addHighlight(plr) end
        end
        updateESPRange()
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            plr.CharacterAdded:Connect(function()
                clearPlayerESP(plr)
                task.wait(0.3)
                if S.espEnabled and isAliveSoft(plr) then addHighlight(plr) end
            end)
        end
    end

    Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function()
            clearPlayerESP(plr)
            task.wait(0.3)
            if S.espEnabled and isAliveSoft(plr) then addHighlight(plr) end
        end)
    end)

    Players.PlayerRemoving:Connect(clearPlayerESP)

    -- ============================================================
    -- ANTI-FLASH & ANTI-SMOKE ENGINE
    -- ============================================================
    local function doAntiFlash()
        if not S.antiFlash then return end
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if pg then
            local b = pg:FindFirstChild("Blinded")
            if b then
                if b:IsA("ScreenGui") and b.Enabled then b.Enabled = false end
                for _, v in ipairs(b:GetDescendants()) do
                    if v:IsA("Frame") or v:IsA("ImageLabel") then v.Visible = false; v.BackgroundTransparency = 1 end
                end
            end
            local g = pg:FindFirstChild("GUI")
            if g then
                local f = g:FindFirstChild("Flash")
                if f then f.Visible = false; f.BackgroundTransparency = 1 end
                local w = g:FindFirstChild("White")
                if w then w.Visible = false; w.BackgroundTransparency = 1 end
            end
        end
    end

    local function cleanSmokeObject(obj)
        if not S.antiSmoke then return end
        if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") then
            obj.Enabled = false; obj.Rate = 0
        elseif obj:IsA("BasePart") and not obj:FindFirstAncestorOfClass("Humanoid") then
            local n = obj.Name:lower()
            if n:find("smoke") or (obj.Parent and obj.Parent.Name:lower():find("smoke")) then
                obj.Transparency = 1
            end
        end
    end

    workspace.DescendantAdded:Connect(function(child)
        if S.antiSmoke then
            pcall(function()
                local n = child.Name:lower()
                if n:find("smoke") or (child.Parent and child.Parent.Name:lower():find("smoke")) then
                    cleanSmokeObject(child)
                end
            end)
        end
    end)

    task.spawn(function()
        while task.wait(0.3) do
            if S.antiSmoke then
                pcall(function()
                    local rayIgnore = workspace:FindFirstChild("Ray_Ignore")
                    if rayIgnore then
                        local smokes = rayIgnore:FindFirstChild("Smokes")
                        if smokes then
                            for _, s in ipairs(smokes:GetDescendants()) do cleanSmokeObject(s) end
                        end
                    end
                end)
            end
        end
    end)

    -- ============================================================
    -- FOG ENGINE (СБРОС И ПРИМЕНЕНИЕ)
    -- ============================================================
    local function resetFog()
        pcall(function()
            if S.fogAtmos then S.fogAtmos:Destroy(); S.fogAtmos = nil end
            local oldAtmos = Lighting:FindFirstChild("ZentryxFog")
            if oldAtmos then oldAtmos:Destroy() end

            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
            Lighting.FogColor = origLighting.FogColor or Color3.fromRGB(190, 190, 190)
            Lighting.Brightness = origLighting.Brightness or 2
            Lighting.ExposureCompensation = origLighting.ExposureCompensation or 0
        end)
    end

    local function applyFog()
        pcall(function()
            if S.fogEnabled then
                if not S.fogAtmos or not S.fogAtmos.Parent then
                    S.fogAtmos = Instance.new("Atmosphere")
                    S.fogAtmos.Name = "ZentryxFog"
                    S.fogAtmos.Parent = Lighting
                end
                S.fogAtmos.Density = math.clamp(S.fogDensity, 0.01, 1)
                S.fogAtmos.Offset = 0.25
                S.fogAtmos.Color = S.fogColor
                S.fogAtmos.Decay = S.fogColor:Lerp(Color3.new(1, 1, 1), 0.35)
                S.fogAtmos.Haze = math.clamp(S.fogDensity * 0.6, 0, 1)
                S.fogAtmos.Glare = math.clamp(S.fogBrightness * 0.3, 0, 1)
                Lighting.Brightness = S.fogBrightness
                Lighting.FogColor = S.fogColor
                Lighting.FogStart = math.max(0, S.fogDistance * 0.05)
                Lighting.FogEnd = S.fogDistance
            else
                resetFog()
            end
        end)
    end

    -- ============================================================
    -- MAIN WINDOW UI
    -- ============================================================
    local Main = Instance.new("Frame", gui)
    Main.Name = "ZentryxHub"
    Main.Size = UDim2.new(0, 480, 0, 520)
    Main.Position = UDim2.new(0.5, -240, 0.5, -260)
    Main.BackgroundColor3 = C_BG
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.ZIndex = 10
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Color = C_STROKE; MainStroke.Thickness = 1.2

    local MainScale = Instance.new("UIScale", Main); MainScale.Scale = 1

    local Header = Instance.new("Frame", Main)
    Header.Name = "Header"; Header.Size = UDim2.new(1, 0, 0, 48); Header.BackgroundColor3 = C_CARD
    Header.BorderSizePixel = 0; Header.ZIndex = 11
    Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

    local HeaderFix = Instance.new("Frame", Header)
    HeaderFix.Size = UDim2.new(1, 0, 0, 10); HeaderFix.Position = UDim2.new(0, 0, 1, -10)
    HeaderFix.BackgroundColor3 = C_CARD; HeaderFix.BorderSizePixel = 0; HeaderFix.ZIndex = 11

    local LogoDot = Instance.new("Frame", Header)
    LogoDot.Size = UDim2.new(0, 8, 0, 8); LogoDot.Position = UDim2.new(0, 16, 0.5, -4)
    LogoDot.BackgroundColor3 = C_ACCENT; LogoDot.BorderSizePixel = 0; LogoDot.ZIndex = 12
    Instance.new("UICorner", LogoDot).CornerRadius = UDim.new(1, 0)

    local TitleLbl = Instance.new("TextLabel", Header)
    TitleLbl.Size = UDim2.new(0, 200, 1, 0); TitleLbl.Position = UDim2.new(0, 32, 0, 0)
    TitleLbl.BackgroundTransparency = 1; TitleLbl.Text = "ZENTRYX <font color=\"rgb(88,145,255)\">HUB</font>"
    TitleLbl.RichText = true; TitleLbl.Font = Enum.Font.GothamBold; TitleLbl.TextSize = 14
    TitleLbl.TextColor3 = C_TEXT; TitleLbl.TextXAlignment = Enum.TextXAlignment.Left; TitleLbl.ZIndex = 12

    local CloseBtn = Instance.new("TextButton", Header)
    CloseBtn.Size = UDim2.new(0, 28, 0, 28); CloseBtn.Position = UDim2.new(1, -38, 0.5, -14)
    CloseBtn.BackgroundColor3 = C_CARD_INNER; CloseBtn.BorderSizePixel = 0; CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.TextSize = 13; CloseBtn.TextColor3 = C_TEXT_MUTED
    CloseBtn.AutoButtonColor = false; CloseBtn.ZIndex = 12
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

    local MinBtn = Instance.new("TextButton", Header)
    MinBtn.Size = UDim2.new(0, 28, 0, 28); MinBtn.Position = UDim2.new(1, -72, 0.5, -14)
    MinBtn.BackgroundColor3 = C_CARD_INNER; MinBtn.BorderSizePixel = 0; MinBtn.Text = "-"
    MinBtn.Font = Enum.Font.GothamBold; MinBtn.TextSize = 16; MinBtn.TextColor3 = C_TEXT_MUTED
    MinBtn.AutoButtonColor = false; MinBtn.ZIndex = 12
    Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

    CloseBtn.MouseEnter:Connect(function() TWS:Create(CloseBtn, TweenInfo.new(0.12), {BackgroundColor3 = C_DANGER, TextColor3 = Color3.new(1,1,1)}):Play() end)
    CloseBtn.MouseLeave:Connect(function() TWS:Create(CloseBtn, TweenInfo.new(0.12), {BackgroundColor3 = C_CARD_INNER, TextColor3 = C_TEXT_MUTED}):Play() end)
    MinBtn.MouseEnter:Connect(function() TWS:Create(MinBtn, TweenInfo.new(0.12), {TextColor3 = C_TEXT}):Play() end)
    MinBtn.MouseLeave:Connect(function() TWS:Create(MinBtn, TweenInfo.new(0.12), {TextColor3 = C_TEXT_MUTED}):Play() end)

    local TabBar = Instance.new("Frame", Main)
    TabBar.Name = "TabBar"; TabBar.Size = UDim2.new(1, -24, 0, 36); TabBar.Position = UDim2.new(0, 12, 0, 56)
    TabBar.BackgroundColor3 = C_CARD; TabBar.BorderSizePixel = 0; TabBar.ZIndex = 11
    Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 8)

    local TabStroke = Instance.new("UIStroke", TabBar); TabStroke.Color = C_STROKE; TabStroke.Thickness = 1
    local TabLayout = Instance.new("UIListLayout", TabBar); TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center; TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    TabLayout.Padding = UDim.new(0, 6)

    local TAB_CONFIG = {
        {id = "Aimbot",   title = "Aimbot"},
        {id = "Visuals",  title = "Visuals"},
        {id = "Movement", title = "Movement"},
        {id = "Settings", title = "Settings"}
    }
    local TabButtons = {}; local TabPages = {}; local activeTab = "Aimbot"

    local Content = Instance.new("Frame", Main)
    Content.Name = "Content"; Content.Size = UDim2.new(1, -24, 1, -136); Content.Position = UDim2.new(0, 12, 0, 100)
    Content.BackgroundTransparency = 1; Content.ZIndex = 11

    local Footer = Instance.new("Frame", Main)
    Footer.Name = "Footer"; Footer.Size = UDim2.new(1, 0, 0, 28); Footer.Position = UDim2.new(0, 0, 1, -28)
    Footer.BackgroundColor3 = C_CARD; Footer.BorderSizePixel = 0; Footer.ZIndex = 11
    Instance.new("UICorner", Footer).CornerRadius = UDim.new(0, 12)

    local FooterFix = Instance.new("Frame", Footer)
    FooterFix.Size = UDim2.new(1, 0, 0, 10); FooterFix.Position = UDim2.new(0, 0, 0, 0); FooterFix.BackgroundColor3 = C_CARD; FooterFix.BorderSizePixel = 0; FooterFix.ZIndex = 11

    local StatFps = Instance.new("TextLabel", Footer)
    StatFps.Size = UDim2.new(0, 90, 1, 0); StatFps.Position = UDim2.new(0, 16, 0, 0); StatFps.BackgroundTransparency = 1
    StatFps.Text = "FPS: --"; StatFps.Font = Enum.Font.GothamMedium; StatFps.TextSize = 11; StatFps.TextColor3 = C_TEXT_MUTED; StatFps.TextXAlignment = Enum.TextXAlignment.Left; StatFps.ZIndex = 12

    local StatPing = Instance.new("TextLabel", Footer)
    StatPing.Size = UDim2.new(0, 90, 1, 0); StatPing.Position = UDim2.new(0, 110, 0, 0); StatPing.BackgroundTransparency = 1
    StatPing.Text = "Ping: --"; StatPing.Font = Enum.Font.GothamMedium; StatPing.TextSize = 11; StatPing.TextColor3 = C_TEXT_MUTED; StatPing.TextXAlignment = Enum.TextXAlignment.Left; StatPing.ZIndex = 12

    local StatCross = Instance.new("TextLabel", Footer)
    StatCross.Size = UDim2.new(0, 180, 1, 0); StatCross.Position = UDim2.new(1, -196, 0, 0); StatCross.BackgroundTransparency = 1
    StatCross.Text = "Crosshair: Center"; StatCross.Font = Enum.Font.GothamMedium; StatCross.TextSize = 11; StatCross.TextColor3 = C_TEXT_MUTED; StatCross.TextXAlignment = Enum.TextXAlignment.Right; StatCross.ZIndex = 12

    local function createTabPage(name)
        local sf = Instance.new("ScrollingFrame", Content)
        sf.Name = "Page_" .. name; sf.Size = UDim2.new(1, 0, 1, 0); sf.BackgroundTransparency = 1; sf.BorderSizePixel = 0
        sf.ScrollBarThickness = 3; sf.ScrollBarImageColor3 = C_ACCENT; sf.ScrollBarImageTransparency = 0.6
        sf.AutomaticCanvasSize = Enum.AutomaticSize.Y; sf.CanvasSize = UDim2.new(0, 0, 0, 0); sf.Visible = (name == activeTab); sf.ZIndex = 12
        local layout = Instance.new("UIListLayout", sf); layout.SortOrder = Enum.SortOrder.LayoutOrder; layout.Padding = UDim.new(0, 10)
        local pad = Instance.new("UIPadding", sf); pad.PaddingRight = UDim.new(0, 4); pad.PaddingTop = UDim.new(0, 2); pad.PaddingBottom = UDim.new(0, 10)
        return sf
    end

    for _, tabData in ipairs(TAB_CONFIG) do
        local tabId = tabData.id
        local page = createTabPage(tabId)
        TabPages[tabId] = page

        local btn = Instance.new("TextButton", TabBar)
        btn.Name = "Tab_" .. tabId; btn.Size = UDim2.new(0.25, -6, 0, 28)
        btn.BackgroundColor3 = (tabId == activeTab) and C_CARD_INNER or Color3.fromRGB(0,0,0)
        btn.BackgroundTransparency = (tabId == activeTab) and 0 or 1
        btn.Text = tabData.title; btn.Font = Enum.Font.GothamBold; btn.TextSize = 12
        btn.TextColor3 = (tabId == activeTab) and C_TEXT or C_TEXT_MUTED; btn.AutoButtonColor = false; btn.ZIndex = 12
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        local tStroke = Instance.new("UIStroke", btn); tStroke.Thickness = 1; tStroke.Color = C_ACCENT; tStroke.Transparency = (tabId == activeTab) and 0.5 or 1
        TabButtons[tabId] = {btn = btn, stroke = tStroke}

        btn.MouseButton1Click:Connect(function()
            if activeTab == tabId then return end
            activeTab = tabId
            for tName, tData in pairs(TabButtons) do
                local sel = (tName == activeTab)
                TWS:Create(tData.btn, TweenInfo.new(0.18), {BackgroundTransparency = sel and 0 or 1, TextColor3 = sel and C_TEXT or C_TEXT_MUTED, BackgroundColor3 = sel and C_CARD_INNER or Color3.fromRGB(0,0,0)}):Play()
                TWS:Create(tData.stroke, TweenInfo.new(0.18), {Transparency = sel and 0.5 or 1}):Play()
                TabPages[tName].Visible = sel
            end
        end)
    end

    local function createGroup(parent, title, order)
        local card = Instance.new("Frame", parent)
        card.Size = UDim2.new(1, 0, 0, 0); card.AutomaticSize = Enum.AutomaticSize.Y; card.BackgroundColor3 = C_CARD; card.BorderSizePixel = 0; card.LayoutOrder = order or 1; card.ZIndex = 12
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 9)
        local stroke = Instance.new("UIStroke", card); stroke.Color = C_STROKE; stroke.Thickness = 1
        local pad = Instance.new("UIPadding", card); pad.PaddingLeft = UDim.new(0, 14); pad.PaddingRight = UDim.new(0, 14); pad.PaddingTop = UDim.new(0, 12); pad.PaddingBottom = UDim.new(0, 12)
        local layout = Instance.new("UIListLayout", card); layout.SortOrder = Enum.SortOrder.LayoutOrder; layout.Padding = UDim.new(0, 10)
        if title then
            local head = Instance.new("TextLabel", card); head.Size = UDim2.new(1, 0, 0, 16); head.BackgroundTransparency = 1; head.Text = title:upper()
            head.Font = Enum.Font.GothamBold; head.TextSize = 11; head.TextColor3 = C_ACCENT; head.TextXAlignment = Enum.TextXAlignment.Left; head.ZIndex = 13
        end
        return card
    end

    local function createToggle(parent, title, defaultState, callback, order)
        local row = Instance.new("Frame", parent)
        row.Size = UDim2.new(1, 0, 0, 28); row.BackgroundTransparency = 1; row.LayoutOrder = order or 1; row.ZIndex = 13

        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(1, -50, 1, 0); lbl.BackgroundTransparency = 1; lbl.Text = title; lbl.Font = Enum.Font.GothamMedium; lbl.TextSize = 13
        lbl.TextColor3 = C_TEXT; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 13

        local pill = Instance.new("Frame", row)
        pill.Size = UDim2.new(0, 40, 0, 22); pill.Position = UDim2.new(1, -40, 0.5, -11); pill.BackgroundColor3 = defaultState and C_SUCCESS or C_CARD_INNER; pill.BorderSizePixel = 0; pill.ZIndex = 14
        Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)

        local knob = Instance.new("Frame", pill)
        knob.Size = UDim2.new(0, 16, 0, 16); knob.Position = defaultState and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8); knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); knob.BorderSizePixel = 0; knob.ZIndex = 15
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1; btn.Text = ""; btn.ZIndex = 16

        local isTog = defaultState
        btn.MouseButton1Click:Connect(function()
            isTog = not isTog
            TWS:Create(pill, TweenInfo.new(0.18), {BackgroundColor3 = isTog and C_SUCCESS or C_CARD_INNER}):Play()
            TWS:Create(knob, TweenInfo.new(0.18), {Position = isTog and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}):Play()
            callback(isTog)
        end)
    end

    local function createSlider(parent, title, minVal, maxVal, defaultVal, suffix, step, callback, order)
        local block = Instance.new("Frame", parent)
        block.Size = UDim2.new(1, 0, 0, 44); block.BackgroundTransparency = 1; block.LayoutOrder = order or 1; block.ZIndex = 13

        local lbl = Instance.new("TextLabel", block)
        lbl.Size = UDim2.new(1, -70, 0, 18); lbl.BackgroundTransparency = 1; lbl.Text = title; lbl.Font = Enum.Font.GothamMedium; lbl.TextSize = 13
        lbl.TextColor3 = C_TEXT; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 13

        local valBadge = Instance.new("TextLabel", block)
        valBadge.Size = UDim2.new(0, 65, 0, 18); valBadge.Position = UDim2.new(1, -65, 0, 0); valBadge.BackgroundTransparency = 1; valBadge.Text = tostring(defaultVal) .. (suffix or "")
        valBadge.Font = Enum.Font.GothamBold; valBadge.TextSize = 12; valBadge.TextColor3 = C_ACCENT; valBadge.TextXAlignment = Enum.TextXAlignment.Right; valBadge.ZIndex = 13

        local track = Instance.new("Frame", block)
        track.Size = UDim2.new(1, 0, 0, 6); track.Position = UDim2.new(0, 0, 0, 28); track.BackgroundColor3 = C_CARD_INNER; track.BorderSizePixel = 0; track.ZIndex = 14
        Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

        local pct = math.clamp((defaultVal - minVal) / (maxVal - minVal), 0, 1)
        local fill = Instance.new("Frame", track)
        fill.Size = UDim2.new(pct, 0, 1, 0); fill.BackgroundColor3 = C_ACCENT; fill.BorderSizePixel = 0; fill.ZIndex = 15
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

        local thumb = Instance.new("TextButton", track)
        thumb.Size = UDim2.new(0, 14, 0, 14); thumb.Position = UDim2.new(pct, -7, 0.5, -7); thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255); thumb.BorderSizePixel = 0; thumb.Text = ""; thumb.ZIndex = 16
        Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)

        local sliding = false
        local function setValue(inputX)
            local tX, tW = track.AbsolutePosition.X, track.AbsoluteSize.X
            if tW <= 0 then return end
            local p = math.clamp((inputX - tX) / tW, 0, 1)
            local raw = minVal + p * (maxVal - minVal)
            if step then raw = math.floor((raw / step) + 0.5) * step end
            local cur = (step and step < 1) and tonumber(string.format("%.2f", raw)) or math.floor(raw)
            p = math.clamp((cur - minVal) / (maxVal - minVal), 0, 1)
            fill.Size = UDim2.new(p, 0, 1, 0); thumb.Position = UDim2.new(p, -7, 0.5, -7)
            valBadge.Text = tostring(cur) .. (suffix or "")
            callback(cur)
        end

        thumb.MouseButton1Down:Connect(function() sliding = true end)
        UIS.InputEnded:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end end)
        UIS.InputChanged:Connect(function(inp) if sliding and inp.UserInputType == Enum.UserInputType.MouseMovement then setValue(inp.Position.X) end end)
    end

    local function createDropdown(parent, title, options, defaultIndex, callback, order)
        local container = Instance.new("Frame", parent)
        container.Size = UDim2.new(1, 0, 0, 36); container.BackgroundTransparency = 1; container.LayoutOrder = order or 1; container.ZIndex = 14

        local headerBtn = Instance.new("TextButton", container)
        headerBtn.Size = UDim2.new(1, 0, 0, 36); headerBtn.BackgroundColor3 = C_CARD_INNER; headerBtn.BorderSizePixel = 0; headerBtn.Text = ""; headerBtn.AutoButtonColor = false; headerBtn.ZIndex = 15
        Instance.new("UICorner", headerBtn).CornerRadius = UDim.new(0, 7)
        local headStroke = Instance.new("UIStroke", headerBtn); headStroke.Color = C_STROKE; headStroke.Thickness = 1

        local lbl = Instance.new("TextLabel", headerBtn)
        lbl.Size = UDim2.new(0, 130, 1, 0); lbl.Position = UDim2.new(0, 12, 0, 0); lbl.BackgroundTransparency = 1; lbl.Text = title; lbl.Font = Enum.Font.GothamMedium; lbl.TextSize = 13
        lbl.TextColor3 = C_TEXT; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 16

        local initialOpt = options[defaultIndex or 1]
        local headColorSwatch
        if initialOpt and initialOpt.color then
            headColorSwatch = Instance.new("Frame", headerBtn)
            headColorSwatch.Size = UDim2.new(0, 16, 0, 16); headColorSwatch.Position = UDim2.new(1, -48, 0.5, -8); headColorSwatch.BackgroundColor3 = initialOpt.color; headColorSwatch.BorderSizePixel = 0; headColorSwatch.ZIndex = 16
            Instance.new("UICorner", headColorSwatch).CornerRadius = UDim.new(0, 4)
        end

        local selBadge = Instance.new("TextLabel", headerBtn)
        selBadge.Size = UDim2.new(1, -200, 1, 0); selBadge.Position = UDim2.new(0, 140, 0, 0); selBadge.BackgroundTransparency = 1; selBadge.Text = initialOpt and initialOpt.name or ""
        selBadge.Font = Enum.Font.GothamBold; selBadge.TextSize = 12; selBadge.TextColor3 = C_ACCENT; selBadge.TextXAlignment = Enum.TextXAlignment.Right; selBadge.ZIndex = 16

        local list = Instance.new("Frame", container)
        list.Size = UDim2.new(1, 0, 0, 0); list.Position = UDim2.new(0, 0, 0, 40); list.BackgroundColor3 = C_CARD_INNER; list.BorderSizePixel = 0; list.ClipsDescendants = true; list.Visible = false; list.ZIndex = 25
        Instance.new("UICorner", list).CornerRadius = UDim.new(0, 7)
        local listLayout = Instance.new("UIListLayout", list); listLayout.SortOrder = Enum.SortOrder.LayoutOrder; listLayout.Padding = UDim.new(0, 3)
        local listPad = Instance.new("UIPadding", list); listPad.PaddingTop = UDim.new(0, 5); listPad.PaddingBottom = UDim.new(0, 5); listPad.PaddingLeft = UDim.new(0, 5); listPad.PaddingRight = UDim.new(0, 5)

        local isOpen = false
        local targetHeight = (#options * 30) + 10

        local function toggleDropdown(open)
            isOpen = open
            if isOpen then
                container.ZIndex = 40; list.Visible = true
                TWS:Create(container, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 40 + targetHeight)}):Play()
                TWS:Create(list, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
            else
                TWS:Create(container, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 36)}):Play()
                local t = TWS:Create(list, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)})
                t.Completed:Connect(function() if not isOpen then list.Visible = false; container.ZIndex = 14 end end)
                t:Play()
            end
        end

        headerBtn.MouseButton1Click:Connect(function() toggleDropdown(not isOpen) end)

        for i, opt in ipairs(options) do
            local optBtn = Instance.new("TextButton", list)
            optBtn.Size = UDim2.new(1, 0, 0, 27); optBtn.BackgroundColor3 = C_CARD; optBtn.BackgroundTransparency = 1; optBtn.BorderSizePixel = 0; optBtn.Text = ""; optBtn.AutoButtonColor = false; optBtn.ZIndex = 26
            Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0, 5)

            local optName = Instance.new("TextLabel", optBtn)
            optName.Size = UDim2.new(1, -40, 1, 0); optName.Position = UDim2.new(0, 10, 0, 0); optName.BackgroundTransparency = 1; optName.Text = opt.name; optName.Font = Enum.Font.GothamMedium; optName.TextSize = 12
            optName.TextColor3 = C_TEXT_MUTED; optName.TextXAlignment = Enum.TextXAlignment.Left; optName.ZIndex = 27

            if opt.color then
                local swatch = Instance.new("Frame", optBtn)
                swatch.Size = UDim2.new(0, 16, 0, 16); swatch.Position = UDim2.new(1, -26, 0.5, -8); swatch.BackgroundColor3 = opt.color; swatch.BorderSizePixel = 0; swatch.ZIndex = 27
                Instance.new("UICorner", swatch).CornerRadius = UDim.new(0, 4)
            end

            optBtn.MouseButton1Click:Connect(function()
                selBadge.Text = opt.name
                if headColorSwatch and opt.color then headColorSwatch.BackgroundColor3 = opt.color end
                toggleDropdown(false)
                callback(opt, i)
            end)
        end
    end

    local function createKeybind(parent, title, defaultStr, onKeySet, order)
        local row = Instance.new("Frame", parent)
        row.Size = UDim2.new(1, 0, 0, 32); row.BackgroundTransparency = 1; row.LayoutOrder = order or 1; row.ZIndex = 13

        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(1, -95, 1, 0); lbl.BackgroundTransparency = 1; lbl.Text = title; lbl.Font = Enum.Font.GothamMedium; lbl.TextSize = 13; lbl.TextColor3 = C_TEXT; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 13

        local bindBtn = Instance.new("TextButton", row)
        bindBtn.Size = UDim2.new(0, 85, 0, 26); bindBtn.Position = UDim2.new(1, -85, 0.5, -13); bindBtn.BackgroundColor3 = C_CARD_INNER; bindBtn.BorderSizePixel = 0; bindBtn.Text = "[ " .. defaultStr .. " ]"
        bindBtn.Font = Enum.Font.GothamBold; bindBtn.TextSize = 12; bindBtn.TextColor3 = C_ACCENT; bindBtn.AutoButtonColor = false; bindBtn.ZIndex = 14
        Instance.new("UICorner", bindBtn).CornerRadius = UDim.new(0, 6)

        bindBtn.MouseButton1Click:Connect(function()
            if S.isBinding then return end
            S.isBinding = true; bindBtn.Text = "..."; bindBtn.TextColor3 = C_WARNING
            local conn; conn = UIS.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.Keyboard then
                    local str = keyStr(inp.KeyCode)
                    bindBtn.Text = "[ " .. str .. " ]"; bindBtn.TextColor3 = C_ACCENT; S.isBinding = false; conn:Disconnect()
                    onKeySet("keyboard", inp.KeyCode, str)
                elseif inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.MouseButton2 or inp.UserInputType == Enum.UserInputType.MouseButton3 then
                    local ms = {[Enum.UserInputType.MouseButton1]="MB1",[Enum.UserInputType.MouseButton2]="MB2",[Enum.UserInputType.MouseButton3]="MB3"}
                    local str = ms[inp.UserInputType] or "MB?"
                    bindBtn.Text = "[ " .. str .. " ]"; bindBtn.TextColor3 = C_ACCENT; S.isBinding = false; conn:Disconnect()
                    onKeySet("mouse", inp.UserInputType, str)
                end
            end)
        end)
    end

    local function createStepper(parent, title, valGetter, onMinus, onPlus, order)
        local row = Instance.new("Frame", parent)
        row.Size = UDim2.new(1, 0, 0, 32); row.BackgroundTransparency = 1; row.LayoutOrder = order or 1; row.ZIndex = 13

        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(1, -120, 1, 0); lbl.BackgroundTransparency = 1; lbl.Text = title; lbl.Font = Enum.Font.GothamMedium; lbl.TextSize = 13; lbl.TextColor3 = C_TEXT; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 13

        local box = Instance.new("Frame", row)
        box.Size = UDim2.new(0, 110, 0, 26); box.Position = UDim2.new(1, -110, 0.5, -13); box.BackgroundColor3 = C_CARD_INNER; box.BorderSizePixel = 0; box.ZIndex = 14
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)

        local btnMinus = Instance.new("TextButton", box)
        btnMinus.Size = UDim2.new(0, 28, 1, 0); btnMinus.BackgroundTransparency = 1; btnMinus.Text = "-"; btnMinus.Font = Enum.Font.GothamBold; btnMinus.TextSize = 13; btnMinus.TextColor3 = C_TEXT_MUTED; btnMinus.ZIndex = 15

        local valLbl = Instance.new("TextLabel", box)
        valLbl.Size = UDim2.new(1, -56, 1, 0); valLbl.Position = UDim2.new(0, 28, 0, 0); valLbl.BackgroundTransparency = 1; valLbl.Text = tostring(valGetter()); valLbl.Font = Enum.Font.GothamBold; valLbl.TextSize = 12; valLbl.TextColor3 = C_ACCENT; valLbl.ZIndex = 15

        local btnPlus = Instance.new("TextButton", box)
        btnPlus.Size = UDim2.new(0, 28, 1, 0); btnPlus.Position = UDim2.new(1, -28, 0, 0); btnPlus.BackgroundTransparency = 1; btnPlus.Text = "+"; btnPlus.Font = Enum.Font.GothamBold; btnPlus.TextSize = 13; btnPlus.TextColor3 = C_TEXT_MUTED; btnPlus.ZIndex = 15

        btnMinus.MouseButton1Click:Connect(function() onMinus(); valLbl.Text = tostring(valGetter()) end)
        btnPlus.MouseButton1Click:Connect(function() onPlus(); valLbl.Text = tostring(valGetter()) end)

        return {Update = function() valLbl.Text = tostring(valGetter()) end}
    end

    local function createButton(parent, text, colorType, callback, order)
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(1, 0, 0, 32); btn.BackgroundColor3 = (colorType == "danger" and C_DANGER or C_CARD_INNER); btn.BorderSizePixel = 0; btn.Text = text
        btn.Font = Enum.Font.GothamBold; btn.TextSize = 12; btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.AutoButtonColor = false; btn.LayoutOrder = order or 1; btn.ZIndex = 13
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
        btn.MouseButton1Click:Connect(callback)
    end

    -- ============================================================
    -- POPULATE TABS
    -- ============================================================
    local aimPage = TabPages["Aimbot"]
    local aimGroup = createGroup(aimPage, "General Aim Assist", 1)
    createToggle(aimGroup, "Enable Aim Assist", S.enabled, function(on)
        S.enabled = on
        OV.stroke.Transparency = on and 0 or 1
        OV.vL.BackgroundTransparency = on and 0 or 1
        OV.hL.BackgroundTransparency = on and 0 or 1
        OV.dt.BackgroundTransparency = on and 0 or 1
        toast("Aim Assist", on)
    end, 1)
    createToggle(aimGroup, "Aim on Cursor", S.aimOnCursor, function(on) S.aimOnCursor = on; if not on then updOverlay() end; toast("Cursor Mode", on) end, 2)
    createKeybind(aimGroup, "Aim Activation Key", inputStr(), function(t, key, str) S.bindType = t; if t == "keyboard" then S.bindKey = key else S.bindMouse = key end; toast("Aim Key", str, C_ACCENT) end, 3)

    local aimSettings = createGroup(aimPage, "Radius & Smoothing", 2)
    createSlider(aimSettings, "FOV Radius", 30, 300, S.radius, " px", 1, function(val) S.radius = val; updOverlay() end, 1)
    createSlider(aimSettings, "Aim Speed", 0.05, 1.0, S.aimSpeed, "", 0.05, function(val) S.aimSpeed = val end, 2)

    local colorOptions = {
        {name = "Electric Blue", color = Color3.fromRGB(88, 145, 255)},
        {name = "Crimson Red",   color = Color3.fromRGB(255, 80, 80)},
        {name = "Emerald Green", color = Color3.fromRGB(63, 185, 80)},
        {name = "Golden Yellow", color = Color3.fromRGB(255, 200, 50)},
        {name = "Neon Purple",   color = Color3.fromRGB(200, 80, 255)},
        {name = "Pure White",    color = Color3.fromRGB(255, 255, 255)}
    }
    createDropdown(aimSettings, "Circle Color", colorOptions, 1, function(opt)
        local c = opt.color
        OV.stroke.Color = c; OV.vL.BackgroundColor3 = c; OV.hL.BackgroundColor3 = c; OV.dt.BackgroundColor3 = c
    end, 3)

    local visPage = TabPages["Visuals"]
    local espGroup = createGroup(visPage, "Player ESP", 1)
    createToggle(espGroup, "Player Highlight", S.espEnabled, function(on) S.espEnabled = on; if on then rebuildESP() else clearESP() end; toast("Player ESP", on) end, 1)
    createToggle(espGroup, "Team Filter", S.teamFilter, function(on) if not S.myTeamName then return end; S.teamFilter = on; rebuildESP(); toast("Team Filter", on) end, 2)
    createToggle(espGroup, "Show View Angles (Look Line)", S.viewAngles, function(on) S.viewAngles = on; for plr, _ in pairs(S.playerHighlights) do updateViewAngle(plr) end; toast("View Angles", on) end, 3)
    createSlider(espGroup, "Max Distance", 100, 10000, S.espRange, " studs", 100, function(val) S.espRange = val; updateESPRange() end, 4)
    createDropdown(espGroup, "ESP Highlight Color", colorOptions, 2, function(opt) S.espColor = opt.color; rebuildESP() end, 5)

    local removalsGroup = createGroup(visPage, "Removals & Clears", 2)
    createToggle(removalsGroup, "Anti-Flash (No Blind Screen)", S.antiFlash, function(on) S.antiFlash = on; toast("Anti-Flash", on) end, 1)
    createToggle(removalsGroup, "Anti-Smoke (Clear Smoke Clouds)", S.antiSmoke, function(on) S.antiSmoke = on; toast("Anti-Smoke", on) end, 2)

    local fogGroup = createGroup(visPage, "World Fog & Atmosphere", 3)
    createToggle(fogGroup, "Enable World Fog", S.fogEnabled, function(on) S.fogEnabled = on; if on then applyFog() else resetFog() end; toast("World Fog", on) end, 1)
    createSlider(fogGroup, "Fog Density", 0.05, 1.0, S.fogDensity, "", 0.05, function(val) S.fogDensity = val; if S.fogEnabled then applyFog() end end, 2)
    createSlider(fogGroup, "Fog Distance", 20, 2000, S.fogDistance, " studs", 20, function(val) S.fogDistance = val; if S.fogEnabled then applyFog() end end, 3)
    createSlider(fogGroup, "Fog Brightness", 0.1, 5.0, S.fogBrightness, "", 0.1, function(val) S.fogBrightness = val; if S.fogEnabled then applyFog() end end, 4)

    local fogColors = {
        {name = "Ice Blue",       color = Color3.fromRGB(180, 190, 210)},
        {name = "Sunset Orange",  color = Color3.fromRGB(255, 180, 100)},
        {name = "Blood Red",      color = Color3.fromRGB(255, 120, 80)},
        {name = "Deep Violet",    color = Color3.fromRGB(200, 130, 200)},
        {name = "Sky Cyan",       color = Color3.fromRGB(100, 150, 255)},
        {name = "Mint Emerald",   color = Color3.fromRGB(80, 200, 160)}
    }
    createDropdown(fogGroup, "Fog Atmosphere Color", fogColors, 1, function(opt) S.fogColor = opt.color; if S.fogEnabled then applyFog() end end, 5)

    local movePage = TabPages["Movement"]
    local bhopGroup = createGroup(movePage, "Auto BunnyHop", 1)
    createToggle(bhopGroup, "Enable BunnyHop", S.bhopEnabled, function(on) S.bhopEnabled = on; toast("BunnyHop", on) end, 1)
    createKeybind(bhopGroup, "Toggle Keybind", S.bhopToggleStr, function(_, key, str) S.bhopToggleKey = key; S.bhopToggleStr = str; toast("Bhop Key", str, C_ACCENT) end, 2)

    local bhopSettings = createGroup(movePage, "Physics Settings", 2)
    createSlider(bhopSettings, "Hop Speed Multiplier", 1.0, 5.0, S.bhopSpeed, "x", 0.1, function(val) S.bhopSpeed = val end, 1)
    createSlider(bhopSettings, "Vertical Jump Power", 20, 150, S.bhopJumpPower, " pwr", 5, function(val) S.bhopJumpPower = val end, 2)

    local settPage = TabPages["Settings"]
    local crossGroup = createGroup(settPage, "Crosshair Calibration", 1)
    local stepX, stepY
    stepX = createStepper(crossGroup, "Offset X", function() return S.overlayOffset.X end, function() S.overlayOffset = Vector2.new(S.overlayOffset.X - 1, S.overlayOffset.Y); updOverlay() end, function() S.overlayOffset = Vector2.new(S.overlayOffset.X + 1, S.overlayOffset.Y); updOverlay() end, 1)
    stepY = createStepper(crossGroup, "Offset Y", function() return S.overlayOffset.Y end, function() S.overlayOffset = Vector2.new(S.overlayOffset.X, S.overlayOffset.Y - 1); updOverlay() end, function() S.overlayOffset = Vector2.new(S.overlayOffset.X, S.overlayOffset.Y + 1); updOverlay() end, 2)
    createButton(crossGroup, "X  Reset Crosshair Center", "danger", function()
        S.overlayOffset = Vector2.new(0, 0); updOverlay(); stepX.Update(); stepY.Update(); scanCH(); toast("Offset Reset", "Center", C_WARNING)
    end, 3)

    local sysGroup = createGroup(settPage, "Client Information", 2)
    local function createReadout(parent, title, valText)
        local r = Instance.new("Frame", parent); r.Size = UDim2.new(1, 0, 0, 22); r.BackgroundTransparency = 1
        local l1 = Instance.new("TextLabel", r); l1.Size = UDim2.new(0.5, 0, 1, 0); l1.BackgroundTransparency = 1; l1.Text = title; l1.Font = Enum.Font.GothamMedium; l1.TextSize = 12; l1.TextColor3 = C_TEXT_MUTED; l1.TextXAlignment = Enum.TextXAlignment.Left
        local l2 = Instance.new("TextLabel", r); l2.Size = UDim2.new(0.5, 0, 1, 0); l2.Position = UDim2.new(0.5, 0, 0, 0); l2.BackgroundTransparency = 1; l2.Text = valText; l2.Font = Enum.Font.GothamBold; l2.TextSize = 12; l2.TextColor3 = C_TEXT; l2.TextXAlignment = Enum.TextXAlignment.Right
        return l2
    end
    local readTeam = createReadout(sysGroup, "Current Team", S.myTeamName or "None")
    createReadout(sysGroup, "Menu Toggle Key", "RightControl")
    createReadout(sysGroup, "Bhop Engine", "Counter-Blox Safe")

    -- Dragging
    local dragging, dragStart, startPos = false, nil, nil
    Header.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = Vector2.new(inp.Position.X, inp.Position.Y); startPos = Main.Position
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) and dragging then
            local delta = Vector2.new(inp.Position.X, inp.Position.Y) - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)

    CloseBtn.MouseButton1Click:Connect(function() resetFog(); gui:Destroy() end)
    MinBtn.MouseButton1Click:Connect(function()
        S.menuMinimized = not S.menuMinimized
        if S.menuMinimized then
            TWS:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 480, 0, 48)}):Play()
            TabBar.Visible = false; Content.Visible = false; Footer.Visible = false
        else
            TWS:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 480, 0, 520)}):Play()
            task.delay(0.1, function() TabBar.Visible = true; Content.Visible = true; Footer.Visible = true end)
        end
    end)

    local function setMenuVisible(vis)
        S.menuVisible = vis
        if vis then
            Main.Visible = true; MainScale.Scale = 0.94
            TWS:Create(MainScale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
        else
            local t = TWS:Create(MainScale, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0.94})
            t.Completed:Connect(function() if not S.menuVisible then Main.Visible = false end end); t:Play()
        end
    end

    pcall(function()
        CAS:BindActionAtPriority("Zentryx_SpaceHold", function(_, state)
            if state == Enum.UserInputState.Begin then S.bhopHolding = true elseif state == Enum.UserInputState.End or state == Enum.UserInputState.Cancel then S.bhopHolding = false end
            return Enum.ContextActionResult.Pass
        end, false, 3000, Enum.KeyCode.Space)
    end)

    UIS.InputBegan:Connect(function(inp, g)
        if inp.UserInputType == Enum.UserInputType.Keyboard then
            if inp.KeyCode == Enum.KeyCode.Space then S.bhopHolding = true end
            if S.bhopToggleKey and inp.KeyCode == S.bhopToggleKey and not S.bhopToggleHeld then
                S.bhopToggleHeld = true; S.bhopEnabled = not S.bhopEnabled; toast("BunnyHop", S.bhopEnabled)
            end
            if inp.KeyCode == Enum.KeyCode.RightControl then setMenuVisible(not S.menuVisible) end
        end
        if g then return end
        if S.bindType == "keyboard" and inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == S.bindKey and not S.keyHeld then S.keyHeld = true end
        if S.bindType == "mouse" and inp.UserInputType == S.bindMouse and not S.keyHeld then S.keyHeld = true end
    end)

    UIS.InputEnded:Connect(function(inp, g)
        if inp.UserInputType == Enum.UserInputType.Keyboard then
            if inp.KeyCode == Enum.KeyCode.Space then S.bhopHolding = false end
            if S.bhopToggleKey and inp.KeyCode == S.bhopToggleKey then S.bhopToggleHeld = false end
        end
        if g then return end
        if S.bindType == "keyboard" and inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == S.bindKey then S.keyHeld = false end
        if S.bindType == "mouse" and inp.UserInputType == S.bindMouse then S.keyHeld = false end
    end)

    local lastJumpTime = 0
    local function doBHop()
        if not S.bhopEnabled or not S.bhopHolding then
            S.bhopActive = false
            if S.bhopBV then S.bhopBV:Destroy(); S.bhopBV = nil end
            S.bhopJumped = false; return
        end
        local char = LocalPlayer.Character
        if not char then S.bhopActive = false; return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        local cam = workspace.CurrentCamera
        if not (hum and root and cam) or hum.Health <= 0 then S.bhopActive = false; if S.bhopBV then S.bhopBV:Destroy(); S.bhopBV = nil end return end

        S.bhopActive = true
        local look = cam.CFrame.LookVector
        local dir = Vector3.new(look.X, 0, look.Z)
        dir = dir.Magnitude > 0.01 and dir.Unit or Vector3.new(0,0,-1)

        if not S.bhopBV or S.bhopBV.Parent ~= root then
            if S.bhopBV then S.bhopBV:Destroy() end
            S.bhopBV = Instance.new("BodyVelocity"); S.bhopBV.MaxForce = Vector3.new(math.huge, 0, math.huge); S.bhopBV.P = 1250; S.bhopBV.Parent = root
        end
        S.bhopBV.Velocity = dir * (16 * S.bhopSpeed)

        local state = hum:GetState()
        local vy = root.Velocity.Y
        local onGround = (state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.RunningNoPhysics or state == Enum.HumanoidStateType.Landed or state == Enum.HumanoidStateType.Seated) and math.abs(vy) < 3
        if not onGround and hum.FloorMaterial ~= Enum.Material.Air then onGround = true end

        local now = tick()
        if onGround and (now - lastJumpTime) >= 0.05 then
            lastJumpTime = now
            root.Velocity = Vector3.new(root.Velocity.X, S.bhopJumpPower, root.Velocity.Z)
            pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
            pcall(function() hum.Jump = true end)
            S.bhopJumped = true
        end
    end

    local function nearestInCircle()
        local cam = workspace.CurrentCamera
        if not cam then return nil end
        local vp = cam.ViewportSize
        local ctr = S.aimOnCursor and UIS:GetMouseLocation() or (Vector2.new(vp.X/2, vp.Y/2) + S.overlayOffset)
        local best, bd = nil, S.radius
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and isAlive(p) and not (S.teamFilter and isTeammate(p)) then
                local char = p.Character
                local head = char and char:FindFirstChild("Head")
                if head then
                    local sp, on = cam:WorldToViewportPoint(head.Position)
                    if on then
                        local d = (Vector2.new(sp.X, sp.Y) - ctr).Magnitude
                        if d < bd then bd = d; best = p end
                    end
                end
            end
        end
        return best
    end

    local fc, trc, erc = 0, 0, 0
    local statsTimer, fpsCount, fpsTimer = 0, 0, 0

    RS.RenderStepped:Connect(function(dt)
        local cam = workspace.CurrentCamera
        if not cam then return end
        fc = fc + 1; trc = trc + 1; erc = erc + 1

        statsTimer = statsTimer + dt; fpsCount = fpsCount + 1
        if fpsTimer >= 0.5 then
            StatFps.Text = ("FPS: %d"):format(math.floor(fpsCount / fpsTimer))
            fpsCount = 0; fpsTimer = 0
        else
            fpsTimer = fpsTimer + dt
        end

        if statsTimer >= 0.5 then
            statsTimer = 0
            local ping = 0
            pcall(function() ping = math.floor(Players:GetNetworkPing() * 1000) end)
            StatPing.Text = ("Ping: %d ms"):format(ping)
        end

        if erc >= 15 then erc = 0; updateESPRange() end
        if fc >= 180 then
            fc = 0; task.spawn(function() pcall(scanCH) end)
            StatCross.Text = "Crosshair: " .. (S.crosshairDetected and "Detected" or "Center")
        end
        if trc >= 1800 then
            trc = 0
            pcall(function()
                local nn, nc = detectTeam(LocalPlayer)
                if nn and nn ~= S.myTeamName then
                    S.myTeamName = nn; S.myTeamColor = nc; readTeam.Text = nn; rebuildESP()
                end
            end)
        end

        doBHop()
        doAntiFlash()
        if S.fogEnabled then applyFog() end

        if S.aimOnCursor and S.enabled then
            local mp = UIS:GetMouseLocation(); local ox, oy = S.overlayOffset.X, S.overlayOffset.Y
            OV.circle.Position = UDim2.new(0, mp.X + ox - S.radius, 0, mp.Y + oy - S.radius)
            OV.vL.Position = UDim2.new(0, mp.X + ox - 1, 0, mp.Y + oy - 8)
            OV.hL.Position = UDim2.new(0, mp.X + ox - 8, 0, mp.Y + oy - 1)
            OV.dt.Position = UDim2.new(0, mp.X + ox - 2, 0, mp.Y + oy - 2)
        end

        if not S.enabled or not S.keyHeld then S.aimHasTarget = false; return end
        local t = nearestInCircle()
        if not t or not isAlive(t) then S.aimHasTarget = false; return end
        local char = t.Character; local h = char and char:FindFirstChild("Head")
        if not h then S.aimHasTarget = false; return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then S.aimHasTarget = false; return end

        S.aimHasTarget = true
        cam.CFrame = cam.CFrame:Lerp(CFrame.lookAt(cam.CFrame.Position, h.Position), math.clamp(S.aimSpeed * dt * 60, 0, 1))
    end)

    task.spawn(function()
        while task.wait(1) do
            if not S.espEnabled then continue end
            for plr, _ in pairs(S.playerHighlights) do if not isAliveSoft(plr) then clearPlayerESP(plr) end end
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and isAliveSoft(plr) and not S.playerHighlights[plr] then addHighlight(plr) end
            end
        end
    end)

    task.spawn(function()
        while task.wait(0.6) do
            local alpha = (S.aimHasTarget and S.enabled) and 0.15 or 0.5
            TWS:Create(OV.stroke, TweenInfo.new(0.5), {Transparency = alpha}):Play()
        end
    end)

    toast("Zentryx Hub", "LOADED", C_SUCCESS)
    if S.myTeamName then toast("Assigned Team", S.myTeamName, C_ACCENT) end
end

-- ============================================================
-- GUI KEY SYSTEM (ОКНО ВВОДА КЛЮЧА)
-- ============================================================
local KeyWin = Instance.new("Frame")
KeyWin.Name = "KeyWindow"
KeyWin.Parent = gui
KeyWin.Size = UDim2.new(0, 390, 0, 245)
KeyWin.Position = UDim2.new(0.5, -195, 0.5, -122)
KeyWin.BackgroundColor3 = C_BG
KeyWin.BorderSizePixel = 0
KeyWin.Active = true
KeyWin.ZIndex = 100
Instance.new("UICorner", KeyWin).CornerRadius = UDim.new(0, 12)

local kStroke = Instance.new("UIStroke", KeyWin)
kStroke.Color = C_STROKE
kStroke.Thickness = 1.2

local KHead = Instance.new("Frame", KeyWin)
KHead.Size = UDim2.new(1, 0, 0, 42)
KHead.BackgroundColor3 = C_CARD
KHead.BorderSizePixel = 0
KHead.ZIndex = 101
Instance.new("UICorner", KHead).CornerRadius = UDim.new(0, 12)

local KTitle = Instance.new("TextLabel", KHead)
KTitle.Size = UDim2.new(1, -50, 1, 0)
KTitle.Position = UDim2.new(0, 14, 0, 0)
KTitle.BackgroundTransparency = 1
KTitle.Text = "ZENTRYX <font color=\"rgb(88,145,255)\">KEY SYSTEM</font>"
KTitle.RichText = true
KTitle.Font = Enum.Font.GothamBold
KTitle.TextSize = 13
KTitle.TextColor3 = C_TEXT
KTitle.TextXAlignment = Enum.TextXAlignment.Left
KTitle.ZIndex = 102

local KClose = Instance.new("TextButton", KHead)
KClose.Size = UDim2.new(0, 26, 0, 26)
KClose.Position = UDim2.new(1, -34, 0.5, -13)
KClose.BackgroundColor3 = C_CARD_INNER
KClose.BorderSizePixel = 0
KClose.Text = "X"
KClose.Font = Enum.Font.GothamBold
KClose.TextSize = 12
KClose.TextColor3 = C_TEXT_MUTED
KClose.AutoButtonColor = false
KClose.ZIndex = 102
Instance.new("UICorner", KClose).CornerRadius = UDim.new(0, 6)
KClose.MouseButton1Click:Connect(function() gui:Destroy() end)

local KSub = Instance.new("TextLabel", KeyWin)
KSub.Size = UDim2.new(1, -30, 0, 24)
KSub.Position = UDim2.new(0, 15, 0, 48)
KSub.BackgroundTransparency = 1
KSub.Text = "Введите лицензионный ключ для разблокировки чита:"
KSub.Font = Enum.Font.GothamMedium
KSub.TextSize = 11
KSub.TextColor3 = C_TEXT_MUTED
KSub.TextXAlignment = Enum.TextXAlignment.Left
KSub.ZIndex = 101

local BoxWrap = Instance.new("Frame", KeyWin)
BoxWrap.Size = UDim2.new(1, -30, 0, 40)
BoxWrap.Position = UDim2.new(0, 15, 0, 78)
BoxWrap.BackgroundColor3 = C_CARD_INNER
BoxWrap.BorderSizePixel = 0
BoxWrap.ZIndex = 101
Instance.new("UICorner", BoxWrap).CornerRadius = UDim.new(0, 8)
local bSt = Instance.new("UIStroke", BoxWrap)
bSt.Color = C_STROKE; bSt.Thickness = 1

local KInput = Instance.new("TextBox", BoxWrap)
KInput.Size = UDim2.new(1, -20, 1, 0)
KInput.Position = UDim2.new(0, 10, 0, 0)
KInput.BackgroundTransparency = 1
KInput.PlaceholderText = "Вставьте ключ формата ZTX-XXXX-XXXX-XXXX..."
KInput.PlaceholderColor3 = C_TEXT_MUTED
KInput.Text = ""
KInput.Font = Enum.Font.GothamSemibold
KInput.TextSize = 11
KInput.TextColor3 = C_TEXT
KInput.ClearTextOnFocus = false
KInput.ZIndex = 102

local SubBtn = Instance.new("TextButton", KeyWin)
SubBtn.Size = UDim2.new(1, -30, 0, 36)
SubBtn.Position = UDim2.new(0, 15, 0, 132)
SubBtn.BackgroundColor3 = C_ACCENT
SubBtn.BorderSizePixel = 0
SubBtn.Text = "ПРОВЕРИТЬ КЛЮЧ"
SubBtn.Font = Enum.Font.GothamBold
SubBtn.TextSize = 12
SubBtn.TextColor3 = Color3.new(1, 1, 1)
SubBtn.AutoButtonColor = false
SubBtn.ZIndex = 101
Instance.new("UICorner", SubBtn).CornerRadius = UDim.new(0, 8)

local GetBtn = Instance.new("TextButton", KeyWin)
GetBtn.Size = UDim2.new(1, -30, 0, 34)
GetBtn.Position = UDim2.new(0, 15, 0, 178)
GetBtn.BackgroundColor3 = C_CARD
GetBtn.BorderSizePixel = 0
GetBtn.Text = "ПОЛУЧИТЬ КЛЮЧ (DISCORD)"
GetBtn.Font = Enum.Font.GothamBold
GetBtn.TextSize = 11
GetBtn.TextColor3 = C_TEXT_MUTED
GetBtn.AutoButtonColor = false
GetBtn.ZIndex = 101
Instance.new("UICorner", GetBtn).CornerRadius = UDim.new(0, 8)
local gSt = Instance.new("UIStroke", GetBtn)
gSt.Color = C_STROKE; gSt.Thickness = 1

GetBtn.MouseButton1Click:Connect(function()
    local url = "https://discord.gg/mfxyHQ8AQq"
    pcall(function() if setclipboard then setclipboard(url) end end)
    pcall(function() if openurl then openurl(url) end end)
    toast("Discord Ссылка", "Скопирована в буфер!", C_ACCENT)
end)

-- Валидация и разблокировка
SubBtn.MouseButton1Click:Connect(function()
    local entered = string.upper(KInput.Text:gsub("%s+", ""))
    if entered == "" then
        toast("Key System", "Поле ключа пустое", C_WARNING)
        return
    end

    if RegisteredKeys[entered] ~= nil then
        if RegisteredKeys[entered] == true then
            toast("Key System", "Ключ уже использован!", C_DANGER)
        else
            RegisteredKeys[entered] = true
            toast("Key System", "Ключ подтверждён!", C_SUCCESS)

            TWS:Create(KeyWin, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1
            }):Play()

            task.delay(0.3, function()
                KeyWin:Destroy()
                startZentryxHub()
            end)
        end
    else
        toast("Key System", "Неверный ключ!", C_DANGER)
    end
end)

local drag, dStart, sPos
KHead.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true; dStart = Vector2.new(inp.Position.X, inp.Position.Y); sPos = KeyWin.Position
    end
end)
UIS.InputChanged:Connect(function(inp)
    if drag and inp.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = Vector2.new(inp.Position.X, inp.Position.Y) - dStart
        KeyWin.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + delta.X, sPos.Y.Scale, sPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
end)

toast("Zentryx Key System", "Ожидание ввода ключа...", C_ACCENT)

end)

if not ok then
    warn("[-] Zentryx Hub ERROR:", err)
end
