-- returns table index
function table.find(table, obj)
  for index,value in pairs(table) do
    if value == obj then
      return index
    end
  end
  return nil
end