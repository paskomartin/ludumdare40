local vec2 = require("tools/vec2")
local rect = require("objects/rect")
local Entity = {}

function Entity:new(x, y, w, h, id)
  local ent = {}
  -- position --
  ent.pos = vec2:new(x,y)
  -- width and height --
  ent.size = vec2:new(w,h)
  -- collision rectangle
  ent.rect = rect:new(x,y,w,h)
  -- collision offset from top-left corner
  ent.offset = vec2:new(0,0)

  -- velocity --
  ent.vel = vec2:new(0,0)
  -- direction --
  ent.dir = vec2:new(0,0)
  -- speed --
  ent.speed = vec2:new(0,0)
  -- id --
  ent.id = id or "entity"
  -- time to remove? --
  ent.remove = false
  -- drawing layer
  ent.layer = 0
  -- life
  ent.life = 0
  
   
  -- abstract virtual methods --
  function ent:load() end
  function ent:tick(dt) end
  function ent:draw() end
  function ent:takeHit(damage) end
  
  function ent:updateCollisionRect()
    self.rect.pos.x = self.pos.x + self.offset.x
    self.rect.pos.y = self.pos.y + self.offset.y
  end
 
  function ent:drawDebugRect()
    love.graphics.setColor(0,255,0)
    love.graphics.rectangle('line', self.pos.x, self.pos.y, self.size.x, self.size.y)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle('line', self.rect.pos.x, self.rect.pos.y, self.rect.size.x, self.rect.size.y)
    love.graphics.setColor(255,255,255)
  end

  
  return ent
end

return Entity