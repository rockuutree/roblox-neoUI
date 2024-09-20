local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(label, callback)
    local self = setmetatable({}, Toggle)
    self.label = label
    self.callback = callback
    self.state = false
    return self
end

function Toggle:render(parent, position)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 150, 0, 30)
    toggle.Position = UDim2.new(0, position.X, 0, position.Y)
    toggle.Text = self.label .. " [OFF]"
    toggle.Parent = parent
    toggle.MouseButton1Click:Connect(function()
        self.state = not self.state
        toggle.Text = self.label .. (self.state and " [ON]" or " [OFF]")
        self.callback(self.state)
    end)
end

return Toggle