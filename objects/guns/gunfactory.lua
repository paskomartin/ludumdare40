local vec2 = require("tools/vec2")
local Gunfactory = {}

function Gunfactory:new(x,y, gunID)
	local tile_w = 32
	local tile_h = 32

  assert(type(gunID) == "string" )
  --local ids = { "rifle", "shotgun" } -- , "pistol" } -- pistol in future
	--local gunfactory = require("objects/entity"):new(x,y, tile_w, tile_h, "gunfactory")
  local gunfactory = require("objects/collectible"):new(x,y,tile_w, tile_h, "gunfactory", true)
	gunfactory.isAlive = true
  gunfactory.canPickUp = true -- can player pick up this object?
  gunfactory.canUse = false   -- can we use this object? 
  gunfactory.value = 1
  gunfactory.id = gunID
  gunfactory.image = asm:get(gunfactory.id)
  
	local color = {196,146,21,255}

	function gunfactory:load()
		-- add gunfactory quad here --
    self.layer = 1
		gameManager.gameLoop:add(self)
		gameManager.renderer:add(self, self.layer)
    
    --self.maxLifeTime = 45
    
    if self.id == "shotgun" then
      self.rect.pos.y = self.pos.y + 11
      self.rect.size.y = 9
      self.animation = require("objects/animations/genericanim"):new("shotgun anim", self.pos.x, self.pos.y, tile_w, tile_h,1, 18, 0.02, 5)
    elseif self.id == "rifle" then
      self.rect.pos.y = self.pos.y + 10
      self.rect.size.y = 11
      self.animation = require("objects/animations/genericanim"):new("rifle anim", self.pos.x, self.pos.y, tile_w, tile_h,1, 20, 0.02, 5)
    elseif self.id == "pistol" then
      self.rect.pos.y = self.pos.y + 11
      self.rect.pos.x = self.pos.x + 8
      self.rect.size.y = 8
      self.rect.size.x = 15
      self.animation = require("objects/animations/genericanim"):new("gun anim", self.pos.x, self.pos.y, tile_w, tile_h,1, 15, 0.02, 5)
    end
    
	end	
  
  function gunfactory:tick(dt)
    self.animation:update(dt)
    self:updateLifeTime(dt)
    self.blink:update(dt)
    self:isTimeToDestroy()     
  end

	function gunfactory:draw()
		if gunfactory.isAlive then
      if self.blink:isBlinking() then
        goto skip_draw
      end        
			--love.graphics.setColor(color)
			--love.graphics.circle("fill", self.pos.x, self.pos.y, 8, 8)
      -- shadow
      love.graphics.setColor(0,0,0,128)
      love.graphics.draw(self.image, self.pos.x+1, self.pos.y +1,0,1, 1)
      love.graphics.setColor(255,255,255)
      -- main
      if self.animation:isPlaying() then
        self.animation:draw()
      else
        love.graphics.draw(self.image, self.pos.x, self.pos.y,0,1, 1)
      end
      --love.graphics.setColor(255,255,255)
      if debugRect then
        self:drawDebugRect()
      end
      ::skip_draw::
		end
	end

	function gunfactory:pickup(obj)
    if self.isAlive and not self.remove then
      self.isAlive = false
      self.remove = true
      --obj:addgunfactory(self.value)
      love.audio.play(asm:get("pickupsound"))
      --print("gunfactory is picked up") 
      self:createGun()
    end
	end

  function gunfactory:createGun()
    if self.id == "shotgun" then
      player.gun = require("objects/guns/shotgun"):new()
      -- todo: put gui update here
    elseif self.id == "rifle" then
      player.gun = require("objects/guns/rifle"):new()
    elseif self.id == "pistol" then
      player.gun = require("objects/guns/pistol"):new()
    end
  end


	return gunfactory
end

	


return Gunfactory

