local GameManager = {}
local obm = require("tools/objectmanager")

function GameManager:create()
  local gameManager = {}
  
	gameManager.gameLoop = require("tools/gameLoop"):create()
	gameManager.renderer = require("tools/render"):create()
  gameManager.collectibles = nil --obm:create() --require("tools/objectmanager")
  gameManager.enemies = nil --obm:create() --require("tools/objectmanager")
  gameManager.playerBullets = nil --obm:create() -- require("tools/objectmanager")
  
  function gameManager:init()
    
    self.collectibles = obm:create(gameLoop)
    self.collectibles:init()
    self.enemies = obm:create(gameLoop)
    self.enemies:init()
    self.playerBullets = obm:create(gameLoop)
    self.playerBullets:init()
    
    print("hello")
  end
  
  return gameManager
end
return GameManager