local UI={visible=false,query="",category="All"}
function UI.setVisible(v) UI.visible=v end
function UI.draw(Forge)
  if not UI.visible then return end
  ImGui.SetNextWindowSize(600,720,ImGuiCond.FirstUseEver)
  ImGui.Begin("Wasteland Forge")
  ImGui.Text(Forge.isEnabled() and "FORGE MODE: ON" or "FORGE MODE: OFF"); ImGui.SameLine(); ImGui.Text("Objects: "..Forge.objectCount())
  if ImGui.Button(Forge.isEnabled() and "Exit Forge Mode" or "Enter Forge Mode") then Forge.toggle() end
  ImGui.SameLine(); if ImGui.Button("Undo") then Forge.undo() end; ImGui.SameLine(); if ImGui.Button("Redo") then Forge.redo() end
  ImGui.Separator(); ImGui.Text("BUILD PALETTE")
  local changed; changed,UI.query=ImGui.InputText("Search",UI.query,64)
  local cats={"All","Structures","Furniture","Utility","Lighting","Decor","Barriers"}
  for _,c in ipairs(cats) do if ImGui.Button(c) then UI.category=c end; ImGui.SameLine() end
  ImGui.NewLine(); ImGui.Text("Category: "..UI.category)
  for _,asset in ipairs(Forge.assets(UI.query,UI.category)) do if ImGui.Button("+ "..asset.label.." ["..asset.category.."]") then Forge.add(asset) end end
  ImGui.Separator(); ImGui.Text("SETTLEMENT")
  for i,item in ipairs(Forge.objects()) do if ImGui.Selectable(item.label.."##"..item.id,Forge.selectedObject()==item) then Forge.select(i) end end
  local s=Forge.selectedObject()
  if s then
    local cfg=Forge.config(); ImGui.Separator(); ImGui.Text("INSPECTOR: "..s.label)
    ImGui.Text(string.format("Pos %.2f, %.2f, %.2f | Yaw %.1f",s.position.x,s.position.y,s.position.z,s.rotation.yaw))
    if ImGui.Button("X -") then Forge.nudge("x",-cfg.gridSnap) end; ImGui.SameLine(); if ImGui.Button("X +") then Forge.nudge("x",cfg.gridSnap) end
    if ImGui.Button("Y -") then Forge.nudge("y",-cfg.gridSnap) end; ImGui.SameLine(); if ImGui.Button("Y +") then Forge.nudge("y",cfg.gridSnap) end
    if ImGui.Button("Z -") then Forge.nudge("z",-cfg.gridSnap) end; ImGui.SameLine(); if ImGui.Button("Z +") then Forge.nudge("z",cfg.gridSnap) end
    if ImGui.Button("Rotate -") then Forge.rotate(-cfg.rotationSnap) end; ImGui.SameLine(); if ImGui.Button("Rotate +") then Forge.rotate(cfg.rotationSnap) end
    if ImGui.Button("Duplicate") then Forge.duplicateSelected() end; ImGui.SameLine(); if ImGui.Button("Delete") then Forge.deleteSelected() end
  end
  ImGui.Separator(); if ImGui.Button("Save Settlement") then Forge.save() end; ImGui.SameLine(); if ImGui.Button("CLEAR ALL") then Forge.clear() end
  ImGui.End()
end
return UI
