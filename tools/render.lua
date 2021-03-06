local Renderer = {}
local num_of_layers = 5
local insert = table.insert
local remove = table.remove
require("tools/helpers")


function Renderer:create()
  local renderer = {}
  renderer.drawers = {}
  
  for i = 0, num_of_layers do
    renderer.drawers[i] = {}
  end
  
  function renderer:add(obj,layer)
    local l = layer or 0
    insert(self.drawers[l], obj)
  end
  
  function renderer:draw()
    for layer = 0, #self.drawers do
      for draw = 0, #self.drawers[layer] do
        local obj = self.drawers[layer][draw]
        if obj ~= nil then
          obj:draw()
        end
      end
    end
  end
  
  function renderer:remove(obj)
    assert(obj ~= nil)
    local layer = obj.layer
    
    index = table.find(self.drawers[layer], obj)
    if index ~= nil then
      remove(self.drawers[layer], index)
    end
  end
  
  function renderer:clear()
    for i = 0, num_of_layers do
      clearTable(renderer.drawers[i])
    end
    
  end
  
  return renderer
end

return Renderer