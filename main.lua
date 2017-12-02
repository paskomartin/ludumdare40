
gameManager = require("tools/gameManager"):create()
asm = require("tools/assetsmanager")
tlm = require("tiles/tlm")
width = love.graphics.getWidth()
require("tools/mapbuilder")


-- test

testobj =  {
  x =0,
  y = 0
}
function testobj:tick(dt)
    local speed = 200
      self.x = self.x + speed * dt
      if self.x > width then
        self.x = 0
      end
end
    
function testobj:draw()
      love.graphics.setColor(255, 255, 0)
      love.graphics.rectangle("fill", self.x, self.y, 20, 20)
end



--[[
 Lib = {
      foo = function (x,y) return x + y end,
      goo = function (x,y) return x - y end
    }
]]

function love.load()
    if arg[#arg] == "-debug" then
    require("mobdebug").start() 
  end  
 
	--gameManager.gameLoop:add(testobj)
	--gameManager.renderer:add(testobj)
  asm:create()
  tlm:create()
  
  buildMap("level01")
  
  player = require("objects/player"):new(100, 200)
  player:init()
  local w, h = love.window.getMode()
  canvas = love.graphics.newCanvas(w,h)
end

function love.update(dt)
	gameManager.gameLoop:update(dt)
end

function love.draw()
	--love.graphics.print("Hello world", 0, 0)
  love.graphics.setCanvas()
	gameManager.renderer:draw()
  love.graphics.draw(canvas)
  --love.graphics.setCanvas()
end

function love.keypressed(key)
  if key == keys.up.val then
    keys.up.pressed = true
  end
  
  if key == keys.down.val then
    keys.down.pressed = true
  end
  
  if key == keys.left.val then
    keys.left.pressed = true
  end
  
  if key == keys.right.val then
    keys.right.pressed = true
  end
  
  if key == keys.action.val then
    keys.action.pressed = true
  end
end

function love.keyreleased(key)
  if key == keys.up.val then
    keys.up.pressed = false
  end
  
  if key == keys.down.val then
    keys.down.pressed = false
  end
  
  if key == keys.left.val then
    keys.left.pressed = false
  end
  
  if key == keys.right.val then
    keys.right.pressed = false
  end
  
  if key == keys.action.val then
    keys.action.pressed = false
  end
end


-- old - using table, i think this is not efficient
-- DEPRICATED
--[[
function love.keypressed(key)
  for _,val in pairs(keys.up) do
    if key == val then
      pressedKeys.up = true;
    end
  end
  
  for _,val in pairs(keys.down) do
    if key == val then
      pressedKeys.down = true;
    end
  end
  
  for _,val in pairs(keys.left) do
    if key == val then
      pressedKeys.left = true;
    end
  end
  
  for _,val in pairs(keys.right) do
    if key == val then
      pressedKeys.right = true;
    end
  end
  
  for _,val in pairs(keys.action) do
    if key == val then
      pressedKeys.action = true;
    end
  end
  
end

function love.keyreleased(key)

    for _,val in pairs(keys.up) do
    if key == val then
      pressedKeys.up = false;
    end
  end
  
  for _,val in pairs(keys.down) do
    if key == val then
      pressedKeys.down = false;
    end
  end
  
  for _,val in pairs(keys.left) do
    if key == val then
      pressedKeys.left = false;
    end
  end
  
  for _,val in pairs(keys.right) do
    if key == val then
      pressedKeys.right = false;
   end
  end
  
  for _,val in pairs(keys.action) do
    if key == val then
      pressedKeys.action = false;
    end
  end
  
end
]]