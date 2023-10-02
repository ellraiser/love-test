-- love.physics


-- love.physics.getDistance
love.test.physics.getDistance = function(test)
  local shape1 = love.physics.newEdgeShape(0, 0, 5, 5)
  local shape2 = love.physics.newEdgeShape(10, 10, 15, 15)
  local world = love.physics.newWorld(0, 0, false)
  local body = love.physics.newBody(world, 10, 10, 'static')
  local fixture1 = love.physics.newFixture(body, shape1, 1)
  local fixture2 = love.physics.newFixture(body, shape2, 1)
  test:assertEquals(647106, math.floor(love.physics.getDistance(fixture1, fixture2)*100000))
  fixture1:release()
  fixture2:release()
  body:release()
  world:release()
  shape1:release()
  shape2:release()
end


-- love.physics.getMeter
love.test.physics.getMeter = function(test)
  love.physics.setMeter(30)
  test:assertEquals(30, love.physics.getMeter())
end


-- love.physics.newBody
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newBody = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body = love.physics.newBody(world, 10, 10, 'static')
  test:assertNotEquals(nil, body)
  test:assertEquals('userdata', type(body))
  test:assertNotEquals(nil, body:type())
  body:release()
  world:release()
end


-- love.physics.newChainShape
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newChainShape = function(test)
  local obj = love.physics.newChainShape(true, 0, 0, 1, 0, 1, 1, 0, 1)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
end


-- love.physics.newCircleShape
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newCircleShape = function(test)
  local obj = love.physics.newCircleShape(10)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
end


-- love.physics.newDistanceJoint
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newDistanceJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newDistanceJoint(body1, body2, 10, 10, 20, 20, true)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
  body1:release()
  body2:release()
  world:release()
end


-- love.physics.newEdgeShape
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newEdgeShape = function(test)
  local obj = love.physics.newEdgeShape(0, 0, 10, 10)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
end


-- love.physics.newFixture
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newFixture = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body = love.physics.newBody(world, 10, 10, 'static')
  local shape = love.physics.newCircleShape(10)
  local obj = love.physics.newFixture(body, shape, 1)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
  shape:release()
  body:release()
  world:release()
end


-- love.physics.newFrictionJoint
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newFrictionJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newFrictionJoint(body1, body2, 15, 15, true)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
  body1:release()
  body2:release()
  world:release()
end


-- love.physics.newGearJoint
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newGearJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local body3 = love.physics.newBody(world, 30, 30, 'static')
  local body4 = love.physics.newBody(world, 40, 40, 'static')
  local joint1 = love.physics.newPrismaticJoint(body1, body2, 10, 10, 20, 20, true)
  local joint2 = love.physics.newPrismaticJoint(body3, body4, 30, 30, 40, 40, true)
  local obj = love.physics.newGearJoint(joint1, joint2, 1, true)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
  joint1:release()
  joint2:release()
  body1:release()
  body2:release()
  body3:release()
  body4:release()
  world:release()
end


-- love.physics.newMotorJoint
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newMotorJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newMotorJoint(body1, body2, 1)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
  body1:release()
  body2:release()
  world:release()
end


-- love.physics.newMouseJoint
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newMouseJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body = love.physics.newBody(world, 10, 10, 'static')
  local obj = love.physics.newMouseJoint(body, 10, 10)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
  body:release()
  world:release()
end


-- love.physics.newPolygonShape
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newPolygonShape = function(test)
  local obj = love.physics.newPolygonShape({0, 0, 2, 3, 2, 1, 3, 1, 5, 1})
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
end


-- love.physics.newPrismaticJoint
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newPrismaticJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newPrismaticJoint(body1, body2, 10, 10, 20, 20, true)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
  body1:release()
  body2:release()
  world:release()
end


-- love.physics.newPulleyJoint
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newPulleyJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newPulleyJoint(body1, body2, 10, 10, 20, 20, 15, 15, 25, 25, 1, true)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
  body1:release()
  body2:release()
  world:release()
end


-- love.physics.newRectangleShape
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newRectangleShape = function(test)
  local shape1 = love.physics.newRectangleShape(10, 20)
  local shape2 = love.physics.newRectangleShape(10, 10, 40, 30, 10)
  test:assertNotEquals(nil, shape1)
  test:assertEquals('userdata', type(shape1))
  test:assertNotEquals(nil, shape1:type())
  test:assertNotEquals(nil, shape2)
  test:assertEquals('userdata', type(shape2))
  test:assertNotEquals(nil, shape2:type())
end


-- love.physics.newRevoluteJoint
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newRevoluteJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newRevoluteJoint(body1, body2, 10, 10, true)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
  body1:release()
  body2:release()
  world:release()
end


-- love.physics.newRopeJoint
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newRopeJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newRopeJoint(body1, body2, 10, 10, 20, 20, 50, true)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
  body1:release()
  body2:release()
  world:release()
end


-- love.physics.newWeldJoint
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newWeldJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newWeldJoint(body1, body2, 10, 10, true)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
  body1:release()
  body2:release()
  world:release()
end


-- love.physics.newWheelJoint
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newWheelJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newWheelJoint(body1, body2, 10, 10, 5, 5, true)
  test:assertNotEquals(nil, obj)
  test:assertEquals('userdata', type(obj))
  test:assertNotEquals(nil, obj:type())
  obj:release()
  body1:release()
  body2:release()
  world:release()
end


-- love.physics.newWorld
-- @NOTE this is just basic nil checking, full obj test are in objects.lua
love.test.physics.newWorld = function(test)
  local world = love.physics.newWorld(1, 1, true)
  test:assertNotEquals(nil, world)
  test:assertEquals('userdata', type(world))
  test:assertNotEquals(nil, world:type())
  world:release()
end


-- love.physics.setMeter
love.test.physics.setMeter = function(test)
  local world = love.physics.newWorld(1, 1, true)
  love.physics.setMeter(30)
  local body = love.physics.newBody(world, 300, 300, "dynamic")
  love.physics.setMeter(10)
  local x, y = body:getPosition()
  test:assertEquals(100, x)
  test:assertEquals(100, y)
  body:release()
  world:release()
end