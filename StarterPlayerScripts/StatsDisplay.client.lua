-- StatsDisplay.client.lua

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function updateStatsDisplay()
    local leaderstats = player:WaitForChild("leaderstats")
    local stars = leaderstats:WaitForChild("Stars")
    local trophies = leaderstats:WaitForChild("Trophies")
    
    -- Create a GUI to display the stats
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "StatsDisplay"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 100)
    frame.Position = UDim2.new(0.5, -100, 0, 20)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.Parent = screenGui
    
    local starsLabel = Instance.new("TextLabel")
    starsLabel.Size = UDim2.new(1, 0, 0, 30)
    starsLabel.Position = UDim2.new(0, 0, 0, 0)
    starsLabel.Text = "Stars: " .. stars.Value
    starsLabel.TextColor3 = Color3.new(1, 1, 1)
    starsLabel.BackgroundTransparency = 1
    starsLabel.Parent = frame
    
    local trophiesLabel = Instance.new("TextLabel")
    trophiesLabel.Size = UDim2.new(1, 0, 0, 30)
    trophiesLabel.Position = UDim2.new(0, 0, 0, 30)
    trophiesLabel.Text = "Trophies: " .. trophies.Value
    trophiesLabel.TextColor3 = Color3.new(1, 1, 1)
    trophiesLabel.BackgroundTransparency = 1
    trophiesLabel.Parent = frame
    
    -- Update the stats display when they change
    stars.Changed:Connect(function()
        starsLabel.Text = "Stars: " .. stars.Value
    end)
    
    trophies.Changed:Connect(function()
        trophiesLabel.Text = "Trophies: " .. trophies.Value
    end)
end

-- Wait for the player to be fully loaded
player.CharacterAdded:Connect(function()
    updateStatsDisplay()
end)
