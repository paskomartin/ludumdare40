local Shotgun = {}
local Gun = require("objects/guns/gun")
local sin = math.sin
local cos = math.cos

function Shotgun:new()
  local shotgun = {}
  shotgun = require("objects/guns/gun"):new() --0,0,32,32,"shotgun", true, true)
  
  --setmetatable(shotgun, Gun)
  --shotgun.__init = Gun
  shotgun.cooldownBaseSpeed = 60
  shotgun.cooldown = 0
  shotgun.cooldownSpeed = shotgun.cooldownBaseSpeed
  shotgun.cooldownMaxSpeed = 40
  shotgun.damage = 20
  shotgun.colors = {}
  shotgun.colors.first = { 102, 0, 51 }
  shotgun.colors.second = { 204, 102, 153 }
  
  function shotgun:update(self, dt)
    
  end
  
  function shotgun:draw()
    
  end
  
  function shotgun:shoot(dt)
    if self.cooldown <= 0  then 
      
      local x = player.dir.x
      local y = player.dir.y
      local posx, posy = player:genBulletPosition()
      local angle = math.deg(7)

      local reversed = keys.reverseShoot.pressed
      if reversed then
        x = x * -1
        y = y * -1
      end

      local bullet = require("objects/bullet"):new(posx, posy, 5, "playerBullet")   
      --bullet:setColor( {102, 51, 0}, {153, 102, 51} ) 
      bullet:setColor(self.colors.first, self.colors.second)
      gameManager.playerBullets:add(bullet)
      bullet:shoot(x,y)
      
      self:generateBullets(posx,posy)
      
      --[[
      
      x = cos( math.rad(angle) ) * player.dir.x
      y = sin( math.rad(angle) ) * player.dir.y
            
      bullet = require("objects/bullet"):new(posx, posy, 5, "playerBullet")   
      gameManager.playerBullets:add(bullet)
      bullet:shoot(x,y)
      --]]
      
      
      --[[
      x = cos( math.rad(-angle) )
      y = sin( math.rad(-angle) )
      
      bullet = require("objects/bullet"):new(posx, posy, 5, "playerBullet")   
      gameManager.playerBullets:add(bullet)
      bullet:shoot(x,y)
      --]]
      local sound = asm:get("shotgunsound")
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
    
  function shotgun:generateBullets(posx,posy)       
    local reversed = keys.reverseShoot.pressed
    if reversed then
      self:reversedShoot(posx, posy)
    else
      self:normalShoot(posx, posy)
    end

  end
    
  function shotgun:createBullet(posx, posy, angle)
      x = cos( math.rad(angle) )
      y = sin( math.rad(angle) )
      
      bullet = require("objects/bullet"):new(posx, posy, 5, "playerBullet")   
      --bullet:setColor( {102, 51, 0}, {153, 102, 51} ) 
      bullet:setColor(self.colors.first, self.colors.second)
      
      
      gameManager.playerBullets:add(bullet)
      bullet:shoot(x,y)
  end
  
  function shotgun:normalShoot(posx, posy)
    local xdir = player.dir.x
    local ydir = player.dir.y
    local angle = 0
    local result = {}
    
    local fullAngle = 360
    local startAngle = 0
    local baseAngle = 10
    local posOffset = 15
    
    -- turn right 
    if xdir == 1 and ydir == 0 then
      --baseAngle = 5
      angle = baseAngle
      shotgun:createBullet(posx - posOffset, posy, angle)
      angle = fullAngle - baseAngle
      shotgun:createBullet(posx - posOffset, posy, angle)
      -- halfs
      angle = baseAngle / 2
      shotgun:createBullet(posx - posOffset * 2, posy, angle)
      angle = fullAngle - angle
      shotgun:createBullet(posx - posOffset * 2, posy, angle)
      -- turn left
    elseif xdir == -1 and ydir == 0 then
      startAngle = 180
      angle = baseAngle + startAngle
      shotgun:createBullet(posx + posOffset, posy, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx + posOffset, posy, angle)
      -- halfs
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx + posOffset * 2, posy, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx + posOffset * 2, posy, angle)
      -- turn up
    elseif xdir == 0 and ydir == -1 then
      startAngle = 270
      angle = baseAngle + startAngle
      shotgun:createBullet(posx, posy + posOffset, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx, posy + posOffset, angle)
      -- halfs
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx, posy + posOffset * 2, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx, posy + posOffset * 2, angle)
    -- turn down
    elseif xdir == 0 and ydir == 1 then
      startAngle = 90
      angle = baseAngle + startAngle
      shotgun:createBullet(posx, posy - posOffset, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx, posy - posOffset, angle)
      -- halfs
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx, posy - posOffset * 2, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx, posy - posOffset * 2, angle)      
    -- turn up-right
    elseif xdir == 1 and ydir == -1 then
      startAngle = fullAngle - 45 
      angle = baseAngle + startAngle
      shotgun:createBullet(posx - posOffset, posy + posOffset, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx - posOffset, posy + posOffset, angle)
      --halfs
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx - posOffset * 2, posy + posOffset * 2, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx - posOffset * 2, posy + posOffset * 2, angle)      
    -- turn down-right
    elseif xdir == 1 and ydir == 1 then
      startAngle = 45 
      angle = baseAngle + startAngle
      shotgun:createBullet(posx, posy, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx, posy, angle)
      --halfs
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx, posy, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx, posy, angle)
    -- turn up-left
    elseif xdir == -1 and ydir == -1 then
      startAngle = 270 - 45 
      angle = baseAngle + startAngle
      shotgun:createBullet(posx + posOffset, posy + posOffset, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx + posOffset, posy + posOffset, angle)
      --halfs
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx + posOffset * 2, posy + posOffset * 2, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx + posOffset * 2, posy + posOffset * 2, angle)
    -- turn down-left
    elseif xdir == -1 and ydir == 1 then
      --posx = posx + posOffset * 2 + 10
      startAngle = 90 + 45 
      angle = baseAngle + startAngle
      shotgun:createBullet(posx - posOffset , posy + posOffset, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx - posOffset , posy + posOffset, angle)
      --halfs
      ---[[
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx - posOffset / 2 , posy + posOffset / 2, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx - posOffset / 2  , posy + posOffset / 2, angle)
      --]]
    end
    
  end
  
  function shotgun:reversedShoot(posx, posy)
    local xdir = player.dir.x * -1
    local ydir = player.dir.y * -1
    local angle = 0
    local result = {}
    
    local fullAngle = 360
    local startAngle = 0
    local baseAngle = 10
    local posOffset = 15
    
    -- turn right 
    if xdir == 1 and ydir == 0 then
      --baseAngle = 5
      angle = baseAngle
      shotgun:createBullet(posx - posOffset, posy, angle)
      angle = fullAngle - baseAngle
      shotgun:createBullet(posx - posOffset, posy, angle)
      -- halfs
      angle = baseAngle / 2
      shotgun:createBullet(posx - posOffset * 2, posy, angle)
      angle = fullAngle - angle
      shotgun:createBullet(posx - posOffset * 2, posy, angle)
      -- turn left
    elseif xdir == -1 and ydir == 0 then
      startAngle = 180
      angle = baseAngle + startAngle
      shotgun:createBullet(posx + posOffset, posy, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx + posOffset, posy, angle)
      -- halfs
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx + posOffset * 2, posy, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx + posOffset * 2, posy, angle)
      -- turn up
    elseif xdir == 0 and ydir == -1 then
      startAngle = 270
      angle = baseAngle + startAngle
      shotgun:createBullet(posx, posy + posOffset, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx, posy + posOffset, angle)
      -- halfs
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx, posy + posOffset * 2, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx, posy + posOffset * 2, angle)
    -- turn down
    elseif xdir == 0 and ydir == 1 then
      startAngle = 90
      angle = baseAngle + startAngle
      shotgun:createBullet(posx, posy - posOffset, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx, posy - posOffset, angle)
      -- halfs
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx, posy - posOffset * 2, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx, posy - posOffset * 2, angle)      
    -- turn up-right
    elseif xdir == 1 and ydir == -1 then
      startAngle = fullAngle - 45 
      angle = baseAngle + startAngle
      shotgun:createBullet(posx - posOffset, posy + posOffset, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx - posOffset, posy + posOffset, angle)
      --halfs
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx - posOffset * 2, posy + posOffset * 2, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx - posOffset * 2, posy + posOffset * 2, angle)      
    -- turn down-right
    elseif xdir == 1 and ydir == 1 then
      startAngle = 45 
      angle = baseAngle + startAngle
      shotgun:createBullet(posx, posy, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx, posy, angle)
      --halfs
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx, posy, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx, posy, angle)
    -- turn up-left
    elseif xdir == -1 and ydir == -1 then
      startAngle = 270 - 45 
      angle = baseAngle + startAngle
      shotgun:createBullet(posx + posOffset, posy + posOffset, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx + posOffset, posy + posOffset, angle)
      --halfs
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx + posOffset * 2, posy + posOffset * 2, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx + posOffset * 2, posy + posOffset * 2, angle)
    -- turn down-left
    elseif xdir == -1 and ydir == 1 then
      --posx = posx + posOffset * 2 + 10
      startAngle = 90 + 45 
      angle = baseAngle + startAngle
      shotgun:createBullet(posx - posOffset , posy + posOffset, angle)
      angle = startAngle - baseAngle
      shotgun:createBullet(posx - posOffset , posy + posOffset, angle)
      --halfs
      ---[[
      angle = (baseAngle / 2) + startAngle
      shotgun:createBullet(posx - posOffset / 2 , posy + posOffset / 2, angle)
      angle = startAngle - (baseAngle / 2)
      shotgun:createBullet(posx - posOffset / 2  , posy + posOffset / 2, angle)
      --]]
    end
    
  end
  
  
  return shotgun
end
  
  
return Shotgun
