local Storage={}
local FILE="settlement.json"
function Storage.load()
  local f=io.open(FILE,"r"); if not f then return nil end
  local raw=f:read("*a"); f:close()
  local ok,data=pcall(function() return json.decode(raw) end)
  if ok then return data end
  return nil
end
function Storage.save(data)
  local f=io.open(FILE,"w+"); if not f then return false end
  f:write(json.encode(data)); f:close(); return true
end
return Storage
