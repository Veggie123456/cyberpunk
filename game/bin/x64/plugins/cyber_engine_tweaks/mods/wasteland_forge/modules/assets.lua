local Assets={}
Assets.all={
  {label="Concrete Barrier",category="Barriers",path="PLACEHOLDER:barrier"},
  {label="Cargo Container",category="Structures",path="PLACEHOLDER:container"},
  {label="Work Light",category="Lighting",path="PLACEHOLDER:light"},
  {label="Chair",category="Furniture",path="PLACEHOLDER:chair"},
  {label="Table",category="Furniture",path="PLACEHOLDER:table"},
  {label="Generator",category="Utility",path="PLACEHOLDER:generator"},
  {label="Tent",category="Structures",path="PLACEHOLDER:tent"},
  {label="Crate",category="Decor",path="PLACEHOLDER:crate"},
  {label="Road Barrier",category="Barriers",path="PLACEHOLDER:road_barrier"},
  {label="Flood Light",category="Lighting",path="PLACEHOLDER:flood_light"},
  {label="Bench",category="Furniture",path="PLACEHOLDER:bench"},
  {label="Terminal",category="Utility",path="PLACEHOLDER:terminal"}
}
function Assets.filtered(query,category)
  local out={}
  query=string.lower(query or "")
  for _,a in ipairs(Assets.all) do
    local matchCategory=(not category or category=="All" or a.category==category)
    local matchQuery=(query=="" or string.find(string.lower(a.label),query,1,true))
    if matchCategory and matchQuery then table.insert(out,a) end
  end
  return out
end
return Assets
