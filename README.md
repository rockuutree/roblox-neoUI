# NeoUI for Roblox

NeoUI is a flexible and easy-to-use UI library for Roblox games. It provides a clean, modern interface with support for multiple categories, various UI elements, and theme switching.

## Features

- Simple and intuitive API
- Support for categories and sub-elements
- Built-in light and dark themes
- Customizable UI elements (Buttons, Toggles, Sliders)
- Easy to extend with new element types

## Installation

1. In Roblox Studio, create a new Script in ServerScriptService.
2. Inside that Script, create the following ModuleScripts:
   - NeoUI.lua
   - Button.lua
   - Toggle.lua
   - Slider.lua
3. Copy the code from this repository into each respective ModuleScript.
4. Create a new Script (e.g., "DemoScript") to set up your UI.

## Usage

Here's a basic example of how to use NeoUI:

```lua
local NeoUI = require(script.Parent.NeoUI)
local Button = require(script.Parent.Button)
local Toggle = require(script.Parent.Toggle)
local Slider = require(script.Parent.Slider)

local ui = NeoUI.new("My Cool Game")

local homeCategory = ui:addCategory("Home", "🏠")
ui:addElement("Home", Button.new("Start Game", function()
    print("Starting game...")
end))

local settingsCategory = ui:addCategory("Settings", "⚙️")
ui:addElement("Settings", Toggle.new("Sound Effects", function(state)
    print("Sound effects:", state)
end))
ui:addElement("Settings", Slider.new("Volume", 0, 100, 50, function(value)
    print("Volume set to:", value)
end))
```

## API Reference

### NeoUI

- `NeoUI.new(title)`: Create a new NeoUI instance
- `ui:addCategory(name, icon)`: Add a new category
- `ui:addElement(categoryName, element)`: Add an element to a category

### Button

- `Button.new(label, callback)`: Create a new button

### Toggle

- `Toggle.new(label, callback)`: Create a new toggle switch

### Slider

- `Slider.new(label, min, max, default, callback)`: Create a new slider

## Customization

You can easily extend NeoUI by creating new element types. Simply create a new ModuleScript for your element type, following the pattern of existing elements like Button or Toggle.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Inspired by modern UI design principles
- Built for the Roblox community

Happy coding!