-- moveable object manager --
-- depricated?
local ObjectManager {}

function ObjectManager:create()
  self.objects = {}
  -- global from main
  gameManager.gameLoop:add(self)
end

function ObjectManager:add(obj)
  obj:load()
  table.insert(self.objects, obj)
end

function ObjectManager:tick(dt)
  for i = self.objects,1,-1 do
    local obj = self.objects[i]
    if obj.remove then
      table.remove(self.objects, i)
    end
  end
end

function ObjectManager:draw()
  
end


function ObjectManager:getObjectByID(object, id)
  for i = 1,#self.objects do
    local obj = self.objects[i]
    if obj.id == id then
      return obj
    end
  end
  return nil
end



return ObjectManager