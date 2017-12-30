local vec2 = require("tools/vec2")
local Valuable = {}
local quad = love.graphics.newQuad

function Valuable:new(x,y, frames, id, tileW, tileH, animSpeed, sound )
	local tile_w = tileW or 16
	local tile_h = tileH or 16
  local aSpeed = animSpeed or 0.05
	--local valuable = require("objects/entity"):new(x,y, tile_w, tile_h, "valuable")
  local valuable = require("objects/collectible"):new(x,y,tile_w, tile_h, id, true)
	valuable.isAlive = true
  valuable.canPickUp = true -- can player pick up this object?
  valuable.canUse = false   -- can we use this object? 
  valuable.value = 1
  valuable.sound = sound or asm:get("coinsound")
  
  
  valuable.idleQuad = quad(0,0, 8,8, 144, 8)
  valuable.image = asm:get(id)
  valuable.scale = 1
  valuable.animation = require("objects/animations/genericanim"):new(id .. "-anim", valuable.pos.x, valuable.pos.y, tile_w, tile_h,1, frames, aSpeed, 5, valuable.scale)
	local color = {196,146,21,255}


	function valuable:load()
    self.layer = 1
		gameManager.gameLoop:add(self)
		gameManager.renderer:add(self, self.layer)
	end	


  function valuable:tick(dt)
    self.animation:update(dt)
  end


	function valuable:draw()
		if valuable.isAlive then
      -- main
      if self.animation:isPlaying() then
        self.animation:draw(true) 
      else
        -- shadow
        love.graphics.setColor(0,0,0,128)
        love.graphics.draw(self.image, self.pos.x + 1, self.pos.y + 1, 0, self.scale, self.scale)
        love.graphics.setColor(255,255,255)
        -- main
        love.graphics.draw(self.image, self.pos.x, self.pos.y,0, self.scale, self.scale)
      end
      if debugRect then
        self:drawDebugRect()
      end
		end
	end

	function valuable:pickup(obj)
    if self.isAlive and not self.remove then
      self.isAlive = false
      self.remove = true
      obj:addCoin(self.value)
      if self.sound:isPlaying() then
        self.sound:stop()
      end
      love.audio.play(self.sound)
    end
	end


	return valuable
end


return Valuable