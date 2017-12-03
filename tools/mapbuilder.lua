


function buildMap(levelname)
  assert(type(levelname) == "string")
  --tlm = require("main")
  tlm:clear()
  tlm:loadmap(levelname)
  love.timer.sleep(0.25)
  
  
  local coin = require("objects/coin"):new(100,300)
  coin:init()
  local enemy = require("objects/enemy"):new(200,200,"enemy")
  enemy:init()
  
  gameManager.collectibles:add(coin)
  gameManager.enemies:add(enemy)
  
end