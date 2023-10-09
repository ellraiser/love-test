-- love.thread


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
----------------------------------OBJECTS---------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


-- Channel (love.thread.newChannel)
love.test.thread.Channel = function(test)
  test:skipTest('test class needs writing')
end


-- Thread (love.thread.newThread)
love.test.thread.Thread = function(test)
  test:skipTest('test class needs writing')
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
----------------------------------METHODS---------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


-- love.thread.getChannel
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.thread.getChannel = function(test)
  test:assertObject(love.thread.getChannel('test'))
end


-- love.thread.newChannel
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.thread.newChannel = function(test)
  test:assertObject(love.thread.newChannel())
end


-- love.thread.newThread
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.thread.newThread = function(test)
  test:assertObject(love.thread.newThread('classes/TestSuite.lua'))
end
