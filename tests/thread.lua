-- love.thread


-- love.thread.getChannel
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.thread.getChannel = function(test)
  local channel = love.thread.getChannel('test')
  test:assertNotEquals(nil, channel)
  test:assertEquals('userdata', type(channel))
  test:assertNotEquals(nil, channel:type())
  channel:release()
end


-- love.thread.newChannel
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.thread.newChannel = function(test)
  local channel = love.thread.newChannel()
  test:assertNotEquals(nil, channel)
  test:assertEquals('userdata', type(channel))
  test:assertNotEquals(nil, channel:type())
  channel:release()
end


-- love.thread.newThread
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.thread.newThread = function(test)
  local thread = love.thread.newThread('lovetest.lua')
  test:assertNotEquals(nil, thread)
  test:assertEquals('userdata', type(thread))
  test:assertNotEquals(nil, thread:type())
  thread:release()
end