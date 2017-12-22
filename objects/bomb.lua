local vec2 = require("tools/vec2")

local Bomb = {}

function Bomb:new(x,y)
	local tile_w = 32
	local tile_h = 32

	--local coin = require("objects/entity"):new(x,y, tile_w, tile_h, "coin")
  local bomb = require("objects/collectible"):new(x,y,tile_w, tile_h, "bomb", true)
	bomb.isAlive = true
  bomb.canPickUp = true -- can player pick up this object?
  bomb.canUse = false   -- can we use this object? 
  bomb.value = 20
  bomb.image = asm:get("bomb")
  
	local color = {196,146,21,255}

	function bomb:load()
    self.layer = 2
		gameManager.gameLoop:add(self)
		gameManager.renderer:add(self, self.layer)
	end	

	function bomb:draw()
		if bomb.isAlive then
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

	function bomb:pickup(obj)
    if self.isAlive and not self.remove then
      self.isAlive = false
      self.remove = true

      self:hitEnemies()
      self:resetSpawners()
      local sound = asm:get("explosionsound")
      if sound:isPlaying() then
        sound:stop()
      end
      love.audio.play(sound)

    end
	end

  function bomb:hitEnemies()
    for _, enemy in pairs(gameManager.enemies.objects) do
      local x = enemy.pos.x
      local y = enemy.pos.y
      
      local explosion = require("objects/animations/explosion"):new(x,y)
      explosion:load()
      enemy:takeHit(self.value)
      
    end
  end


  function bomb:resetSpawners()
    for _,spawner in pairs(gameManager.spawners.objects) do
      spawner:setCurrentTime( (math.random(0, 5) * -1) )
    end
  end

	return bomb
end



return Bomb