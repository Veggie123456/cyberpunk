local UI={visible=false}
function UI.setVisible(v) UI.visible=v end
function UI.draw(Forge)
  if not UI.visible then return end
  ImGui.SetNextWindowSize(520,600,ImGuiCond.FirstUseEver)
  local open=true
  open=ImGui.Begin("Wasteland Forge",open)
  ImGui.Text(Forge.isEnabled() and "FORGE MODE: ON" or "FORGE MODE: OFF")
  if ImGui.Button(Forge.isEnabled() and "Exit Forge Mode" or "Enter Forge Mode") then Forge.toggle() end
  ImGui.Separator(); ImGui.Text("Build palette")
  for _,asset in ipairs(Forge.assets()) do
    if ImGui.Button("Spawn "..asset.label) then Forge.add(asset) end
  end
  ImGui.Separator(); ImGui.Text("Settlement objects")
  for i,item in ipairs(Forge.objects()) do
    if ImGui.Selectable(item.label.."##"..item.id, Forge.selectedObject()==item) then Forge.select(i) end
  end
  local s=Forge.selectedObject()
  if s then
    ImGui.Separator(); ImGui.Text("Selected: "..s.label)
    if ImGui.Button("X -") then Forge.nudge("x",-0.25) end; ImGui.SameLine(); if ImGui.Button("X +") then Forge.nudge("x",0.25) end
    if ImGui.Button("Y -") then Forge.nudge("y",-0.25) end; ImGui.SameLine(); if ImGui.Button("Y +") then Forge.nudge("y",0.25) end
    if ImGui.Button("Z -") then Forge.nudge("z",-0.25) end; ImGui.SameLine(); if ImGui.Button("Z +") then Forge.nudge("z",0.25) end
    if ImGui.Button("Rotate -5") then Forge.rotate(-5) end; ImGui.SameLine(); if ImGui.Button("Rotate +5") then Forge.rotate(5) end
    if ImGui.Button("Delete selected") then Forge.deleteSelected() end
  end
  if ImGui.Button("Save Settlement") then Forge.save() end
  ImGui.End()
end
return UI
