--[[ -- put it in release
local paths = "assets/maps/?.lua;assets/sounds/?.wav;assets/sprites/?.png;objects/animations/?.lua;objects/guns/?.lua;objects/?.lua;tiles/?.lua;tools/?.lua;?.lua"
package.path = paths
love.filesystem.setRequirePath(paths)
--]]
gameManager = require("tools/gamemanager"):create()
asm = require("tools/assetsmanager")
tlm = require("tiles/tlm")
width = love.graphics.getWidth()
require("tools/mapbuilder")
-- post effects
shaderManager = require("shaders/shadermanager"):new()
--obm = require("tools/objectmanager")



debugRect = false

worldWidth = 800
worldHeigth = 600

joypad = nil

scalex = 1--1920 / 800
scaley = 1--1080 / 600
local windowWidth = 0
local windowHeight = 0

function love.load()
  -- [[--
  if arg[#arg] == "-debug" then
    require("mobdebug").start() 
  end  
  --]]
  
  --[[
  local _,_,mode = love.window.getMode()
  local mw = 1024
  local mh = 768
  --mode.fullscreen = true
  love.window.setMode(mw,mh,mode)

  scalex = mw / 800
  scaley = mh / 600
  ]]--
  loadConf()
  
  asm:create()
  tlm:create()
  loadTextures()
  loadSounds()
  gameManager:init()
  gameManager:startNewGame()
  
  love.keyboard.setKeyRepeat(false)
  love.mouse.setVisible(false)

  local fontSize = 16
  local font = love.graphics.newFont(fontSize)
  love.graphics.setFont(font)

  local w, h = love.window.getMode()
  canvas = love.graphics.newCanvas(w,h)
  --canvas:setFilter('nearest', 'nearest')
  canvas:setFilter('linear', 'linear')
  
  --setJoypad()
  joypad = require("tools/joypad"):init()
  
  -- shaders
  initShaders()
end

function initShaders()
  --shaderManager = require("shaders/shadermanager"):new()
  local shader = require("shaders/shockwave"):new()
  --shaders["shockwave"] = shader
  shaderManager:add(shader, "shockwave")
end


function checkJoypad()
  if joypad:isGamepadDown("dpleft") then --or joypad:getAxis(-1) then
    print("left")
  end
  
  print(joypad:getAxis(1))
end


function setJoypad()
  local joypads = love.joystick.getJoysticks()
  if #joypads ~= 0 then
    joypad = joypads[1]
    local guid = joypad:getGUID()
    print(joypad:getAxisCount())
  end
end


function love.update(dt)
  local delta = smoothDeltaTime(dt)
  
  if joypad ~= nil then
    --joypad:checkJoypad()
    --joypad:printKeys()
  end
  
  if not gameManager.paused then
    if gameManager.state == 'game' then
      gameManager.gameLoop:update(delta)
    end
  end
  gameManager.update(delta)
  --pausedKey()
  shaderManager:update(dt)
  
end


function love.draw()
  love.graphics.setCanvas(canvas)
  gameManager:draw()
  love.graphics.setCanvas()
  --for _,shader
  shaderManager:set()
  love.graphics.draw(canvas, 0, 0, 0, scalex, scaley)  
  shaderManager:unset()
  

  --[[
  if not gameManager.isGameOver then
    
  --  love.graphics.setCanvas(canvas)
    gameManager.renderer:draw()
  
  else
    canvas:setFilter('nearest', 'nearest')
    love.graphics.setColor(0,0,0)
    love.graphics.rect("fill", windowWidth, windowHeight)
    love.graphics.print("GAME OVER", 100, 100,0,6, 6)
    love.graphics.setColor(255,255,255  )
  end
  
  love.graphics.setCanvas()
  love.graphics.draw(canvas, 0, 0, 0, scalex, scaley)
  ]]
end


function pausedKey()
  joypad:checkButtons()
  if keys.paused.pressed then
    gameManager.paused = not gameManager.paused
    keys.paused.pressed = false
  end
end


function love.keypressed(key)
  -- temporary
  if key == 'escape' then
    quit()
  end
  
  if love.keyboard.isDown('p') then 
    gameManager.paused = not gameManager.paused
  end

end

local filter = false
local anisotropy = 1

-- --[[
function love.keyreleased(key)
  
  if key == 'f1' then
    debugRect = not debugRect
  elseif key == 'f2' then
    love.window.maximize( )
  elseif key == 'f3' then
    filter = not filter
    if filter then
      canvas:setFilter("linear", "linear", anisotropy)
    else
      canvas:setFilter("nearest", "nearest", anisotropy)
    end
  end
end
--]]

function love.resize(w, h)
  local _,_,mode = love.window.getMode()
  scalex = w / mode.minwidth
  scaley = h / mode.minheight
  
  windowWidth = w
  windowHeight = h
end

---

function love.quit()
  quit()
end

function quit()
  saveConf()
  love.event.quit()
end

function saveConf()
  local w,h,mode = love.window.getMode()
  local fullscreen = 0
  if mode.fullscreen then
    fullscreen = 1
  end
  local cwd = love.filesystem.getSaveDirectory()
  local filename = "save.lua"
  local text = "config = {}\n"
  local result = love.filesystem.write( filename, text)
  text = "config.width = " .. w .. "\nconfig.height = " .. h .. "\nconfig.fullscreen = " .. fullscreen .. "\n"
  result = love.filesystem.append(filename, text)
  --print("saved")
end

function loadConf()
  local chunk = love.filesystem.load("save.lua")
  if chunk ~= nil then
    chunk()
    
    local _,_,mode = love.window.getMode()
    fullscreen = false
    if config.fullscreen == 1 then
      fullscreen = true
    end
    mode.fullscreen = fullscreen

    love.window.setMode(config.width,config.height,mode)

    
    scalex = config.width / mode.minwidth
    scaley = config.height / mode.minheight
    
    windowWidth = config.width 
    windowHeight = config.height
--end

    
  end
end





local remove, insert = table.remove,
			      table.insert
local delta_time = {}
local av_dt      = 0.016
local sample     = 10

function smoothDeltaTime(dt)
  insert(delta_time,dt)
	if #delta_time > sample then
		local av 	= 0
		local num 	= #delta_time
		for i = #delta_time,1,-1 do
			av = av + delta_time[i]
			remove(delta_time,i)
		end
	av_dt = av / num
  end
  return av_dt
end




function loadTextures()
  local directory = "assets/sprites/"
  local filename = directory .. "menu.png"
  local image = love.graphics.newImage(filename)
   image:setFilter("nearest","nearest")
  asm:add(image, "menu", "image")
  
  filename = directory .. "title.png"
  image = love.graphics.newImage(filename)
   image:setFilter("nearest","nearest")
  asm:add(image, "menutitle", "image")
  
  filename = directory .. "gameover.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "gameover", "image")
  

  filename = directory .. "theend.png"
  image = love.graphics.newImage(filename)
   image:setFilter("nearest","nearest")
  asm:add(image, "theend", "image")
  
  
  
  filename = "assets/sprites/hero-up.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "hero-up", "image")
  
  filename = "assets/sprites/hero-left.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "hero-left", "image")
  
  filename = "assets/sprites/hero-left-up.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "hero-left-up", "image")
  
  filename = "assets/sprites/hero-left-down.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "hero-left-down", "image")
  
  filename = "assets/sprites/hero-right.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "hero-right", "image")
  
  filename = "assets/sprites/hero-right-up.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "hero-right-up", "image")
  
  filename = "assets/sprites/hero-right-down.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "hero-right-down", "image")
  
  filename = "assets/sprites/hero-down.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "hero-down", "image")
  
  filename = "assets/sprites/coin.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "coin", "image")
  
  filename = "assets/sprites/coin2 silver.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "coin2 silver", "image")

  filename = "assets/sprites/coin2 gold.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "coin2 gold", "image")

  filename = "assets/sprites/medkit.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "medkit", "image")
  
  filename = "assets/sprites/bomb.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "bomb", "image")
  
  -- guns
  filename = "assets/sprites/shotgun.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "shotgun", "image")
  
  filename = "assets/sprites/rifle.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "rifle", "image")
  
  filename = "assets/sprites/pistol.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "pistol", "image")
  
  filename = "assets/sprites/fastreload.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "fastreload", "image")
    
  filename = "assets/sprites/explosion03.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "explosion", "image")
    
  filename = "assets/sprites/portal.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "portal", "image")
  
  filename = "assets/sprites/redportal.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "redportal", "image")
  
  filename = "assets/sprites/rifle anim.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "rifle anim", "image")
  
  filename = "assets/sprites/gun anim.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "gun anim", "image")
  
  filename = "assets/sprites/shotgun anim.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "shotgun anim", "image")
  
  filename = "assets/sprites/bomb anim.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "bomb anim", "image")
    
  filename = "assets/sprites/fastreload anim.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "fastreload anim", "image")
  
  filename = "assets/sprites/demon.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "demon", "image")
  
  filename = "assets/sprites/gui-background.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "gui-background", "image")
  
  filename = "assets/sprites/skull.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "skull", "image")
  
  filename = "assets/sprites/heart.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "heart", "image")
  
  filename = "assets/sprites/special.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "special", "image")
  
  filename = "assets/sprites/chest2.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "chest2", "image")
  
  filename = "assets/sprites/chest2-anim.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "chest2-anim", "image")
  
  filename = "assets/sprites/ruby.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "ruby", "image")
  
  filename = "assets/sprites/ruby-anim.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "ruby-anim", "image")
  
  filename = "assets/sprites/emerald.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "emerald", "image")
  
  filename = "assets/sprites/emerald-anim.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "emerald-anim", "image")
  
  filename = "assets/sprites/diamond.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "diamond", "image")
  
  filename = "assets/sprites/diamond-anim.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "diamond-anim", "image")
  
  filename = "assets/sprites/paused.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "paused", "image")

  filename = "assets/sprites/getready.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "getready", "image")

  -- enemy
  
  --[[
  filename = "assets/sprites/enemy-up.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "enemy-up", "image")
  
  filename = "assets/sprites/enemy-left.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "enemy-left", "image")
  
  filename = "assets/sprites/enemy-left-up.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "enemy-left-up", "image")
  
  filename = "assets/sprites/enemy-left-down.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "enemy-left-down", "image")
  
  filename = "assets/sprites/enemy-right.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "enemy-right", "image")
  
  filename = "assets/sprites/enemy-right-up.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "enemy-right-up", "image")
  
  filename = "assets/sprites/enemy-right-down.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "enemy-right-down", "image")
  
  filename = "assets/sprites/enemy-down.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "enemy-down", "image")
  --]]
  filename = "assets/sprites/lizard.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "lizard", "image")
end
  
  
function loadSounds()
  local type = "static"
  local sound = nil
  filename = "assets/sounds/coin.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "coinsound", "sound")

  filename = "assets/sounds/enemyouch1.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "enemyouch1", "sound")
  
  filename = "assets/sounds/enemyouch2.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "enemyouch2", "sound")
  
  filename = "assets/sounds/enemyouch3.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "enemyouch3", "sound")
  
  filename = "assets/sounds/enemyouch4.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "enemyouch4", "sound")  
  
  filename = "assets/sounds/enemyouch5.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "enemyouch5", "sound")
  
  filename = "assets/sounds/enemyouch6.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "enemyouch6", "sound")  
  
  filename = "assets/sounds/enemyouch7.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "enemyouch7", "sound")  
  
  filename = "assets/sounds/fire.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "firesound", "sound")
  
  filename = "assets/sounds/rifle.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "laserriflesound", "sound")
  
  filename = "assets/sounds/gun.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "gunsound", "sound")
    
   
  filename = "assets/sounds/playerouch.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "playerouch", "sound")
  
  filename = "assets/sounds/shotgun.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "shotgunsound", "sound")

  filename = "assets/sounds/pickup.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "pickupsound", "sound")
  
  filename = "assets/sounds/powerup.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "pickupsound02", "sound")

  filename = "assets/sounds/explosion04.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "explosionsound", "sound")

  filename = "assets/sounds/shoot02.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "shoot02", "sound")
  
  filename = "assets/sounds/specialready.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "specialready", "sound")
  
  filename = "assets/sounds/gem1sound.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "gem1sound", "sound")
  
  filename = "assets/sounds/gem2sound.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "gem2sound", "sound")
  
  filename = "assets/sounds/gem3sound.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "gem3sound", "sound")
  
  filename = "assets/sounds/chestsound.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "chestsound", "sound")
  
  filename = "assets/sounds/getreadysound.wav"
  sound = love.audio.newSource(filename, type)
  asm:add(sound, "getreadysound", "sound")
  
end
  
  
  
  
  
  
  
  
  
  
  
  
