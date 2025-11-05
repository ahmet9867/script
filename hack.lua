-- Empty Animated Hub (Safe)
-- Place this LocalScript inside StarterGui > ScreenGui or directly inside StarterPlayerScripts.
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Config
local TOGGLE_KEY = Enum.KeyCode.H
local TWEEN_INFO = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local HUB_W = 420
local HUB_H = 300

-- Create ScreenGui if script placed under StarterPlayerScripts
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EmptyHubGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Overlay
local overlay = Instance.new("Frame")
overlay.Name = "Overlay"
overlay.Size = UDim2.new(1,0,1,0)
overlay.Position = UDim2.new(0,0,0,0)
overlay.BackgroundColor3 = Color3.new(0,0,0)
overlay.BackgroundTransparency = 1
overlay.ZIndex = 1
overlay.Parent = screenGui

-- Hub frame (starts closed)
local hub = Instance.new("Frame")
hub.Name = "Hub"
hub.Size = UDim2.new(0,0,0,0)
hub.AnchorPoint = Vector2.new(0.5,0.5)
hub.Position = UDim2.new(0.5,0.5,0.5,0)
hub.BackgroundColor3 = Color3.fromRGB(28,28,28)
hub.BorderSizePixel = 0
hub.ZIndex = 2
hub.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,10)
corner.Parent = hub

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -24, 0, 36)
title.Position = UDim2.new(0,12,0,8)
title.BackgroundTransparency = 1
title.Text = "Empty Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(240,240,240)
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 3
title.Parent = hub

-- Close button (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0,36,0,28)
closeBtn.Position = UDim2.new(1, -44, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.Gotham
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextSize = 18
closeBtn.ZIndex = 4
closeBtn.Parent = hub
local closeCorner = Instance.new("UICorner"); closeCorner.CornerRadius = UDim.new(0,6); closeCorner.Parent = closeBtn

-- Content area (empty)
local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.new(0,12,0,52)
content.Size = UDim2.new(1, -24, 1, -64)
content.BackgroundTransparency = 1
content.ZIndex = 3
content.Parent = hub

-- Toggle button (on-screen)
local toggle = Instance.new("TextButton")
toggle.Name = "ToggleHub"
toggle.Size = UDim2.new(0,140,0,36)
toggle.Position = UDim2.new(0.02, 0, 0.88, 0)
toggle.BackgroundColor3 = Color3.fromRGB(64,64,64)
toggle.Text = "Open Hub (H)"
toggle.Font = Enum.Font.Gotham
toggle.TextSize = 16
toggle.TextColor3 = Color3.new(1,1,1)
toggle.ZIndex = 5
toggle.Parent = screenGui
local togCorner = Instance.new("UICorner"); togCorner.CornerRadius = UDim.new(0,8); togCorner.Parent = toggle

-- State
local isOpen = false
local openSize = UDim2.new(0, HUB_W, 0, HUB_H)
local closedSize = UDim2.new(0,0,0,0)
local overlayOpenTransparency = 0.55
local overlayClosedTransparency = 1

local function setOpen(state)
    if state == isOpen then return end
    isOpen = state
    if isOpen then
        TweenService:Create(overlay, TWEEN_INFO, {BackgroundTransparency = 1 - overlayOpenTransparency}):Play()
        TweenService:Create(hub, TWEEN_INFO, {Size = openSize}):Play()
        toggle.Text = "Close Hub (H)"
    else
        TweenService:Create(overlay, TWEEN_INFO, {BackgroundTransparency = overlayClosedTransparency}):Play()
        TweenService:Create(hub, TWEEN_INFO, {Size = closedSize}):Play()
        toggle.Text = "Open Hub (H)"
    end
end

toggle.Activated:Connect(function() setOpen(not isOpen) end)
closeBtn.Activated:Connect(function() setOpen(false) end)
overlay.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and isOpen then
        setOpen(false)
    end
end)

-- Keybind (H)
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == TOGGLE_KEY then
        setOpen(not isOpen)
    end
end)

-- Initialize closed
hub.Size = closedSize
overlay.BackgroundTransparency = overlayClosedTransparency
