local Player = {}



require "tools/collision"
require "tools/keys"
vec2 = require("tools/vec2")
local keyDown = love.keyboard.isDown
local insert = table.insert
local floor = math.floor

function Player:new(x, y)
  local tile_w = 32
  local tile_h = 32
  local player = require("objects/entity"):new(x, y, tile_w, tile_h, "player")
  local color = { 255,0,255,255}
  player.life = 5
  local velSpeed = 250
  local cooldownSpeed = 15
  local cooldown = 0
  local isShoot = false
  player.points = 0
  player.coins = 0
  player.isAlive = true
  player.blink = false
  player.blinkAnim = false
  player.blinkStep = 0.5
  player.blinkTime = 3
  player.currentBlinkTime = 0
  player.lastBlinkTime = 0
  
  function player:init()
    -- add to loop?
    -- add to renderer?
    -- init physics?
      gameManager.gameLoop:add(self)
      self.layer = 3
      self.dir.x = 0
      self.dir.y = 1
      gameManager.renderer:add(self,self.layer)
      
      self.isAlive = true
      
      
      local image = asm:get("hero-right")
            
      self.animation = require("tools/animation"):new(
        image,
        {
          {
            -- idle
            gameManager.animData["player_walkRight"][1]
          },
          {
            -- right
            gameManager.animData["player_walkRight"][1],
            gameManager.animData["player_walkRight"][2],
            gameManager.animData["player_walkRight"][3],
            gameManager.animData["player_walkRight"][4],
            gameManager.animData["player_walkRight"][5],
            gameManager.animData["player_walkRight"][6]
            
          }
        },
        0.1
      )
      
      self.animation:play()
      
  end
  
  function player:reinit()
      gameManager.gameLoop:add(self)
      self.layer = 2
      self.dir.x = 0
      self.dir.y = 1
      gameManager.renderer:add(self,self.layer)
      
      self.isAlive = true
  end
  
  
  function player:draw()
    if self.blink then
      if self.blinkAnim then
        goto skip_anim
      end
    end
    
    --love.graphics.setColor(color)
    --love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)
    --love.graphics.setColor(0,0,0)
    self.animation:draw( {self.pos.x, self.pos.y} )
    ::skip_anim::
  end



  
  
  function player:tick(dt)
    player:checkBlink(dt)

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
    
    self.animation:update(dt)
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
      self.animation:set_animation(2)
      if keys.left.pressed then
        self.animation:set_image( asm:get("hero-left-up") )
        
      elseif keys.right.pressed then
        self.animation:set_image( asm:get("hero-right-up") )
      else
        self.animation:set_image( asm:get("hero-up") )
      end
    elseif keys.down.pressed then
      self.vel.y = velSpeed
      self.dir.y = 1
      upDownPressed = true
      self.animation:set_animation(2)
      if keys.left.pressed then
        self.animation:set_image( asm:get("hero-left-down") )
        
      elseif keys.right.pressed then
        self.animation:set_image( asm:get("hero-right-down") )
      else
        self.animation:set_image( asm:get("hero-down") )
      end
    else 
      self.vel.y = 0
    end
    
    if keys.left.pressed then
      self.vel.x = -velSpeed
      self.dir.x = -1
      leftRightPressed = true
      self.animation:set_animation(2)
      if not upDownPressed then
        self.animation:set_image( asm:get("hero-left") )
      end
    elseif keys.right.pressed then
      self.vel.x = velSpeed
      self.dir.x = 1
      leftRightPressed = true
      self.animation:set_animation(2)
      if not upDownPressed then
        self.animation:set_image( asm:get("hero-right") )
      end
    else 
      self.vel.x = 0
    end
    
    if upDownPressed and leftRightPressed == false then
      self.dir.x = 0
    elseif leftRightPressed and upDownPressed == false then
      self.dir.y = 0
    end
    
    if not upDownPressed and not leftRightPressed then
      self.animation:set_animation(1)
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
    --print("Points: ", self.points, " coins: ", self.coins)
  end
  function player:takeHit(damage)
    -- simple take, have no time for rest :/ --
    if not self.blink and self.isAlive then
      player.life = player.life - 1
      if player.life > 0 then
        self.blink = true
        self.currentBlinkTime = 0
      else
        isActive = false
      end
    end
  end
  
  function player:checkBlink(dt)
    if self.blink then
      self.currentBlinkTime = self.currentBlinkTime + dt
      if self.currentBlinkTime < self.blinkTime then
      
        if floor(self.currentBlinkTime * 100) >=  self.lastBlinkTime + player.blinkStep * 100 then
          self.blinkAnim = not self.blinkAnim
          self.currentBlinkTime = floor(self.currentBlinkTime*100) / 100
          self.lastBlinkTIme = self.currentBlinkTime
        end
      else
        self.blink = false
        self.blinkAnim = false
      end
    end
    
    
  end
  
  return player
end

return Player