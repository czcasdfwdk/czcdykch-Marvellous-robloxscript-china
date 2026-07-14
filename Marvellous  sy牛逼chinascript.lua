-- ============================================================
--  可拖动窗口 - DyK杀戮/吸人 (双模式)
--  模式1: 杀戮模式 - 循环执行 (速度可调)
--  模式2: 吸人模式 - 单次执行 (速度可调)
--  窗口可拖动、可展开/收回
--  位置: Y = 0.50，高度 = 310
-- ============================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- ============================================================
--  配置参数
-- ============================================================
local CONFIG = {
    TargetName = "MrFantastic",
    TargetName2 = "TheFlashCw",
    AttackRange = 99999,
    AttackSpeed = 0.3,
    SelectedPlayers = {},
    IsAllMode = true,
    CurrentMode = 1,
}

-- ============================================================
--  创建 GUI
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DyKGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- 主窗口
local mainWindow = Instance.new("Frame")
mainWindow.Name = "MainWindow"
mainWindow.Size = UDim2.new(0, 200, 0, 310)
mainWindow.Position = UDim2.new(0.42, -100, 0.50, -155)
mainWindow.BackgroundColor3 = Color3.fromRGB(18, 22, 40)
mainWindow.BackgroundTransparency = 0.1
mainWindow.BorderSizePixel = 0
mainWindow.ClipsDescendants = true
mainWindow.Parent = screenGui

local windowCorner = Instance.new("UICorner")
windowCorner.CornerRadius = UDim.new(0, 12)
windowCorner.Parent = mainWindow

local windowStroke = Instance.new("UIStroke")
windowStroke.Color = Color3.fromRGB(255, 255, 255)
windowStroke.Transparency = 0.9
windowStroke.Thickness = 1
windowStroke.Parent = mainWindow

-- ============================================================
--  标题栏 (可拖动区域 - 使用TextButton确保交互)
-- ============================================================
local titleBar = Instance.new("TextButton")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 32)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
titleBar.BackgroundTransparency = 0.96
titleBar.BorderSizePixel = 0
titleBar.AutoButtonColor = false
titleBar.Text = ""
titleBar.Parent = mainWindow

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 130, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚔ DyK杀戮"
titleLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
titleLabel.TextSize = 13
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Font = Enum.Font.GothamSemibold
titleLabel.Parent = titleBar

local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleBtn"
toggleBtn.Size = UDim2.new(0, 24, 0, 24)
toggleBtn.Position = UDim2.new(1, -58, 0.5, -12)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.BackgroundTransparency = 0.9
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "▲"
toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
toggleBtn.TextSize = 12
toggleBtn.Font = Enum.Font.Gotham
toggleBtn.Parent = titleBar

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = toggleBtn

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -30, 0.5, -12)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeBtn.BackgroundTransparency = 0.85
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.Gotham
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

-- ============================================================
--  内容容器
-- ============================================================
local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, 0, 1, -32)
contentContainer.Position = UDim2.new(0, 0, 0, 32)
contentContainer.BackgroundTransparency = 1
contentContainer.ClipsDescendants = true
contentContainer.Parent = mainWindow

local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -12, 1, 0)
content.Position = UDim2.new(0, 6, 0, 0)
content.BackgroundTransparency = 1
content.Parent = contentContainer

local isExpanded = true

toggleBtn.MouseButton1Click:Connect(function()
    isExpanded = not isExpanded
    local targetHeight = isExpanded and 310 or 44
    toggleBtn.Text = isExpanded and "▲" or "▼"
    TweenService:Create(mainWindow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 200, 0, targetHeight)
    }):Play()
end)

-- ============================================================
--  范围输入
-- ============================================================
local rangeLabel = Instance.new("TextLabel")
rangeLabel.Size = UDim2.new(1, 0, 0, 14)
rangeLabel.Position = UDim2.new(0, 0, 0, 2)
rangeLabel.BackgroundTransparency = 1
rangeLabel.Text = "📏 范围:"
rangeLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
rangeLabel.TextSize = 11
rangeLabel.TextXAlignment = Enum.TextXAlignment.Left
rangeLabel.Font = Enum.Font.Gotham
rangeLabel.Parent = content

local rangeInput = Instance.new("TextBox")
rangeInput.Name = "RangeInput"
rangeInput.Size = UDim2.new(1, 0, 0, 22)
rangeInput.Position = UDim2.new(0, 0, 0, 18)
rangeInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
rangeInput.BackgroundTransparency = 0.9
rangeInput.BorderSizePixel = 0
rangeInput.Text = "无限制"
rangeInput.TextColor3 = Color3.fromRGB(230, 230, 230)
rangeInput.TextSize = 12
rangeInput.Font = Enum.Font.Gotham
rangeInput.PlaceholderText = "数字 或 无限制"
rangeInput.Parent = content

local rangeCorner = Instance.new("UICorner")
rangeCorner.CornerRadius = UDim.new(0, 5)
rangeCorner.Parent = rangeInput

rangeInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local text = rangeInput.Text:gsub("^%s*(.-)%s*$", "%1")
        if text == "" or text:lower() == "无限制" then
            CONFIG.AttackRange = 99999
            rangeInput.Text = "无限制"
        else
            local num = tonumber(text)
            if num and num > 0 then
                CONFIG.AttackRange = num
                rangeInput.Text = tostring(num)
            else
                rangeInput.Text = "无限制"
                CONFIG.AttackRange = 99999
            end
        end
    end
end)

-- ============================================================
--  模式切换按钮 (杀戮/吸人)
-- ============================================================
local modeSwitchLabel = Instance.new("TextLabel")
modeSwitchLabel.Size = UDim2.new(1, 0, 0, 14)
modeSwitchLabel.Position = UDim2.new(0, 0, 0, 44)
modeSwitchLabel.BackgroundTransparency = 1
modeSwitchLabel.Text = "🔄 当前模式: 杀戮"
modeSwitchLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
modeSwitchLabel.TextSize = 11
modeSwitchLabel.TextXAlignment = Enum.TextXAlignment.Left
modeSwitchLabel.Font = Enum.Font.Gotham
modeSwitchLabel.Parent = content

local modeSwitchBtn = Instance.new("TextButton")
modeSwitchBtn.Name = "ModeSwitchBtn"
modeSwitchBtn.Size = UDim2.new(1, 0, 0, 24)
modeSwitchBtn.Position = UDim2.new(0, 0, 0, 60)
modeSwitchBtn.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
modeSwitchBtn.BackgroundTransparency = 0.3
modeSwitchBtn.BorderSizePixel = 0
modeSwitchBtn.Text = "⚔ 切换为: 吸人"
modeSwitchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
modeSwitchBtn.TextSize = 12
modeSwitchBtn.Font = Enum.Font.GothamSemibold
modeSwitchBtn.Parent = content

local modeSwitchCorner = Instance.new("UICorner")
modeSwitchCorner.CornerRadius = UDim.new(0, 5)
modeSwitchCorner.Parent = modeSwitchBtn

local modeNames = {"杀戮", "吸人"}
local modeIcons = {"⚔", "🌀"}

modeSwitchBtn.MouseButton1Click:Connect(function()
    CONFIG.CurrentMode = CONFIG.CurrentMode == 1 and 2 or 1
    local modeName = modeNames[CONFIG.CurrentMode]
    local icon = modeIcons[CONFIG.CurrentMode]
    local nextMode = CONFIG.CurrentMode == 1 and 2 or 1
    modeSwitchLabel.Text = "🔄 当前模式: " .. modeName
    modeSwitchBtn.Text = icon .. " 切换为: " .. modeNames[nextMode]
    titleLabel.Text = icon .. " DyK" .. modeName
    if CONFIG.CurrentMode == 2 then
        if not speedInput.IsFocused then
            CONFIG.AttackSpeed = 1.00
            speedInput.Text = "1.00"
            speedLabel.Text = "⚡ 速度: 1.00s"
            speedLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
        end
    else
        if not speedInput.IsFocused then
            CONFIG.AttackSpeed = 0.3
            speedInput.Text = "0.30"
            speedLabel.Text = "⚡ 速度: 0.30s"
            speedLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
        end
    end
    print("🔄 切换到 " .. modeName .. " 模式")
    if isRunning then
        stopLoop()
        task.wait(0.1)
        startLoop()
    end
end)

-- ============================================================
--  攻击速度输入
-- ============================================================
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 14)
speedLabel.Position = UDim2.new(0, 0, 0, 88)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ 速度: 0.30s"
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
speedLabel.TextSize = 11
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Font = Enum.Font.Gotham
speedLabel.Parent = content

local speedInput = Instance.new("TextBox")
speedInput.Name = "SpeedInput"
speedInput.Size = UDim2.new(1, 0, 0, 22)
speedInput.Position = UDim2.new(0, 0, 0, 104)
speedInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
speedInput.BackgroundTransparency = 0.9
speedInput.BorderSizePixel = 0
speedInput.Text = "0.30"
speedInput.TextColor3 = Color3.fromRGB(230, 230, 230)
speedInput.TextSize = 12
speedInput.Font = Enum.Font.Gotham
speedInput.PlaceholderText = "秒 (0.01-150)"
speedInput.Parent = content

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 5)
speedCorner.Parent = speedInput

speedInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local text = speedInput.Text:gsub("^%s*(.-)%s*$", "%1")
        local num = tonumber(text)
        if num and num >= 0.01 and num <= 150 then
            CONFIG.AttackSpeed = num
            speedInput.Text = string.format("%.2f", num)
            speedLabel.Text = "⚡ 速度: " .. string.format("%.2f", num) .. "s"
            speedLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
            if isRunning then
                stopLoop()
                task.wait(0.1)
                startLoop()
            end
        else
            speedInput.Text = string.format("%.2f", CONFIG.AttackSpeed)
        end
    end
end)

-- ============================================================
--  合并行: 目标玩家 (左) 与 模式 (右)
-- ============================================================
local mergeRow = Instance.new("Frame")
mergeRow.Name = "MergeRow"
mergeRow.Size = UDim2.new(1, 0, 0, 26)
mergeRow.Position = UDim2.new(0, 0, 0, 130)
mergeRow.BackgroundTransparency = 1
mergeRow.Parent = content

local selectPlayersBtn = Instance.new("TextButton")
selectPlayersBtn.Name = "SelectPlayersBtn"
selectPlayersBtn.Size = UDim2.new(0.6, -4, 1, 0)
selectPlayersBtn.Position = UDim2.new(0, 0, 0, 0)
selectPlayersBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
selectPlayersBtn.BackgroundTransparency = 0.9
selectPlayersBtn.BorderSizePixel = 0
selectPlayersBtn.Text = "👥 目标玩家 (0)"
selectPlayersBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
selectPlayersBtn.TextSize = 11
selectPlayersBtn.Font = Enum.Font.Gotham
selectPlayersBtn.TextXAlignment = Enum.TextXAlignment.Left
selectPlayersBtn.TextTruncate = Enum.TextTruncate.AtEnd
selectPlayersBtn.Parent = mergeRow

local selectCorner = Instance.new("UICorner")
selectCorner.CornerRadius = UDim.new(0, 5)
selectCorner.Parent = selectPlayersBtn

local modeBtn = Instance.new("TextButton")
modeBtn.Name = "ModeBtn"
modeBtn.Size = UDim2.new(0.35, -4, 1, 0)
modeBtn.Position = UDim2.new(0.65, 0, 0, 0)
modeBtn.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
modeBtn.BackgroundTransparency = 0.3
modeBtn.BorderSizePixel = 0
modeBtn.Text = "🌍 所有"
modeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
modeBtn.TextSize = 11
modeBtn.Font = Enum.Font.GothamSemibold
modeBtn.Parent = mergeRow

local modeCorner = Instance.new("UICorner")
modeCorner.CornerRadius = UDim.new(0, 5)
modeCorner.Parent = modeBtn

local selectPlayersBtnRef = selectPlayersBtn
local modeBtnRef = modeBtn

-- ============================================================
--  状态显示
-- ============================================================
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 16)
statusLabel.Position = UDim2.new(0, 0, 0, 160)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "● 已停止"
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = content

local targetInfo = Instance.new("TextLabel")
targetInfo.Size = UDim2.new(1, 0, 0, 14)
targetInfo.Position = UDim2.new(0, 0, 0, 178)
targetInfo.BackgroundTransparency = 1
targetInfo.Text = "等待启动..."
targetInfo.TextColor3 = Color3.fromRGB(140, 140, 160)
targetInfo.TextSize = 10
targetInfo.Font = Enum.Font.Gotham
targetInfo.Parent = content

-- ============================================================
--  启动/停止按钮
-- ============================================================
local triggerBtn = Instance.new("TextButton")
triggerBtn.Size = UDim2.new(1, 0, 0, 30)
triggerBtn.Position = UDim2.new(0, 0, 0, 198)
triggerBtn.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
triggerBtn.BorderSizePixel = 0
triggerBtn.Text = "▶ 启动"
triggerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
triggerBtn.TextSize = 13
triggerBtn.Font = Enum.Font.GothamSemibold
triggerBtn.Parent = content

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = triggerBtn

-- ============================================================
--  玩家选择列表 (弹窗 - 使用ScrollingFrame支持滚动)
-- ============================================================
local selectionGui = Instance.new("ScreenGui")
selectionGui.Name = "PlayerSelectionGUI"
selectionGui.Parent = screenGui
selectionGui.Enabled = false

local selectionFrame = Instance.new("Frame")
selectionFrame.Size = UDim2.new(0, 180, 0, 230)
selectionFrame.Position = UDim2.new(0.5, -90, 0.5, -115)
selectionFrame.BackgroundColor3 = Color3.fromRGB(22, 26, 48)
selectionFrame.BackgroundTransparency = 0.05
selectionFrame.BorderSizePixel = 0
selectionFrame.ClipsDescendants = true
selectionFrame.Parent = selectionGui

local selCorner = Instance.new("UICorner")
selCorner.CornerRadius = UDim.new(0, 12)
selCorner.Parent = selectionFrame

local selStroke = Instance.new("UIStroke")
selStroke.Color = Color3.fromRGB(255, 255, 255)
selStroke.Transparency = 0.9
selStroke.Thickness = 1
selStroke.Parent = selectionFrame

-- 标题
local selTitle = Instance.new("TextLabel")
selTitle.Size = UDim2.new(1, 0, 0, 28)
selTitle.Position = UDim2.new(0, 0, 0, 0)
selTitle.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
selTitle.BackgroundTransparency = 0.3
selTitle.Text = "选择目标玩家"
selTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
selTitle.TextSize = 13
selTitle.Font = Enum.Font.GothamSemibold
selTitle.Parent = selectionFrame

local selTitleCorner = Instance.new("UICorner")
selTitleCorner.CornerRadius = UDim.new(0, 12)
selTitleCorner.Parent = selTitle

-- 关闭按钮 (右上角)
local selCloseBtn = Instance.new("TextButton")
selCloseBtn.Name = "SelCloseBtn"
selCloseBtn.Size = UDim2.new(0, 24, 0, 24)
selCloseBtn.Position = UDim2.new(1, -32, 0, 2)
selCloseBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
selCloseBtn.BackgroundTransparency = 0.85
selCloseBtn.BorderSizePixel = 0
selCloseBtn.Text = "✕"
selCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
selCloseBtn.TextSize = 12
selCloseBtn.Font = Enum.Font.Gotham
selCloseBtn.Parent = selectionFrame

local selCloseCorner = Instance.new("UICorner")
selCloseCorner.CornerRadius = UDim.new(1, 0)
selCloseCorner.Parent = selCloseBtn

-- 玩家列表容器 (ScrollingFrame - 支持滚动)
local listContainer = Instance.new("ScrollingFrame")
listContainer.Name = "ListContainer"
listContainer.Size = UDim2.new(1, -10, 1, -44)
listContainer.Position = UDim2.new(0, 5, 0, 34)
listContainer.BackgroundTransparency = 1
listContainer.BorderSizePixel = 0
listContainer.ClipsDescendants = true
listContainer.ScrollBarThickness = 4
listContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 130)
listContainer.Parent = selectionFrame

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Padding = UDim.new(0, 2)
listLayout.Parent = listContainer

-- 监听布局变化更新CanvasSize
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    listContainer.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 4)
end)

-- ============================================================
--  临时选中列表
-- ============================================================
local tempSelected = {}

-- ============================================================
--  刷新玩家列表
-- ============================================================
local function refreshPlayerList()
    for _, child in ipairs(listContainer:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local onlinePlayers = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            table.insert(onlinePlayers, plr.Name)
        end
    end
    
    if #onlinePlayers == 0 then
        local emptyLabel = Instance.new("TextLabel")
        emptyLabel.Size = UDim2.new(1, 0, 0, 30)
        emptyLabel.BackgroundTransparency = 1
        emptyLabel.Text = "没有在线玩家"
        emptyLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
        emptyLabel.TextSize = 12
        emptyLabel.Parent = listContainer
        listContainer.CanvasSize = UDim2.new(0, 0, 0, 34)
        return
    end
    
    for _, name in ipairs(onlinePlayers) do
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Size = UDim2.new(1, 0, 0, 24)
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundTransparency = 0.9
        btn.BorderSizePixel = 0
        btn.Text = "☐ " .. name
        btn.TextColor3 = Color3.fromRGB(200, 200, 210)
        btn.TextSize = 11
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Font = Enum.Font.Gotham
        btn.Parent = listContainer
        
        local btnCornerLocal = Instance.new("UICorner")
        btnCornerLocal.CornerRadius = UDim.new(0, 4)
        btnCornerLocal.Parent = btn
        
        if tempSelected[name] then
            btn.Text = "☑ " .. name
            btn.TextColor3 = Color3.fromRGB(110, 231, 183)
            btn.BackgroundColor3 = Color3.fromRGB(110, 231, 183)
            btn.BackgroundTransparency = 0.7
        end
        
        btn.MouseButton1Click:Connect(function()
            if tempSelected[name] then
                tempSelected[name] = nil
                btn.Text = "☐ " .. name
                btn.TextColor3 = Color3.fromRGB(200, 200, 210)
                btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                btn.BackgroundTransparency = 0.9
            else
                tempSelected[name] = true
                btn.Text = "☑ " .. name
                btn.TextColor3 = Color3.fromRGB(110, 231, 183)
                btn.BackgroundColor3 = Color3.fromRGB(110, 231, 183)
                btn.BackgroundTransparency = 0.7
            end
        end)
    end
    
    -- CanvasSize会在布局更新时自动调整
    task.wait(0.05)
    listContainer.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 4)
end

-- ============================================================
--  关闭选择列表 (自动确认)
-- ============================================================
local function closePlayerSelection()
    CONFIG.SelectedPlayers = {}
    for name, _ in pairs(tempSelected) do
        table.insert(CONFIG.SelectedPlayers, name)
    end
    local count = #CONFIG.SelectedPlayers
    selectPlayersBtnRef.Text = "👥 目标玩家 (" .. count .. ")"
    selectionGui.Enabled = false
    print("📋 已选择 " .. count .. " 个玩家: " .. table.concat(CONFIG.SelectedPlayers, ", "))
end

selCloseBtn.MouseButton1Click:Connect(function()
    closePlayerSelection()
end)

-- ============================================================
--  打开选择列表
-- ============================================================
local function openPlayerSelection()
    tempSelected = {}
    for _, name in pairs(CONFIG.SelectedPlayers) do
        tempSelected[name] = true
    end
    refreshPlayerList()
    selectionGui.Enabled = true
end

selectPlayersBtnRef.MouseButton1Click:Connect(function()
    if not CONFIG.IsAllMode then
        openPlayerSelection()
    else
        print("⚠️ 请先切换到 '指定玩家' 模式")
    end
end)

-- ============================================================
--  模式切换 (所有玩家/指定玩家)
-- ============================================================
modeBtnRef.MouseButton1Click:Connect(function()
    CONFIG.IsAllMode = not CONFIG.IsAllMode
    if CONFIG.IsAllMode then
        modeBtnRef.Text = "🌍 所有"
        modeBtnRef.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
        modeBtnRef.BackgroundTransparency = 0.3
        selectPlayersBtnRef.TextTransparency = 0.5
        selectPlayersBtnRef.Active = false
        tempSelected = {}
        print("🌍 切换为: 检测所有玩家")
    else
        modeBtnRef.Text = "🎯 指定"
        modeBtnRef.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
        modeBtnRef.BackgroundTransparency = 0.3
        selectPlayersBtnRef.TextTransparency = 0
        selectPlayersBtnRef.Active = true
        if #CONFIG.SelectedPlayers > 0 then
            tempSelected = {}
            for _, name in pairs(CONFIG.SelectedPlayers) do
                tempSelected[name] = true
            end
            selectPlayersBtnRef.Text = "👥 目标玩家 (" .. #CONFIG.SelectedPlayers .. ")"
        else
            selectPlayersBtnRef.Text = "👥 目标玩家 (0)"
        end
        print("🎯 切换为: 检测指定玩家")
    end
end)

selectPlayersBtnRef.TextTransparency = 0.5
selectPlayersBtnRef.Active = false

-- ============================================================
--  状态变量
-- ============================================================
local isRunning = false
local loopConnection = nil

-- ============================================================
--  获取有效目标
-- ============================================================
local function getValidTarget()
    local character = player.Character
    if not character then return nil end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local nearest = nil
    local minDist = math.huge
    local range = CONFIG.AttackRange
    
    local allowedPlayers = {}
    if CONFIG.IsAllMode then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                allowedPlayers[plr.Name] = true
            end
        end
    else
        for _, name in pairs(CONFIG.SelectedPlayers) do
            allowedPlayers[name] = true
        end
    end
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and allowedPlayers[plr.Name] then
            local targetChar = plr.Character
            if targetChar then
                local humanoid = targetChar:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        local dist = (root.Position - targetRoot.Position).Magnitude
                        if dist <= range and dist < minDist then
                            minDist = dist
                            nearest = targetChar
                        end
                    end
                end
            end
        end
    end
    return nearest
end

-- ============================================================
--  执行攻击
-- ============================================================
local function executeHitSpin()
    pcall(function()
        local target = getValidTarget()
        
        if target then
            local targetName = target.Parent and target.Parent.Name or "未知"
            local humanoid = target:FindFirstChild("Humanoid")
            local hp = humanoid and math.floor(humanoid.Health) or 0
            
            local dist = "∞"
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root and target:FindFirstChild("HumanoidRootPart") then
                dist = string.format("%.1f", (root.Position - target.HumanoidRootPart.Position).Magnitude)
            end
            
            targetInfo.Text = "🎯 " .. targetName .. " HP:" .. hp .. " 📊" .. dist .. "格"
            
            local targetChar = CONFIG.CurrentMode == 1 and "MrFantastic" or "TheFlashCw"
            local remoteName = CONFIG.CurrentMode == 1 and "HitSpin" or "Mirrage"
            
            if CONFIG.CurrentMode == 2 then
                local targetPlayer = Players:FindFirstChild("hsuhsb213211")
                if targetPlayer then
                    local args = { targetPlayer }
                    ReplicatedStorage
                        :WaitForChild("Characters", 1)
                        :WaitForChild(targetChar, 1)
                        :WaitForChild("Remotes", 1)
                        :WaitForChild(remoteName, 1)
                        :FireServer(unpack(args))
                else
                    targetInfo.Text = "⚠️ 未找到目标玩家 hsuhsb213211"
                end
            else
                local args = { target }
                ReplicatedStorage
                    :WaitForChild("Characters", 1)
                    :WaitForChild(targetChar, 1)
                    :WaitForChild("Remotes", 1)
                    :WaitForChild(remoteName, 1)
                    :FireServer(unpack(args))
            end
        else
            local modeText = CONFIG.IsAllMode and "任何玩家" or "指定玩家"
            targetInfo.Text = "⏳ 未找到 " .. modeText
        end
    end)
end

-- ============================================================
--  循环控制
-- ============================================================
local function startLoop()
    if isRunning then return end
    isRunning = true
    
    executeHitSpin()
    
    if CONFIG.CurrentMode == 1 then
        loopConnection = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(CONFIG.AttackSpeed)
            if isRunning then
                executeHitSpin()
            end
        end)
        local modeName = modeNames[CONFIG.CurrentMode]
        print("🟢 DyK" .. modeName .. "循环已启动 (速度: " .. string.format("%.2f", CONFIG.AttackSpeed) .. "s)")
    else
        print("🌀 DyK吸人单次执行完成")
        isRunning = false
        triggerBtn.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
        triggerBtn.Text = "▶ 启动"
        statusLabel.Text = "● 已停止"
        statusLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
        modeBtnRef.Active = true
        rangeInput.Active = true
        speedInput.Active = true
        modeSwitchBtn.Active = true
        if not CONFIG.IsAllMode then
            selectPlayersBtnRef.Active = true
        end
        return
    end
    
    triggerBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
    triggerBtn.Text = "■ 停止"
    statusLabel.Text = "● 运行中..."
    statusLabel.TextColor3 = Color3.fromRGB(110, 231, 183)
    modeBtnRef.Active = false
    selectPlayersBtnRef.Active = false
    rangeInput.Active = false
    speedInput.Active = false
    modeSwitchBtn.Active = false
end

local function stopLoop()
    if not isRunning then return end
    isRunning = false
    
    if loopConnection then
        loopConnection:Disconnect()
        loopConnection = nil
    end
    
    triggerBtn.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
    triggerBtn.Text = "▶ 启动"
    statusLabel.Text = "● 已停止"
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
    modeBtnRef.Active = true
    rangeInput.Active = true
    speedInput.Active = true
    modeSwitchBtn.Active = true
    if not CONFIG.IsAllMode then
        selectPlayersBtnRef.Active = true
    end
    targetInfo.Text = "等待启动..."
    
    local modeName = modeNames[CONFIG.CurrentMode]
    print("🔴 DyK" .. modeName .. "已停止")
end

triggerBtn.MouseButton1Click:Connect(function()
    if isRunning then
        stopLoop()
    else
        startLoop()
    end
end)

-- ============================================================
--  关闭功能
-- ============================================================
closeBtn.MouseButton1Click:Connect(function()
    if isRunning then
        stopLoop()
    end
    screenGui:Destroy()
    print("❌ DyK已关闭")
end)

-- ============================================================
--  拖动功能 (修复版 - 支持PC和手机)
-- ============================================================
local dragData = {
    dragging = false,
    offset = Vector2.new(),
    startPos = Vector2.new()
}

local function onDragStart(input)
    if not input then return end
    
    local inputType = input.UserInputType
    if inputType ~= Enum.UserInputType.MouseButton1 and 
       inputType ~= Enum.UserInputType.Touch then 
        return 
    end
    
    -- 检查是否点击了可交互控件
    local target = inputType == Enum.UserInputType.MouseButton1 and player:GetMouse() and player:GetMouse().Target or nil
    if target then
        local name = target.Name
        if name == "CloseBtn" or name == "ToggleBtn" or name == "ModeBtn" or 
           name == "TriggerBtn" or name == "SelectPlayersBtn" or name == "RangeInput" or
           name == "SpeedInput" or name == "SelCloseBtn" or name == "ModeSwitchBtn" then
            return
        end
    end
    
    dragData.dragging = true
    dragData.offset = Vector2.new(
        input.Position.X - mainWindow.AbsolutePosition.X,
        input.Position.Y - mainWindow.AbsolutePosition.Y
    )
    dragData.startPos = Vector2.new(input.Position.X, input.Position.Y)
end

local function onDragMove(input)
    if not dragData.dragging then return end
    if not input or not input.Position then return end
    
    local viewportSize = game:GetService("GuiService"):GetViewportSize()
    local newX = input.Position.X - dragData.offset.X
    local newY = input.Position.Y - dragData.offset.Y
    
    newX = math.clamp(newX, 0, viewportSize.X - mainWindow.AbsoluteSize.X)
    newY = math.clamp(newY, 0, viewportSize.Y - mainWindow.AbsoluteSize.Y)
    
    mainWindow.Position = UDim2.new(0, newX, 0, newY)
end

local function onDragEnd()
    dragData.dragging = false
end

-- 绑定标题栏事件 (使用InputBegan/InputEnded)
titleBar.InputBegan:Connect(onDragStart)
titleBar.InputEnded:Connect(onDragEnd)

-- 全局移动监听
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        onDragMove(input)
    end
end)

-- 触摸移动专用
UserInputService.TouchMoved:Connect(function(input)
    onDragMove(input)
end)

-- ============================================================
--  初始化
-- ============================================================
print("⚔ DyK双模式已加载 (滚动+拖动已修复)")
print("📏 默认范围: 无限制")
print("⚡ 杀戮模式: 循环执行 | 吸人模式: 单次执行")
print("🔄 点击 '切换为: 吸人' 切换模式")
print("▶ 点击启动执行，再次点击停止")
print("▲ 点击标题栏箭头可展开/收回窗口")
