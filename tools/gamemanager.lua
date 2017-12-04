local GameManager = {}
local obm = require("tools/objectmanager")

require("tools/helpers")
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
  gameManager.spawners = nil
  
  gameManager.level = 1
  gameManager.maxEnemy = 1
  gameManager.maxLevelEnemy = 0
  gameManager.enemyCounter = 0
  gameManager.maxCoins = 0
  gameManager.spawnerChange = 0
  gameManager.enemyStep = 0
  gameManager.animData = nil -- it'll table
  gameManager.lastCoinsCounter = 0
  gameManager.isGameOver = false
  gameManager.state = "menu"  -- menu, game, gameover, highscore, theend
  function gameManager:init()
    
    self.collectibles = obm:create("collectibles")
    self.collectibles:init()
    self.enemies = obm:create("enemies")
    self.enemies:init()
    self.playerBullets = obm:create("playerBullets")
    self.playerBullets:init()
    self.spawners = obm:create("spawners")
    self.spawners:init()
    self:createAnimations()
  end
  
  function gameManager:startNewGame()
    -- add objects to the screen --
    self.resetValues()
    self.resetContainers()
    self.initContainers()
    player = require("objects/player"):new(100, 200)
    player:init()

    gameManager.renderer:add(tlm)
    self.level = 1
    
    player.isAlive = true
    
    buildMap(maplist[self.level])
    self.gameGui = gui:new()
    self.gameGui:init()
    
    self.isGameOver = false
  end
  
  
  function gameManager:update(dt)
    if gameManager.state == "menu"
      gameManager:getKeys()
      
      goto skip_update
    end
    
    
    if (player.coins % gameManager.spawnerChange) == 0 and player.coins ~= 0 and player.coins < gameManager.maxCoins  and gameManager.lastCoinsCounter ~= player.coins then
      gameManager.lastCoinsCounter = player.coins
      gameManager.maxEnemy = gameManager.maxEnemy + gameManager.enemyStep
      if gameManager.maxEnemy > gameManager.maxLevelEnemy then
        gameManager.maxEnemy = gameManager.maxLevelEnemy
      end
    end
    
    if player.life <= 0 then
      --print("YOU ARE DEAD")
      gameManager.isGameOver = true
      --gameManager:gameOver()
    end
    
    ::skip_update::
  end

  function gameManager:draw()
    
       gameManager.renderer:draw()
  end
  function gameManager:showMenu()
    
  end
  
  function gameManager:getKeys()
    keys.action.pressed =  love.keyboard.isDown(keys.action.val)
    keys.up.pressed =  love.keyboard.isDown(keys.up.val)
    keys.down.pressed =  love.keyboard.isDown(keys.down.val)
    keys.left.pressed =  love.keyboard.isDown(keys.left.val)
    keys.right.pressed =  love.keyboard.isDown(keys.right.val)
    keys.special.pressed = love.keyboard.isDown(keys.special.val)
  end

  function gameManager:increaseEnemy()
    self.enemyCounter = self.enemyCounter + 1
  end
  
  function gameManager:decreaseEnemy()
    self.enemyCounter = self.enemyCounter - 1
    if self.enemyCounter < 0 then self.enemyCounter = 0 end
  end
  
  function gameManager:createAnimations()
    local animData = {}
    local quad = love.graphics.newQuad
    animData["player_walkRight"] = { quad(0,0, 16, 32, 64, 32),
      quad(16,0, 16, 32, 64, 32), quad(32,0, 16, 32, 64, 32), quad(48,0, 16, 32, 64, 32)  }
    -- AssetsManager:add(asset, name, assetType)
    filename = "assets/sprites/hero.png"
    local image = love.graphics.newImage(filename)
    image:setFilter("nearest","nearest")
    asm:add(image, "player", "image")
    
    self.animData = animData
  end
  
  
  function gameManager:resetValues()
    gameManager.maxEnemy = 1
    gameManager.maxLevelEnemy = 0
    gameManager.enemyCounter = 0
    gameManager.maxCoins = 0
    gameManager.spawnerChange = 0
    gameManager.enemyStep = 0
    gameManager.lastCoinsCounter = 0 
  end
  
  function gameManager:resetContainers()
    gameManager.gameLoop:clear()
    gameManager.renderer:clear()    
    gameManager.collectibles:clear()
    gameManager.enemies:clear()
    gameManager.playerBullets:clear()
    gameManager.spawners:clear()
  end
  
  function gameManager:initContainers()
    gameManager.collectibles:init()
    gameManager.enemies:init()
    gameManager.playerBullets:init()
    gameManager.spawners:init()
  end
  
  
  function gameManager:gameOver()
    gameManager:resetValues()
    
  end
  
  return gameManager
end
return GameManager