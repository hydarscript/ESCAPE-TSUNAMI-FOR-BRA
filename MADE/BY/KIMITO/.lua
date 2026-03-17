local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- ============================================
--           MAKE ORION WINDOW
-- ============================================
local Window = OrionLib:MakeWindow({
    Name = "😈 VEX BLOX PREMIUM PANEL 😈",
    HidePremium = false,
    SaveConfig = false,
    ConfigFolder = "BETA TEST"
})
-- ============================================
--           NOTIFICATION ON LOAD
-- ============================================
OrionLib:MakeNotification({
    Name = "🌈 CHUDMARANI",
    Content = "🎮 HACK HAS BEEN ACTIVATED",
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

