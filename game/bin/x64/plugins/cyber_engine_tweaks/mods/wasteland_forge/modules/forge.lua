local Storage = require("modules/storage")
local Assets = require("modules/assets")
local Runtime = require("modules/runtime")

local Forge = { enabled=false, selected=nil, settlement={version=1,name="Badlands Alpha",objects={}} }

function Forge.init()
  Forge.settlement = Storage.load() or Forge.settlement
  Runtime.restore(Forge.settlement.objects)
end

function Forge.toggle() Forge.enabled = not Forge.enabled end
function Forge.isEnabled() return Forge.enabled end
function Forge.assets() return Assets.all end
function Forge.objects() return Forge.settlement.objects end

function Forge.add(asset)
  local item = {
    id = tostring(os.time()) .. "-" .. tostring(#Forge.settlement.objects + 1),
    asset = asset.path,
    label = asset.label,
    position = {x=0,y=0,z=0},
    rotation = {roll=0,pitch=0,yaw=0},
    scale = {x=1,y=1,z=1}
  }
  table.insert(Forge.settlement.objects,item)
  Forge.selected=item
  Runtime.spawn(item)
  Storage.save(Forge.settlement)
end

function Forge.select(i) Forge.selected = Forge.settlement.objects[i] end
function Forge.selectedObject() return Forge.selected end

function Forge.nudge(axis, amount)
  if not Forge.selected then return end
  Forge.selected.position[axis] = Forge.selected.position[axis] + amount
  Runtime.update(Forge.selected)
end

function Forge.rotate(amount)
  if not Forge.selected then return end
  Forge.selected.rotation.yaw = Forge.selected.rotation.yaw + amount
  Runtime.update(Forge.selected)
end

function Forge.deleteSelected()
  if not Forge.selected then return end
  Runtime.remove(Forge.selected)
  for i,v in ipairs(Forge.settlement.objects) do
    if v.id == Forge.selected.id then table.remove(Forge.settlement.objects,i) break end
  end
  Forge.selected=nil
  Storage.save(Forge.settlement)
end

function Forge.save() Storage.save(Forge.settlement) end
return Forge
