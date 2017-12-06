  
  
  function enemy:move(dt)

    local x = self.pos.x + self.size.x / 2
    local y = self.pos.y + self.size.y / 2
    distCenter = {}
    distCenter.pos = require("tools/vec2"):new(x,y)
    local playerCenter = {}
    x = player.pos.x + player.size.x / 2
    y = player.pos.y + player.size.y / 2
    playerCenter.pos = require("tools/vec2"):new(x,y)
    
    local acc = 0
    angle = atan2(player.pos.y - self.pos.y, player.pos.x - self.pos.x)

    
    local distance = floor(distance(playerCenter, distCenter) )
    if distance <= self.distanceTrigger / 2 then
      acc = 50
      self.vel.x = cos(angle) * (velSpeed + acc)
      self.vel.y = sin(angle) * (velSpeed + acc)
      self.orientation = angle - math.pi/2
      
    elseif distance <= self.distanceTrigger and distance > self.distanceTrigger / 2 then     
      acc = 0
      self.vel.x = cos(angle) * (velSpeed + acc)
      self.vel.y = sin(angle) * (velSpeed + acc)
      self.orientation = angle - math.pi/2
    else
      if strollTime <= 0 then
        self:stroll(dt)
        strollTime = rand(strollTimeSpeed[1], strollTimeSpeed[2])
      end
    end
        
    self.animation:update(dt)
  end
  
  function enemy:stroll(dt)
    local destx = math.random(0, mapWidth)
    local desty = math.random(0, mapHeight)
    angle = atan2(desty - self.pos.y, destx - self.pos.x)
    
    self.orientation = angle - math.pi /2 
    
    self.vel.x = cos(angle) * velSpeed
    self.vel.y = sin(angle) * velSpeed
  end

  

