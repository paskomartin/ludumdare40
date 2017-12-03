local Enemy = {}

require("tools/collision")
require("tools/keys")
require("tools/helpers")
vec2 = require("tools/vec2")
local floor = math.floor
local atan2 = math.atan2
local sin = math.sin
local cos = math.cos

function Enemy:new(x,y, id)
  assert(type(id) == "string")
  local tile_w = 32
  local tile_h = 32
  local enemy = require("objects/entity"):new(x, y, tile_w, tile_h, id)
  local color = { 201,20,72,255}
  enemy.life = 1
  local velSpeed = 150
  local cooldownSpeed = 5
  local cooldown = 0
  local isShoot = false
  enemy.isAlive = true
  enemy.distanceTrigger = 300
  --enemy.function = nil
    
  local mapWidth = tlm.mapwidth * tlm.tilewidth
  local mapHeight = tlm.mapheight * tlm.tileheight
  local stollTimeSpeed = 50
  local strollTime = 0
  
  function enemy:init()
      gameManager.gameLoop:add(self)
      self.layer = 1
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
    end
  end
  
  function enemy:ai(dt)
    if self.isAlive and not self.remove then
      strollTime = strollTime - 1
      self:move(dt)
      self.pos.x = self.pos.x + self.vel.x * dt
      self.pos.y = self.pos.y + self.vel.y * dt
      collisionWithPlayerBullet(self)
      wallCollision(self,dt)
    end
  end
  
  function enemy:move(dt)
    local distance = floor(distance(player, self) )
    if distance <= self.distanceTrigger / 2 then
      local acc = 50
      angle = atan2(player.pos.y - self.pos.y, player.pos.x - self.pos.x)
      self.vel.x = cos(angle) * (velSpeed + acc)
      self.vel.y = sin(angle) * (velSpeed + acc)
      --print("RUN FOREST RUUUUUN!")
    elseif distance <= self.distanceTrigger then
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
        strollTime = stollTimeSpeed
      end
    end
  end
  
  function enemy:stroll(dt)
    local destx = math.random(0, mapWidth)
    local desty = math.random(0, mapHeight)
    angle = atan2(player.pos.y - self.pos.y, player.pos.x - self.pos.x)
    self.vel.x = cos(angle) * velSpeed
    self.vel.y = sin(angle) * velSpeed
  end

  return enemy
end

return Enemy