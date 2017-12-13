local GameGui = {}

function GameGui:new()
  local gameGui = {}
  gameGui.points = 0
  gameGui.coins = 0
  gameGui.playerLife = 0
  gameGui.canShoot = false
  --gameGui.level = 1
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
    self.canShoot = player.gun.canShoot
  end
  
  function gameGui:draw()
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    local text = "Coins: " .. self.coins .. " / " .. gameManager.maxCoins
    local margin = 6
    love.graphics.setColor(255,255,255)
    love.graphics.print(text, self.x + 16, self.y + 2, 0, 2, 2)
    text = "Points: " .. self.points
    love.graphics.print(text, self.x + 16, self.y + 16 + margin * 2, 0, 2, 2)
    
    -- DEBUG ONLY
    --[[--
    text = "En: " .. gameManager.enemyCounter .. "/" .. gameManager.maxEnemy
    local x = self.w / 2 - self.w / 4
    love.graphics.print(text, x, self.y + 2, 0, 2, 2)
    
    text = "EnC: " .. gameManager.enemies:count()
    love.graphics.print(text, x, self.y + 16 + margin * 2, 0, 2, 2)
    --]]--
    
    
    
    text = "Life: " .. self.playerLife
    x = self.w / 2
    love.graphics.print(text, x, self.y + 2, 0, 2, 2)
    text = "Level: " .. gameManager.level
    love.graphics.print(text, x, self.y + 16 + margin * 2, 0, 2, 2)
    
    if self.canShoot then
      text = "Shoot!"
    else
      text = "Reloading"
    end
    x = self.w - 200
    love.graphics.print(text, x + 12, self.y, 0, 2, 2)
    text = "Cooldown: " .. player.gun.cooldownSpeed
    love.graphics.print(text, x + 12, self.y+16+margin, 0, 2, 2)
      
    
    love.graphics.setColor(255,255,255)
  end
  
  
  return gameGui
end

return GameGui