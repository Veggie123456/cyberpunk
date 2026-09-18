local Forge = require("modules/forge")
local UI = require("modules/ui")

registerForEvent("onInit", function()
  Forge.init()
end)

registerForEvent("onOverlayOpen", function()
  UI.setVisible(true)
end)

registerForEvent("onOverlayClose", function()
  UI.setVisible(false)
end)

registerForEvent("onDraw", function()
  UI.draw(Forge)
end)

registerHotkey("wasteland_forge_toggle", "Wasteland Forge: Toggle Forge Mode", function()
  Forge.toggle()
end)
