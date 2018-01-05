-- shockwave test
local Shockwave = {}

function Shockwave:new()
  local shockwave = {}
  shockwave.maxTime = 1.0
  shockwave.elapsedTime = 0
-- debugonly
  --shockwave.elapsedTime = shockwave.maxTime
  shockwave.speed = 0.0185
  shockwave.active = false
  shockwave.windowWidth = 0
  shockwave.windowHeight = 0
  
  shockwave.shader = love.graphics.newShader [[
    // uniform float screenWidth;
    extern vec2 center; // position
    extern number time; // elapsed time
    extern vec3 shockParams;
    //extern number screenWidth;
    //extern number screenHeight;
    
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
      // unnecessary?
      vec2 uv = texture_coords;
      vec2 texCoord = uv;
      vec2 newCenter = center;
      
      //newCenter.x = newCenter.x / screenWidth;
      //newCenter.y = newCenter.y / screenHeight;
      
      number distance = distance(uv, newCenter);
      if ( (distance <= (time + shockParams.z)) && (distance >= (time - shockParams.z)))
      {
        number diff = (distance - time);
        number powDiff = 1.0 - pow(abs(diff * shockParams.x), shockParams.y);
        
        number diffTime = diff * powDiff;
        vec2 diffUV = normalize(uv - newCenter);
        texCoord = uv + (diffUV * diffTime);
      }
      return Texel(texture, texCoord);
      //vec4 pixel = Texel(texture, texCoord);
      //return pixel;
    }
  ]] 
  
  -- x, y in screen pixels eg. 500, 400
  function shockwave:start(params)
    self.active = true

    self.elapsedTime = 0
--    debugonly
    --self.elapsedTime = self.maxTime
    local mode =  nil
    self.windowWidth, self.windowHeight, mode = love.window.getMode()
--    local scalex = self.windowWidth / mode.minwidth
--    local scaley = self.windowHeight / mode.minheight
--    print(self.windowWidth .. " " .. self.windowHeight)

--    self.shader:send("center", {params[1] / scalex, params[2] / scaley} )
--    self.shader:send("center", {params[1] / 800, params[2] / 600} )--{params[1] / shockwave.windowWidth,  params[2] / shockwave.windowHeight } )
    --print("playerx = " .. params[1] .. " playery = " .. params[2])
    self.shader:send("center", {params[1] / self.windowWidth,  params[2] / self.windowHeight } )
    --print("centerx = " .. params[1] / self.windowWidth.. " centery = " .. params[2] / self.windowHeight)
    self.shader:send("shockParams", {10.0, 0.8, 0.1} )
   --self.shader:send("shockParams", {10.0 * scalex, 0.8 * scaley, 0.1} )
    self.shader:send("time", self.elapsedTime)
    
  end
  
  function shockwave:set()
    if self.active then
      love.graphics.setShader(self.shader)
    end
  end
  
  
  function shockwave:unset()
    love.graphics.setShader()
  end
  
  function shockwave:update(dt)
    if self.active then
      if self.elapsedTime == self.maxTime then
              self.active = false
      else
        self.elapsedTime = self.elapsedTime + self.speed

        if self.elapsedTime >= self.maxTime then --     
          self.elapsedTime = self.maxTime
        end
        --print(self.elapsedTime)
        self.shader:send("time", self.elapsedTime)
      end
    end
  end
  
  -- for debug only 
  --[[ DEPRICATED ]]--
  function shockwave:update2(dt)
    if self.active then
--      shockwave.elapsedTime = shockwave.elapsedTime + shockwave.speed
 --     if shockwave.elapsedTime >= shockwave.maxTime then
      -- debug only!
      if self.elapsedTime == 0 then
              self.active = false
      else
        self.elapsedTime = self.elapsedTime - self.speed

        if self.elapsedTime < 0 then --     
          self.elapsedTime = 0
        end
        --print(self.elapsedTime)
        self.shader:send("time", self.elapsedTime)
      end
    end
  end
  
  return shockwave  
end

return Shockwave

