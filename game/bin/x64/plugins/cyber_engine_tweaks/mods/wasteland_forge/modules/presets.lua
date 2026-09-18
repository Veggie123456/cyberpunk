local Presets={items={}}
function Presets.capture(name,objects)
  Presets.items[name]={name=name,objects=objects}
end
function Presets.get(name) return Presets.items[name] end
return Presets
