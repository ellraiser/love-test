-- love.event


-- love.event.clear
love.test.event.clear = function(test)
  -- setup
  love.event.push('test', 1, 2, 3)
  love.event.push('test', 1, 2, 3)
  love.event.push('test', 1, 2, 3)
  -- tests
  love.event.clear()
  local count = 0
  for n, a, b, c, d, e, f in love.event.poll() do
    count = count + 1
  end
  test:assertEquals(0, count)
end


-- love.event.poll
love.test.event.poll = function(test)
  -- setup
  love.event.push('test', 1, 2, 3)
  love.event.push('test', 1, 2, 3)
  love.event.push('test', 1, 2, 3)
  -- tests
  local count = 0
  for n, a, b, c, d, e, f in love.event.poll() do
    count = count + 1
  end
  test:assertEquals(3, count)
end


-- love.event.pump
-- @NOTE dont think can really test as internal?
love.test.event.pump = function(test)
  test:skipTest()
end


-- love.event.push
love.test.event.push = function(test)
  -- test
  love.event.push('add', 1, 2, 3)
  love.event.push('ignore', 1, 2, 3)
  love.event.push('add', 1, 2, 3)
  love.event.push('ignore', 1, 2, 3)
  local count = 0
  for n, a, b, c, d, e, f in love.event.poll() do
    if n == 'add' then
      count = count + a + b + c
    end
  end
  test:assertEquals(12, count)
end


-- love.event.quit
love.test.event.quit = function(test)
  love.test.testsuite.fakequit = true
  -- this should call love.quit, which will prevent the quit
  -- if this fails then the test would just abort here
  love.event.quit(0)
  test:assertEquals(true, true)
end


-- love.event.wait
-- @NOTE not sure best way to test this one
love.test.event.wait = function(test)
  test:skipTest()
end