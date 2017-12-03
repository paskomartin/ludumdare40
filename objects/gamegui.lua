local GameGui = {}

function GameGui:new()
  local gameGui = {}
  gameGui.points = 0
  gameGui.coins = 0
  gameGui.playerLife = 0
  gameGui.x = 0
  gameGui.y = 17 * 32
  gameGui.h = 56
  gameGui.w = 800
  -- h 56
  
  function gameGui:init()
    gameManager.gameLoop:add(self)
    gameManager.renderer:add(self, 4)
  end
  
  function gameGui:tick(dt)
    self.points = player.points
    self.coins = player.coins
    self.playerLife = player.life
  end
  
  function gameGui:draw()
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    local text = "Coins: " .. self.coins
    local margin = 6
    love.graphics.setColor(255,255,255)
    love.graphics.print(text, self.x + 16, self.y + 4, 0, 2, 2)
    text = "Points: " .. self.points
    love.graphics.print(text, self.x + 16, self.y + 16 + margin * 2, 0, 2, 2)
    love.graphics.setColor(255,255,255)
  end
  
  
  return gameGui
end

return GameGui