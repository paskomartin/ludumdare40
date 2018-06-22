local vec2 = require("tools/vec2")
local Coin = {}
local quad = love.graphics.newQuad

function Coin:new(x,y)
	local tile_w = 8--16
	local tile_h = 8--16

	--local coin = require("objects/entity"):new(x,y, tile_w, tile_h, "coin")
  local coin = require("objects/collectible"):new(x,y,tile_w, tile_h, "coin", true)
	coin.isAlive = true
  coin.canPickUp = true -- can player pick up this object?
  coin.canUse = false   -- can we use this object? 
  coin.value = 1
  -- animation
  local val = math.random(0, 2) % 2
  local subname = ""
  if val == 0 then
    subname = "gold"
  else
    subname = "silver"
  end
  coin.idleQuad = quad(0,0, 8,8, 144, 8)
  coin.image = asm:get("coin2 " .. subname )
  coin.scale = 1.5
  coin.animation = require("objects/animations/genericanim"):new("coin2 " .. subname, coin.pos.x, coin.pos.y, tile_w, tile_h,1, 18, 0.05, 5, coin.scale)
	local color = {196,146,21,255}


	function coin:load()
    --self.maxLifeTime = 15
    --self.blink.blinkTime = 30
		-- add coin quad here --
    self.layer = 1
		gameManager.gameLoop:add(self)
		gameManager.renderer:add(self, self.layer)
	end	


  function coin:tick(dt)
    self.animation:update(dt)
    self:updateLifeTime(dt)
    self.blink:update(dt)
    self:isTimeToDestroy()
  end



	function coin:draw()
		if self.isAlive then
      if self.blink:isBlinking() then
        goto skip_draw
      end
			--love.graphics.setColor(color)
			--love.graphics.circle("fill", self.pos.x, self.pos.y, 8, 8)
      --[[ --
      -- shadow
      love.graphics.setColor(0,0,0,128)
      love.graphics.draw(self.image, self.idleQuad, self.pos.x+1, self.pos.y +1,0,1.5, self.scale)
      love.graphics.setColor(255,255,255)
      --]]
      -- main
      if self.animation:isPlaying() then
      --  self.animation:draw( {self.pos.x, self.pos.y} ) 
        self.animation:draw(true) 
      else
        -- shadow
        love.graphics.setColor(0,0,0,128)
        love.graphics.draw(self.image, self.idleQuad, self.pos.x+1, self.pos.y +1,0,1.5, self.scale)
        love.graphics.setColor(255,255,255)
        -- main
        love.graphics.draw(self.image, self.idleQuad, self.pos.x, self.pos.y,0,1.5, self.scale)
      end
      --love.graphics.setColor(255,255,255)
      if debugRect then
        self:drawDebugRect()
      end
      ::skip_draw::
		end
	end

	function coin:pickup(obj)
    if self.isAlive and not self.remove then
      self.isAlive = false
      self.remove = true
      obj:addCoin(self.value)
      obj:addPoints(self.value * 100)
      local sound = asm:get("coinsound")
      if sound:isPlaying() then
        sound:stop()
      end
      --love.audio.play(asm:get("coinsound"))
      love.audio.play(sound)
      --print("coin is picked up") 
    end
	end


	return coin
end

	


return Coin