local Slider = {}
Slider.__index = Slider

function Slider.new(label, min, max, default, callback)
    local self = setmetatable({}, Slider)
    self.label = label
    self.min = min
    self.max = max
    self.value = default
    self.callback = callback
    return self
end

function Slider:render(parent, position)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 150, 0, 50)
    frame.Position = UDim2.new(0, position.X, 0, position.Y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Text = self.label
    label.Parent = frame

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, 0, 0, 5)
    sliderBar.Position = UDim2.new(0, 0, 0, 25)
    sliderBar.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
    sliderBar.Parent = frame

    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 20, 0, 20)
    sliderButton.Position = UDim2.new((self.value - self.min) / (self.max - self.min), -10, 0, 17.5)
    sliderButton.Text = ""
    sliderButton.Parent = sliderBar

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(1, 0, 0, 20)
    valueLabel.Position = UDim2.new(0, 0, 0, 30)
    valueLabel.Text = tostring(self.value)
    valueLabel.Parent = frame

    local dragging = false
    sliderButton.MouseButton1Down:Connect(function() dragging = true end)
    sliderButton.MouseButton1Up:Connect(function() dragging = false end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            local relativeX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
            self.value = math.floor(self.min + (self.max - self.min) * relativeX)
            sliderButton.Position = UDim2.new(relativeX, -10, 0, 17.5)
            valueLabel.Text = tostring(self.value)
            self.callback(self.value)
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        if dragging then
            local mousePos = game:GetService("UserInputService"):GetMouseLocation()
            local relativeX = math.clamp((mousePos.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
            self.value = math.floor(self.min + (self.max - self.min) * relativeX)
            sliderButton.Position = UDim2.new(relativeX, -10, 0, 17.5)
            valueLabel.Text = tostring(self.value)
            self.callback(self.value)
        end
    end)
end

return Slider