local History={undo={},redo={}}
local function copy(v) return loadstring("return "..json.encode(v)) end
function History.push(snapshot)
  table.insert(History.undo,json.encode(snapshot))
  if #History.undo>50 then table.remove(History.undo,1) end
  History.redo={}
end
function History.popUndo(current)
  local raw=table.remove(History.undo)
  if not raw then return nil end
  table.insert(History.redo,json.encode(current))
  return json.decode(raw)
end
function History.popRedo(current)
  local raw=table.remove(History.redo)
  if not raw then return nil end
  table.insert(History.undo,json.encode(current))
  return json.decode(raw)
end
return History
