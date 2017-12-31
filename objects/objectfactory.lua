require("tools/helpers")

function demonFactory(x, y)
  local id = 'demon'
  local demon = require("objects/enemy"):new(x, y, id)
  demon.points = 100
  demon.distanceTrigger = 300
  demon.damage = 10
  demon.velSpeed = 65
  demon.value = 150
  
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

  demon.cooldownSpeed = { min = 70, max = 450 }
  demon.cooldown = math.random( demon.cooldownSpeed.min, demon.cooldownSpeed.max) 
  
  demon.spawnCoin = function(self)
    local result = math.random()-- % 20
    local valuable = nil
    if result <= 0.03 then
      valuable = valuableFactory(demon.rect.pos.x, demon.rect.pos.y, "chest2")
      player.points = player.points + 5000
    elseif result <= 0.15 then
      valuable = valuableFactory(demon.rect.pos.x, demon.rect.pos.y, "diamond")    
      player.points = player.points + 2000
    elseif result <= 0.27 then
      valuable = valuableFactory(demon.rect.pos.x, demon.rect.pos.y, "ruby")
      player.points = player.points + 500
    elseif result <= 0.45 then
      valuable = valuableFactory(demon.rect.pos.x, demon.rect.pos.y, "emerald")  
      player.points = player.points + 250
    else
      valuable = require("objects/coin"):new(demon.rect.pos.x, demon.rect.pos.y)
    end
    
    gameManager.collectibles:add(valuable)
  end
  
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


function valuableFactory(x, y, id)
  assert(type(id) == "string")
  if id == "ruby" then
    return genRuby(x,y)
  elseif id == "diamond" then
    return genDiamond(x,y)
  elseif id == "emerald" then
    return genEmerald(x,y)
  elseif id == "chest2" then
    return genChest(x, y)
  end
  
end


function genRuby(x, y)
  local tileSize = 16
  local animSpeed = 0.05
  local frames = 14
  local sound = asm:get("gem3sound")
  local gem = require("objects/valuable"):new(x,y, frames, "ruby", tileSize, tileSize, animSpeed, sound )
  gem.value = 3
  
  return gem  
end


function genDiamond(x,y)
  local tileSize = 16
  local animSpeed = 0.05
  local frames = 11
  local sound = asm:get("gem2sound")
  local gem = require("objects/valuable"):new(x,y, frames, "diamond", tileSize, tileSize, animSpeed, sound )
  gem.value = 4
  return gem  
end



function genEmerald(x,y)
  local tileSize = 16
  local animSpeed = 0.05
  local frames = 11
  local sound = asm:get("gem1sound")
  local gem = require("objects/valuable"):new(x,y, frames, "emerald", tileSize, tileSize, animSpeed, sound )
  gem.value = 2
  return gem
end


function genChest(x,y)
  local tileSize = 32
  local animSpeed = 0.04
  local frames = 28
  local sound = asm:get("chestsound")
  local chest = require("objects/valuable"):new(x,y, frames, "chest2", tileSize, tileSize, animSpeed, sound )
  chest.value = 5
  return chest
end