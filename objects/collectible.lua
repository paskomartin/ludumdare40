local Collectible = {}

function Collectible:new(x, y, w, h, id, canPickup, canUse)
	local collectible = require("objects/entity"):new(x,y,w,h,id)
	collectible.canUse = canUse or false
	collectible.canPickup = canPickup or false
	collectible.isAlive = true

	function collectible:use() end
	function collectible:pickup(obj) end

	return collectible
end

return Collectible