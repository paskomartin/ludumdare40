local HighScore = {}
local utf8 = require("utf8")

-- temporary
worldWidth = 800
worldHeight = 600


function HighScore:new()
  local highscore= {}
  highscore.table = {}
  highscore.textLimit = 10
  highscore.fontSize = 16
  highscore.font = love.graphics.newFont(highscore.fontSize)
  love.graphics.setFont(highscore.font)
  highscore.currentName = ""
  highscore.isActive = false  -- typing is active
  highscore.tableLimit = 10
  highscore.currentValue = 0
  highscore.tablePosition = -1
  highscore.state = 'inactive' -- highscores, input, inactive
  highscore.keyDown = false
  
  highscore.pos = {}
  highscore.pos.x = worldWidth / 4
  highscore.pos.y = worldHeight / 12 --300
  
  highscore.delta = 0
  highscore.angle = 0


  function highscore:turnOnHighscoreTable()
    self.state = 'highscores'
  end

  function highscore:turnOnInput(value, position)
    love.keyboard.setTextInput(true) 
    love.keyboard.setKeyRepeat(true)
    self.isActive = true
    self.currentName = ""
    self.state = 'input'
  end

  function highscore:inputEntry(t)
    local tLen = utf8.len(self.currentName) + utf8.len(t)
    if utf8.len(self.currentName) + utf8.len(t) < self.textLimit then
      self.currentName = self.currentName .. t
    end
  end

  function highscore:deleteOneLetter()
    --if self.isActive then
    if self.state == 'input' then
      local byteoffset = utf8.offset(self.currentName, -1)
      if byteoffset then 
        self.currentName = string.sub(self.currentName, 1, byteoffset - 1)
      end
    end
  end

    
  function highscore:draw()
    --if self.isActive then
    if self.state == 'input' then
      self:showInput()
    --else
    elseif self.state == 'highscores' then
      self:showTable()
    end
  end

  function highscore:update(dt)
    self.delta = dt
    --self:checkKeys()
  end

  function highscore:checkKeys(key)
    --if ( love.keyboard.isDown('return') or love.keyboard.isDown(keys.action.val) ) then
    if key == 'return' or key == keys.action.val then
      if self.state == 'highscores' then
        self.state = 'inactive'
      elseif self.state == 'input' then
        self:turnOffInput()
      end
    end
  end

  
  function highscore:showInput()
    love.graphics.setColor(234,12,45)
    love.graphics.print("value : " .. self.currentValue, 100, 200)
    love.graphics.printf(self.currentName, 100, 300, 400)
  end
  
  function highscore:showTable()
    local x = self.pos.x
    local startX = self.pos.x
    local y = self.pos.y --100
    local yOffset = 40
    -- show header
    x = worldWidth /2 - worldWidth / 8
    local text = "High Score"
    
    love.graphics.setColor(234,12,45)
    --x = math.sin( math.rad(self.angle) ) * 150 + self.pos.x
    --self.angle = (self.angle + 1) % 361
    love.graphics.print("High Score", x, y)
    
    y = self.pos.y
    y = y + yOffset * 2
    -- sinus
    --[[
    for _, c in utf8.codes(text) do
      y = math.sin( self.angle + 2.05)  * 25
      love.graphics.print(utf8.char(c), x, y)
      self.angle = (self.angle + .01) % 361
      x = x + 40
    end
    y = self.pos.y
    y = y + yOffset * 2
    ]]
    
    
    x = startX - 70
    love.graphics.printf("Place", x, y, 400 )
    love.graphics.printf("Name", x + 140, y, 400)
    x = x + 250
    love.graphics.printf("Points", x + 140, y, 400)
    y = y + yOffset
    
    -- show scores
    for i = 1, #self.table, 1 do
      x = startX --130
      love.graphics.print(i .. '.', x, y)
      x = x + 70
      love.graphics.printf(self.table[i].name, x, y, 400 )
      love.graphics.printf(self.table[i].value, x + 250, y, 400)
      y = y + yOffset
    end
  end
  
  
  
  function highscore:turnOffInput()
    --self.isActive = false
    self.state = 'highscores'
    love.keyboard.setTextInput(false) 
    love.keyboard.setKeyRepeat(false)
    self.table[self.tablePosition] = { name = self.currentName, value = self.currentValue }
    --table.insert(self.table, { name = self.currentName, value = self.currentValue } )
    self:sort()
  end
  
  function highscore:sort()
    table.sort(self.table, function(a,b) return a.value > b.value end )
  end
  
  function highscore:putValue(val, position)
    self.currentValue = val
    self.tablePosition = position
  end

  function highscore:canPutValue(value)
    local currentPosition = -1
    if #self.table == 0 then
      currentPosition = 1
      return true, currentPosition
    end
    local tableLen = #self.table
    for i = 1, tableLen, 1 do
      if self.table[i] ~= nil and self.table[i].value <= value then
        currentPosition = i
        i = #self.table + 1
      elseif self.table[i] == nil and i <= self.tableLimit then
        currentPosition = i
        i = #self.table + 1
      end
    end
    
    if tableLen < self.tableLimit then
      currentPosition = tableLen + 1
    end
    
    
    if currentPosition == -1 then
      return false, currentPosition
    else
      return true, currentPosition
    end
  end
    

  function highscore:load()
    local filename = "highscore.lua"
    local result = love.filesystem.exists(filename)
    if result then
      local chunk = love.filesystem.load(filename)
      if chunk ~= nil then
        chunk()
        self.table = scoreTable;
        self:sort()
        scoreTable = nil
      end
    end
    self.state = 'inactive'
  end

  function highscore:genDebugHighscores()
    for i = 1, 10, 1 do
      self.table[i] = { name ="ala" .. i, value = i }
    end
  end

  function highscore:printDebugHighscores()
    for i=1, #self.table do
      print("Name = " .. self.table[i].name .. " \tvalue = " .. self.table[i].value)
    end
  end

  function highscore:save()
    local filename = "highscore.lua"
    local text = "scoreTable = { \n"
    --self:genDebugHighscores()
    
    local tableLen = #self.table
    for i = 1, tableLen, 1 do
      text = text .. "\t{ name = \"" .. self.table[i].name .. "\", value = " .. tostring(self.table[i].value) .. " }"
      if i ~= tableLen then
        text = text .. ",\n"
      end
    end
    
    text = text .. "\n}"
    local result = love.filesystem.write(filename, text)
  end

  

  function highscore:clear()
    local tabLen = #self.table
    for i =1, tabLen do
      self.table[i] = nil
    end
  end
  
  return highscore
end




return HighScore