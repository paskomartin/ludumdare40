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
  local velSpeed = 100
  local cooldownSpeed = 5
  local cooldown = 0
  local isShoot = false
  enemy.isAlive = true
  enemy.distanceTrigger = 20
  enemy.damage = 5
  
  enemy.orientation = 0
  --enemy.function = nil
    
  local mapWidth = tlm.mapwidth * tlm.tilewidth
  local mapHeight = tlm.mapheight * tlm.tileheight
  local strollTimeSpeed = { 20, 50}
  local strollTime = 0
  
  function enemy:load()
      local image = asm:get("enemy-down")
            
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
      
      self.animation:set_animation(2)
      self.animation:play()
    
    
    
      gameManager.gameLoop:add(self)
      self.layer = 2
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
        self.animation:draw4( {self.pos.x, self.pos.y, self.size.x , self.size.y }, self.orientation)
        
        if debugRect then
          self:drawDebugRect()
        end
  end
  
  
  function enemy:tick(dt)
    self:ai(dt)
  end

  function enemy:takeHit(damage)
    self.life = self.life - damage
    if self.life <= 0 then
      self.isAlive = false
      self.remove = true
      love.audio.play(asm:get("enemyouch"))
      
      player.points = player.points + self.points
      
      local result = rand()
      if result >= 0.3 then
        self:spawnCoin()
      end
      
    end
  end
  
  function enemy:spawnCoin()
    --local coin = require("objects/coin"):new(self.pos.x, self.pos.y)
    local coin = require("objects/coin"):new(self.rect.pos.x, self.rect.pos.y)
    gameManager.collectibles:add(coin)
  end
  
  function enemy:ai(dt)
    if self.isAlive and not self.remove then
      strollTime = strollTime - 1
      self:move(dt)
      self.pos.x = self.pos.x + self.vel.x * dt
      self:updateCollisionRect()
      collisionWithPlayerBullet(self)
      self:collisionWithPlayer()
      wallCollision(self,dt)
      
      self.pos.y = self.pos.y + self.vel.y * dt
      self:updateCollisionRect()
      collisionWithPlayerBullet(self)
      self:collisionWithPlayer()
      wallCollision(self,dt)
    end
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
    if distance <= self.distanceTrigger then
      acc = 0
      if distance < self.distanceTrigger / 2 then
        acc = 50
      end
    else     
      if strollTime <= 0 then
        self:stroll(dt)
        strollTime = rand(strollTimeSpeed[1], strollTimeSpeed[2])
        goto skip_toanim
      end
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
    self.vel.x = cos(angle) * (velSpeed + acc)
    self.vel.y = sin(angle) * (velSpeed + acc)
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
    
    self.vel.x = cos(angle) * velSpeed
    self.vel.y = sin(angle) * velSpeed

  end

  
  
  function enemy:collisionWithPlayer()
    local result = rect_collision(self.rect, player.rect)
    if result then
      player:takeHit(self.damage)
    end
  end
  
  
  return enemy
end



return Enemy
