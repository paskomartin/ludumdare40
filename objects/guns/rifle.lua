local Rifle = {}
local Gun = require("objects/guns/gun")


function Rifle:new()
  local rifle = {}
   
  rifle = require("objects/guns/gun"):new()
  --setmetatable(rifle, Gun)
  --rifle.__init = Gun
  rifle.cooldownBaseSpeed = 25
  rifle.cooldown = 0
  rifle.cooldownSpeed = rifle.cooldownBaseSpeed
  rifle.cooldownMaxSpeed = 8
  rifle.damage = 10
  rifle.image = asm:get("rifle")
  
  function rifle:update(self, dt)
    
  end
  
  function rifle:draw()
  end
  
  function rifle:shoot(dt)
    if self.cooldown <= 0  then 
      
      local x = player.dir.x
      local y = player.dir.y
      if keys.reverseShoot.pressed then
          x = x * -1
          y = y * -1
      end
      
      local posx, posy = player:genBulletPosition()
      

      local bullet = require("objects/bullet"):new(posx, posy, 5, "playerBullet")   
      gameManager.bullets:add(bullet)
      
      bullet:shoot(x,y)
      local sound = asm:get("laserriflesound")
      if sound:isPlaying() then
        sound:stop()
      end
      love.audio.play(sound)
      
      keys.action.pressed = false
     
      isShoot = false
      self.canShoot = false
      self.cooldown = self.cooldownSpeed
    end    
  end  
    
    
  return rifle
end
  
return Rifle