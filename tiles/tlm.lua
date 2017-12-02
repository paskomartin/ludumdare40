local Tlm = {}

local quad = love.graphics.newQuad 

-- all sprite tiles --
local quads = {}

function tile(x,y,w,h,quad)
  local tile = {}
  
  tile.pos = require("tools/vec2"):new(x,y)
  tile.size = require("tools/vec2"):new(w,h)
  tile.quad = quad
  
  return tile
end


function Tlm:genQuads()
    local cols = self.imagewidth / self.tilewidth
    local rows = self.imageheight / self.tileheight
    for row=1, rows, 1 do
      for col=1, cols, 1 do
        local q = quad( col  * self.tilewidth - self.tilewidth, row * self.tileheight - self.tileheight, self.tilewidth, self.tileheight, self.imagewidth, self.imageheight)
        table.insert(quads, q)
      end
    end
end

function Tlm:create() --tilename)
  --assert(type(tilename) == "sprite")
  self.tiles = {}
  --self.img = asm:get(tilename) --love.graphics.newImage("assets/images/tiles16x16.png")
  --self.img:setFilter("nearest","nearest")
  
  gameManager.renderer:add(self)
end

function Tlm:drawWalls()
  for i=1, #self.walls, 1 do
    local tile = self.walls[i]
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("line", tile.pos.x, tile.pos.y, tile.size.x, tile.size.y)
    love.graphics.setColor(255, 255, 255)
  end
end

function Tlm:draw()
  --for i = 1, #self.tiles do
  --  for j = 1, #self.tiles do
  for layer = 1, #self.tiles do
    for i = 1, self.mapheight do
      for j =1, self.mapwidth do
      
        --if self.tiles[i][j] ~= nil then
        if self.tiles[layer][i][j] ~= nil then
          local tile = self.tiles[layer][i][j]
          love.graphics.draw(self.img, tile.quad, tile.pos.x, tile.pos.y) --, 0, 1, 1)
        end
        
      end
    end
  end
  
  self:drawWalls()
end

function Tlm:isSolidAtPos(x, y)
  local solids = self.tiles[2]
  
  if solids[y][x] ~= nil then
    print("solid")
    return true
  end
  return false
end

function Tlm:loadmap(mapname)
  local map = require("assets/maps/" .. mapname)
  
  for layer = 1, #map.layers do
    self.tiles[layer] = {}
    for i = 1, map.height do
      self.tiles[layer][i] = {}
    end
  end
  --[[
  for i = 1, map.height do
    self.tiles[i] = {}
  end
  ]]
  
  self.mapwidth = map.width
  self.mapheight = map.height
  self.tilewidth = map.tilewidth
  self.tileheight = map.tileheight
  self.imagewidth = map.tilesets[1].imagewidth
  self.imageheight = map.tilesets[1].imageheight
  
  -- tiles graphics
  local tilesName = map.tilesets[1].name
  self.img = love.graphics.newImage("assets/sprites/" .. tilesName .. ".png")
  self.img:setFilter("nearest","nearest")
  
  asm:add(self.img, tilesName, "image")

  
  Tlm:genQuads()
  self.walls = {}
  
  for layer = 1, #map.layers do
    
    -- build walls
    if map.layers[layer].type == "objectgroup" then 
      
      local walls = map.layers[layer].objects
      
      for _, val in ipairs(walls) do
        local wall = {}
        wall.pos = require("tools/vec2"):new(val.x, val.y)
        wall.size = require("tools/vec2"):new(val.width, val.height)
        --local wall = require("objects/rect"):new(val.x, val.y, val.height, val.width)
        table.insert(self.walls, wall)
      end
      
      
    elseif map.layers[layer].type == "tilelayer" then
      
      local data = map.layers[layer].data
      local prop = map.layers[layer].properties
  
  
      for y = 1, map.height do
        for x = 1, map.width do
          
          local index = (y * map.width + (x - 1) - map.width) + 1
          if data[index] ~= 0 and data[index] ~= nil then
            
            local q = quads[data[index]]
            self.tiles[layer][y][x] = tile (self.tilewidth * x - self.tilewidth, self.tileheight * y - self.tileheight, tilewidth, tileheight, q)
          end
        end
      end
      
    end
  end
  
end

function Tlm:clear()
  self.mapwidth = 0
  self.mapheight = 0
  self.tilewidth = 0
  self.tileheight = 0
  self.imagewidth = 0
  self.imageheight = 0
  self.tiles = {}
  self.img = nil
  
  self.walls = {}
end



function Tlm:destroy()
  
end

return Tlm