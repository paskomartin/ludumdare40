camera = 
{
  pos = require("tools/vec2"):new(0,0),
  size = require("tools/vec2"):new(0,0),
  
  scale = require("tools/vec2"):new(1,1),
  rot = 0,
  
  levelSize = require("tools/vec2"):new(1,1),
  isLevelInit = false
}

local lg        = love.graphics
local pop       = lg.pop
local translate = lg.translate
local rotate    = lg.rotate
local scale     = lg.scale
local push      = lg.push


function camera:setLevelSize(width, height)
  self.levelSize.x = width
  self.levelSize.y = height
  self.isLevelInit = true
end




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


function camera:setViewport(width, height)
  self.size.x = width
  self.size.y = height
end


function camera:move(playerRectPosition)
  local playerCenterX = player.rect.pos.x + player.rect.size.x / 2
  local playerCenterY = player.rect.pos.y + player.rect.size.y / 2
  local viewportCenterX = self.size.x / 2
  local viewportCenterY = self.size.y / 2
  
  self.pos.x = playerCenterX - viewportCenterX
  self.pos.y = playerCenterY - viewportCenterY 
  
  self:checkCameraBounds()
end


function camera:checkCameraBounds()
  if self.pos.x < 0 then
    self.pos.x = 0
  end
  
  if self.pos.y < 0 then
    self.pos.y = 0
  end
  
  if self.pos.x > self.levelSize.x - self.size.x then
    self.pos.x = self.levelSize.x - self.size.x
  end
  
  if self.pos.y > self.levelSize.y - self.size.y then
    self.pos.y = self.levelSize.y - self.size.y 
  end
end


function camera:move2(pos)
  --self.pos.x = pos.x * (1 / self.scale.x) - Width / 2
  --self.pos.y = pos.y * (1 / self.scale.y) - Height / 2

-- TODO: dodac mapWidth i mapHeight
  -- DEBUG ONLY!
  local mapWidth = 800
  local mapHeight = 600
  self.pos.x = (pos.x * self.scale.x) - mapWidth / 2
  self.pos.y = (pos.y * self.scale.y) - mapHeight / 2

end

return camera
