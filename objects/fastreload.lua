local vec2 = require("tools/vec2")
local FastReload = {}

function FastReload:new(x,y)
	local tile_w = 16
	local tile_h = 16

	--local fastReload = require("objects/entity"):new(x,y, tile_w, tile_h, "fastReload")
  local fastReload = require("objects/collectible"):new(x,y,tile_w, tile_h, "fastreload", true)
	fastReload.isAlive = true
  fastReload.canPickUp = true -- can player pick up this object?
  fastReload.canUse = false   -- can we use this object? 
  fastReload.value = 1
  fastReload.image = asm:get("fastreload")
  
	local color = {196,146,21,255}

	function fastReload:load()
		-- add fastReload quad here --
    self.layer = 1
		gameManager.gameLoop:add(self)
		gameManager.renderer:add(self, self.layer)
	end	

	function fastReload:draw()
		if fastReload.isAlive then
			--love.graphics.setColor(color)
			--love.graphics.circle("fill", self.pos.x, self.pos.y, 8, 8)
      -- shadow
      love.graphics.setColor(0,0,0,128)
      love.graphics.draw(self.image, self.pos.x+1, self.pos.y +1,0,1, 1)
      love.graphics.setColor(255,255,255)
      -- main
      love.graphics.draw(self.image, self.pos.x, self.pos.y,0,1, 1)
      --love.graphics.setColor(255,255,255)
      if debugRect then
        self:drawDebugRect()
      end
		end
	end

	function fastReload:pickup(obj)
    if self.isAlive and not self.remove then
      self.isAlive = false
      self.remove = true
      player.gun.cooldownSpeed = player.gun.cooldownMaxSpeed
      love.audio.play(asm:get("pickupsound02"))
      --print("fastReload is picked up") 
    end
	end


	return fastReload
end

	


return FastReload
