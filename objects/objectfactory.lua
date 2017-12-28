require("tools/helpers")

function demonFactory(x, y)
  local id = 'demon'
  local demon = require("objects/enemy"):new(x, y, id)
  demon.points = 100
  demon.distanceTrigger = 300
  demon.damage = 10
  demon.velSpeed = 100
  
  demon.load = function(self)
    local image = asm:get("demon")
            
    self.animation = require("tools/animation"):new(
      image,
      {
        {
          -- idle
          gameManager.animData["player_walkRight"][1]
        },
        genAnimQuads( 4, 1, 64, 64)
          --[[
        {
          -- right
        
        
          gameManager.animData["player_walkRight"][1],
          gameManager.animData["player_walkRight"][2],
          gameManager.animData["player_walkRight"][3],
          gameManager.animData["player_walkRight"][4]            
        }
        --]]
      },
      0.1
    )
    self.animation.scale = 2
    self.animation:set_animation(2)
    self.animation:play()
    
    
    
    gameManager.gameLoop:add(self)
    self.layer = 3
    self.dir.x = 0
    self.dir.y = 1
    gameManager.renderer:add(self,self.layer)
    
     -- init collision rect
    self.offset.x =19
    self.offset.y = 18
    self.rect.pos.x = 0--18
    self.rect.pos.y = 0--22
    self.rect.size.x = 28--18
    self.rect.size.y = 28
  end

  demon.cooldownSpeed = { min = 60, max = 200 }
  demon.cooldown = math.random( demon.cooldownSpeed.min, demon.cooldownSpeed.max) 
  
  demon.attack = function(self, dt)
    demon.cooldown = demon.cooldown - 1
    
    if demon.cooldown <= 0 then
      local enemyCenter = {}
      enemyCenter.pos = require("tools/vec2"):new(x,y)
      enemyCenter.pos.x = demon.pos.x + demon.size.x / 2
      enemyCenter.pos.y = demon.pos.y + demon.size.y / 2
      
    -- player center
      local playerCenter = {}
      playerCenter.pos = require("tools/vec2"):new(x,y)
      playerCenter.pos.x = player.pos.x + player.size.x / 2
      playerCenter.pos.y = player.pos.y + player.size.y / 2
    
      local bullet = require("objects/bullet"):new(enemyCenter.pos.x, enemyCenter.pos.y, 5, "enemyBullet")   
      bullet.color.second = { 255, 175, 46 }
      bullet.color.first = { 255, 70, 46 }

    
        local acc = 0
      angle = math.atan2(playerCenter.pos.y - enemyCenter.pos.y, playerCenter.pos.x - enemyCenter.pos.x)
      --angle = angle - math.pi/2
      local x = math.cos(angle)
      local y = math.sin(angle)
      
      
      gameManager.bullets:add(bullet)
      bullet.velSpeed = 450
      bullet:shoot(x,y)
      local sound = asm:get("shoot02")
      if sound:isPlaying() then
        sound:stop()
      end
      love.audio.play(sound)
      
      
      
      --[[
      local direction = require("tools/vec2"):new(0,0)
      direction.x = (playerCenter.pos.x - enemyCenter.pos.x)
      direction.y = (playerCenter.pos.y - enemyCenter.pos.y)
      direction = direction:normalize()
      bullet:shootDirection(direction)
      --]]
      
      
      demon.cooldown =  math.random( demon.cooldownSpeed.min, demon.cooldownSpeed.max) --demon.cooldownSpeed
    end
  end
  
  
  
  
  return demon
end