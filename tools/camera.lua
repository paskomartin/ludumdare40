camera = 
{
  pos = require("tools/vec2"):new(0,0),
  size = require("tools/vec2"):new(0,0),
  scale = require("tools/vec2"):new(1,1),
  rot = 0
}

local lg        = love.graphics
local pop       = lg.pop
local translate = lg.translate
local rotate    = lg.rotate
local scale     = lg.scale
local push      = lg.push


function camera:set()
  -- if player goes forward the camera needs backwards
  push()
  translate( -self.pos.x, -self.pos.y)
  rotate(self.rot)
  scale(1 / self.scale.x , 1 / self.scale.y);
end


function camera:unset()
  pop()
end

function camera:move(pos)
  --self.pos.x = pos.x * (1 / self.scale.x) - Width / 2
  --self.pos.y = pos.y * (1 / self.scale.y) - Height / 2

-- TODO: dodac mapWidth i mapHeight
  -- DEBUG ONLY!
  local mapWidth = 320
  local mapHeight = 200
  self.pos.x = pos.x * self.scale.x) - mapWidth / 2
  self.pos.y = pos.y * self.scale.y) - mapHeight / 2

end

return camera
