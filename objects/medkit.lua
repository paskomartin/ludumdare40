local vec2 = require("tools/vec2")

local Medkit = {}

function Medkit:new(x,y)
	local tile_w = 32
	local tile_h = 32

	--local coin = require("objects/entity"):new(x,y, tile_w, tile_h, "coin")
  local medkit = require("objects/collectible"):new(x,y,tile_w, tile_h, "medkit", true)
	medkit.isAlive = true
  medkit.canPickUp = true -- can player pick up this object?
  medkit.canUse = false   -- can we use this object? 
  medkit.value = 1
  medkit.image = asm:get("medkit")
  
	local color = {196,146,21,255}

	function medkit:load()
    self.layer = 2
		gameManager.gameLoop:add(self)
		gameManager.renderer:add(self, self.layer)
	end	

	function medkit:draw()
		if medkit.isAlive then
      -- shadow
      love.graphics.setColor(0,0,0,128)
      love.graphics.draw(self.image, self.pos.x+1, self.pos.y +1,0,1, 1)
      love.graphics.setColor(255,255,255)
      -- main
      love.graphics.draw(self.image, self.pos.x, self.pos.y,0,1, 1)
      if debugRect then
        self:drawDebugRect()
      end
		end
	end

	function medkit:pickup(obj)
    if self.isAlive and not self.remove then
      self.isAlive = false
      self.remove = true
      obj:addLife(self.value)
      --love.audio.play(asm:get("pickupsound"))
    end
	end


	return medkit
end



return Medkit