-- love.sound


-- love.sound.newDecoder
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.sound.newDecoder = function(test)
  local decoder = love.sound.newDecoder('click.ogg')
  test:assertNotEquals(nil, decoder)
  test:assertEquals('userdata', type(decoder))
  test:assertNotEquals(nil, decoder:type())
end


-- love.sound.newSoundData
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.sound.newSoundData = function(test)
  local sounddata = love.sound.newSoundData('click.ogg')
  test:assertNotEquals(nil, sounddata)
  test:assertEquals('userdata', type(sounddata))
  test:assertNotEquals(nil, sounddata:type())
  local soundbeep = love.sound.newSoundData(math.floor((1/32)*44100), 44100, 16, 1)
  test:assertNotEquals(nil, soundbeep)
  test:assertEquals('userdata', type(soundbeep))
  test:assertNotEquals(nil, soundbeep:type())
end