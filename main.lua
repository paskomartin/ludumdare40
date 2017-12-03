
gameManager = require("tools/gameManager"):create()
asm = require("tools/assetsmanager")
tlm = require("tiles/tlm")
width = love.graphics.getWidth()
require("tools/mapbuilder")
--obm = require("tools/objectmanager")



function love.load()
    if arg[#arg] == "-debug" then
    require("mobdebug").start() 
  end  

  asm:create()
  tlm:create()
  gameManager:init()
  gameManager:startNewGame()

  local w, h = love.window.getMode()
  canvas = love.graphics.newCanvas(w,h)
end


function love.update(dt)
	gameManager.gameLoop:update(dt)
end

function love.draw()
  love.graphics.setCanvas()
	gameManager.renderer:draw()
  love.graphics.draw(canvas)
  --love.graphics.setCanvas()
end
