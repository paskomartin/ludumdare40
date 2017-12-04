
gameManager = require("tools/gameManager"):create()
asm = require("tools/assetsmanager")
tlm = require("tiles/tlm")
width = love.graphics.getWidth()
require("tools/mapbuilder")
--obm = require("tools/objectmanager")


local scalex = 1--1920 / 800
local scaley = 1--1080 / 600


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
  --loadConf()
  
  asm:create()
  tlm:create()
  gameManager:init()
  gameManager:startNewGame()

  local w, h = love.window.getMode()
  canvas = love.graphics.newCanvas(w,h)
  canvas:setFilter('nearest', 'nearest')
end


function love.update(dt)
  local delta = smoothDeltaTime(dt)
	gameManager.gameLoop:update(delta)
end



function love.draw()
  love.graphics.setCanvas(canvas)
	gameManager.renderer:draw()
  love.graphics.setCanvas()
  love.graphics.draw(canvas, 0, 0, 0, scalex, scaley)
  
end




function love.keypressed(key)
  -- temporary
  if key == 'escape' then
    quit()
  end
end


function love.resize(w, h)
  local _,_,mode = love.window.getMode()
  scalex = w / mode.minwidth
  scaley = h / mode.minheight
end

---

function quit()
  --saveConf()
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


