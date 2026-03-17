-- // RAINBOW ANIMATED ORION LIB SCRIPT
-- // VEX BLOX PREMIUM PANEL

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- ============================================
--         RAINBOW ANIMATION SETUP
-- ============================================
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Function to convert HSV hue to RGB Color3
local function hueToColor(hue)
    return Color3.fromHSV(hue, 1, 1)
end

-- ============================================
--           MAKE ORION WINDOW
-- ============================================
local Window = OrionLib:MakeWindow({
    Name = "😈 VEX BLOX PREMIUM PANEL 😈",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BETA TEST"
})

-- ============================================
--     RAINBOW ANIMATE THE ORION BACKGROUND
-- ============================================
task.spawn(function()
    -- Wait a moment for Orion UI to fully load
    task.wait(0.5)

    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Find the Orion ScreenGui
    local orionGui = nil
    for _, gui in pairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name ~= "RobloxGui" then
            -- Try to find the main background frame
            orionGui = gui
            break
        end
    end

    if not orionGui then
        warn("Orion GUI not found!")
        return
    end

    -- Find the main dark background frame (usually first Frame child)
    local mainFrame = orionGui:FindFirstChildWhichIsA("Frame", true)

    if not mainFrame then
        warn("Main frame not found!")
        return
    end

    -- Create a rainbow border/background Frame BEHIND everything
    local rainbowBG = Instance.new("Frame")
    rainbowBG.Size = UDim2.new(1, 6, 1, 6)
    rainbowBG.Position = UDim2.new(0, -3, 0, -3)
    rainbowBG.ZIndex = mainFrame.ZIndex - 1
    rainbowBG.BorderSizePixel = 0
    rainbowBG.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    rainbowBG.Parent = mainFrame

    -- Add rounded corners to rainbow border
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = rainbowBG

    -- Also create a glowing rainbow STROKE on the main frame
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 4
    stroke.Color = Color3.fromRGB(255, 0, 0)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = mainFrame

    -- Animate hue over time
    local hue = 0
    RunService.Heartbeat:Connect(function(dt)
        hue = (hue + dt * 0.3) % 1  -- Speed: 0.3 = full cycle every ~3.3 seconds
        local color = hueToColor(hue)

        rainbowBG.BackgroundColor3 = color
        stroke.Color = color
    end)
end)

-- ============================================
--           NOTIFICATION ON LOAD
-- ============================================
OrionLib:MakeNotification({
    Name = "🌈 CHUDMARANI",
    Content = "🎮 HACK HAS BEEN ACTIVATED - RAINBOW MODE ON!",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- ============================================
--               HACKING TAB
-- ============================================
local Tab = Window:MakeTab({
    Name = "💀 HACKING",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- ============================================
--         AREA NOTI REMOVE TOGGLE
-- ============================================
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local areaEnabled = false
local areaConnection

local function checkGui(gui)
    if areaEnabled and gui:IsA("TextLabel") and gui.Text and string.find(gui.Text, "Area") then
        gui:Destroy()
    end
end

local function startArea()
    areaEnabled = true
    for _, gui in pairs(playerGui:GetDescendants()) do
        checkGui(gui)
    end
    areaConnection = playerGui.DescendantAdded:Connect(checkGui)
end

local function stopArea()
    areaEnabled = false
    if areaConnection then
        areaConnection:Disconnect()
        areaConnection = nil
    end
end

Tab:AddToggle({
    Name = "🚫 Area Noti <REMOVE>",
    Default = false,
    Callback = function(Value)
        if Value then
            startArea()
        else
            stopArea()
        end
    end
})

-- ============================================
--       DISPLAY NOTI REMOVE TOGGLE
-- ============================================
local displayEnabled = false

local function removeWaveNoti()
    pcall(function()
        local notif = playerGui:FindFirstChild("NewNotifications", true)
        if notif and notif:FindFirstChild("Items") and notif.Items:FindFirstChild("Frame") then
            notif.Items.Frame:Destroy()
        end
    end)
end

Tab:AddToggle({
    Name = "🚫 Display Noti <REMOVE>",
    Default = false,
    Callback = function(Value)
        displayEnabled = Value
        if displayEnabled then
            removeWaveNoti()
        end
    end
})

-- ============================================
--              INIT ORION
-- ============================================
OrionLib:Init()
