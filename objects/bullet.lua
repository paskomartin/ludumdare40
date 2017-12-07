local Bullet = {}
require("tools/collision")

function Bullet:new(x,y,damage,id)
  local w = 5
  local h = 5
  
  
  local bullet = require("objects/entity"):new(x,y,w,h,id)
  bullet.damage = damage
  bullet.isAlive = true
  bullet.life = 1
  local velSpeed = 650
  
  function bullet:hit(obj)
    obj.takeHit(self.damage)
    self.isAlive = false
  end
  
  function bullet:shoot(velx, vely)
    self.vel.x = velx * velSpeed
    self.vel.y = vely * velSpeed
  end
  
  function bullet:tick(dt)
    if self.vel.x == 0 and self.vel.y == 0 then goto cont end
    if self.remove then goto cont end
    
    self.pos.x = self.pos.x + self.vel.x * dt
    self:updateCollisionRect()
    -- only for drawing circles
    self.rect.pos.x = self.rect.pos.x - self.size.x / 2
    self.rect.pos.y = self.rect.pos.y - self.size.y / 2
    local result = wallCollision(self, dt)    
    if result then
      self:setDead()
    end
    
    
    self.pos.y = self.pos.y + self.vel.y * dt
    self:updateCollisionRect()
    -- only for drawing circles
    self.rect.pos.x = self.rect.pos.x - self.size.x / 2
    self.rect.pos.y = self.rect.pos.y - self.size.y / 2
    result = wallCollision(self, dt)    
    if result then
      self:setDead()
    end
    
    
    ::cont::
  end
  
  function bullet:setDead()
    self.isAlive = false
    self.remove = true
  end
  
  function bullet:draw()
    love.graphics.setColor(0, 20, 255)
    love.graphics.circle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)
    love.graphics.setColor(112, 128, 255)
    love.graphics.circle("fill", self.pos.x , self.pos.y , self.size.x - 2, self.size.y - 2)
    if debugRect then
      self:drawDebugRect()
    end

    love.graphics.setColor(255, 255, 255)
  end
  
  function bullet:load()
    gameManager.gameLoop:add(self)
    gameManager.renderer:add(self)
  end
  
  return bullet
end

return Bullet