local GenericAnim = {}

function GenericAnim:new(imageName, x, y, w, h, rows, cols, speed, waitTime, scale)
  local genericAnim = {}
  
     -- animation
  genericAnim.animationWaitTime = waitTime or 5
  genericAnim.animationCurrentTime = 0 -- 
  genericAnim.x = x 
  genericAnim.y = y
  local image = asm:get(imageName)
  local animSpeed = speed or 0.02 
  genericAnim.animation = require("tools/animation"):new(image, { genAnimQuads(cols, rows, w, h) }, animSpeed, true)
  genericAnim.animation:set_animation(1)
  genericAnim.animation:start()
  genericAnim.animation.scale = scale or 1
  
  
  function genericAnim:update(dt)
    if not self.animation.play then
      self.animationCurrentTime = self.animationCurrentTime + dt
      if self.animationCurrentTime >= self.animationWaitTime then
        self.animationCurrentTime = 0
        --self.animation.current_frame = 1
        self.animation:start()
      end
    end
    
    if self.animation.play then
        self.animation:update(dt)
    end
  end
  
  
  function genericAnim:draw(sh)
    local shadow = sh or false
    self.animation:draw( {self.x, self.y}, 0, shadow) 
  end
  
  function genericAnim:isPlaying()
    return self.animation.play
  end
  
  return genericAnim
end

return GenericAnim