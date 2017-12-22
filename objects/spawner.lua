local Spawner = {}
local floor = math.floor

function Spawner:new(x,y)
  local w = 32
  local h = 32
  local spawner = require("objects/entity"):new(x,y,h,w, "spawner")
  spawner.currentTime = 0
  spawner.lastTime = 0
  spawner.spawnTime = 1--3
  spawner.canSpawn = true
  spawner.isAlive = true
  -- animation
  local image = asm:get("portal")
  local animSpeed = 0.08
  spawner.animation = require("tools/animation"):new(image, { genAnimQuads(6, 1, w, h) }, animSpeed)
  spawner.animation.currentFrame = math.random(1, 6)
  spawner.animation:set_animation(1)
  love.timer.sleep(0.04)
  spawner.animation:play()
  local color = { 134, 53, 56,255 }

  function spawner:load()
    gameManager.gameLoop:add(self)
    gameManager.renderer:add(self,1)
    self.currentTime = floor(love.timer.getTime())
    self.lastTime = self.currentTime
  end

  function spawner:tick(dt)
    self.animation:update(dt)
    self:spawn(dt)
  end
  
  function spawner:draw()
    self.animation:draw( {self.pos.x, self.pos.y} ) 
    if debugRect then
      love.graphics.setColor(color)
      love.graphics.rectangle("line", self.pos.x, self.pos.y, self.size.x, self.size.y)
      love.graphics.setColor(255,255,255)
    end
  end
  
  function spawner:spawn(dt)
    if self.isAlive and not self.remove then
      self.currentTime = self.currentTime + dt
      --self.currentTime = floor(love.timer.getTime())
      if gameManager.enemyCounter < gameManager.maxEnemy then
        
        if self.currentTime >= self.spawnTime then
        --if (self.currentTime - self.lastTime) >= self.spawnTime then
          self:spawnEnemy("enemy")
          self.currentTime = 0
         -- self.lastTime = self.currentTime
        end
      end
    end
  end
  
  
  function spawner:spawnEnemy(id)
    local enemy = require("objects/enemy"):new(self.pos.x, self.pos.y, id)
    gameManager.enemies:add(enemy)
    gameManager:increaseEnemy()
  end
  
  function spawner:setCurrentTime(time)
    self.currentTime = time
  end
  
  return spawner
end

return Spawner