--[[
	a = {
		{quads}, --walk
		{quads}, -- idle
	}
]]

local gfx = love.graphics

local push = love.graphics.push
local pop = love.graphics.pop
local rotate = love.graphics.rotate
local translate = love.graphics.translate
local scale = love.graphics.scale

return{
	new = function(self,image,animation,time,once)
	return{
		current_frame = 1,
		current_anim  = 1,
		image 		  = image,
		a 			  = animation,  -- quads table
		play		  = false,
    playOnce  = once or false,
    scale     = 1,
		time          = time or 0.2,
		counter		  = 0,

		update = function(self,dt)
			if self.play then
				self.counter = self.counter + dt
				if self.counter >= self.time then
					self.counter = 0
					self.current_frame = self.current_frame + 1
				end
				if self.current_frame > #self.a[self.current_anim] then
          if not self.playOnce then
            self.current_frame = 1
          else
            self:stop()
          end
				end
			else

			end
		end,
    -- [[ DEPRICATED ]] -- FIX: change dependencies
		play   = function(self)
			self.play = true
		end,
		stop   = function(self)
			self.play = false
		end,
    
    start   = function(self)
			self.play = true
      self.current_frame = 1
		end,

		set_animation = function(self,anim)
			if anim > #self.a then error("there is no animation: "..anim); return end
			self.current_anim = anim
		end,
  
    set_image = function(self, image)
      self.image = image
    end,

		draw = function(self,data, orientation, shadow) -- orientation, shadow)
      local angle = orientation or 0
      --local orient = orientation or 0
      
      local sh = shadow or false
      if sh then
        love.graphics.setColor(0,0,0,128)
        gfx.draw(self.image,self.a[self.current_anim][self.current_frame],data[1] + 1,data[2] + 1, angle, self.scale)
        love.graphics.setColor(255,255,255)
      end
      

			gfx.draw(self.image,self.a[self.current_anim][self.current_frame],data[1],data[2], angle, self.scale)

      --[[
      push()
      translate( worldWidth / 2, worldHeigth / 2)
      rotate(angle)
      translate( -worldWidth / 2, -worldHeigth / 2)
      -- scale(1,1)
      gfx.draw(self.image,self.a[self.current_anim][self.current_frame],data[1],data[2])
            
      pop()
      ]]
      --gfx.draw(self.image,self.a[self.current_anim][self.current_frame],data[1],data[2], orient,1 ,1, 0,0)
      
		end,	
    
    draw4 = function(self, data, ang)
      local img = self.image
      local quad = self.a[self.current_anim][self.current_frame]
      local originX = data[3] / 2
      local originY = data[4] / 2
      local x = data[1] + originX
      local y = data[2] + originY
      local angle = ang or 0
      local scaleX = 1
      local scaleY = 1
      gfx.draw(img, quad, x, y, angle, scaleX, scaleY, originX, originY)
    end,
    
    draw3 = function(self, pos, orientation)
      local angle = orientation or 0
      --local orient = orientation or 0
			--gfx.draw(self.image,self.a[self.current_anim][self.current_frame],data[1],data[2], orient)
      
      print("before: tr x=", pos[1], ", y=", pos[2])
      push()
      translate( -pos[1], -pos[2])
      rotate(angle)
      translate( pos[1], pos[2])
      --scale(1,1)
      print("after: tr x=", pos[1], ", y=", pos[2])
      gfx.draw(self.image,self.a[self.current_anim][self.current_frame],pos[1],pos[2])
            
      pop()
    end,
    
    draw2 = function(self, pos, angle)
      
      --gfx.draw(self.image,self.a[self.current_anim][self.current_frame],pos[1],pos[2], angle,1 ,1, pos[1] + pos[3] /2, pos[2] + pos[4] / 2)
      gfx.draw(self.image,self.a[self.current_anim][self.current_frame],pos[1],pos[2], angle,1 ,1, pos[3], pos[4])--, 400, 300)
    end,

	}
	end,
}