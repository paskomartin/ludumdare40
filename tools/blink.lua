--[[
Blinker 
--]]
local Blink = {}


function Blink:new(blinkingTime, blinkSpeed)
  local blink = {}
  blink.active = false
  blink.blinkAnim = false
  blink.blinkStep = blinkSpeed or 0.15   
  blink.blinkTime = blinkingTime or 20   -- totalTime
  blink.currentBlinkTime = 0
  blink.lastBlinkTime = 0
  blink.currentBlinkTime = 0
  blink.blinkCounter = 0
  
  function blink:update(dt)
    if self.active then
      if self.blinkCounter < self.blinkTime then
      
        self.currentBlinkTime = self.currentBlinkTime + dt
        if self.currentBlinkTime >= self.blinkStep then
          self.currentBlinkTime = 0
          self.blinkAnim = not self.blinkAnim
          self.blinkCounter = self.blinkCounter + 1
        end
      else
        self:stop()
      end
    end
  end
  
  
  function blink:start()
    self.active = true
    self.blinkAnim = true
    self.currentBlinkTime = 0
  end
  
  function blink:isActive()
    return self.active;
  end
  
  --[[
  function blink:isBlinking()
    return self.blinkAnim
  end
  --]]
  
  function blink:stop()
    self.active = false
    self.blinkAnim = false
    self.blinkCounter = 0    
  end
  
  
  function blink:isBlinking()
    if self.active then
       return self.blinkAnim
    end
    return false
  end
  
  
  return blink
end


return Blink
