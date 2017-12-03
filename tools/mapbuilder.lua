


function buildMap(levelname)
  assert(type(levelname) == "string")
  --tlm = require("main")
  tlm:clear()
  tlm:loadmap(levelname)
  love.timer.sleep(0.25)
  
  
  local coin = require("objects/coin"):new(100,300)
  coin:init()
  gameManager.collectibles:add(coin)
  
end