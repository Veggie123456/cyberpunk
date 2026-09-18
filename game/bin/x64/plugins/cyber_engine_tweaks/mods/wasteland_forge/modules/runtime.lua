-- Runtime adapter. We deliberately keep game-entity calls here so the
-- settlement model and UI remain stable while runtime spawning is validated.
local Runtime={handles={}}
function Runtime.spawn(item)
  print("[Wasteland Forge] queued spawn: "..item.label.." ("..item.asset..")")
end
function Runtime.update(item)
  print("[Wasteland Forge] transform "..item.id)
end
function Runtime.remove(item)
  Runtime.handles[item.id]=nil
  print("[Wasteland Forge] remove "..item.id)
end
function Runtime.restore(items)
  for _,item in ipairs(items or {}) do Runtime.spawn(item) end
end
return Runtime
