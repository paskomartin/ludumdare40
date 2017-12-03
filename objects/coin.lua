local vec2 = require("tools/vec2")
local Coin = {}

function Coin:new(x,y)
	local tile_w = 16
	local tile_h = 16

	--local coin = require("objects/entity"):new(x,y, tile_w, tile_h, "coin")
  local coin = require("objects/collectible"):new(x,y,tile_w, tile_h, "coin", true)
	coin.isAlive = true
  coin.canPickUp = true -- can player pick up this object?
  coin.canUse = false   -- can we use this object? 
  coin.value = 1
  
	local color = {196,146,21,255}

	function coin:init()
		-- add coin quad here --
    self.layer = 1
		gameManager.gameLoop:add(self)
		gameManager.renderer:add(self, self.layer)
	end	

	function coin:draw()
		if coin.isAlive then
			love.graphics.setColor(color)
			love.graphics.circle("fill", self.pos.x, self.pos.y, 8, 8)
      love.graphics.setColor(255,255,255)
		end
	end

	function coin:pickup(obj)
    if self.isAlive and not self.remove then
      self.isAlive = false
      self.remove = true
      obj:addCoin(self.value)
      print("coin is picked up") 
    end
	end


	return coin
end

	


return Coin