-- love.font


-- love.font.newBMFontRasterizer
-- @NOTE the wiki specifies diff. params to source code and trying to do 
-- what source code wants gives some errors still
love.test.font.newBMFontRasterizer = function(test)
  test:skipTest()
end


-- love.font.newGlyphData
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.font.newGlyphData = function(test)
  local img = love.image.newImageData('love.png')
  local rasterizer = love.font.newImageRasterizer(img, 'ABC', 0, 1);
  local glyphdata = love.font.newGlyphData(rasterizer, 65)
  test:assertNotEquals(nil, glyphdata)
  test:assertEquals('userdata', type(glyphdata))
  test:assertNotEquals(nil, glyphdata:type())
  img:release()
  rasterizer:release()
  glyphdata:release()
end


-- love.font.newImageRasterizer
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.font.newImageRasterizer = function(test)
  local img = love.image.newImageData('love.png')
  local rasterizer = love.font.newImageRasterizer(img, 'ABC', 0, 1);
  test:assertNotEquals(nil, rasterizer)
  test:assertEquals('userdata', type(rasterizer))
  test:assertNotEquals(nil, rasterizer:type())
  img:release()
  rasterizer:release()
end


-- love.font.newRasterizer
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.font.newRasterizer = function(test)
  local rasterizer = love.font.newRasterizer('font.ttf');
  test:assertNotEquals(nil, rasterizer)
  test:assertEquals('userdata', type(rasterizer))
  test:assertNotEquals(nil, rasterizer:type())
  rasterizer:release()
end


-- love.font.newTrueTypeRasterizer
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.font.newTrueTypeRasterizer = function(test)
  local defaltraster = love.font.newTrueTypeRasterizer(12, "normal", 1)
  local customraster = love.font.newTrueTypeRasterizer('font.ttf', 8, "normal", 1)
  test:assertNotEquals(nil, defaltraster)
  test:assertEquals('userdata', type(defaltraster))
  test:assertNotEquals(nil, defaltraster:type())
  test:assertNotEquals(nil, customraster)
  test:assertEquals('userdata', type(customraster))
  test:assertNotEquals(nil, customraster:type())
  customraster:release()
end