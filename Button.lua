local Button = {}
Button.__index = Button

function Button.new(label, callback)
    local self = setmetatable({}, Button)
    self.label = label
    self.callback = callback
    return self
end

function Button:render(parent, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 150, 0, 30)
    button.Position = UDim2.new(0, position.X, 0, position.Y)
    button.Text = self.label
    button.Parent = parent
    button.MouseButton1Click:Connect(self.callback)
end

return Button