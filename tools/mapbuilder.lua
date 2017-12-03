

function buildMap(levelname)
  assert(type(levelname) == "string")
  --tlm = require("main")
  tlm:clear()
  tlm:loadmap(levelname)
  love.timer.sleep(0.25)
  
  -- add objects to the screen --
  player = require("objects/player"):new(100, 200)
  player:init()
  
  local coin = require("objects/coin"):new(100,300)
  coin:init()
  gameManager.collectibles:add(coin)
  
end