-- DataManager.server.lua

local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("PlayerData")

local function savePlayerData(player)
    local data = {
        stars = player.leaderstats.Stars.Value,
        trophies = player.leaderstats.Trophies.Value
    }
    
    local success, errorMessage = pcall(function()
        playerDataStore:SetAsync(player.UserId, data)
    end)
    
    if not success then
        warn("Failed to save data for " .. player.Name .. ": " .. errorMessage)
    end
end

local function loadPlayerData(player)
    local success, data = pcall(function()
        return playerDataStore:GetAsync(player.UserId)
    end)
    
    if success and data then
        player.leaderstats.Stars.Value = data.stars or 7000
        player.leaderstats.Trophies.Value = data.trophies or 800
    else
        player.leaderstats.Stars.Value = 7000
        player.leaderstats.Trophies.Value = 800
        warn("Failed to load data for " .. player.Name .. ": " .. (data or "No data"))
    end
end

game.Players.PlayerAdded:Connect(function(player)
    -- Create leaderstats if they don't exist
    if not player:FindFirstChild("leaderstats") then
        local leaderstats = Instance.new("Folder")
        leaderstats.Name = "leaderstats"
        leaderstats.Parent = player
        
        local stars = Instance.new("IntValue")
        stars.Name = "Stars"
        stars.Value = 0
        stars.Parent = leaderstats
        
        local trophies = Instance.new("IntValue")
        trophies.Name = "Trophies"
        trophies.Value = 0
        trophies.Parent = leaderstats
    end
    
    -- Load player data
    loadPlayerData(player)
    
    -- Save player data when they leave
    player.AncestryChanged:Connect(function(_, parent)
        if parent == nil then
            savePlayerData(player)
        end
    end)
end)
