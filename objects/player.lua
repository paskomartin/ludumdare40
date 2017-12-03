local Player = {}

require "tools/collision"
require "tools/keys"
vec2 = require("tools/vec2")
local keyDown = love.keyboard.isDown

function Player:new(x, y)
  local tile_w = 32
  local tile_h = 32
  local player = require("objects/entity"):new(x, y, tile_w, tile_h, "player")
  local color = { 255,0,255,255}
  
  local velSpeed = 350
  
  function player:init()
    -- add to loop?
    -- add to renderer?
    -- init physics?
      gameManager.gameLoop:add(self)
      self.layer = 2
      gameManager.renderer:add(self,self.layer)
  end
  
  function player:tick(dt)
    local lastPos = {}
    lastPos.x = self.pos.x
    lastPos.y = self.pos.y
    self:move()
    self.pos.x = self.pos.x + self.vel.x * dt
    collectibleCollision(self)
    wallCollision(self,dt)
    
    --[[
    local result = wallCollision(self, dt)
    if result then
      self.pos.x = self.pos.x - self.vel.x * dt
    end
    ]]
    
    self.pos.y = self.pos.y + self.vel.y * dt
    collectibleCollision(self)
    wallCollision(self,dt)
    
    --[[
    result = wallCollision(self, dt)
    if result then
      self.pos.y = self.pos.y - self.vel.y * dt
    end 
    ]]
  end

  function player:draw()
    --love.graphics.setColor(color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)
    --love.graphics.setColor(0,0,0)
  end

  function player:move()
    if keys.up.pressed then
      self.vel.y = -velSpeed
      self.dir.y = -1
    elseif keys.down.pressed then
      self.vel.y = velSpeed
      self.dir.y = 1
    else 
      self.vel.y = 0
    end
    
    if keys.left.pressed then
      self.vel.x = -velSpeed
      self.dir.x = -1
    elseif keys.right.pressed then
      self.vel.x = velSpeed
      self.dir.x = 1
    else 
      self.vel.x = 0
    end
    
    --[[
    if pressedKeys.up then
      self.vel.y = -velSpeed
    elseif pressedKeys.down then
      self.vel.y = velSpeed
    else 
      self.vel.y = 0
    end
    
    if pressedKeys.left then
      self.vel.x = -velSpeed
    elseif pressedKeys.right then
      self.vel.x = velSpeed
    else 
      self.vel.x = 0
    end
    ]]
    
    --[[
    local upPressed = false
    upPressed = keyDown(keys.up)
    downPressed = keyDown(keys.down)
    
    if upPressed = keyDown(keys.up)  then
      self.vel.y = -velSpeed
    elseif downPressed = keyDown(keys.down) then
      self.vel.y = velSpeed
    else
      self.vel.y = 0
    end
    upPressed = false
    
    if upPressed = keyDown(keys.left) then
      self.vel.x = -velSpeed
    elseif upPressed = keyDown(keys.right) then
      self.vel.x = velSpeed
    else
      self.vel.x = 0
    end
    ]]
  end


  return player
end


return Player