function rect_collision(obj1, obj2)
  if (obj1.pos.x + obj1.size.x > obj2.pos.x) and
     (obj1.pos.x < obj2.pos.x + obj2.size.x) and
     (obj1.pos.y + obj1.size.y > obj2.pos.y) and
     (obj1.pos.y < obj2.pos.y + obj2.size.y) then
  
    return true, obj2
  end
  
  return false,nil
  
end