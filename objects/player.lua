local Player = {}

require "tools/collision"
require "tools/keys"
vec2 = require("tools/vec2")
local keyDown = love.keyboard.isDown
local insert = table.insert
local floor = math.floor
local cos = math.cos
local sin = math.sin


function Player:new(x, y)
  local tile_w = 64
  local tile_h = 64
  local player = require("objects/entity"):new(x, y, tile_w, tile_h, "player")
  local color = { 255,0,255,255}
  player.life = 10
  local velSpeed = 250
  player.cooldownBaseSpeed = 10--50
  player.cooldownMaxSpeed = 7--15
  player.cooldownSpeed = player.cooldownBaseSpeed --15--55--65--15
  player.cooldown = 0
  -- special cooldown
  player.canUseSpecial = true
  player.specialCooldown = 0
  player.specialTimes = { min = 50, max = 150 }
  
  local isShoot = false
  player.canShoot = true  -- info for gui
  player.points = 0
  player.coins = 0
  player.isAlive = true
  player.blink = false
  player.blinkAnim = false
  player.blinkStep = 0.15 --0.5
  player.blinkTime = 20
  player.currentBlinkTime = 0
  player.lastBlinkTime = 0
  
  player.gun = nil
  
  
  function player:init()
    -- add to loop?
    -- add to renderer?
    -- init physics?
      gameManager.gameLoop:add(self)
      self.layer = 3
      self.dir.x = 1
      self.dir.y = 0
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
      
      -- init collision rect
      self.offset.x =18
      self.offset.y = 22
      self.rect.pos.x = 0--18
      self.rect.pos.y = 0--22
      self.rect.size.x = 22
      self.rect.size.y = 22      
      
      -- init gun -- TEST
      self.gun = require("objects/guns/shotgun"):new()
  end
  
  function player:reinit()
      gameManager.gameLoop:add(self)
      self.layer = 2
      self.dir.x = 0
      self.dir.y = 1
      gameManager.renderer:add(self,self.layer)
      self.cooldownSpeed = self.cooldownBaseSpeed
      player.canShoot = true
      player.cooldown = 0
      player.cooldownSpeed = player.cooldownBaseSpeed
      self.isAlive = true
      self.canUseSpecial = true
      self.specialCooldown = 0
      
      --self.gun = require("objects/guns/rifle"):new()
      self.gun.cooldown = 0
      self.gun.cooldownSpeed = self.gun.cooldownBaseSpeed
      self.gun.canShoot = true
  end
  
  
  function player:draw()
    if self.blink then
      if self.blinkAnim then
        goto skip_anim
      end
    end
    
    -- cast shadow
    love.graphics.setColor(0,0,0,128)
    self.animation:draw( {self.pos.x+3, self.pos.y+3} )
    love.graphics.setColor(255,255,255)
    -- main character
    self.animation:draw( {self.pos.x, self.pos.y} )    
    
    
    if debugRect then
      self:drawDebugRect()
    end
    ::skip_anim::
  end


  
  
  function player:tick(dt)
    player:checkBlink(dt)
    
    -- test
    self.gun.cooldown = self.gun.cooldown - 1
    if self.gun.cooldown <= 0 then
      self.gun.canShoot = true
    end
    
    -- fire cooldown
    self.cooldown = self.cooldown - 1
    if self.cooldown <= 0 then
      self.canShoot = true
    end
    
    
    
    -- special cooldown
    if self.specialCooldown > 0 then
      self.specialCooldown = self.specialCooldown - 1
      if self.specialCooldown <= 0 then
        self.canUseSpecial = true
      end
    end
    
    
    self:checkKeys()
    self:move(dt)
    self.pos.x = self.pos.x + self.vel.x * dt
    
    self:updateCollisionRect()
    collectibleCollision(self)
    wallCollision(self,dt)
    
    self.pos.y = self.pos.y + self.vel.y * dt
    
    self:updateCollisionRect()
    collectibleCollision(self)
    wallCollision(self,dt)
    
    self.animation:update(dt)
  end

  function player:checkKeys()
    keys.up.pressed =  love.keyboard.isDown(keys.up.val)
    keys.down.pressed =  love.keyboard.isDown(keys.down.val)
    keys.left.pressed =  love.keyboard.isDown(keys.left.val)
    keys.right.pressed =  love.keyboard.isDown(keys.right.val)
    keys.action.pressed =  love.keyboard.isDown(keys.action.val)
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
    
    if keys.action.pressed then --and not isShoot then
      self:shoot()
    end
    
    if keys.special.pressed then
      self:shootSpecial()
    end

  end

  function player:updateCollisionRect()
    self.rect.pos.x = self.pos.x + self.offset.x
    self.rect.pos.y = self.pos.y + self.offset.y
  end
 
  function player:shoot(dt)
    self.gun:shoot(dt)
    goto SKIP
    
    if self.cooldown <= 0  then 
      
      local x = self.dir.x
      local y = self.dir.y
      local posx, posy = self:genBulletPosition()

      local bullet = require("objects/bullet"):new(posx, posy, 5, "playerBullet")   
      gameManager.playerBullets:add(bullet)
      
      bullet:shoot(x,y)
      local sound = asm:get("fire")
      love.audio.play(sound)
      
      keys.action.pressed = false
     
      isShoot = false
      self.canShoot = false
      self.cooldown = self.cooldownSpeed
    end
    
    
    ::SKIP::
    
  end
  
  function player:shootSpecial()
    if self.canUseSpecial then
      local count = 30--15;
      local step = 360 / count
    
      local velX = 0
      local velY = 0
      local posx = self.rect.pos.x + self.rect.size.x / 2
      local posy = self.rect.pos.y + self.rect.size.y / 2
      for angle= 0, 360, step do
        local bullet = require("objects/bullet"):new(posx, posy, 5, "playerBullet")   
        gameManager.playerBullets:add(bullet)
      
        x = cos( math.rad(angle) )
        y = sin( math.rad(angle) )
        bullet:shoot(x,y)
      
      end      
      self.canUseSpecial = false
      self.specialCooldown = math.random( self.specialTimes.min, self.specialTimes.max)
      
      local sound = asm:get("fire")
      love.audio.play(sound)
      keys.special.pressed = false
    end
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
    love.audio.play(asm:get("coinsound"))
  end
  
  
  function player:takeHit(damage)
    -- simple take, have no time for rest :/ --
    if not self.blink and self.isAlive then
      if player.life > 0 and not self.blink then
        player.life = player.life - 1
        self.blink = true
        self.blinkAnim = true
        self.currentBlinkTime = 0
      else
        isActive = false
      end
      love.audio.play(asm:get("playerouch"))
    end
  end
  
  local blinkCounter = 0
  function player:checkBlink(dt)
    if self.blink then
      if blinkCounter < self.blinkTime then
      
        self.currentBlinkTime = self.currentBlinkTime + dt
        if self.currentBlinkTime >= self.blinkStep then
          self.currentBlinkTime = 0
          self.blinkAnim = not self.blinkAnim
          blinkCounter = blinkCounter + 1
        end
      else
        self.blink = false
        self.blinkAnim = false
        blinkCounter = 0
      end
    end
  end
  
  -- [[ DEPRICATED! ]] --
  function player:checkBlink2(dt)
    if self.blink then
      self.currentBlinkTime = self.currentBlinkTime + dt
      if self.currentBlinkTime < self.blinkTime then
        --[[
        if self.currentBlinkTime >= self.lastBlinkTime + player.blinkStep then
          self.blinkAnim = not self.blinkAnim
          self.currentBlinkTime = floor(self.currentBlinkTime*100) / 100
          self.lastBlinkTime = self.currentBlinkTime
        end
        --]]
      -- [[
        if floor(self.currentBlinkTime * 100) >=  self.lastBlinkTime + player.blinkStep * 100 then
          self.blinkAnim = not self.blinkAnim
          self.currentBlinkTime = floor(self.currentBlinkTime*100) / 100
          self.lastBlinkTime = self.currentBlinkTime
        end
      --]]
      else
        self.blink = false
        self.blinkAnim = false
        self.lastBlinkTime = 0
      end
    end
    
    
  end
  
  return player
end

return Player