local ShaderManager = {}

function ShaderManager:new()
  local shaderManager = {}
  shaderManager.shaders = {}
  shaderManager.activeShaderName = nil
  
  function shaderManager:add(shader, name)
    assert(type(shader) ~= nil)
    assert(type(name) == "string")
    self.shaders[name] = shader
  end
  
  function shaderManager:remove(name)
    self.shaders[name] = nil
  end
  
  function shaderManager:get(name)
    return self.shaders[name]
  end
  
  function shaderManager:setActiveShader(name)
    local shader = self.shaders[name]
    assert(shader ~= nil)
    self.activeShader = shader
  end
  
  -- param - table 
  function shaderManager:startShader(params)
    --self.shaders[self.activeShaderName]:start(params)
    self.activeShader:start(params)
  end
  
  function shaderManager:update(dt)
    if self.activeShader ~= nil then
      --self.shaders[self.activeShaderName]:update(dt)
      self.activeShader:update(dt)
    end
    --[[
    for _, shader in ipairs(self.shaders) do
      shader:update(dt)
    end
    ]]
  end
  
  function shaderManager:set()    
    if self.activeShader ~= nil then
      --self.shader[self.activeShaderName]:set()
      self.activeShader:set()
    end
  end
  
  function shaderManager:unset()
    love.graphics.setShader()
  end
  
  return shaderManager
end

return ShaderManager