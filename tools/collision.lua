function rect_collision(obj1, obj2)
  if (obj1.pos.x + obj1.size.x > obj2.pos.x) and
     (obj1.pos.x < obj2.pos.x + obj2.size.x) and
     (obj1.pos.y + obj1.size.y > obj2.pos.y) and
     (obj1.pos.y < obj2.pos.y + obj2.size.y) then
  
    return true, obj2
  end
  
  return false,nil
end


-- thank you stackoverflow :P
-- https://stackoverflow.com/questions/29861096/detect-which-side-of-a-rectangle-is-colliding-with-another-rectangle
function collisionSide(r1, r2)
  local dx=(r1.x+r1.w/2)-(r2.x+r2.w/2);
  local dy=(r1.y+r1.h/2)-(r2.y+r2.h/2);
  local width=(r1.w+r2.w)/2;
  local height=(r1.h+r2.h)/2;
  local crossWidth=width*dy;
  local crossHeight=height*dx;
  local collision='none';
  
    if(math.abs(dx)<=width and math.abs(dy)<=height) then
        if(crossWidth>crossHeight) then
          if crossWidth > -crossHeight then
            collision = 'bottom'
          else
            collision = 'left'
          end
            
        else
          if crossWidth > -crossHeight then
            collision = 'right'
          else
            collision = 'top'
          end
        end
    end
    return collision
end

function wallCollision(obj, dt)
  local walls = tlm.walls
  local result = false
  
  for i = 1, #walls do
    local wall = walls[i]
    local r2 = { x = wall.pos.x, y = wall.pos.y, w = wall.size.x, h = wall.size.y }
    local r1 = { x = obj.pos.x, y = obj.pos.y, w = obj.size.x, h = obj.size.y }
    local side = collisionSide(r2, r1)
    if side ~= 'none' then
      if side == 'right' then
        obj.pos.x = wall.pos.x - obj.size.x - 1
        result = true
      elseif side == 'left' then
        obj.pos.x = wall.pos.x + wall.size.x + 1
        result = true
      elseif side == 'top' then
        obj.pos.y = wall.pos.y + wall.size.y + 1
        result = true
      elseif side == 'bottom' then
        obj.pos.y = wall.pos.y - obj.size.y - 1
        result = true
      end
      
      --print(side)
    end
  end
  return result
  --isObjectOnMapBounds(obj)
end


function collectibleCollision(obj)
  local objects = gameManager.collectibles.objects
  
  for i = 1, #objects do
    if objects[i] ~= nil then
      local result = rect_collision(obj, objects[i])
      if result then
        objects[i]:pickup(obj)
      end
    end
  end
end



function collisionWithPlayerBullet(obj)
  local objects = gameManager.playerBullets.objects
  
  for i = 1, #objects do
    if objects[i] ~= nil then
      local result = rect_collision(obj, objects[i])
      if result then
        obj:takeHit(objects[i].damage)
        objects[i]:setDead()
        gameManager:decreaseEnemy()
      end
    end
  end
end


--[[ -- DEPRICATED 
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

--]]