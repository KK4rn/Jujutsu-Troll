-- Simple test - does this print?
print("Script starting...")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("Player found:", player.Name)

-- Try creating basic UI
local success, err = pcall(function()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TestUI"
    
    -- Try different parent methods for compatibility
    if syn then
        screenGui.Parent = game.CoreGui
        print("Using Synapse method")
    elseif gethui then
        screenGui.Parent = gethui()
        print("Using gethui method")
    else
        screenGui.Parent = player:WaitForChild("PlayerGui")
        print("Using PlayerGui method")
    end
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 100)
    frame.Position = UDim2.new(0.5, -100, 0.5, -50)
    frame.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
    frame.Parent = screenGui
    
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = "Script Loaded!\nPress T for emotes"
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.Font = Enum.Font.GothamBold
    text.TextSize = 16
    text.Parent = frame
    
    print("UI Created Successfully")
    
    -- Simple emote spam
    local UserInputService = game:GetService("UserInputService")
    local spamming = false
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.T then
            spamming = not spamming
            text.Text = spamming and "Emote Spam: ON" or "Emote Spam: OFF"
            
            if spamming then
                spawn(function()
                    while spamming do
                        game:GetService("ReplicatedStorage").EmoteEvent:FireServer("Emote1")
                        wait(0.5)
                    end
                end)
            end
        end
    end)
end)

if not success then
    warn("ERROR:", err)
elseA
    print("All systems go!")
end
