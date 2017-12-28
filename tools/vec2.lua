local Vec2 = {}

function Vec2:new( x, y )
	local vec2 = {}

	vec2.x = x or 0
	vec2.y = y or 0
	--vec2.h = vec2.x
	---vec2.w = vec2.y

	function vec2:move(nx, ny, dt)
		local deltaTime = dt or 1
		self.x = self.x + nx * deltaTime
		self.y = self.y + ny * deltaTime
	end

  function vec2:length()
    return math.sqrt(self.x ^2 + self.y^2)
  end
  
  function vec2:normalize()
    local x = 0
    local y = 0
    local vecLen = self:length()
    if self.x ~= 0 then
      x = 1.0 / vecLen --math.abs(self.x)
    end
    if self.y ~= 0 then
      y = 1.0 / vecLen --math.abs(self.y)
    end
    return Vec2:new(x, y)
  end

	return vec2
end

return Vec2