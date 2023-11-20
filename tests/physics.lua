-- love.physics


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
----------------------------------OBJECTS---------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


-- Body (love.physics.newBody)
love.test.physics.Body = function(test)
  test:skipTest('@TODO test class needs writing')
end


-- Contact (love.physics.World:getContacts)
love.test.physics.Contact = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 0, 0, 'dynamic')
  local body2 = love.physics.newBody(world, 10, 10, 'dynamic')
  local rectangle1 = love.physics.newRectangleShape(body1, 0, 0, 10, 10)
  local rectangle2 = love.physics.newRectangleShape(body2, 0, 0, 10, 10)
  rectangle1:setUserData('rec1')
  rectangle2:setUserData('rec2')
  local collided = false
  local pass = 1
  world:setCallbacks(
    function(shape_a, shape_b, contact)
      collided = true
      test:assertObject(contact)
      local indexA, indexB = contact:getChildren()
      test:assertEquals(1, indexA, 'check child indice a')
      test:assertEquals(1, indexB, 'check child indice b')
      local shapeA, shapeB = contact:getShapes()
      test:assertEquals(shape_a:getUserData(), shapeA:getUserData(), 'check shape a matches')
      test:assertEquals(shape_b:getUserData(), shapeB:getUserData(), 'check shape b matches')
      local nx, ny = contact:getNormal()
      test:assertEquals(1, nx, 'check normal x')
      test:assertEquals(0, ny, 'check normal y')
      local px1, py1, px2, py2 = contact:getPositions()
      test:assertEquals(5, math.floor(px1), 'check collide x 1')
      test:assertEquals(5, math.floor(py1), 'check collide y 1')
      test:assertEquals(5, math.floor(px2), 'check collide x 2')
      test:assertEquals(5, math.floor(py2), 'check collide y 2')
      test:assertEquals(true, contact:isTouching(), 'check touching')
      test:assertEquals(pass == 1, contact:isEnabled(), 'check enabled for pass ' .. tostring(pass))
      test:assertEquals(2, math.floor(contact:getFriction()*10), 'check def friction')
      contact:setFriction(0.1)
      test:assertEquals(1, math.floor(contact:getFriction()*10), 'check set friction')
      contact:resetFriction()
      test:assertEquals(2, math.floor(contact:getFriction()*10), 'check reset friction')
      test:assertEquals(0, contact:getRestitution(), 'check def restitution')
      contact:setRestitution(1)
      test:assertEquals(1, contact:getRestitution(), 'check set restitution')
      contact:resetRestitution()
      test:assertEquals(0, contact:getRestitution(), 'check reset restitution')
      pass = pass + 1
    end, function() end, function(shape_a, shape_b, contact) 
      if pass > 2 then
        contact:setEnabled(false)
      end
    end, function() end
  )
  world:update(1)
  test:assertEquals(true, collided, 'check bodies collided')
  -- update again for enabled check
  world:update(1)
  test:assertEquals(2, pass, 'check ran twice')
end


-- Joint (love.physics.newDistanceJoint)
love.test.physics.Joint = function(test)
  -- make joint
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'dynamic')
  local body2 = love.physics.newBody(world, 20, 20, 'dynamic')
  local joint = love.physics.newDistanceJoint(body1, body2, 10, 10, 20, 20, true)
  test:assertObject(joint)
  -- check props
  test:assertEquals('distance', joint:getType(), 'check joint type')
  test:assertEquals(false, joint:isDestroyed(), 'check not destroyed')
  test:assertEquals(0, joint:getReactionForce(1), 'check reaction force')
  test:assertEquals(0, joint:getReactionTorque(1), 'check reaction torque')
  local b1, b2 = joint:getBodies()
  test:assertEquals(body1:getX(), b1:getX(), 'check body 1')
  test:assertEquals(body2:getX(), b2:getX(), 'check body 2')
  local x1, y1, x2, y2 = joint:getAnchors()
  test:assertEquals(10, math.floor(x1), 'check anchor x1')
  test:assertEquals(10, math.floor(y1), 'check anchor y1')
  test:assertEquals(20, math.floor(x2), 'check anchor x2')
  test:assertEquals(20, math.floor(y2), 'check anchor y2')
  test:assertEquals(true, joint:getCollideConnected(), 'check not colliding')
  -- test userdata
  test:assertEquals(nil, joint:getUserData(), 'check no data by def')
  joint:setUserData('hello')
  test:assertEquals('hello', joint:getUserData(), 'check set userdata')
  -- destroy
  joint:destroy()
  test:assertEquals(true, joint:isDestroyed(), 'check destroyed')
end


--love.test.physics.Test1 = function(test)
--  local world = love.physics.newWorld(0, 0, false)
--  local body1 = love.physics.newBody(world, 0, 0, 'dynamic')
--  local shape1 = love.physics.newRectangleShape(body1, 5, 5, 10, 10)
--  local tlx, tly, brx, bry = shape1:getBoundingBox(1)
--  print('position:', tlx, tly, brx, bry) -- (-0.3, -0.3, 10.3, 10.3)
--  test:assertEquals(true, shape1:testPoint(5, 5), 'check point 1') -- returns false
--end


-- Shape (love.physics.newCircleShape)
-- @NOTE in 12.0 fixtures have been merged into shapes
love.test.physics.Shape = function(test)
  -- create shape
  local world = love.physics.newWorld(0, 0, false)
  local body1 = love.physics.newBody(world, 0, 0, 'dynamic')
  local shape1 = love.physics.newRectangleShape(body1, 5, 5, 10, 10)
  test:assertObject(shape1)
  -- check base properties
  test:assertEquals(1, shape1:getChildCount(), 'check child count')
  test:assertEquals(0, math.floor(shape1:getRadius()), 'check radius')
  test:assertEquals('polygon', shape1:getType(), 'check rectangle type')
  test:assertEquals(0, shape1:getBody():getX(), 'check body link')
  test:assertEquals(1, shape1:getCategory(), 'check def category')
  shape1:setCategory(3, 5, 6)
  local categories = {shape1:getCategory()}
  test:assertEquals(14, categories[1] + categories[2] + categories[3], 'check set category')
  test:assertEquals(false, shape1:isSensor(), 'check sensor def')
  shape1:setSensor(true)
  test:assertEquals(true, shape1:isSensor(), 'check set sensor')
  shape1:setSensor(false)
  test:assertEquals(false, shape1:isDestroyed(), 'check not destroyed')
  test:assertEquals(nil, shape1:getUserData(), 'check no user data')
  shape1:setUserData({ test = 14 })
  test:assertEquals(14, shape1:getUserData().test, 'check user data set')
  -- check bounding box
  -- polygons have an additional skin radius to help with collisions
  -- so this wont be 0, 0, 10, 10 as you'd think but has an additional 0.3 padding
  local topLeftX, topLeftY, bottomRightX, bottomRightY = shape1:computeAABB(0, 0, 0, 1)
  local tlx, tly, brx, bry = shape1:getBoundingBox(1)
  test:assertEquals(topLeftX, tlx, 'check bbox methods match tlx')
  test:assertEquals(topLeftY, tly, 'check bbox methods match tly')
  test:assertEquals(bottomRightX, brx, 'check bbox methods match brx')
  test:assertEquals(bottomRightY, bry, 'check bbox methods match bry')
  test:assertEquals(topLeftX, topLeftY, 'check bbox tl 1')
  test:assertEquals(-3, math.floor(topLeftY*10), 'check bbox tl 2')
  test:assertEquals(bottomRightX, bottomRightY, 'check bbox br 1')
  test:assertEquals(10, math.floor(bottomRightX), 'check bbox br 2')
  -- check physics props
  test:assertEquals(1, shape1:getDensity(), 'check def density')
  shape1:setDensity(5)
  test:assertEquals(5, shape1:getDensity(), 'check set density')
  local x, y, mass, inertia = shape1:getMassData()
  test:assertEquals(5, math.floor(x), 'check shape mass pos x')
  test:assertEquals(5, math.floor(y), 'check shape mass pos y')
  test:assertEquals(5, math.floor(mass*10), 'check mass at 1 density')
  test:assertEquals(0, math.floor(inertia*10), 'check intertia at 1 density')
  x, y, mass, inertia = shape1:computeMass(1000)
  test:assertEquals(111, math.floor(mass), 'check mass at 1000 density')
  test:assertEquals(7407, math.floor(inertia), 'check intertia at 1000 density')
  test:assertEquals(2, math.floor(shape1:getFriction()*10), 'check def friction')
  shape1:setFriction(1)
  test:assertEquals(1, shape1:getFriction(), 'check set friction')
  test:assertEquals(0, shape1:getRestitution(), 'check def restitution')
  shape1:setRestitution(0.5)
  test:assertEquals(5, math.floor(shape1:getRestitution()*10), 'check set restitution')
  -- check points
  local shape2 = love.physics.newRectangleShape(body1, 5, 5, 10, 10)
  tlx, tly, brx, bry = shape2:getBoundingBox(1)
  test:assertEquals(true, shape2:testPoint(5, 5), 'check point 5,5')
  test:assertEquals(true, shape2:testPoint(15, 15, 10, 10, 0), 'check point 15,15 after translate 10,10')
  test:assertEquals(true, shape2:testPoint(15, 15, 10, 10, 90), 'check point 15,15 after translate 10,10,90')
  test:assertEquals(false, shape2:testPoint(5, 5, 10, 10, 90), 'check point 5,5 after translate 10,10,90')
  test:assertEquals(false, shape2:testPoint(15, 15), 'check point 15,15')
  local xn, yn, fraction = shape2:rayCast(-20, -20, 20, 20, 100, 0, 0, 0, 1)
  test:assertNotEquals(nil, xn, 'check ray 1 x')
  test:assertNotEquals(nil, xn, 'check ray 1 y')
  xn, yn, fraction = shape2:rayCast(10, 10, -150, -150, 100, 0, 0, 0, 1)
  test:assertEquals(nil, xn, 'check ray 2 x')
  test:assertEquals(nil, xn, 'check ray 2 y')
  -- check filtering
  test:assertEquals(nil, shape2:getMask(), 'check no mask')
  shape2:setMask(1, 2, 3)
  test:assertEquals(3, #{shape2:getMask()}, 'check set mask')
  test:assertEquals(0, shape2:getGroupIndex(), 'check no index')
  shape2:setGroupIndex(-1)
  test:assertEquals(-1, shape2:getGroupIndex(), 'check set index')
  local cat, mask, group = shape2:getFilterData()
  test:assertEquals(1, cat, 'check filter cat')
  test:assertEquals(65528, mask, 'check filter mask')
  test:assertEquals(-1, group, 'check filter group')
  -- run some collision checks using filters
  shape1:destroy()
  test:assertEquals(true, shape1:isDestroyed(), 'check destroyed')
  shape2:destroy()
  local body2 = love.physics.newBody(world, 5, 5, 'dynamic')
  local shape3 = love.physics.newRectangleShape(body1, 0, 0, 10, 10)
  local shape4 = love.physics.newRectangleShape(body2, 0, 0, 10, 10)
  local collisions = 0
  world:setCallbacks(
    function() collisions = collisions + 1 end,
    function() end,
    function() end,
    function() end
  )
  -- same group will always collide if the group is positive or never collide if it's negative
  shape3:setGroupIndex(1)
  shape4:setGroupIndex(1)
  world:update(1)
  test:assertEquals(1, collisions, 'check positive group collide')
  shape3:setGroupIndex(-1)
  shape4:setGroupIndex(-1)
  body2:setPosition(20, 20); world:update(1); body2:setPosition(0, 0); world:update(1)
  test:assertEquals(1, collisions, 'check negative group collide')
  -- mask sets which categories this fixture should NOT collide with.
  shape3:setGroupIndex(0)
  shape4:setGroupIndex(0)
  shape3:setCategory(2)
  shape4:setMask(3)
  body2:setPosition(20, 20); world:update(1); body2:setPosition(0, 0); world:update(1)
  test:assertEquals(2, collisions, 'check mask collide')
  shape3:setCategory(2)
  shape4:setMask(2, 4, 6)
  body2:setPosition(20, 20); world:update(1); body2:setPosition(0, 0); world:update(1)
  test:assertEquals(2, collisions, 'check mask not collide')
end


-- World (love.physics.newWorld)
love.test.physics.World = function(test)
  -- create new world
  local world = love.physics.newWorld(0, 0, false)
  local body1 = love.physics.newBody(world, 0, 0, 'dynamic')
  local rectangle1 = love.physics.newRectangleShape(body1, 0, 0, 10, 10)
  test:assertObject(world)
  -- check defaults
  test:assertEquals(1, #world:getBodies(), 'check 1 body')
  test:assertEquals(0, world:getBodies()[1]:getX(), 'check body prop x')
  test:assertEquals(0, world:getBodies()[1]:getY(), 'check body prop y')
  world:translateOrigin(-10, -10)
  test:assertEquals(10, math.floor(world:getBodies()[1]:getX()), 'check body prop change x')
  test:assertEquals(10, math.floor(world:getBodies()[1]:getY()), 'check body prop change y')
  test:assertEquals(1, world:getBodyCount(), 'check 1 body count')
  test:assertEquals(false, world:isDestroyed(), 'check not destroyed')
  test:assertEquals(false, world:isLocked(), 'check not updating')
  test:assertEquals(0, #world:getJoints(), 'check no joints')
  test:assertEquals(0, world:getJointCount(), 'check no joints count')
  test:assertEquals(0, world:getGravity(), 'check def gravity')
  test:assertEquals(0, #world:getContacts(), 'check no contacts')
  test:assertEquals(0, world:getContactCount(), 'check no contact count')
  test:assertEquals(false, world:isSleepingAllowed(), 'check no sleep (till brooklyn)')
  world:setSleepingAllowed(true)
  test:assertEquals(true, world:isSleepingAllowed(), 'check can sleep')
  -- check callbacks are called
  local beginContact, endContact, preSolve, postSolve = world:getCallbacks()
  test:assertEquals(nil, beginContact, 'check no begin contact callback')
  test:assertEquals(nil, endContact, 'check no end contact callback')
  test:assertEquals(nil, preSolve, 'check no pre solve callback')
  test:assertEquals(nil, postSolve, 'check no post solve callback')
  local beginContactCheck = false
  local endContactCheck = false
  local preSolveCheck = false
  local postSolveCheck = false
  local collisions = 0
  world:setCallbacks(
    function() beginContactCheck = true; collisions = collisions + 1 end,
    function() endContactCheck = true end,
    function() preSolveCheck = true end,
    function() postSolveCheck = true end
  )
  local body2 = love.physics.newBody(world, 10, 10, 'dynamic')
  local rectangle2 = love.physics.newRectangleShape(body2, 0, 0, 10, 10)
  test:assertEquals(false, beginContactCheck, 'check world didnt update after adding body')
  world:update(1)
  test:assertEquals(true, beginContactCheck, 'check contact start')
  test:assertEquals(true, preSolveCheck, 'check pre solve')
  test:assertEquals(true, postSolveCheck, 'check post solve')
  body2:setPosition(100, 100)
  world:update(1)
  test:assertEquals(true, endContactCheck, 'check contact end')
  -- check point checking
  local shapes = 0
  world:queryShapesInArea(0, 0, 10, 10, function(x)
    shapes = shapes + 1
  end)
  test:assertEquals(1, shapes, 'check shapes in area')
  world:rayCast(0, 0, 200, 200, function(x)
    shapes = shapes + 1
    return 1
  end)
  test:assertEquals(3, shapes, 'check shapes in raycast')
  -- change collision logic
  test:assertEquals(nil, world:getContactFilter(), 'check def filter')
  world:update(1)
  world:setContactFilter(function(s1, s2)
    return false -- nothing collides
  end)
  body2:setPosition(10, 10)
  world:update(1)
  test:assertEquals(1, collisions, 'check collision logic change')
  -- final bits
  world:setGravity(1, 1)
  test:assertEquals(1, world:getGravity(), 'check grav change')
  world:destroy()
  test:assertEquals(true, world:isDestroyed(), 'check world destroyed')
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
------------------------------------METHODS-------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


-- love.physics.getDistance
love.test.physics.getDistance = function(test)
  -- setup two fixtues to check
  local world = love.physics.newWorld(0, 0, false)
  local body = love.physics.newBody(world, 10, 10, 'static')
  local shape1 = love.physics.newEdgeShape(body, 0, 0, 5, 5)
  local shape2 = love.physics.newEdgeShape(body, 10, 10, 15, 15)
  -- check distance between them
  test:assertEquals(647106, math.floor(love.physics.getDistance(shape1, shape2)*100000), 'check distance matches')
end


-- love.physics.getMeter
love.test.physics.getMeter = function(test)
  -- check value set is returned
  love.physics.setMeter(30)
  test:assertEquals(30, love.physics.getMeter(), 'check meter matches')
end


-- love.physics.newBody
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newBody = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body = love.physics.newBody(world, 10, 10, 'static')
  test:assertObject(body)
end


-- love.physics.newChainShape
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newChainShape = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body = love.physics.newBody(world, 10, 10, 'static')
  test:assertObject(love.physics.newChainShape(body, true, 0, 0, 1, 0, 1, 1, 0, 1))
end


-- love.physics.newCircleShape
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newCircleShape = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body = love.physics.newBody(world, 10, 10, 'static')
  test:assertObject(love.physics.newCircleShape(body, 10))
end


-- love.physics.newDistanceJoint
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newDistanceJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newDistanceJoint(body1, body2, 10, 10, 20, 20, true)
  test:assertObject(obj)
end


-- love.physics.newEdgeShape
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newEdgeShape = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body = love.physics.newBody(world, 10, 10, 'static')
  local obj = love.physics.newEdgeShape(body, 0, 0, 10, 10)
  test:assertObject(obj)
end


-- love.physics.newFrictionJoint
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newFrictionJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newFrictionJoint(body1, body2, 15, 15, true)
  test:assertObject(obj)
end


-- love.physics.newGearJoint
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newGearJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'dynamic')
  local body2 = love.physics.newBody(world, 20, 20, 'dynamic')
  local body3 = love.physics.newBody(world, 30, 30, 'dynamic')
  local body4 = love.physics.newBody(world, 40, 40, 'dynamic')
  local joint1 = love.physics.newPrismaticJoint(body1, body2, 10, 10, 20, 20, true)
  local joint2 = love.physics.newPrismaticJoint(body3, body4, 30, 30, 40, 40, true)
  local obj = love.physics.newGearJoint(joint1, joint2, 1, true)
  test:assertObject(obj)
end


-- love.physics.newMotorJoint
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newMotorJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newMotorJoint(body1, body2, 1)
  test:assertObject(obj)
end


-- love.physics.newMouseJoint
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newMouseJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body = love.physics.newBody(world, 10, 10, 'static')
  local obj = love.physics.newMouseJoint(body, 10, 10)
  test:assertObject(obj)
end


-- love.physics.newPolygonShape
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newPolygonShape = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body = love.physics.newBody(world, 10, 10, 'static')
  local obj = love.physics.newPolygonShape(body, {0, 0, 2, 3, 2, 1, 3, 1, 5, 1})
  test:assertObject(obj)
end


-- love.physics.newPrismaticJoint
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newPrismaticJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newPrismaticJoint(body1, body2, 10, 10, 20, 20, true)
  test:assertObject(obj)
end


-- love.physics.newPulleyJoint
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newPulleyJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newPulleyJoint(body1, body2, 10, 10, 20, 20, 15, 15, 25, 25, 1, true)
  test:assertObject(obj)
end


-- love.physics.newRectangleShape
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newRectangleShape = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body = love.physics.newBody(world, 10, 10, 'static')
  local shape1 = love.physics.newRectangleShape(body, 10, 20)
  local shape2 = love.physics.newRectangleShape(body, 10, 10, 40, 30, 10)
  test:assertObject(shape1)
  test:assertObject(shape2)
end


-- love.physics.newRevoluteJoint
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newRevoluteJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newRevoluteJoint(body1, body2, 10, 10, true)
  test:assertObject(obj)
end


-- love.physics.newRopeJoint
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newRopeJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newRopeJoint(body1, body2, 10, 10, 20, 20, 50, true)
  test:assertObject(obj)
end


-- love.physics.newWeldJoint
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newWeldJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newWeldJoint(body1, body2, 10, 10, true)
  test:assertObject(obj)
end


-- love.physics.newWheelJoint
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newWheelJoint = function(test)
  local world = love.physics.newWorld(1, 1, true)
  local body1 = love.physics.newBody(world, 10, 10, 'static')
  local body2 = love.physics.newBody(world, 20, 20, 'static')
  local obj = love.physics.newWheelJoint(body1, body2, 10, 10, 5, 5, true)
  test:assertObject(obj)
end


-- love.physics.newWorld
-- @NOTE this is just basic nil checking, objs have their own test method
love.test.physics.newWorld = function(test)
  local world = love.physics.newWorld(1, 1, true)
  test:assertObject(world)
end


-- love.physics.setMeter
love.test.physics.setMeter = function(test)
  -- set initial meter
  local world = love.physics.newWorld(1, 1, true)
  love.physics.setMeter(30)
  local body = love.physics.newBody(world, 300, 300, "dynamic")
  -- check changing meter changes pos value relatively
  love.physics.setMeter(10)
  local x, y = body:getPosition()
  test:assertEquals(100, x, 'check pos x')
  test:assertEquals(100, y, 'check pos y')
end
