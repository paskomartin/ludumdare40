


function buildMap(levelname)
  assert(type(levelname) == "string")
  --tlm = require("main")
  tlm:clear()
  tlm:loadmap(levelname)
  love.timer.sleep(0.25)
  
  
  --local bomb = require("objects/bomb"):new(100, 464)
  --gameManager.collectibles:add(bomb)

  --[[
  local coin = require("objects/coin"):new(100,300)
  --coin:load()
  --local enemy = require("objects/enemy"):new(200,200,"enemy")
  --enemy:load()
  
  gameManager.collectibles:add(coin)
  
  local medkit = require("objects/medkit"):new(100, 400)
  gameManager.collectibles:add(medkit)
  
  local bomb = require("objects/bomb"):new(100, 464)
  gameManager.collectibles:add(bomb)
  
  local gunfactory = require("objects/guns/gunfactory"):new(200, 464, "rifle")
  gameManager.collectibles:add(gunfactory)
  --]]--
  --local fastreload = require("objects/fastreload"):new(200, 464) --, "fastreload")
  --gameManager.collectibles:add(fastreload)
  
  
  --local rifle = require("objects/guns/rifle"):new(150, 450)
  --gameManager.collectibles:add(rifle)
  --gameManager.enemies:add(enemy)
  
end