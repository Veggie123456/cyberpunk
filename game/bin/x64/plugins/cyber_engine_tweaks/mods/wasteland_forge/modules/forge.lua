local Storage=require("modules/storage")
local Assets=require("modules/assets")
local Runtime=require("modules/runtime")
local History=require("modules/history")
local Config=require("modules/config")

local Forge={enabled=false,selected=nil,settlement={version=2,name="Badlands Alpha",objects={}}}
local function clone(v) return json.decode(json.encode(v)) end
local function checkpoint() History.push(Forge.settlement) end
local function autosave() if Config.autosave then Storage.save(Forge.settlement) end end

function Forge.init() Forge.settlement=Storage.load() or Forge.settlement; Runtime.restore(Forge.settlement.objects) end
function Forge.toggle() Forge.enabled=not Forge.enabled end
function Forge.isEnabled() return Forge.enabled end
function Forge.assets(query,category) return Assets.filtered(query,category) end
function Forge.objects() return Forge.settlement.objects end
function Forge.config() return Config end
function Forge.objectCount() return #Forge.settlement.objects end

function Forge.add(asset)
  checkpoint()
  local item={id=tostring(os.time()).."-"..tostring(#Forge.settlement.objects+1),asset=asset.path,label=asset.label,category=asset.category,
    position={x=0,y=0,z=0},rotation={roll=0,pitch=0,yaw=0},scale={x=1,y=1,z=1}}
  table.insert(Forge.settlement.objects,item); Forge.selected=item; Runtime.spawn(item); autosave()
end
function Forge.select(i) Forge.selected=Forge.settlement.objects[i] end
function Forge.selectedObject() return Forge.selected end
function Forge.nudge(axis,amount) if not Forge.selected then return end; checkpoint(); Forge.selected.position[axis]=Forge.selected.position[axis]+amount; Runtime.update(Forge.selected); autosave() end
function Forge.rotate(amount) if not Forge.selected then return end; checkpoint(); Forge.selected.rotation.yaw=(Forge.selected.rotation.yaw+amount)%360; Runtime.update(Forge.selected); autosave() end
function Forge.duplicateSelected()
  if not Forge.selected then return end; checkpoint()
  local item=clone(Forge.selected); item.id=tostring(os.time()).."-copy-"..tostring(#Forge.settlement.objects+1); item.position.x=item.position.x+Config.gridSnap
  table.insert(Forge.settlement.objects,item); Forge.selected=item; Runtime.spawn(item); autosave()
end
function Forge.deleteSelected()
  if not Forge.selected then return end; checkpoint(); Runtime.remove(Forge.selected)
  for i,v in ipairs(Forge.settlement.objects) do if v.id==Forge.selected.id then table.remove(Forge.settlement.objects,i) break end end
  Forge.selected=nil; autosave()
end
function Forge.clear()
  checkpoint(); for _,v in ipairs(Forge.settlement.objects) do Runtime.remove(v) end
  Forge.settlement.objects={}; Forge.selected=nil; autosave()
end
function Forge.undo()
  local previous=History.popUndo(Forge.settlement); if not previous then return end
  Forge.settlement=previous; Forge.selected=nil; Runtime.restore(Forge.settlement.objects); autosave()
end
function Forge.redo()
  local nextState=History.popRedo(Forge.settlement); if not nextState then return end
  Forge.settlement=nextState; Forge.selected=nil; Runtime.restore(Forge.settlement.objects); autosave()
end
function Forge.save() Storage.save(Forge.settlement) end
return Forge
