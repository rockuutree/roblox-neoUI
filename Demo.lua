local NeoUI = require(script.Parent.NeoUI)
local Button = require(script.Parent.Button)
local Toggle = require(script.Parent.Toggle)
local Slider = require(script.Parent.Slider)

local ui = NeoUI.new("NeoUI Demo")

local homeCategory = ui:addCategory("Home", "🏠")
ui:addElement("Home", Button.new("Click Me!", function()
    print("Button clicked!")
end))
ui:addElement("Home", Toggle.new("Enable Feature", function(state)
    print("Toggle:", state)
end))

local settingsCategory = ui:addCategory("Settings", "⚙️")
ui:addElement("Settings", Slider.new("Volume", 0, 100, 50, function(value)
    print("Volume set to:", value)
end))
ui:addElement("Settings", Button.new("Reset Settings", function()
    print("Settings reset!")
end))

local profileCategory = ui:addCategory("Profile", "👤")
ui:addElement("Profile", Button.new("Edit Profile", function()
    print("Editing profile...")
end))

-- The UI is now set up and will be visible to players