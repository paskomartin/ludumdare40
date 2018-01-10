local GameManager = {}
local obm = require("tools/objectmanager")

require("tools/helpers")
require("assets/maps/maplist")
require("tools/mapbuilder")
local gui = require("objects/gamegui")
local quad = love.graphics.newQuad



function GameManager:create()
  local gameManager = {}
  
  
	gameManager.gameLoop = require("tools/gameLoop"):create()
	gameManager.renderer = require("tools/render"):create()
  gameManager.collectibles = nil --obm:create() --require("tools/objectmanager")
  gameManager.enemies = nil --obm:create() --require("tools/objectmanager")
  gameManager.bullets = nil --obm:create() -- require("tools/objectmanager")
  gameManager.spawners = nil
  gameManager.paused = false
  
  
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
  gameManager.state = "menu"  -- menu, game, newgame, gameover, inputscore, highscore, theend, getready
  
  gameManager.endTime = 200
  gameManager.currentEndTime = gameManager.endTime
  gameManager.highscore = nil
  
  
  local menuItems = 2 -- start exit
  local menuIterator = 1
  local menuSelected = 0;
  
  gameManager.getReadyStartTime = 80
  gameManager.currentGetReadyTime = gameManager.getReadyStartTime
  
  
  
  function gameManager:init()
    self.fontSize = 16
    self.font = love.graphics.newFont(self.fontSize)
    love.graphics.setFont(self.font)

    self.collectibles = obm:create("collectibles")
    self.collectibles:init()
    self.enemies = obm:create("enemies")
    self.enemies:init()
    self.bullets = obm:create("bullets")
    self.bullets:init()
    self.spawners = obm:create("spawners")
    self.spawners:init()
    self.highscore = require("tools/highscore"):new()
    self.highscore:load()
    --self.highscore:printDebugHighscores()
    self:createAnimations()
    
    self:generateQuads()
    
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
    if gameManager.state == "newgame" then
      gameManager.state = "getready"--"game"
      gameManager:init()
      gameManager:startNewGame()
      love.audio.play(asm:get("getreadysound"))
      goto skip_update
    end
    
    if gameManager.state == "menu" then
      
      gameManager:getKeys()
      joypad:checkJoypad()
      gameManager:selectMenu()
      goto skip_update
    end
    
    
    if player.life <= 0 and (gameManager.state ~= "theend" and gameManager.state ~= "gameover" and gameManager.state ~= "highscore") then
      gameManager.isGameOver = true
      gameManager.state = "gameover"
      gameManager:resetEndWaitingTime()
    end
    
    
    --[[
    if gameManager.state == "gameover" then
      goto skip_update
    end
    ]]
    if gameManager.state == "theend" or gameManager.state == "gameover" then
      gameManager.currentEndTime = (gameManager.currentEndTime - 1)
      if gameManager.currentEndTime < 0 then
        if gameManager.state == "theend" then
          --quit()
          local result = gameManager:canInsertScoreToTable()
          gameManager.state = "highscore"
        elseif gameManager.state == "gameover" then
          local result = gameManager:canInsertScoreToTable()
          --gameManager.state = "menu"
          gameManager.state = "highscore"
        end
      end
      goto skip_update
    end
    
    
    if gameManager.state == "highscore" then
      if gameManager.highscore.state == "inactive" then
        gameManager.state = "menu"
      else
        gameManager.highscore:update(dt)
      end
      goto skip_update
    end
    
    
    gameManager:changeEnemiesOnArena()

    gameManager:checkNextLevel()
    ::skip_update::
    
    --self.gameLoop:update(dt)
  end
  
  
  function gameManager:canInsertScoreToTable()
    local result, position = gameManager.highscore:canPutValue(player.points)
    if result then
      gameManager.highscore:turnOnInput()
      gameManager.highscore:putValue(player.points, position)
    end
    
    return result
  end
  

  -- [[ DEPRICATED ]] --
  function gameManager:changeEnemiesOnArena2()
    -- change enemies on arena
    if (player.coins % gameManager.spawnerChange) == 0 and player.coins ~= 0 and player.coins < gameManager.maxCoins  and gameManager.lastCoinsCounter ~= player.coins then
      gameManager.lastCoinsCounter = player.coins
      gameManager.maxEnemy = gameManager.maxEnemy + gameManager.enemyStep
      if gameManager.maxEnemy > gameManager.maxLevelEnemy then
        gameManager.maxEnemy = gameManager.maxLevelEnemy
      end
      
      -- [[ ALMOST DEPRICATED ]] --
      player.cooldownSpeed = player.cooldownSpeed - 10
      if player.cooldownSpeed < player.cooldownMaxSpeed then
        player.cooldownSpeed = player.cooldownMaxSpeed
      end
      
      local cooldownSpeed = 3
      
      player.gun.cooldownSpeed = player.gun.cooldownSpeed - cooldownSpeed
      if player.gun.cooldownSpeed < player.gun.cooldownMaxSpeed then
        player.gun.cooldownSpeed = player.gun.cooldownMaxSpeed
      end
      
      
    end
        
  end

  



  function gameManager:changeEnemiesOnArena()
    -- change enemies on arena
    if player.coins > gameManager.lastCoinsCounter then
      local difference = player.coins - gameManager.lastCoinsCounter
      local multiplier = 0
      if difference == 1 then 
        if (player.coins % gameManager.spawnerChange) == 0 and player.coins ~= 0 and player.coins < gameManager.maxCoins then
          multiplier = 1
        end
      else 
          multiplier = math.floor(difference / gameManager.spawnerChange)
      end
        
        -- change enemy
        gameManager.lastCoinsCounter = player.coins
        gameManager.maxEnemy = gameManager.maxEnemy + gameManager.enemyStep * multiplier
        if gameManager.maxEnemy > gameManager.maxLevelEnemy then
          gameManager.maxEnemy = gameManager.maxLevelEnemy
        end
        
        -- [[ ALMOST DEPRICATED ]] --
        player.cooldownSpeed = player.cooldownSpeed - 10 * multiplier
        if player.cooldownSpeed < player.cooldownMaxSpeed then
          player.cooldownSpeed = player.cooldownMaxSpeed
        end
        
        local cooldownSpeed = 3
        
        -- change gun cooldown
        player.gun.cooldownSpeed = player.gun.cooldownSpeed - cooldownSpeed * multiplier
        if player.gun.cooldownSpeed < player.gun.cooldownMaxSpeed then
          player.gun.cooldownSpeed = player.gun.cooldownMaxSpeed
        end
      
        -- slow down spawners
        for _,spawner in pairs(gameManager.spawners.objects) do
          spawner:setCurrentTime( (math.random(0, 5) * -1) )
        end
      
    end
    
    
    --end -- if
    
  end

  
  function gameManager:checkNextLevel()
    if player.coins >= gameManager.maxCoins then
      local bonus = 20
      local lifeBonus = 100
      player.points = player.points + bonus * player.coins + lifeBonus * player.coins
      
      player.coins = 0
      gameManager:resetValues()
      gameManager:resetContainers()
      gameManager:loadNextLevel()
    end
  end
  

  
  function gameManager:loadNextLevel()
    gameManager.level = gameManager.level + 1
    local name = maplist[gameManager.level]
    if name == nil then
      gameManager.state = "theend"
      gameManager:resetEndWaitingTime()
    else
      gameManager:initContainers()
      player:reinit()
      buildMap(name)
      gameManager.renderer:add(tlm)
      self.gameGui:init()
      gameManager.state = "getready"
      love.audio.play(asm:get("getreadysound"))
    end
  end

  function gameManager:draw()
    love.graphics.clear( 0, 0, 0, 255 )
    if gameManager.state == "menu" then
      gameManager:showMenu()
    elseif gameManager.state == "highscore" then
      gameManager.highscore:draw()
    elseif gameManager.state == "gameover" then
      gameManager:showGameOver()
    elseif gameManager.state == "theend" then
      gameManager:showTheEnd()
    elseif gameManager.state == "getready" then
      self:showGetReady()
        
    elseif gameManager.state == "game" then
       gameManager.renderer:draw()
      if gameManager.paused then
        local img = asm:get("paused")
        local imgW, imgH = img:getDimensions()
        local x = worldWidth / 2 - imgW / 2
        local y = worldHeigth / 2 - imgH / 2
        
        love.graphics.draw(img, x, y)
      end       
    end
  end

  function gameManager:showHighscore()
  end

  function gameManager:showGetReady()
    gameManager.renderer:draw()
    local img = asm:get("getready")
    local imgW, imgH = img:getDimensions()
    local x = worldWidth / 2 - imgW / 2
    local y = worldHeigth / 2 - imgH / 2
        
    love.graphics.draw(img, x, y)
    self.currentGetReadyTime = self.currentGetReadyTime - 1 --getReadyTime = getReadyTime - 1
    if self.currentGetReadyTime < 0 then
      self.currentGetReadyTime = self.getReadyStartTime
      gameManager.state = "game"
    end
            
  end
  
   
  function gameManager:showMenu()
    local titlequad = gameManager.quads[5]
    love.graphics.draw(gameManager.menuTitleImage , titlequad,100,100)
    
    local quadSelected = nil
    local quadUnselected = nil
    if menuIterator == 1 then
      quadSelected = gameManager.quads[2]
      quadUnselected = gameManager.quads[4]
    elseif menuIterator == 2 then
      quadSelected = gameManager.quads[1]
      quadUnselected = gameManager.quads[3]
    end
    
    love.graphics.draw(gameManager.menuItemsImage ,quadSelected , 500, 360)
    love.graphics.draw(gameManager.menuItemsImage ,quadUnselected , 500, 420)
    love.graphics.setFont(self.font)
    
    love.graphics.setColor(255,255,255)
    local text = "by Martin Pasko"
    love.graphics.print(text, 300, 420)
    love.graphics.setColor(238, 85,51)
    text = "Ludum Dare 40 PostJam Edition"
    love.graphics.print(text, 200, 460)
    love.graphics.setColor(255,255,255)
    
    --"The more you have, the worse it is"


  end
  
  
  function gameManager:showGameOver()
    
    --gameManager:resetValues()
    local quad = gameManager.quads[6]
    love.graphics.draw(gameManager.gameOverTileImage , gameManager.quads[6], 0, 100)
    
  end
  
  function gameManager:showTheEnd()
    local quad = gameManager.quads[7]
    love.graphics.draw(gameManager.theEndTileImage , gameManager.quads[6], 0, 100)
  end
  
  
  -- bug in love.keyboars.setKeyRepeat(false) ????
  function gameManager:selectMenu2()
    menuSelected = 0
    if keys.up.pressed then
      menuIterator = menuIterator - 1
      if menuIterator < 1 then menuIterator = menuItems end
    elseif keys.down.pressed then
      menuIterator = menuIterator + 1
      if menuIterator > menuItems then menuIterator = 1 end
    end
    
    if keys.action.pressed then
      menuSelected = menuIterator
    end    
  end
  
  function gameManager:selectMenu()
        menuSelected = 0
    if keys.up.pressed then
      menuIterator = 1
    elseif keys.down.pressed then
      menuIterator = 2
    end
    
    if keys.action.pressed then
      menuSelected = menuIterator
    end 
    
    if menuSelected == 2 then
      quit()
    elseif menuSelected == 1 then
      gameManager.state = "newgame"
    end
  end
  
  
  
  
  function gameManager:getKeys()
    keys.action.pressed =  love.keyboard.isDown(keys.action.val)
    if not keys.action.pressed then 
      keys.action.pressed = love.keyboard.isDown("return")
    end
    keys.up.pressed =  love.keyboard.isDown(keys.up.val)
    if not keys.up.pressed then 
      keys.up.pressed = love.keyboard.isDown("up")
    end
    keys.down.pressed =  love.keyboard.isDown(keys.down.val)
    if not keys.down.pressed then 
      keys.down.pressed = love.keyboard.isDown("down")
    end
    keys.left.pressed =  love.keyboard.isDown(keys.left.val)
    if not keys.left.pressed then 
      keys.left.pressed = love.keyboard.isDown("left")
    end
    keys.right.pressed =  love.keyboard.isDown(keys.right.val)
    if not keys.right.pressed then 
      keys.right.pressed = love.keyboard.isDown("right")
    end
    keys.special.pressed = love.keyboard.isDown(keys.special.val)
    
  end

  function gameManager:increaseEnemy()
    self.enemyCounter = self.enemyCounter + 1
  end
  
  function gameManager:decreaseEnemy()   
    self.enemyCounter = self.enemyCounter - 1
    
    
    assert (self.enemyCounter >= 0)
    if self.enemyCounter < 0 then
      print("something goes wrong, enemies: " .. self.enemyCounter)
      self.enemyCounter = 0
    end
    
  end
  
  function gameManager:createAnimations()
    local animData = {}
    local quad = love.graphics.newQuad
    --animData["player_walkRight"] = { quad(0,0, 16, 32, 64, 32),
    --  quad(16,0, 16, 32, 64, 32), quad(32,0, 16, 32, 64, 32), quad(48,0, 16, 32, 64, 32)  }
    -- AssetsManager:add(asset, name, assetType)
    
    animData["player_walkRight"] = { quad(0,0, 64, 64, 384, 64),
      quad(64, 0, 64, 64, 384, 64), quad(128, 0, 64, 64, 384, 64), quad(192, 0, 64, 64, 384, 64),
      quad(256,0, 64, 64, 384, 64), quad(320,0, 64, 64, 384, 64) }

    
    
    
    
    --[[
    filename = "assets/sprites/hero.png"
    local image = love.graphics.newImage(filename)
    image:setFilter("nearest","nearest")
    asm:add(image, "player", "image")
    ]]
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
    gameManager.isGameOver = false
    menuSelected = 0
    menuIterator = 1
  end
  
  function gameManager:resetContainers()
    gameManager.gameLoop:clear()
    gameManager.renderer:clear()    
    gameManager.collectibles:clear()
    gameManager.enemies:clear()
    gameManager.bullets:clear()
    gameManager.spawners:clear()
  end
  
  function gameManager:initContainers()
    gameManager.collectibles:init()
    gameManager.enemies:init()
    gameManager.bullets:init()
    gameManager.spawners:init()
  end
 
  function gameManager:generateQuads()
    local quads = {
        -- items, menu.png
        quad(0, 0, 256, 54, 256, 256),
        quad(0, 54, 256, 54, 256, 256),
        quad(0, 108, 88, 60, 256, 256),
        quad(88, 108, 88, 60, 256, 256),
        -- title, title.png
        quad(0, 0, 446, 343, 446, 343),
        -- gameover, gameover.png
        quad(0, 0, 800, 285, 800, 285),
        -- the end, theend.png
        quad(0, 0, 800, 600, 800, 600),
          
      }
    gameManager.quads = quads
    gameManager.menuItemsImage = asm:get("menu")
    gameManager.menuTitleImage = asm:get("menutitle")
    gameManager.gameOverTileImage = asm:get("gameover")
    gameManager.theEndTileImage = asm:get("theend")
  end
  
  function gameManager:resetSpawnersTime(min, max)
    for _,spawner in pairs(gameManager.spawners.objects) do
      spawner:setCurrentTime( (math.random(min, max) * -1) )
    end
  end
  
  
  function gameManager:resetEndWaitingTime()
    gameManager.currentEndTime =  gameManager.endTime
  end
  
  
  
  return gameManager
end
return GameManager