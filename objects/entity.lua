local vec2 = require("tools/vec2")
local Entity = {}

function Entity:new(x, y, w, h, id)
  local ent = {}
  -- position --
  ent.pos = vec2:new(x,y)
  -- width and height --
  ent.size = vec2:new(w,h)
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
  
  -- collision rectangle 
  --ent.rect = 
  
  -- abstract virtual methods --
  function ent:load() end
  function ent:tick(dt) end
  function ent:draw() end
  function ent:takeHit(damage) end
  
  return ent
end

return Entity