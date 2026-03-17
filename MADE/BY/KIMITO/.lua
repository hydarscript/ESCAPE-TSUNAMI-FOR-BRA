local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "KIMITO HACKER", HidePremium = false, SaveConfig = true, ConfigFolder = "BETA TEST"})

local Tab = Window:MakeTab({
	Name = "HACKING",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

OrionLib:MakeNotification({
	Name = "CHUDMARANI",
	Content = "HACK HAS BEEN ACTIVATED",
	Image = "rbxassetid://4483345998",
	Time = 5
})


local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local enabled = false
local connection

local function checkGui(gui)
    if enabled and gui:IsA("TextLabel") and gui.Text and string.find(gui.Text, "Area") then
        gui:Destroy()
    end
end

local function start()
    enabled = true

    -- check existing
    for _, gui in pairs(playerGui:GetDescendants()) do
        checkGui(gui)
    end

    -- listen for new
    connection = playerGui.DescendantAdded:Connect(checkGui)
end

local function stop()
    enabled = false

    if connection then
        connection:Disconnect()
        connection = nil
    end
end

--// TOGGLE
Tab:AddToggle({
	Name = "Area Noti <REMOVE>",
	Default = false,
	Callback = function(Value)
        if Value then
            start()
        else
            stop()
        end
	end    
})

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local enabled = false

local function removeWaveNoti()
    pcall(function()
        local notif = playerGui:FindFirstChild("NewNotifications", true)
        if notif and notif:FindFirstChild("Items") and notif.Items:FindFirstChild("Frame") then
            notif.Items.Frame:Destroy()
        end
    end)
end

-- Togglew
Tab:AddToggle({
	Name = "Display Noti <REMOVE>",
	Default = false,
	Callback = function(Value)
        enabled = Value
        
        if enabled then
            removeWaveNoti()
        end
	end    
})

