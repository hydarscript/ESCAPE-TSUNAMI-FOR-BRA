local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "☠VEX BLOX PREMIUM PANEL☠",
    Icon = "monitor-cog", -- lucide icon
    Author = "by KIMITO",
    Folder = "MySuperHub",
    
    -- ↓ This all is Optional. You can remove it.
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
})   

Window:SetToggleKey(Enum.KeyCode.H)

local Tab = Window:Tab({
    Title = "HACKING",
    Icon = "skull", -- optional
    Locked = false,
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

local Toggle = Tab:Toggle({
    Title = "Area Noti Remove",
    Desc = "Removes area notification",
    Icon = "ban",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        if state then
            startArea()
        else
            stopArea()
        end
    end
})

-- ============================================
--         DISPLAY NOTI REMOVE TOGGLE
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

local Toggle = Tab:Toggle({
    Title = "Display Noti Remove",
    Desc = "Removes display notification",
    Icon = "ban",
    Type = "Checkbox",
    Value = false,
    Callback = function(state)
        displayEnabled = state
        if displayEnabled then
            removeWaveNoti()
        end
    end
})
