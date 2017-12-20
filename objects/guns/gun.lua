local Gun = {}

function Gun:new()
  local gun = {}
  --local gun = require("objects/collectible"):new()
  gun.cooldownBaseSpeed = 30--10--50
  gun.cooldownMaxSpeed = 15--15
  gun.cooldownSpeed = gun.cooldownBaseSpeed --15--55--65--15
  gun.cooldown = 0
  gun.canShoot = true
  gun.damage = 0
  gun.isShot = false
  
  function update(dt) end
  function draw() end
  function shoot(dt) end
  --function pickup() end
  
  return gun
end

return Gun