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

	return vec2
end

return Vec2