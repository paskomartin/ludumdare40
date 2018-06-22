local Collectible = {}

function Collectible:new(x, y, w, h, id, canPickup, canUse)
	local collectible = require("objects/entity"):new(x,y,w,h,id)
	collectible.canUse = canUse or false
	collectible.canPickup = canPickup or false
	collectible.isAlive = true
  collectible.remove = false


  collectible.maxLifeTime = 10--15
  --collectible.blinkThreshold = 200
  collectible.currentLifeTime = 0
  collectible.blink = require("tools/blink"):new(30)

	function collectible:use() end
	function collectible:pickup(obj) end
    

  function collectible:updateLifeTime(dt)
    if self.currentLifeTime < self.maxLifeTime then
      self.currentLifeTime = self.currentLifeTime + dt
      if self.currentLifeTime >= self.maxLifeTime then
        self.blink:start()
      end
    end
  end

  function collectible:isTimeToDestroy()
    if self.isAlive and not self.remove and not self.blink:isActive() and self.currentLifeTime >= self.maxLifeTime then
      self:destroy()
    end
  end

  function collectible:destroy()
    self.isAlive = false
    self.remove = true
  end

	return collectible
end

return Collectible