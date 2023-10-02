-- love.video


-- love.video.newVideoStream
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.video.newVideoStream = function(test)
  local videostream = love.video.newVideoStream('sample.ogv')
  test:assertNotEquals(nil, videostream)
  test:assertEquals('userdata', type(videostream))
  test:assertNotEquals(nil, videostream:type())
  videostream:release()
end