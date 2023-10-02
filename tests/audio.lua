-- love.audio


-- love.audio.getActiveEffects
love.test.audio.getActiveEffects = function(test)
  -- tests
  test:assertNotEquals(nil, love.audio.getActiveEffects())
  test:assertEquals(0, #love.audio.getActiveEffects())
  love.audio.setEffect('testeffect', {
    type = 'chorus',
    volume = 10
  })
  test:assertEquals(1, #love.audio.getActiveEffects())
  test:assertEquals('testeffect', love.audio.getActiveEffects()[1])
end


-- love.audio.getActiveSourceCount
love.test.audio.getActiveSourceCount = function(test)
  -- tests
  test:assertNotEquals(nil, love.audio.getActiveSourceCount()) -- always number
  test:assertEquals(0, love.audio.getActiveSourceCount()) -- 0 def
  local testsource = love.audio.newSource('click.ogg', 'static')
  test:assertEquals(0, love.audio.getActiveSourceCount())
  love.audio.play(testsource)
  test:assertEquals(1, love.audio.getActiveSourceCount())
  love.audio.pause()
  testsource:release()
end


-- love.audio.getDistanceModel
love.test.audio.getDistanceModel = function(test)
  -- tests
  test:assertNotEquals(nil, love.audio.getDistanceModel()) -- always string
  test:assertEquals('inverseclamped', love.audio.getDistanceModel()) -- def val
  love.audio.setDistanceModel('inverse')
  test:assertEquals('inverse', love.audio.getDistanceModel())
end


-- love.audio.getDopplerScale
love.test.audio.getDopplerScale = function(test)
  test:assertEquals(1, love.audio.getDopplerScale())
  love.audio.setDopplerScale(0)
  test:assertEquals(0, love.audio.getDopplerScale())
  love.audio.setDopplerScale(1)
end


-- love.audio.getEffect
love.test.audio.getEffect = function(test)
  -- setup
  love.audio.setEffect('testeffect', {
    type = 'chorus',
    volume = 10
  })
  -- tests
  test:assertEquals(nil, love.audio.getEffect('madeupname'))
  test:assertNotEquals(nil, love.audio.getEffect('testeffect'))
  test:assertEquals('chorus', love.audio.getEffect('testeffect').type)
  test:assertEquals(10, love.audio.getEffect('testeffect').volume)
end


-- love.audio.getMaxSceneEffects
-- @NOTE feel like this is platform specific number so best we can do is a nil?
love.test.audio.getMaxSceneEffects = function(test)
  test:assertNotEquals(nil, love.audio.getMaxSceneEffects())
end


-- love.audio.getMaxSourceEffects
-- @NOTE feel like this is platform specific number so best we can do is a nil?
love.test.audio.getMaxSourceEffects = function(test)
  test:assertNotEquals(nil, love.audio.getMaxSourceEffects())
end


-- love.audio.getOrientation
-- @NOTE is there an expected default listener pos?
love.test.audio.getOrientation = function(test)
  -- setup
  love.audio.setOrientation(1, 2, 3, 4, 5, 6)
  -- tests
  local fx, fy, fz, ux, uy, uz = love.audio.getOrientation()
  test:assertEquals(1, fx)
  test:assertEquals(2, fy)
  test:assertEquals(3, fz)
  test:assertEquals(4, ux)
  test:assertEquals(5, uy)
  test:assertEquals(6, uz)
end


-- love.audio.getPosition
-- @NOTE is there an expected default listener pos?
love.test.audio.getPosition = function(test)
  -- setup
  love.audio.setPosition(1, 2, 3)
  -- tests
  local x, y, z = love.audio.getPosition()
  test:assertEquals(1, x)
  test:assertEquals(2, y)
  test:assertEquals(3, z)
end


-- love.audio.getRecordingDevices
love.test.audio.getRecordingDevices = function(test)
  test:assertNotEquals(nil, love.audio.getRecordingDevices())
end


-- love.audio.getVelocity
love.test.audio.getVelocity = function(test)
  -- setup
  love.audio.setVelocity(1, 2, 3)
  -- tests
  local x, y, z = love.audio.getVelocity()
  test:assertEquals(1, x)
  test:assertEquals(2, y)
  test:assertEquals(3, z)
end


-- love.audio.getVolume
love.test.audio.getVolume = function(test)
  -- setup
  love.audio.setVolume(0.5)
  -- tests
  test:assertNotEquals(nil, love.audio.getVolume())
  test:assertEquals(0.5, love.audio.getVolume())
end


-- love.audio.isEffectsSupported
love.test.audio.isEffectsSupported = function(test)
  test:assertNotEquals(nil, love.audio.isEffectsSupported())
end


-- love.audio.newQueueableSource
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.audio.newQueueableSource = function(test)
  local source = love.audio.newQueueableSource(32, 8, 1, 8)
  test:assertNotEquals(nil, source)
  test:assertEquals('userdata', type(source))
  test:assertNotEquals(nil, source:type())
  source:release()
end


-- love.audio.newSource
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.audio.newSource = function(test)
  -- setup
  local source1 = love.audio.newSource('click.ogg', 'static')
  local source2 = love.audio.newSource('click.ogg', 'stream')
  -- tests
  test:assertNotEquals(nil, source1)
  test:assertEquals('userdata', type(source1))
  test:assertNotEquals(nil, source1:type())
  test:assertNotEquals(nil, source2)
  test:assertEquals('userdata', type(source2))
  test:assertNotEquals(nil, source2:type())
  -- cleanup
  source1:release()
  source2:release()
end


-- love.audio.pause
love.test.audio.pause = function(test)
  -- tests
  local nopauses = love.audio.pause()
  test:assertNotEquals(nil, nopauses)
  test:assertEquals(0, #nopauses)
  local source = love.audio.newSource('click.ogg', 'static')
  love.audio.play(source)
  local onepause = love.audio.pause()
  test:assertEquals(1, #onepause)
  source:release()
end


-- love.audio.play
love.test.audio.play = function(test)
  -- setup
  local source = love.audio.newSource('click.ogg', 'static')
  -- tests
  love.audio.play(source)
  test:assertEquals(true, source:isPlaying())
  love.audio.pause()
  source:release()
end


-- love.audio.setDistanceModel
love.test.audio.setDistanceModel = function(test)
  -- tests
  local distancemodel = {
    'none', 'inverse', 'inverseclamped', 'linear', 'linearclamped',
    'exponent', 'exponentclamped'
  }
  for d=1,#distancemodel do
    love.audio.setDistanceModel(distancemodel[d])
    test:assertEquals(distancemodel[d], love.audio.getDistanceModel())
  end
end


-- love.audio.setDopplerScale
love.test.audio.setDopplerScale = function(test)
  -- tests
  love.audio.setDopplerScale(0)
  test:assertEquals(0, love.audio.getDopplerScale())
  love.audio.setDopplerScale(1)
  test:assertEquals(1, love.audio.getDopplerScale())
end


-- love.audio.setEffect
love.test.audio.setEffect = function(test)
  -- tests
  local effect = love.audio.setEffect('testeffect', {
    type = 'chorus',
    volume = 10
  })
  test:assertEquals(true, effect)
  local settings = love.audio.getEffect('testeffect')
  test:assertEquals('chorus', settings.type)
  test:assertEquals(10, settings.volume)
end


-- love.audio.setMixWithSystem
love.test.audio.setMixWithSystem = function(test)
  test:assertNotEquals(nil, love.audio.setMixWithSystem(true))
end


-- love.audio.setOrientation
love.test.audio.setOrientation = function(test)
  -- setup
  love.audio.setOrientation(1, 2, 3, 4, 5, 6)
  -- tests
  local fx, fy, fz, ux, uy, uz = love.audio.getOrientation()
  test:assertEquals(1, fx)
  test:assertEquals(2, fy)
  test:assertEquals(3, fz)
  test:assertEquals(4, ux)
  test:assertEquals(5, uy)
  test:assertEquals(6, uz)
end


-- love.audio.setPosition
love.test.audio.setPosition = function(test)
  -- setup
  love.audio.setPosition(1, 2, 3)
  -- tests
  local x, y, z = love.audio.getPosition()
  test:assertEquals(1, x)
  test:assertEquals(2, y)
  test:assertEquals(3, z)
end


-- love.audio.setVelocity
love.test.audio.setVelocity = function(test)
  -- setup
  love.audio.setVelocity(1, 2, 3)
  -- tests
  local x, y, z = love.audio.getVelocity()
  test:assertEquals(1, x)
  test:assertEquals(2, y)
  test:assertEquals(3, z)
end


-- love.audio.setVolume
love.test.audio.setVolume = function(test)
  -- setup
  love.audio.setVolume(0.5)
  -- tests
  test:assertNotEquals(nil, love.audio.getVolume())
  test:assertEquals(0.5, love.audio.getVolume())
end


-- love.audio.stop
love.test.audio.stop = function(test)
  -- setup
  local source = love.audio.newSource('click.ogg', 'static')
  love.audio.play(source)
  -- tests
  test:assertEquals(true, source:isPlaying())
  love.audio.stop()
  test:assertEquals(false, source:isPlaying())
  source:release()
end