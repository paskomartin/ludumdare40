

function buildMap(levelname)
  assert(type(levelname) == "string")
  --tlm = require("main")
  tlm:clear()
  tlm:loadmap(levelname)
  love.timer.sleep(0.25)
  
  -- add objects to the screen --
  
  
  
end