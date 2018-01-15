local Enemy = {}

require("tools/collision")
require("tools/keys")
require("tools/helpers")
vec2 = require("tools/vec2")
local floor = math.floor
local atan2 = math.atan2
local sin = math.sin
local cos = math.cos
local rand = math.random


function Enemy:new(x,y, id)
  assert(type(id) == "string")
  local tile_w = 64
  local tile_h = 64
  local enemy = require("objects/entity"):new(x, y, tile_w, tile_h, id)
  local color = { 201,20,72,255}
  enemy.life = 1
  enemy.points = 50
  enemy.velSpeed = 75--100
  enemy.cooldownSpeed = 5
  enemy.cooldown = 0
  enemy.isShoot = false
  enemy.isAlive = true
  enemy.distanceTrigger = 200
  enemy.damage = 5
  enemy.value = 50
    
  enemy.orientation = 0
  --enemy.function = nil
    
  local mapWidth = tlm.mapwidth * tlm.tilewidth
  local mapHeight = tlm.mapheight * tlm.tileheight
  local strollTimeSpeed = { 20, 50}
  local strollTime = 0
  
  function enemy:load()
      --local image = asm:get("enemy-down")
      local image = asm:get("lizard")
            
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
      self.animation.scale = 2
      self.animation:set_animation(2)
      self.animation:play()
    
    
    
      gameManager.gameLoop:add(self)
      self.layer = 3
      self.dir.x = 0
      self.dir.y = 1
      gameManager.renderer:add(self,self.layer)
      
       -- init collision rect
      self.offset.x =15
      self.offset.y = 15
      self.rect.pos.x = 0--18
      self.rect.pos.y = 0--22
      self.rect.size.x = 30
      self.rect.size.y = 30
  end
    
  function enemy:draw()
    local cx = self.size.x / 2
    local cy = self.size.y / 2
    local x = self.pos.x
    local y = self.pos.y
   
    -- cast shadow
    love.graphics.setColor(0,0,0,128)
    self.animation:draw4( {self.pos.x +3 , self.pos.y + 3, self.size.x , self.size.y }, self.orientation)
    love.graphics.setColor(255,255,255)

    -- main character
    self.animation:draw4( {self.pos.x, self.pos.y, self.size.x , self.size.y }, self.orientation)
        
        
    if debugRect then
      self:drawDebugRect()
    end
  end
  
  
  function enemy:tick(dt)
    self:ai(dt)
  end

  function enemy:takeHit(damage)
    if self.isAlive and not self.remove then
      self.life = self.life - damage
      if self.life <= 0 then
        self.isAlive = false
        self.remove = true
        local r =  math.random(1, 7) 
        local name = "enemyouch" .. tostring(r)
        --local sound = asm:get("enemyouch")
        local sound = asm:get(name)
        
        love.audio.play(sound)
        player:addPoints(self.points)
        player:increaseKill()
        
        
        local result = rand()
        if result <= 0.19 then
          if result <= 0.05 then --0.05--0.02
            self:spawnBonus()
          else
            self:spawnCoin()  
          end
        end
        
        if gameManager.enemyCounter == gameManager.maxEnemy then
          gameManager:resetSpawnersTime(0, 1.5)
        end
        
        gameManager:decreaseEnemy()
        player:addValToSpecial(self.value)
        
      end
    end
    
  end
  
  function enemy:spawnCoin()
    --local coin = require("objects/coin"):new(self.pos.x, self.pos.y)
    local coin = require("objects/coin"):new(self.rect.pos.x, self.rect.pos.y)

    gameManager.collectibles:add(coin)
  end
  
  function enemy:spawnBonus()
    -- medkit, rifle, shotgun or bomb
    -- temporary --
    local bonusesCount = 4
    local r = math.random(0, 4096) % bonusesCount
    
    local bonus = nil
    if r == 0 then
      bonus = require("objects/medkit"):new(self.rect.pos.x, self.rect.pos.y)
    elseif r == 1 then
      bonus = require("objects/bomb"):new(self.rect.pos.x, self.rect.pos.y)
    elseif r == 2 then
      bonus = require("objects/fastreload"):new(self.rect.pos.x, self.rect.pos.y)
    elseif r == 3 then
      local guns = { "shotgun", "rifle", "pistol" }
      local gunNum =  math.random(0, 8192)  % #guns
      gunNum = gunNum + 1
      bonus = require("objects/guns/gunfactory"):new(self.rect.pos.x, self.rect.pos.y, guns[gunNum] )
    end
    -- check collision with walls here!
    gameManager.collectibles:add(bonus)
  end
  
  function enemy:ai(dt)
    if self.isAlive and not self.remove then
      self.attack(dt)
      strollTime = strollTime - 1
      self:move(dt)
      self.pos.x = self.pos.x + self.vel.x * dt
      self:updateCollisionRect()
          collisionWithEnemy(self)
      local bulletID = "playerBullet"
      collisionWithBullet(self, bulletID)
      self:collisionWithPlayer()
      if wallCollision(self,dt) then
        strollTime = 0
      end
  
      
      self.pos.y = self.pos.y + self.vel.y * dt
      self:updateCollisionRect()
      collisionWithEnemy(self)
      collisionWithBullet(self, bulletID)
      self:collisionWithPlayer()
      if wallCollision(self,dt) then
        strollTime = 0
      end

    end
  end
  
  
  function enemy:attack(dt)
  end
  
  
    function enemy:move(dt)
    -- self center
    local enemyCenter = {}
    enemyCenter.pos = require("tools/vec2"):new(x,y)
    enemyCenter.pos.x = self.pos.x + self.size.x / 2
    enemyCenter.pos.y = self.pos.y + self.size.y / 2
    -- player center
    local playerCenter = {}
    playerCenter.pos = require("tools/vec2"):new(x,y)
    playerCenter.pos.x = player.pos.x + player.size.x / 2
    playerCenter.pos.y = player.pos.y + player.size.y / 2
    
    --[[ -- TEST
        local acc= 0
    if strollTime <= 0 then
      self:stroll(dt)
      math.randomseed(love.timer.getTime())
      strollTime = rand(strollTimeSpeed[1], strollTimeSpeed[2])
      --print(strollTime)
      goto skip_toanim
    end
    --]]--


    -- [[
    local acc = 0
    angle = atan2(playerCenter.pos.y - enemyCenter.pos.y, playerCenter.pos.x - enemyCenter.pos.x)


    local distance = floor(distance(playerCenter, enemyCenter) )
    if distance <= self.distanceTrigger  then
      acc = 0
      if distance < self.distanceTrigger / 2 then
        acc = 50
      end
    else
      -- i have to think about this --
      --[[
      if strollTime <= 0 then
        self:stroll(dt)
        strollTime = rand(strollTimeSpeed[1], strollTimeSpeed[2])
        --goto skip_toanim
      end
      goto skip_toanim
      --]]
    end


    --[[
    local distance = floor(distance(playerCenter, enemyCenter) )
    if distance <= self.distanceTrigger then
      acc = 0
    else if distance < self.distanceTrigger / 2 then
        acc = 150
--      end
    else     
      if strollTime <= 0 then
        self:stroll(dt)
        strollTime = rand(strollTimeSpeed[1], strollTimeSpeed[2])
        goto skip_toanim
      end
    end
    -- ---]-]
  end

  --]]





  --[[
    local distance = floor(distance(playerCenter, enemyCenter) )
    if distance <= self.distanceTrigger / 2 then
      acc = 50
    elseif distance <= self.distanceTrigger and distance > self.distanceTrigger / 2 then
      acc = 0
    else     
      if strollTime <= 0 then
        self:stroll(dt)
        strollTime = rand(strollTimeSpeed[1], strollTimeSpeed[2])
        goto skip_toanim
      end
    end
  --]]
    self.vel.x = cos(angle) * (self.velSpeed + acc)
    self.vel.y = sin(angle) * (self.velSpeed + acc)
    self.orientation = angle - math.pi/2

    ::skip_toanim::
    self.animation:update(dt)
  end
  
  
  function enemy:stroll(dt)
    local destx = math.random(0, mapWidth)
    local desty = math.random(0, mapHeight)
    local centerx = self.pos.x + self.size.x / 2
    local centery = self.pos.x + self.size.y / 2
    angle = atan2(desty - centery, destx - centerx)
    
    --print(destx, " ", desty)
    
    self.orientation = angle - math.pi /2
    
    self.vel.x = cos(angle) * self.velSpeed
    self.vel.y = sin(angle) * self.velSpeed

  end

  
  
  function enemy:collisionWithPlayer()
    local result = rect_collision(self.rect, player.rect)
    if result then
      player:takeHit(self.damage)
    end
  end
  
  function enemy:collisionWithEnemy()
    local result = collisionWithEnemy(self)
    if result then
      
    end
    
  end
  
  
  return enemy
end



return Enemy
