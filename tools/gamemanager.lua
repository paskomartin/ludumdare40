local GameManager = {}
local obm = require("tools/objectmanager")

require("assets/maps/maplist")
require("tools/mapbuilder")
local gui = require("objects/gamegui")

function GameManager:create()
  local gameManager = {}
  
	gameManager.gameLoop = require("tools/gameLoop"):create()
	gameManager.renderer = require("tools/render"):create()
  gameManager.collectibles = nil --obm:create() --require("tools/objectmanager")
  gameManager.enemies = nil --obm:create() --require("tools/objectmanager")
  gameManager.playerBullets = nil --obm:create() -- require("tools/objectmanager")
  
  gameManager.level = 1
  
  function gameManager:init()
    
    self.collectibles = obm:create("collectibles")
    self.collectibles:init()
    self.enemies = obm:create("enemies")
    self.enemies:init()
    self.playerBullets = obm:create("playerBullets")
    self.playerBullets:init()
    
  end
  
  function gameManager:startNewGame()
    -- add objects to the screen --
    player = require("objects/player"):new(100, 200)
    player:init()
    self.level = 1
    
    buildMap(maplist[self.level])
    self.gameGui = gui:new()
    self.gameGui:init()
end
  
  
  return gameManager
end
return GameManager