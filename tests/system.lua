-- love.system


-- love.system.getClipboardText
love.test.system.getClipboardText = function(test)
  -- ignore if not using window
  if love.test.windowmode == false then return test:skipTest() end
  -- setup
  love.system.setClipboardText('helloworld')
  -- test
  test:assertEquals('helloworld', love.system.getClipboardText())
end


-- love.system.getOS
love.test.system.getOS = function(test)
  local os = love.system.getOS()
  test:assertMatch({'OS X', 'Windows', 'Linux', 'Android', 'iOS'}, os)
end


-- love.system.getPowerInfo
love.test.system.getPowerInfo = function(test)
  local state, percent, seconds = love.system.getPowerInfo()
  test:assertMatch({'unknown', 'battery', 'nobattery', 'charging', 'charged'}, state)
  if percent ~= nil then
    test:assertRange(percent, 0, 100)
  end
  if seconds ~= nil then
    test:assertRange(seconds, 0, 100)
  end
end


-- love.system.getProcessorCount
love.test.system.getProcessorCount = function(test)
  test:assertGreaterEqual(0, love.system.getProcessorCount()) -- youd hope right
end


-- love.system.hasBackgroundMusic
love.test.system.hasBackgroundMusic = function(test)
  test:assertNotEquals(nil, love.system.hasBackgroundMusic())
end


-- love.system.openURL
love.test.system.openURL = function(test)
  test:assertNotEquals(nil, love.system.openURL('https://love2d.org'))
end


-- love.system.getClipboardText
love.test.system.setClipboardText = function(test)
  -- ignore if not using window
  if love.test.windowmode == false then return test:skipTest() end
  -- test
  love.system.setClipboardText('helloworld')
  test:assertEquals('helloworld', love.system.getClipboardText())
end


-- love.system.vibrate
-- @NOTE cant really test this
love.test.system.vibrate = function(test)
  test:skipTest()
end