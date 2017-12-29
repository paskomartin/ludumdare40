local Pistol = {}
local Gun = require("objects/guns/gun")


function Pistol:new()
  local pistol = {}
   
  pistol = require("objects/guns/gun"):new()
  --setmetatable(pistol, Gun)
  --pistol.__init = Gun
  pistol.cooldownBaseSpeed = 40
  pistol.cooldown = 0
  pistol.cooldownSpeed = pistol.cooldownBaseSpeed
  pistol.cooldownMaxSpeed = 25
  pistol.damage = 7
  pistol.image = asm:get("pistol")
  
  function pistol:update(self, dt)
    
  end
  
  function pistol:draw()
  end
  
  function pistol:shoot(dt)
    if self.cooldown <= 0  then 
      
      local x = player.dir.x
      local y = player.dir.y
      if keys.reverseShoot.pressed then
          x = x * -1
          y = y * -1
      end
      
      local posx, posy = player:genBulletPosition()
      

      local bullet = require("objects/bullet"):new(posx, posy, 5, "playerBullet")   
      bullet.color.second = { 255, 175, 46 }
      bullet.color.first = { 255, 70, 46 }

      gameManager.bullets:add(bullet)
      
      bullet:shoot(x,y)
      local sound = asm:get("gunsound")
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
    
    
  return pistol
end
  
return Pistol

