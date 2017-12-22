local anim = require("tools/helpers")
local Explosion = {}
  
function Explosion:new(x,y)
 
  local w = 32
  local h = 32
  local explosion = require("objects/entity"):new(x,y,w,h,"explosion")
  
  local image = asm:get("explosion")
  local quads = genAnimQuads(9, 1, 32, 32)
  local animSpeed = 0.05
  explosion.animation = require("tools/animation"):new(image, { genAnimQuads(9, 1, 32, 32) }, animSpeed, true)

  explosion.animation.scale = 1.5
  explosion.animation:set_animation(1)
  explosion.animation:play()
  


  function explosion:load()
    self.layer = 3
		gameManager.gameLoop:add(self)
		gameManager.renderer:add(self, self.layer)
  end
  
  function explosion:tick(dt)
    self.animation:update(dt)
    if not self.animation.play then
      self.remove = true
    end
  end
  
  function explosion:draw()
    
    if not self.remove then
      self.animation:draw( {self.pos.x, self.pos.y} ) --, self.size.x , self.size.y } )
    end
  end
  
  return explosion
end
 
 
 return Explosion