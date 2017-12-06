
gameManager = require("tools/gameManager"):create()
asm = require("tools/assetsmanager")
tlm = require("tiles/tlm")
width = love.graphics.getWidth()
require("tools/mapbuilder")
--obm = require("tools/objectmanager")


worldWidth = 800
worldHeigth = 600

local scalex = 1--1920 / 800
local scaley = 1--1080 / 600
local windowWidth = 0
local windowHeight = 0

function love.load()
    if arg[#arg] == "-debug" then
    require("mobdebug").start() 
  end  
  
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
  gameManager:init()
  gameManager:startNewGame()
  
  love.keyboard.setKeyRepeat(false)

  local w, h = love.window.getMode()
  canvas = love.graphics.newCanvas(w,h)
  canvas:setFilter('nearest', 'nearest')
end


function love.update(dt)
  local delta = smoothDeltaTime(dt)
  if not gameManager.paused then
    gameManager.gameLoop:update(delta)
  end
  gameManager.update(delta)
end



function love.draw()
  love.graphics.setCanvas(canvas)
  gameManager:draw()
  love.graphics.setCanvas()
  love.graphics.draw(canvas, 0, 0, 0, scalex, scaley)  
  
  

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




function love.keypressed(key)
  -- temporary
  if key == 'escape' then
    quit()
  end
  
  if love.keyboard.isDown('p') then 
    gameManager.paused = not gameManager.paused
  end

end

--[[
function love.keyreleased(key)
  
  if key == 'rctrl' then
    print("Fire released!")
  end
end
]]

function love.resize(w, h)
  local _,_,mode = love.window.getMode()
  scalex = w / mode.minwidth
  scaley = h / mode.minheight
  
  windowWidth = w
  windowHeight = h
end

---

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


  -- enemy
  
  
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
  
  filename = "assets/sprites/coin.png"
  image = love.graphics.newImage(filename)
  image:setFilter("nearest","nearest")
  asm:add(image, "coin", "image")


  -- sound
  -- TODO: put it to another function
  filename = "assets/sounds/coin.wav"
  image = love.audio.newSource(filename)
  asm:add(image, "coinsound", "sound")

  filename = "assets/sounds/enemyouch.wav"
  image = love.audio.newSource(filename)
  asm:add(image, "enemyouch", "sound")
  
  
  filename = "assets/sounds/fire.wav"
  image = love.audio.newSource(filename)
  asm:add(image, "fire", "sound")
  
 
  filename = "assets/sounds/playerouch.wav"
  image = love.audio.newSource(filename)
  asm:add(image, "playerouch", "sound")


end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  