
local insert = table.insert
local quad = love.graphics.newQuad


-- returns table index
function table.find(table, obj)
  for index,value in pairs(table) do
    if value == obj then
      return index
    end
  end
  return nil
end

function distance(obj1, obj2)
  local x1 = obj1.pos.x
  local x2 = obj2.pos.x
  local y1 = obj1.pos.y
  local y2 = obj2.pos.y
  
  
  local distance = math.sqrt( (x2 - x1)^2  + (y2 - y1)^2 )
  return distance
end


function clearTable(t)
  for i, v in ipairs(t) do t[i] = nil end
end


-- generate animation quads
function genAnimQuads( cols, rows, width, height)
  local maxRows = rows or 1
  local maxCols = cols or 1
  local quads = {}
  
  for row = 1,  maxRows, 1 do
    for col = 1,  maxCols, 1 do
      
      local q = quad( (col - 1) * width, (row - 1) * height, width, height,  width * cols, height * rows)
      insert(quads, q)
      
    end
  end
  
  return quads
end

-- color1, color2 -  {r, g, b}
-- pos - current step
-- max - max steps
function interpolate2Colors(color1, color2, pos, max)
  local r = (( color2[1] - color1[1]) * pos / max + color1[1])
  local g = (( color2[2] - color1[2]) * pos / max + color1[2])
  local b = (( color2[3] - color1[3]) * pos / max + color1[3])
  return {r, g, b}
end

function interpolate3Colors(color1, color2, color3, pos, max)
  local color = nil
  if pos < max /2 then
    color = interpolate2Colors(color1, color2, pos, max/2)
  else
    color = interpolate2Colors(color2, color3, pos - max/2, max/2)
  end
  return color
end

















