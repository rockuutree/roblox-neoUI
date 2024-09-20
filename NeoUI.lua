local NeoUI = {}
NeoUI.__index = NeoUI

local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

function NeoUI.new(title)
    local self = setmetatable({}, NeoUI)
    self.title = title
    self.categories = {}
    self.activeCategory = nil
    self.theme = "light"
    self:createMainFrame()
    return self
end

function NeoUI:createMainFrame()
    self.mainFrame = Instance.new("ScreenGui")
    self.mainFrame.Name = "NeoUI"
    self.mainFrame.Parent = StarterGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 300)
    frame.Position = UDim2.new(0.5, -200, 0.5, -150)
    frame.BackgroundColor3 = Color3.new(1, 1, 1)
    frame.Parent = self.mainFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -110, 0, 30)
    title.Text = self.title
    title.TextColor3 = Color3.new(0, 0, 0)
    title.Parent = frame

    local themeButton = Instance.new("TextButton")
    themeButton.Size = UDim2.new(0, 100, 0, 30)
    themeButton.Position = UDim2.new(1, -110, 0, 0)
    themeButton.Text = "Toggle Theme"
    themeButton.Parent = frame
    themeButton.MouseButton1Click:Connect(function()
        self:toggleTheme()
    end)

    self.contentFrame = Instance.new("Frame")
    self.contentFrame.Size = UDim2.new(1, 0, 1, -40)
    self.contentFrame.Position = UDim2.new(0, 0, 0, 40)
    self.contentFrame.BackgroundTransparency = 1
    self.contentFrame.Parent = frame

    self.sidebar = Instance.new("Frame")
    self.sidebar.Size = UDim2.new(0, 100, 1, 0)
    self.sidebar.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
    self.sidebar.Parent = self.contentFrame

    self.mainContent = Instance.new("Frame")
    self.mainContent.Size = UDim2.new(1, -110, 1, 0)
    self.mainContent.Position = UDim2.new(0, 110, 0, 0)
    self.mainContent.BackgroundTransparency = 1
    self.mainContent.Parent = self.contentFrame
end

function NeoUI:addCategory(name, icon)
    local category = {
        name = name,
        icon = icon,
        elements = {}
    }
    table.insert(self.categories, category)
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 30)
    button.Position = UDim2.new(0, 0, 0, (#self.categories - 1) * 35)
    button.Text = name
    button.Parent = self.sidebar
    button.MouseButton1Click:Connect(function()
        self:selectCategory(name)
    end)

    if self.activeCategory == nil then
        self:selectCategory(name)
    end

    return category
end

function NeoUI:selectCategory(name)
    self.activeCategory = name
    self:updateMainContent()
end

function NeoUI:updateMainContent()
    self.mainContent:ClearAllChildren()
    
    for _, category in ipairs(self.categories) do
        if category.name == self.activeCategory then
            for i, element in ipairs(category.elements) do
                local yPos = (i - 1) * 35
                element:render(self.mainContent, Vector2.new(10, yPos))
            end
            break
        end
    end
end

function NeoUI:addElement(categoryName, element)
    for _, category in ipairs(self.categories) do
        if category.name == categoryName then
            table.insert(category.elements, element)
            if self.activeCategory == categoryName then
                self:updateMainContent()
            end
            break
        end
    end
end

function NeoUI:toggleTheme()
    self.theme = self.theme == "light" and "dark" or "light"
    local backgroundColor = self.theme == "light" and Color3.new(1, 1, 1) or Color3.new(0.2, 0.2, 0.2)
    local textColor = self.theme == "light" and Color3.new(0, 0, 0) or Color3.new(1, 1, 1)
    
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    TweenService:Create(self.mainFrame.Frame, tweenInfo, {BackgroundColor3 = backgroundColor}):Play()
    TweenService:Create(self.mainFrame.Frame.TextLabel, tweenInfo, {TextColor3 = textColor}):Play()
    TweenService:Create(self.sidebar, tweenInfo, {BackgroundColor3 = self.theme == "light" and Color3.new(0.9, 0.9, 0.9) or Color3.new(0.3, 0.3, 0.3)}):Play()
    
    for _, button in ipairs(self.sidebar:GetChildren()) do
        if button:IsA("TextButton") then
            TweenService:Create(button, tweenInfo, {TextColor3 = textColor}):Play()
        end
    end
    
    for _, element in ipairs(self.mainContent:GetChildren()) do
        if element:IsA("TextButton") then
            TweenService:Create(element, tweenInfo, {TextColor3 = textColor, BackgroundColor3 = backgroundColor}):Play()
        end
    end
end

return NeoUI