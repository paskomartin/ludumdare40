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