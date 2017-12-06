
  function enemy:move(dt)
    -- self center
    local enemyCenter = {}
    enemyCenter.pos = require("tools/vec2"):new(x,y)
    enemyCenter.pos.x = self.pos.x + self.size.x / 2
    enemyCenter.pos.y = self.pos.y + self.size.y / 2
    -- player center
    local playerCenter = {}
    playerCenter.pos = require("tools/vec2"):new(x,y)
    playerCenter.pos.x = player.pos.x + player.size.x / 2
    playerCenter.pos.y = player.pos.y + player.size.y / 2
    
    local acc = 0
    angle = atan2(playerCenter.pos.y - enemyCenter.pos.y, playerCenter.pos.x - enemyCenter.pos.x)

    
    local distance = floor(distance(playerCenter, enemyCenter) )
    if distance <= self.distanceTrigger / 2 then
      acc = 50
    elseif distance <= self.distanceTrigger and distance > self.distanceTrigger / 2 then
      acc = 0
    else     
      if strollTime <= 0 then
        self:stroll(dt)
        strollTime = rand(strollTimeSpeed[1], strollTimeSpeed[2])
        goto skip_toanim
      end
    end

    self.vel.x = cos(angle) * (velSpeed + acc)
    self.vel.y = sin(angle) * (velSpeed + acc)
    self.orientation = angle - math.pi/2

    ::skip_toanim::
    self.animation:update(dt)
  end
  
  function enemy:stroll(dt)
    local destx = math.random(0, mapWidth)
    local desty = math.random(0, mapHeight)
    local centerx = self.pos.x + self.size.x / 2
    local centery = self.pos.x + self.size.y / 2
    angle = atan2(desty - centerx, destx - centery)
    
    self.orientation = angle - math.pi /2 
    
    self.vel.x = cos(angle) * velSpeed
    self.vel.y = sin(angle) * velSpeed

  end

  
