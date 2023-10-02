-- love.image


-- love.image.isCompressed
-- @NOTE really we need to test each of the files listed here:
-- https://love2d.org/wiki/CompressedImageFormat
love.test.image.isCompressed = function(test)
  local compressed = love.image.isCompressed('love.dxt1')
  test:assertEquals(true, compressed)
end


-- love.image.newCompressedData
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.image.newCompressedData = function(test)
  local imgdata = love.image.newCompressedData('love.dxt1')
  test:assertNotEquals(nil, imgdata)
  test:assertEquals('userdata', type(imgdata))
  test:assertNotEquals(nil, imgdata:type())
end


-- love.image.newImageData
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.image.newImageData = function(test)
  local imgdata = love.image.newImageData('love.png')
  local rawdata = love.image.newImageData(16, 16, 'rgba8', nil)
  test:assertNotEquals(nil, imgdata)
  test:assertEquals('userdata', type(imgdata))
  test:assertNotEquals(nil, imgdata:type())
  test:assertNotEquals(nil, rawdata)
  test:assertEquals('userdata', type(rawdata))
  test:assertNotEquals(nil, rawdata:type())
end