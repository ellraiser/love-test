-- love.timer


-- love.timer.getAverageDelta
-- @NOTE not sure if you could reliably get a specific delta?
love.test.timer.getAverageDelta = function(test)
  test:assertNotEquals(nil, love.timer.getAverageDelta())
end

-- love.timer.getDelta
-- @NOTE not sure if you could reliably get a specific delta?
love.test.timer.getDelta = function(test)
  test:assertNotEquals(nil, love.timer.getDelta())
end


-- love.timer.getFPS
-- @NOTE not sure if you could reliably get a specific FPS?
love.test.timer.getFPS = function(test)
  test:assertNotEquals(nil, love.timer.getFPS())
end


-- love.timer.getTime
love.test.timer.getTime = function(test)
  local starttime = love.timer.getTime()
  love.timer.sleep(1)
  local endtime = love.timer.getTime() - starttime
  test:assertEquals(1, math.floor(endtime))
end


-- love.timer.sleep
love.test.timer.sleep = function(test)
  local starttime = love.timer.getTime()
  love.timer.sleep(1)
  test:assertEquals(1, math.floor(love.timer.getTime() - starttime))
end


-- love.timer.step
-- @NOTE not sure if you could reliably get a specific step val?
love.test.timer.step = function(test)
  test:assertNotEquals(nil, love.timer.step())
end