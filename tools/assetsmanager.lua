local AssetsManager = {}

function AssetsManager:create()
  self.assets {}
end

function AssetsManager:add(asset, name, assetType)
  assert(asset ~= nil)
  assert(type(name) == "string")
  assert(type(assetType) == "string")
  local obj = { asset = asset, assetType = assetType }
  self.assets[name] = obj
end

function AssetsManager:get(name)
  return self.assets[name]
end

return AssetsManager