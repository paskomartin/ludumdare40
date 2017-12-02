local GameManager = {}

function GameManager:create()
  local gameManager = {}
  
	gameManager.gameLoop = require("tools/gameLoop"):create()
	gameManager.renderer = require("tools/render"):create()
  return gameManager
end
return GameManager