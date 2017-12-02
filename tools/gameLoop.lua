local GameLoop = {}

local insert = table.insert
local remove = table.remove

function GameLoop:create()
  local gameLoop = {}
  gameLoop.tickers = {}

  
  function gameLoop:add(obj)
    insert(self.tickers, obj)
  end
  
  function gameLoop:update(dt)
    for ticker = 0, #self.tickers do
      local obj = self.tickers[ticker]
      if obj ~= nil then
        obj:tick(dt)
      end
    end
  end
 
  
  
  return gameLoop
end

return GameLoop
