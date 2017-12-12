-- moveable object manager --
-- depricated?
local ObjectManager = {}
require("tools/helpers")

function ObjectManager:create(id)
  --assert(type(gameLoop) == 'table', "type is " .. type(gameLoop))
  local objectManager = {}
  
  objectManager.objects = {}
  objectManager.id = id
  -- global from main
  --
  --gameLoop:add(self)
  --gameManager.renderer:add(self)
--end

  function objectManager:init()
    gameManager.gameLoop:add(self)
  end

  function objectManager:add(obj)
    obj:load()
    table.insert(self.objects, obj)
  end

  function objectManager:tick(dt)
    for i = #self.objects,1,-1 do
      local obj = self.objects[i]
      if obj.remove then
        table.remove(self.objects, i)
        gameManager.renderer:remove(obj)
        gameManager.gameLoop:remove(obj)
      end
    end
  end


  function objectManager:getObjectByID(object, id)
    for i = 1,#self.objects do
      local obj = self.objects[i]
      if obj.id == id then
        return obj
      end
    end
    return nil
  end

  function objectManager:clear()
    clearTable(objectManager.objects)
  end
  
  function objectManager:count()
    return #self.objects
  end


return objectManager
end

return ObjectManager