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
  local tile_w = 32
  local tile_h = 32
  local enemy = require("objects/entity"):new(x, y, tile_w, tile_h, id)
  local color = { 201,20,72,255}
  enemy.life = 1
  enemy.points = 50
  local velSpeed = 100
  local cooldownSpeed = 5
  local cooldown = 0
  local isShoot = false
  enemy.isAlive = true
  enemy.distanceTrigger = 200
  enemy.damage = 5
  
  --enemy.function = nil
    
  local mapWidth = tlm.mapwidth * tlm.tilewidth
  local mapHeight = tlm.mapheight * tlm.tileheight
  local strollTimeSpeed = { 10, 35}
  local strollTime = 0
  
  function enemy:load()
      gameManager.gameLoop:add(self)
      self.layer = 2
      self.dir.x = 0
      self.dir.y = 1
      gameManager.renderer:add(self,self.layer)
  end
    
  function enemy:draw()
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)
    love.graphics.setColor(255,255,255)
  end
  
  
  function enemy:tick(dt)
    self:ai(dt)
  end

  function enemy:takeHit(damage)
    self.life = self.life - damage
    if self.life <= 0 then
      self.isAlive = false
      self.remove = true
      
      player.points = player.points + self.points
      
      local result = rand()
      if result >= 0.3 then
        self:spawnCoin()
      end
      
    end
  end
  
  function enemy:spawnCoin()
    local coin = require("objects/coin"):new(self.pos.x, self.pos.y)
    gameManager.collectibles:add(coin)
  end
  
  function enemy:ai(dt)
    if self.isAlive and not self.remove then
      strollTime = strollTime - 1
      self:move(dt)
      self.pos.x = self.pos.x + self.vel.x * dt
      self.pos.y = self.pos.y + self.vel.y * dt
      collisionWithPlayerBullet(self)
      self:collisionWithPlayer()
      wallCollision(self,dt)
    end
  end
  
  function enemy:move(dt)
    local x = self.pos.x + self.size.x / 2
    local y = self.pos.y + self.size.y / 2
    distCenter = {}
    distCenter.pos = require("tools/vec2"):new(x,y)
    local playerCenter = {}
    x = player.pos.x + player.size.x / 2
    y = player.pos.y + player.size.y / 2
    playerCenter.pos = require("tools/vec2"):new(x,y)
    
    local distance = floor(distance(playerCenter, distCenter) )
    if distance <= self.distanceTrigger / 2 then
      local acc = 50
      angle = atan2(player.pos.y - self.pos.y, player.pos.x - self.pos.x)
      self.vel.x = cos(angle) * (velSpeed + acc)
      self.vel.y = sin(angle) * (velSpeed + acc)
      --print("RUN FOREST RUUUUUN!")
    elseif distance <= self.distanceTrigger and distance > self.distanceTrigger / 2 then
      -- https://gamedev.stackexchange.com/questions/48119/how-do-i-calculate-how-an-object-will-move-from-one-point-to-another
      -- get angle --
      -- go to player position--
      angle = atan2(player.pos.y - self.pos.y, player.pos.x - self.pos.x)
      self.vel.x = cos(angle) * velSpeed
      self.vel.y = sin(angle) * velSpeed
      
      --print("Distance: " .. distance)
    else
      
      if strollTime <= 0 then
        self:stroll(dt)
        strollTime = rand(strollTimeSpeed[1], strollTimeSpeed[2])
      end
    end
  end
  
  function enemy:stroll(dt)
    local destx = math.random(0, mapWidth)
    local desty = math.random(0, mapHeight)
    angle = atan2(desty - self.pos.y, destx - self.pos.x)
    self.vel.x = cos(angle) * velSpeed
    self.vel.y = sin(angle) * velSpeed
    --print("x: " .. destx .. ", y: " .. desty)
  end

  
  function enemy:collisionWithPlayer()
    local result = rect_collision(self, player)
    if result then
      player:takeHit(self.damage)
    end
  end
  
  
  return enemy
end

return Enemy
