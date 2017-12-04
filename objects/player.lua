local Player = {}

require "tools/collision"
require "tools/keys"
vec2 = require("tools/vec2")
local keyDown = love.keyboard.isDown
local insert = table.insert

function Player:new(x, y)
  local tile_w = 32
  local tile_h = 32
  local player = require("objects/entity"):new(x, y, tile_w, tile_h, "player")
  local color = { 255,0,255,255}
  player.life = 5
  local velSpeed = 350
  local cooldownSpeed = 5
  local cooldown = 0
  local isShoot = false
  player.points = 0
  player.coins = 0
  
  function player:init()
    -- add to loop?
    -- add to renderer?
    -- init physics?
      gameManager.gameLoop:add(self)
      self.layer = 2
      self.dir.x = 0
      self.dir.y = 1
      gameManager.renderer:add(self,self.layer)
  end
  
  
  function player:draw()
    --love.graphics.setColor(color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)
    --love.graphics.setColor(0,0,0)
  end



  
  
  function player:tick(dt)
    local lastPos = {}
    lastPos.x = self.pos.x
    lastPos.y = self.pos.y
    
    if cooldown > 0 then
      cooldown = cooldown - 1
    end
    self:checkKeys()
    self:move(dt)
    self.pos.x = self.pos.x + self.vel.x * dt
    collectibleCollision(self)
    wallCollision(self,dt)
    
    
    self.pos.y = self.pos.y + self.vel.y * dt
    collectibleCollision(self)
    wallCollision(self,dt)
    
    self:shoot()

  end

  function player:checkKeys()
    keys.action.pressed =  love.keyboard.isDown(keys.action.val)
    keys.up.pressed =  love.keyboard.isDown(keys.up.val)
    keys.down.pressed =  love.keyboard.isDown(keys.down.val)
    keys.left.pressed =  love.keyboard.isDown(keys.left.val)
    keys.right.pressed =  love.keyboard.isDown(keys.right.val)
    keys.special.pressed = love.keyboard.isDown(keys.special.val)
  end

  function player:move(dt)
    local leftRightPressed = false
    local upDownPressed = false
    
    local lastDirX = self.dir.x
    local lastDirY = self.dir.y
    
    if keys.up.pressed then
      self.vel.y = -velSpeed
      self.dir.y = -1
      upDownPressed = true
    elseif keys.down.pressed then
      self.vel.y = velSpeed
      self.dir.y = 1
      upDownPressed = true
    else 
      self.vel.y = 0
    end
    
    if keys.left.pressed then
      self.vel.x = -velSpeed
      self.dir.x = -1
      leftRightPressed = true
    elseif keys.right.pressed then
      self.vel.x = velSpeed
      self.dir.x = 1
      leftRightPressed = true
    else 
      self.vel.x = 0
    end
    
    if upDownPressed and leftRightPressed == false then
      self.dir.x = 0
    elseif leftRightPressed and upDownPressed == false then
      self.dir.y = 0
    end
    
    if keys.action.pressed then
      --self:shoot()
      isShoot = true
    end
    
    if keys.special.pressed then
      
    end

  end

 -- add cooldown
  function player:shoot(dt)
    
    if cooldown <= 0  and isShoot then
      --print("shoot")
      
      local x = self.dir.x
      local y = self.dir.y
      local posx, posy = self:genBulletPosition()

      --local bullet = require("objects/bullet"):new(self.pos.x, self.pos.y, 5, "playerBullet")   
      local bullet = require("objects/bullet"):new(posx, posy, 5, "playerBullet")   
      gameManager.playerBullets:add(bullet)
      
      bullet:shoot(x,y)
      isShoot = false
      cooldown = cooldownSpeed
    end
    
  end
  
  function player:shootSpecial()
    local count = 15;
    local step = 360 / count
    
    local destx = math.random(0, mapWidth)
    local desty = math.random(0, mapHeight)
    angle = atan2(player.pos.y - self.pos.y, player.pos.x - self.pos.x)
    self.vel.x = cos(angle) * velSpeed
    self.vel.y = sin(angle) * velSpeed
    
  end

  function player:genBulletPosition()
      local posx = self.pos.x
      local posy = self.pos.y
      
      if self.dir.x ~= 0 then
         if self.dir.y == 0 then
            posy = posy + self.size.y / 2
            if self.dir.x == 1 then
              posx = posx + self.size.x 
            end
        end
        
      end
      
      if self.dir.y ~= 0 then
        if self.dir.x == 0 then
          posx = posx + self.size.x / 2
          if self.dir.y == 1 then
            posy = posy + self.size.y
          end
        end       
      end
      
      if self.dir.y == 1 and self.dir.x == 1 then
          posx = posx + self.size.x
          posy = posy + self.size.y
      elseif self.dir.y == 1 and self.dir.x == -1 then
        posy = posy + self.size.y
      elseif self.dir.y == -1 and self.dir.x == 1 then
        posx = posx + self.size.x
      end
      return posx, posy
  end

  
  function player:addCoin(val)
    self.coins = self.coins + val
    print("Points: ", self.points, " coins: ", self.coins)
  end
  return player
end

return Player