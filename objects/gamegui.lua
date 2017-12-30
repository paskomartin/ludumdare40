local GameGui = {}

require("tools/helpers")

function GameGui:new()
  local gameGui = {}
  gameGui.points = 0
  gameGui.coins = 0
  gameGui.playerLife = 0
  gameGui.canShoot = false
  gameGui.kills = 0
  --gameGui.level = 1
  gameGui.x = 0
  gameGui.y = 17 * 32
  gameGui.h = 56
  gameGui.w = 800
  gameGui.image = asm:get("gui-background")
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
    self.kills = player.kills
  end
  
  function gameGui:draw()
    --love.graphics.setColor(0,0,0)
    --love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.draw(self.image, self.x, self.y)
    local img = asm:get("chest2")
    --local text = "Wealth: " .. self.coins .. " / " .. gameManager.maxCoins
    local text = self.coins .. " / " .. gameManager.maxCoins
    local margin = 6
    local shadowColor = { 16, 16, 16 }
    love.graphics.setColor(shadowColor)
    love.graphics.draw(img, self.x + 16+2, self.y + 2+2)
    love.graphics.print(text, self.x + 16+34 + 8, self.y + 2+2, 0, 2, 2)
    --love.graphics.print(text, self.x + 16+2, self.y + 2+2, 0, 2, 2)
    love.graphics.setColor(255,255,255)
    love.graphics.draw(img, self.x + 16, self.y + 2)
    love.graphics.print(text, self.x + 16 + 32 + 8, self.y + 2, 0, 2, 2)
    --love.graphics.print(text, self.x + 16, self.y + 2, 0, 2, 2)
    
    text = "Points: " .. self.points
    love.graphics.setColor(shadowColor)
    love.graphics.print(text, self.x + 16 + 2, self.y + 16 + 2 + margin * 2, 0, 2, 2)
    love.graphics.setColor(255,255,255)
    love.graphics.print(text, self.x + 16, self.y + 16 + margin * 2, 0, 2, 2)
    
    -- DEBUG ONLY
    --[[--
    text = "En: " .. gameManager.enemyCounter .. "/" .. gameManager.maxEnemy
    local x = self.w / 2 - self.w / 4
    love.graphics.print(text, x, self.y + 2, 0, 2, 2)
    
    text = "EnC: " .. gameManager.enemies:count()
    love.graphics.print(text, x, self.y + 16 + margin * 2, 0, 2, 2)
    --]]--
    
    --text = "Kills: " .. self.kills
    text = self.kills
    img = asm:get("skull")
    x = self.x + self.w / 4
    love.graphics.setColor(shadowColor)
    love.graphics.print(text, x + 16 + 2 - 24, self.y + 2 + 2, 0, 2, 2)
    love.graphics.draw(img, x + 16 + 2 - 64, self.y + 2 + 2,  0, 0.8, 0.8)
    love.graphics.setColor(255,255,255)
    love.graphics.print(text, x + 16 - 24, self.y + 2, 0, 2, 2)
    love.graphics.draw(img, x + 16 - 64, self.y + 2,  0, 0.8, 0.8)
    
    
    text = "Enemy: " .. gameManager.enemyCounter .. '/' .. gameManager.maxEnemy
    --x = self.x + self.w / 4
    love.graphics.setColor(shadowColor)
    love.graphics.print(text, x + 16 + 2, self.y + 16 + 2  + margin *2, 0, 2, 2)
    love.graphics.setColor(255,255,255)
    love.graphics.print(text, x + 16, self.y + 16 + margin *2, 0, 2, 2)
    
    img = asm:get("heart")
    --text = "Life: " .. self.playerLife
    text = self.playerLife
    x = self.w / 2-- - self.w / 7 
    love.graphics.setColor(shadowColor)
    love.graphics.draw(img, x + 2, self.y + 2)
    love.graphics.print(text, x + 2 + 32, self.y + 2, 0, 2, 2)
    love.graphics.setColor(255,255,255)
    love.graphics.draw(img, x, self.y + 2)
    love.graphics.print(text, x + 32, self.y + 2, 0, 2, 2)
    
    text = "Level: " .. gameManager.level
    love.graphics.setColor(shadowColor)
    love.graphics.print(text, x + 2, self.y + 16 + margin * 2 + 2, 0, 2, 2)
    love.graphics.setColor(255,255,255)
    love.graphics.print(text, x, self.y + 16 + margin * 2, 0, 2, 2)
    
    if self.canShoot then
      text = "Shoot!"
    else
      text = "Reloading"
    end
    x = self.w - 200
    img = player.gun.image
    love.graphics.setColor(shadowColor)
    love.graphics.print(text, x + 12 + 2, self.y, 0, 2, 2)
    love.graphics.draw(img, x + 12 + 2 - 40, self.y)
    love.graphics.setColor(255,255,255)
    love.graphics.print(text, x + 12, self.y, 0, 2, 2)
    love.graphics.draw(img, x + 12 - 40, self.y)
    
    --[[--
    local maxRectWidth = 150
    local rectWidthStep = math.abs(maxRectWidth / player.specialCooldownMax)
    local rectHeight = 5
    local color = nil
    --for i = 1, player.specialCooldown, 1 do
    for i = player.specialCooldownMax, 0, -1 do
      if i <= player.specialCooldown then
        i = 0 --player.specialCooldownMax
      else
        color = interpolate3Colors( {224,0,26}, {255,216,25}, {23,178,8}, i, player.specialCooldownMax)
        love.graphics.setColor(color)
        love.graphics.rectangle('fill', x + (maxRectWidth - i * rectWidthStep) + 12, self.y+16+margin + 10, rectWidthStep, rectHeight)
      end
    end
    
    love.graphics.rectangle('line', x + 11, self.y+16+margin  + 10,150,7)
    --]]
    
    img = asm:get("special")
    love.graphics.setColor(shadowColor)
    love.graphics.draw(img, x - 14, self.y+22,0,1.3,1.3)
    love.graphics.setColor(255,255,255)
    love.graphics.draw(img, x - 16, self.y+24,0,1.3,1.3)
    self:drawGradient(x, self.y, margin)
    
    
    -- debug
    --love.graphics.print( player.specialCooldown, x + 11, self.y+30+margin)
    
    --print(player.specialCooldown .. ' / ' .. player.specialCooldownMax .. " .. " .. rectWidthStep)
    
    
    
    --text = "Cooldown: " .. player.gun.cooldownSpeed
    --love.graphics.print(text, x + 12, self.y+16+margin, 0, 2, 2)
      
    
    love.graphics.setColor(255,255,255)
  end
  
  function gameGui:drawGradient(x, y, margin)
    local maxRectWidth = 150
    local rectWidthStep = math.abs(maxRectWidth / player.specialCooldownMax)
    local rectHeight = 5
    local color = nil
    --for i = 1, player.specialCooldown, 1 do
    for i = player.specialCooldownMax, 0, -1 do
      if i <= player.specialCooldown then
        i = 0 --player.specialCooldownMax
      else
        color = interpolate3Colors( {23,178,8}, {255,216,25}, {224,0,26},  i, player.specialCooldownMax)
        love.graphics.setColor(color)
        love.graphics.rectangle('fill', x + (maxRectWidth - i * rectWidthStep) + 12, y+16+margin + 10, rectWidthStep, rectHeight)
      end
    end
    
    love.graphics.rectangle('line', x + 11, self.y+16+margin  + 10,150,7)
  end
  
  
  return gameGui
end

return GameGui