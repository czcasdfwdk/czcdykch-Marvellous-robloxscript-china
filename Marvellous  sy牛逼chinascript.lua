local _0x1A = game:GetService("Players")
local _0x2B = game:GetService("ReplicatedStorage")
local _0x3C = game:GetService("UserInputService")
local _0x4D = game:GetService("TweenService")
local _0x5E = _0x1A.LocalPlayer

local _0x6F = {
    TargetName = "MrFantastic",
    TargetName2 = "TheFlashCw",
    AttackRange = 99999,
    AttackSpeed = 0.3,
    SelectedPlayers = {},
    IsAllMode = true,
    CurrentMode = 1,
}

local _0x7G = Instance.new("ScreenGui")
_0x7G.Name = "DyKGUI"
_0x7G.Parent = _0x5E:WaitForChild("PlayerGui")
_0x7G.ResetOnSpawn = false

local _0x8H = Instance.new("Frame")
_0x8H.Name = "MainWindow"
_0x8H.Size = UDim2.new(0, 200, 0, 310)
_0x8H.Position = UDim2.new(0.42, -100, 0.50, -155)
_0x8H.BackgroundColor3 = Color3.fromRGB(18, 22, 40)
_0x8H.BackgroundTransparency = 0.1
_0x8H.BorderSizePixel = 0
_0x8H.ClipsDescendants = true
_0x8H.Parent = _0x7G

local _0x9I = Instance.new("UICorner")
_0x9I.CornerRadius = UDim.new(0, 12)
_0x9I.Parent = _0x8H

local _0xAJ = Instance.new("UIStroke")
_0xAJ.Color = Color3.fromRGB(255, 255, 255)
_0xAJ.Transparency = 0.9
_0xAJ.Thickness = 1
_0xAJ.Parent = _0x8H

local _0xBK = Instance.new("TextButton")
_0xBK.Name = "TitleBar"
_0xBK.Size = UDim2.new(1, 0, 0, 32)
_0xBK.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_0xBK.BackgroundTransparency = 0.96
_0xBK.BorderSizePixel = 0
_0xBK.AutoButtonColor = false
_0xBK.Text = ""
_0xBK.Parent = _0x8H

local _0xCL = Instance.new("UICorner")
_0xCL.CornerRadius = UDim.new(0, 12)
_0xCL.Parent = _0xBK

local _0xDM = Instance.new("TextLabel")
_0xDM.Size = UDim2.new(0, 130, 1, 0)
_0xDM.Position = UDim2.new(0, 10, 0, 0)
_0xDM.BackgroundTransparency = 1
_0xDM.Text = "⚔ DyK杀戮"
_0xDM.TextColor3 = Color3.fromRGB(230, 230, 230)
_0xDM.TextSize = 13
_0xDM.TextXAlignment = Enum.TextXAlignment.Left
_0xDM.Font = Enum.Font.GothamSemibold
_0xDM.Parent = _0xBK

local _0xEN = Instance.new("TextButton")
_0xEN.Name = "ToggleBtn"
_0xEN.Size = UDim2.new(0, 24, 0, 24)
_0xEN.Position = UDim2.new(1, -58, 0.5, -12)
_0xEN.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_0xEN.BackgroundTransparency = 0.9
_0xEN.BorderSizePixel = 0
_0xEN.Text = "▲"
_0xEN.TextColor3 = Color3.fromRGB(200, 200, 200)
_0xEN.TextSize = 12
_0xEN.Font = Enum.Font.Gotham
_0xEN.Parent = _0xBK

local _0xFO = Instance.new("UICorner")
_0xFO.CornerRadius = UDim.new(1, 0)
_0xFO.Parent = _0xEN

local _0xGP = Instance.new("TextButton")
_0xGP.Name = "CloseBtn"
_0xGP.Size = UDim2.new(0, 24, 0, 24)
_0xGP.Position = UDim2.new(1, -30, 0.5, -12)
_0xGP.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
_0xGP.BackgroundTransparency = 0.85
_0xGP.BorderSizePixel = 0
_0xGP.Text = "✕"
_0xGP.TextColor3 = Color3.fromRGB(255, 255, 255)
_0xGP.TextSize = 12
_0xGP.Font = Enum.Font.Gotham
_0xGP.Parent = _0xBK

local _0xHQ = Instance.new("UICorner")
_0xHQ.CornerRadius = UDim.new(1, 0)
_0xHQ.Parent = _0xGP

local _0xIR = Instance.new("Frame")
_0xIR.Name = "ContentContainer"
_0xIR.Size = UDim2.new(1, 0, 1, -32)
_0xIR.Position = UDim2.new(0, 0, 0, 32)
_0xIR.BackgroundTransparency = 1
_0xIR.ClipsDescendants = true
_0xIR.Parent = _0x8H

local _0xJS = Instance.new("Frame")
_0xJS.Name = "Content"
_0xJS.Size = UDim2.new(1, -12, 1, 0)
_0xJS.Position = UDim2.new(0, 6, 0, 0)
_0xJS.BackgroundTransparency = 1
_0xJS.Parent = _0xIR

local _0xKT = true

_0xEN.MouseButton1Click:Connect(function()
    _0xKT = not _0xKT
    local _0xLU = _0xKT and 310 or 44
    _0xEN.Text = _0xKT and "▲" or "▼"
    _0x4D:Create(_0x8H, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 200, 0, _0xLU)
    }):Play()
end)

local _0xMV = Instance.new("TextLabel")
_0xMV.Size = UDim2.new(1, 0, 0, 14)
_0xMV.Position = UDim2.new(0, 0, 0, 2)
_0xMV.BackgroundTransparency = 1
_0xMV.Text = "📏 范围:"
_0xMV.TextColor3 = Color3.fromRGB(200, 200, 210)
_0xMV.TextSize = 11
_0xMV.TextXAlignment = Enum.TextXAlignment.Left
_0xMV.Font = Enum.Font.Gotham
_0xMV.Parent = _0xJS

local _0xNW = Instance.new("TextBox")
_0xNW.Name = "RangeInput"
_0xNW.Size = UDim2.new(1, 0, 0, 22)
_0xNW.Position = UDim2.new(0, 0, 0, 18)
_0xNW.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_0xNW.BackgroundTransparency = 0.9
_0xNW.BorderSizePixel = 0
_0xNW.Text = "无限制"
_0xNW.TextColor3 = Color3.fromRGB(230, 230, 230)
_0xNW.TextSize = 12
_0xNW.Font = Enum.Font.Gotham
_0xNW.PlaceholderText = "数字 或 无限制"
_0xNW.Parent = _0xJS

local _0xOX = Instance.new("UICorner")
_0xOX.CornerRadius = UDim.new(0, 5)
_0xOX.Parent = _0xNW

_0xNW.FocusLost:Connect(function(_0xPY)
    if _0xPY then
        local _0xQZ = _0xNW.Text:gsub("^%s*(.-)%s*$", "%1")
        if _0xQZ == "" or _0xQZ:lower() == "无限制" then
            _0x6F.AttackRange = 99999
            _0xNW.Text = "无限制"
        else
            local _0xRA = tonumber(_0xQZ)
            if _0xRA and _0xRA > 0 then
                _0x6F.AttackRange = _0xRA
                _0xNW.Text = tostring(_0xRA)
            else
                _0xNW.Text = "无限制"
                _0x6F.AttackRange = 99999
            end
        end
    end
end)

local _0xSB = Instance.new("TextLabel")
_0xSB.Size = UDim2.new(1, 0, 0, 14)
_0xSB.Position = UDim2.new(0, 0, 0, 44)
_0xSB.BackgroundTransparency = 1
_0xSB.Text = "🔄 当前模式: 杀戮"
_0xSB.TextColor3 = Color3.fromRGB(200, 200, 210)
_0xSB.TextSize = 11
_0xSB.TextXAlignment = Enum.TextXAlignment.Left
_0xSB.Font = Enum.Font.Gotham
_0xSB.Parent = _0xJS

local _0xTC = Instance.new("TextButton")
_0xTC.Name = "ModeSwitchBtn"
_0xTC.Size = UDim2.new(1, 0, 0, 24)
_0xTC.Position = UDim2.new(0, 0, 0, 60)
_0xTC.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
_0xTC.BackgroundTransparency = 0.3
_0xTC.BorderSizePixel = 0
_0xTC.Text = "⚔ 切换为: 吸人"
_0xTC.TextColor3 = Color3.fromRGB(255, 255, 255)
_0xTC.TextSize = 12
_0xTC.Font = Enum.Font.GothamSemibold
_0xTC.Parent = _0xJS

local _0xUD = Instance.new("UICorner")
_0xUD.CornerRadius = UDim.new(0, 5)
_0xUD.Parent = _0xTC

local _0xVE = {"杀戮", "吸人"}
local _0XG = {"⚔", "🌀"}

_0xTC.MouseButton1Click:Connect(function()
    _0x6F.CurrentMode = _0x6F.CurrentMode == 1 and 2 or 1
    local _0YH = _0xVE[_0x6F.CurrentMode]
    local _0ZI = _0XG[_0x6F.CurrentMode]
    local _0AJ = _0x6F.CurrentMode == 1 and 2 or 1
    _0xSB.Text = "🔄 当前模式: " .. _0YH
    _0xTC.Text = _0ZI .. " 切换为: " .. _0xVE[_0AJ]
    _0xDM.Text = _0ZI .. " DyK" .. _0YH
    if _0x6F.CurrentMode == 2 then
        if not _0xNW.IsFocused then
            _0x6F.AttackSpeed = 1.00
            _0xNW.Text = "1.00"
            _0xMV.Text = "⚡ 速度: 1.00s"
            _0xMV.TextColor3 = Color3.fromRGB(200, 200, 210)
        end
    else
        if not _0xNW.IsFocused then
            _0x6F.AttackSpeed = 0.3
            _0xNW.Text = "0.30"
            _0xMV.Text = "⚡ 速度: 0.30s"
            _0xMV.TextColor3 = Color3.fromRGB(200, 200, 210)
        end
    end
    print("🔄 切换到 " .. _0YH .. " 模式")
    if _0xKT then
        stopLoop()
        task.wait(0.1)
        startLoop()
    end
end)

local _0xBK = Instance.new("TextLabel")
_0xBK.Size = UDim2.new(1, 0, 0, 14)
_0xBK.Position = UDim2.new(0, 0, 0, 88)
_0xBK.BackgroundTransparency = 1
_0xBK.Text = "⚡ 速度: 0.30s"
_0xBK.TextColor3 = Color3.fromRGB(200, 200, 210)
_0xBK.TextSize = 11
_0xBK.TextXAlignment = Enum.TextXAlignment.Left
_0xBK.Font = Enum.Font.Gotham
_0xBK.Parent = _0xJS

local _0xCL = Instance.new("TextBox")
_0xCL.Name = "SpeedInput"
_0xCL.Size = UDim2.new(1, 0, 0, 22)
_0xCL.Position = UDim2.new(0, 0, 0, 104)
_0xCL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_0xCL.BackgroundTransparency = 0.9
_0xCL.BorderSizePixel = 0
_0xCL.Text = "0.30"
_0xCL.TextColor3 = Color3.fromRGB(230, 230, 230)
_0xCL.TextSize = 12
_0xCL.Font = Enum.Font.Gotham
_0xCL.PlaceholderText = "秒 (0.01-150)"
_0xCL.Parent = _0xJS

local _0xDM = Instance.new("UICorner")
_0xDM.CornerRadius = UDim.new(0, 5)
_0xDM.Parent = _0xCL

_0xCL.FocusLost:Connect(function(_0xEN)
    if _0xEN then
        local _0xFO = _0xCL.Text:gsub("^%s*(.-)%s*$", "%1")
        local _0xGP = tonumber(_0xFO)
        if _0xGP and _0xGP >= 0.01 and _0xGP <= 150 then
            _0x6F.AttackSpeed = _0xGP
            _0xCL.Text = string.format("%.2f", _0xGP)
            _0xBK.Text = "⚡ 速度: " .. string.format("%.2f", _0xGP) .. "s"
            _0xBK.TextColor3 = Color3.fromRGB(200, 200, 210)
            if _0xKT then
                stopLoop()
                task.wait(0.1)
                startLoop()
            end
        else
            _0xCL.Text = string.format("%.2f", _0x6F.AttackSpeed)
        end
    end
end)

local _0xHQ = Instance.new("Frame")
_0xHQ.Name = "MergeRow"
_0xHQ.Size = UDim2.new(1, 0, 0, 26)
_0xHQ.Position = UDim2.new(0, 0, 0, 130)
_0xHQ.BackgroundTransparency = 1
_0xHQ.Parent = _0xJS

local _0xIR = Instance.new("TextButton")
_0xIR.Name = "SelectPlayersBtn"
_0xIR.Size = UDim2.new(0.6, -4, 1, 0)
_0xIR.Position = UDim2.new(0, 0, 0, 0)
_0xIR.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_0xIR.BackgroundTransparency = 0.9
_0xIR.BorderSizePixel = 0
_0xIR.Text = "👥 目标玩家 (0)"
_0xIR.TextColor3 = Color3.fromRGB(200, 200, 200)
_0xIR.TextSize = 11
_0xIR.Font = Enum.Font.Gotham
_0xIR.TextXAlignment = Enum.TextXAlignment.Left
_0xIR.TextTruncate = Enum.TextTruncate.AtEnd
_0xIR.Parent = _0xHQ

local _0xJS = Instance.new("UICorner")
_0xJS.CornerRadius = UDim.new(0, 5)
_0xJS.Parent = _0xIR

local _0xKT = Instance.new("TextButton")
_0xKT.Name = "ModeBtn"
_0xKT.Size = UDim2.new(0.35, -4, 1, 0)
_0xKT.Position = UDim2.new(0.65, 0, 0, 0)
_0xKT.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
_0xKT.BackgroundTransparency = 0.3
_0xKT.BorderSizePixel = 0
_0xKT.Text = "🌍 所有"
_0xKT.TextColor3 = Color3.fromRGB(255, 255, 255)
_0xKT.TextSize = 11
_0xKT.Font = Enum.Font.GothamSemibold
_0xKT.Parent = _0xHQ

local _0xLU = Instance.new("UICorner")
_0xLU.CornerRadius = UDim.new(0, 5)
_0xLU.Parent = _0xKT

local _0xMV = _0xIR
local _0xNW = _0xKT

local _0xOX = Instance.new("TextLabel")
_0xOX.Size = UDim2.new(1, 0, 0, 16)
_0xOX.Position = UDim2.new(0, 0, 0, 160)
_0xOX.BackgroundTransparency = 1
_0xOX.Text = "● 已停止"
_0xOX.TextColor3 = Color3.fromRGB(150, 150, 170)
_0xOX.TextSize = 11
_0xOX.Font = Enum.Font.Gotham
_0xOX.Parent = _0xJS

local _0xPY = Instance.new("TextLabel")
_0xPY.Size = UDim2.new(1, 0, 0, 14)
_0xPY.Position = UDim2.new(0, 0, 0, 178)
_0xPY.BackgroundTransparency = 1
_0xPY.Text = "等待启动..."
_0xPY.TextColor3 = Color3.fromRGB(140, 140, 160)
_0xPY.TextSize = 10
_0xPY.Font = Enum.Font.Gotham
_0xPY.Parent = _0xJS

local _0xQZ = Instance.new("TextButton")
_0xQZ.Size = UDim2.new(1, 0, 0, 30)
_0xQZ.Position = UDim2.new(0, 0, 0, 198)
_0xQZ.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
_0xQZ.BorderSizePixel = 0
_0xQZ.Text = "▶ 启动"
_0xQZ.TextColor3 = Color3.fromRGB(255, 255, 255)
_0xQZ.TextSize = 13
_0xQZ.Font = Enum.Font.GothamSemibold
_0xQZ.Parent = _0xJS

local _0xRA = Instance.new("UICorner")
_0xRA.CornerRadius = UDim.new(0, 6)
_0xRA.Parent = _0xQZ

local _0xSB = Instance.new("ScreenGui")
_0xSB.Name = "PlayerSelectionGUI"
_0xSB.Parent = _0x7G
_0xSB.Enabled = false

local _0xTC = Instance.new("Frame")
_0xTC.Size = UDim2.new(0, 180, 0, 230)
_0xTC.Position = UDim2.new(0.5, -90, 0.5, -115)
_0xTC.BackgroundColor3 = Color3.fromRGB(22, 26, 48)
_0xTC.BackgroundTransparency = 0.05
_0xTC.BorderSizePixel = 0
_0xTC.ClipsDescendants = true
_0xTC.Parent = _0xSB

local _0xUD = Instance.new("UICorner")
_0xUD.CornerRadius = UDim.new(0, 12)
_0xUD.Parent = _0xTC

local _0xVE = Instance.new("UIStroke")
_0xVE.Color = Color3.fromRGB(255, 255, 255)
_0xVE.Transparency = 0.9
_0xVE.Thickness = 1
_0xVE.Parent = _0xTC

local _0XG = Instance.new("TextLabel")
_0XG.Size = UDim2.new(1, 0, 0, 28)
_0XG.Position = UDim2.new(0, 0, 0, 0)
_0XG.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
_0XG.BackgroundTransparency = 0.3
_0XG.Text = "选择目标玩家"
_0XG.TextColor3 = Color3.fromRGB(255, 255, 255)
_0XG.TextSize = 13
_0XG.Font = Enum.Font.GothamSemibold
_0XG.Parent = _0xTC

local _0YH = Instance.new("UICorner")
_0YH.CornerRadius = UDim.new(0, 12)
_0YH.Parent = _0XG

local _0ZI = Instance.new("TextButton")
_0ZI.Name = "SelCloseBtn"
_0ZI.Size = UDim2.new(0, 24, 0, 24)
_0ZI.Position = UDim2.new(1, -32, 0, 2)
_0ZI.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
_0ZI.BackgroundTransparency = 0.85
_0ZI.BorderSizePixel = 0
_0ZI.Text = "✕"
_0ZI.TextColor3 = Color3.fromRGB(255, 255, 255)
_0ZI.TextSize = 12
_0ZI.Font = Enum.Font.Gotham
_0ZI.Parent = _0xTC

local _0AJ = Instance.new("UICorner")
_0AJ.CornerRadius = UDim.new(1, 0)
_0AJ.Parent = _0ZI

local _0BK = Instance.new("ScrollingFrame")
_0BK.Name = "ListContainer"
_0BK.Size = UDim2.new(1, -10, 1, -44)
_0BK.Position = UDim2.new(0, 5, 0, 34)
_0BK.BackgroundTransparency = 1
_0BK.BorderSizePixel = 0
_0BK.ClipsDescendants = true
_0BK.ScrollBarThickness = 4
_0BK.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 130)
_0BK.Parent = _0xTC

local _0xCL = Instance.new("UIListLayout")
_0xCL.SortOrder = Enum.SortOrder.Name
_0xCL.Padding = UDim.new(0, 2)
_0xCL.Parent = _0xBK

_0xCL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    _0xBK.CanvasSize = UDim2.new(0, 0, 0, _0xCL.AbsoluteContentSize.Y + 4)
end)

local _0xDM = {}

local function _0xEN()
    for _0xFO, _0xGP in ipairs(_0xBK:GetChildren()) do
        if _0xGP:IsA("TextButton") then
            _0xGP:Destroy()
        end
    end
    
    local _0xHQ = {}
    for _0xIR, _0xJS in pairs(_0x1A:GetPlayers()) do
        if _0xJS ~= _0x5E then
            table.insert(_0xHQ, _0xJS.Name)
        end
    end
    
    if #_0xHQ == 0 then
        local _0xKT = Instance.new("TextLabel")
        _0xKT.Size = UDim2.new(1, 0, 0, 30)
        _0xKT.BackgroundTransparency = 1
        _0xKT.Text = "没有在线玩家"
        _0xKT.TextColor3 = Color3.fromRGB(150, 150, 170)
        _0xKT.TextSize = 12
        _0xKT.Parent = _0xBK
        _0xBK.CanvasSize = UDim2.new(0, 0, 0, 34)
        return
    end
    
    for _0xLU, _0xMV in ipairs(_0xHQ) do
        local _0xNW = Instance.new("TextButton")
        _0xNW.Name = _0xMV
        _0xNW.Size = UDim2.new(1, 0, 0, 24)
        _0xNW.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        _0xNW.BackgroundTransparency = 0.9
        _0xNW.BorderSizePixel = 0
        _0xNW.Text = "☐ " .. _0xMV
        _0xNW.TextColor3 = Color3.fromRGB(200, 200, 210)
        _0xNW.TextSize = 11
        _0xNW.TextXAlignment = Enum.TextXAlignment.Left
        _0xNW.Font = Enum.Font.Gotham
        _0xNW.Parent = _0xBK
        
        local _0xOX = Instance.new("UICorner")
        _0xOX.CornerRadius = UDim.new(0, 4)
        _0xOX.Parent = _0xNW
        
        if _0xDM[_0xMV] then
            _0xNW.Text = "☑ " .. _0xMV
            _0xNW.TextColor3 = Color3.fromRGB(110, 231, 183)
            _0xNW.BackgroundColor3 = Color3.fromRGB(110, 231, 183)
            _0xNW.BackgroundTransparency = 0.7
        end
        
        _0xNW.MouseButton1Click:Connect(function()
            if _0xDM[_0xMV] then
                _0xDM[_0xMV] = nil
                _0xNW.Text = "☐ " .. _0xMV
                _0xNW.TextColor3 = Color3.fromRGB(200, 200, 210)
                _0xNW.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                _0xNW.BackgroundTransparency = 0.9
            else
                _0xDM[_0xMV] = true
                _0xNW.Text = "☑ " .. _0xMV
                _0xNW.TextColor3 = Color3.fromRGB(110, 231, 183)
                _0xNW.BackgroundColor3 = Color3.fromRGB(110, 231, 183)
                _0xNW.BackgroundTransparency = 0.7
            end
        end)
    end
    
    task.wait(0.05)
    _0xBK.CanvasSize = UDim2.new(0, 0, 0, _0xCL.AbsoluteContentSize.Y + 4)
end

local function _0xPY()
    _0x6F.SelectedPlayers = {}
    for _0xQZ, _0xRA in pairs(_0xDM) do
        table.insert(_0x6F.SelectedPlayers, _0xRA)
    end
    local _0xSB = #_0x6F.SelectedPlayers
    _0xMV.Text = "👥 目标玩家 (" .. _0xSB .. ")"
    _0xSB.Enabled = false
    print("📋 已选择 " .. _0xSB .. " 个玩家: " .. table.concat(_0x6F.SelectedPlayers, ", "))
end

_0xZI.MouseButton1Click:Connect(function()
    _0xPY()
end)

local function _0xTC()
    _0xDM = {}
    for _0xUD, _0xVE in pairs(_0x6F.SelectedPlayers) do
        _0xDM[_0xVE] = true
    end
    _0xEN()
    _0xSB.Enabled = true
end

_0xMV.MouseButton1Click:Connect(function()
    if not _0x6F.IsAllMode then
        _0xTC()
    else
        print("⚠️ 请先切换到 '指定玩家' 模式")
    end
end)

_0xNW.MouseButton1Click:Connect(function()
    _0x6F.IsAllMode = not _0x6F.IsAllMode
    if _0x6F.IsAllMode then
        _0xNW.Text = "🌍 所有"
        _0xNW.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
        _0xNW.BackgroundTransparency = 0.3
        _0xMV.TextTransparency = 0.5
        _0xMV.Active = false
        _0xDM = {}
        print("🌍 切换为: 检测所有玩家")
    else
        _0xNW.Text = "🎯 指定"
        _0xNW.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
        _0xNW.BackgroundTransparency = 0.3
        _0xMV.TextTransparency = 0
        _0xMV.Active = true
        if #_0x6F.SelectedPlayers > 0 then
            _0xDM = {}
            for _0XG, _0YH in pairs(_0x6F.SelectedPlayers) do
                _0xDM[_0YH] = true
            end
            _0xMV.Text = "👥 目标玩家 (" .. #_0x6F.SelectedPlayers .. ")"
        else
            _0xMV.Text = "👥 目标玩家 (0)"
        end
        print("🎯 切换为: 检测指定玩家")
    end
end)

_0xMV.TextTransparency = 0.5
_0xMV.Active = false

local _0XG = false
local _0YH = nil

local function _0ZI()
    local _0AJ = _0x5E.Character
    if not _0AJ then return nil end
    
    local _0BK = _0AJ:FindFirstChild("HumanoidRootPart")
    if not _0BK then return nil end
    
    local _0xCL = nil
    local _0xDM = math.huge
    local _0xEN = _0x6F.AttackRange
    
    local _0xFO = {}
    if _0x6F.IsAllMode then
        for _0xGP, _0xHQ in pairs(_0x1A:GetPlayers()) do
            if _0xHQ ~= _0x5E then
                _0xFO[_0xHQ.Name] = true
            end
        end
    else
        for _0xIR, _0xJS in pairs(_0x6F.SelectedPlayers) do
            _0xFO[_0xJS] = true
        end
    end
    
    for _0xKT, _0xLU in pairs(_0x1A:GetPlayers()) do
        if _0xLU ~= _0x5E and _0xFO[_0xLU.Name] then
            local _0xMV = _0xLU.Character
            if _0xMV then
                local _0xNW = _0xMV:FindFirstChild("Humanoid")
                if _0xNW and _0xNW.Health > 0 then
                    local _0xOX = _0xMV:FindFirstChild("HumanoidRootPart")
                    if _0xOX then
                        local _0xPY = (_0xBK.Position - _0xOX.Position).Magnitude
                        if _0xPY <= _0xEN and _0xPY < _0xDM then
                            _0xDM = _0xPY
                            _0xCL = _0xMV
                        end
                    end
                end
            end
        end
    end
    return _0xCL
end

local function _0xQZ()
    pcall(function()
        local _0xRA = _0xZI()
        
        if _0xRA then
            local _0xSB = _0xRA.Parent and _0xRA.Parent.Name or "未知"
            local _0xTC = _0xRA:FindFirstChild("Humanoid")
            local _0xUD = _0xTC and math.floor(_0xTC.Health) or 0
            
            local _0xVE = "∞"
            local _0XG = _0x5E.Character and _0x5E.Character:FindFirstChild("HumanoidRootPart")
            if _0XG and _0xRA:FindFirstChild("HumanoidRootPart") then
                _0xVE = string.format("%.1f", (_0XG.Position - _0xRA.HumanoidRootPart.Position).Magnitude)
            end
            
            _0xPY.Text = "🎯 " .. _0xSB .. " HP:" .. _0xUD .. " 📊" .. _0xVE .. "格"
            
            local _0YH = _0x6F.CurrentMode == 1 and "MrFantastic" or "TheFlashCw"
            local _0ZI = _0x6F.CurrentMode == 1 and "HitSpin" or "Mirrage"
            
            if _0x6F.CurrentMode == 2 then
                local _0AJ = _0x1A:FindFirstChild("hsuhsb213211")
                if _0AJ then
                    local _0BK = { _0AJ }
                    _0x2B
                        :WaitForChild("Characters", 1)
                        :WaitForChild(_0YH, 1)
                        :WaitForChild("Remotes", 1)
                        :WaitForChild(_0ZI, 1)
                        :FireServer(unpack(_0BK))
                else
                    _0xPY.Text = "⚠️ 未找到目标玩家 hsuhsb213211"
                end
            else
                local _0xCL = { _0xRA }
                _0x2B
                    :WaitForChild("Characters", 1)
                    :WaitForChild(_0YH, 1)
                    :WaitForChild("Remotes", 1)
                    :WaitForChild(_0ZI, 1)
                    :FireServer(unpack(_0xCL))
            end
        else
            local _0xDM = _0x6F.IsAllMode and "任何玩家" or "指定玩家"
            _0xPY.Text = "⏳ 未找到 " .. _0xDM
        end
    end)
end

local function _0xEN()
    if _0XG then return end
    _0XG = true
    
    _0xQZ()
    
    if _0x6F.CurrentMode == 1 then
        _0YH = game:GetService("RunService").Heartbeat:Connect(function()
            task.wait(_0x6F.AttackSpeed)
            if _0XG then
                _0xQZ()
            end
        end)
        local _0xFO = _0xVE[_0x6F.CurrentMode]
        print("🟢 DyK" .. _0xFO .. "循环已启动 (速度: " .. string.format("%.2f", _0x6F.AttackSpeed) .. "s)")
    else
        print("🌀 DyK吸人单次执行完成")
        _0XG = false
        _0xQZ.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
        _0xQZ.Text = "▶ 启动"
        _0xOX.Text = "● 已停止"
        _0xOX.TextColor3 = Color3.fromRGB(150, 150, 170)
        _0xNW.Active = true
        _0xNW.Active = true
        _0xCL.Active = true
        _0xTC.Active = true
        if not _0x6F.IsAllMode then
            _0xMV.Active = true
        end
        return
    end
    
    _0xQZ.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
    _0xQZ.Text = "■ 停止"
    _0xOX.Text = "● 运行中..."
    _0xOX.TextColor3 = Color3.fromRGB(110, 231, 183)
    _0xNW.Active = false
    _0xMV.Active = false
    _0xNW.Active = false
    _0xCL.Active = false
    _0xTC.Active = false
end

local function _0xGP()
    if not _0XG then return end
    _0XG = false
    
    if _0YH then
        _0YH:Disconnect()
        _0YH = nil
    end
    
    _0xQZ.BackgroundColor3 = Color3.fromRGB(124, 58, 237)
    _0xQZ.Text = "▶ 启动"
    _0xOX.Text = "● 已停止"
    _0xOX.TextColor3 = Color3.fromRGB(150, 150, 170)
    _0xNW.Active = true
    _0xNW.Active = true
    _0xCL.Active = true
    _0xTC.Active = true
    if not _0x6F.IsAllMode then
        _0xMV.Active = true
    end
    _0xPY.Text = "等待启动..."
    
    local _0xHQ = _0xVE[_0x6F.CurrentMode]
    print("🔴 DyK" .. _0xHQ .. "已停止")
end

_0xQZ.MouseButton1Click:Connect(function()
    if _0XG then
        _0xGP()
    else
        _0xEN()
    end
end)

_0xGP.MouseButton1Click:Connect(function()
    if _0XG then
        _0xGP()
    end
    _0x7G:Destroy()
    print("❌ DyK已关闭")
end)

local _0xIR = {
    dragging = false,
    offset = Vector2.new(),
    startPos = Vector2.new()
}

local function _0xJS(_0xKT)
    if not _0xKT then return end
    
    local _0xLU = _0xKT.UserInputType
    if _0xLU ~= Enum.UserInputType.MouseButton1 and 
       _0xLU ~= Enum.UserInputType.Touch then 
        return 
    end
    
    local _0xMV = _0xLU == Enum.UserInputType.MouseButton1 and _0x5E:GetMouse() and _0x5E:GetMouse().Target or nil
    if _0xMV then
        local _0xNW = _0xMV.Name
        if _0xNW == "CloseBtn" or _0xNW == "ToggleBtn" or _0xNW == "ModeBtn" or 
           _0xNW == "TriggerBtn" or _0xNW == "SelectPlayersBtn" or _0xNW == "RangeInput" or
           _0xNW == "SpeedInput" or _0xNW == "SelCloseBtn" or _0xNW == "ModeSwitchBtn" then
            return
        end
    end
    
    _0xIR.dragging = true
    _0xIR.offset = Vector2.new(
        _0xKT.Position.X - _0x8H.AbsolutePosition.X,
        _0xKT.Position.Y - _0x8H.AbsolutePosition.Y
    )
    _0xIR.startPos = Vector2.new(_0xKT.Position.X, _0xKT.Position.Y)
end

local function _0xOX(_0xPY)
    if not _0xIR.dragging then return end
    if not _0xPY or not _0xPY.Position then return end
    
    local _0xQZ = game:GetService("GuiService"):GetViewportSize()
    local _0xRA = _0xPY.Position.X - _0xIR.offset.X
    local _0xSB = _0xPY.Position.Y - _0xIR.offset.Y
    
    _0xRA = math.clamp(_0xRA, 0, _0xQZ.X - _0x8H.AbsoluteSize.X)
    _0xSB = math.clamp(_0xSB, 0, _0xQZ.Y - _0x8H.AbsoluteSize.Y)
    
    _0x8H.Position = UDim2.new(0, _0xRA, 0, _0xSB)
end

local function _0xTC()
    _0xIR.dragging = false
end

_0xBK.InputBegan:Connect(_0xJS)
_0xBK.InputEnded:Connect(_0xTC)

_0x3C.InputChanged:Connect(function(_0xUD)
    if _0xUD.UserInputType == Enum.UserInputType.MouseMovement then
        _0xOX(_0xUD)
    end
end)

_0x3C.TouchMoved:Connect(function(_0xVE)
    _0xOX(_0xVE)
end)

synbPython
