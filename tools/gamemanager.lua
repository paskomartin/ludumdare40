local GameManager = {}

function GameManager:create()
  local gameManager = {}
  
	gameManager.gameLoop = require("tools/gameLoop"):create()
	gameManager.renderer = require("tools/render"):create()
  gameManager.collectibles = require("tools/objectmanager")
  gameManager.enemies = require("tools/objectmanager")
  
  function gameManager:init()
    self.collectibles:create(gameLoop)
    self.enemies:create(gameLoop)
  end
  
  return gameManager
end
return GameManager