-- & 'c:\Program Files\LOVE\love.exe' ./ --console 
-- /Applications/love.app/Contents/MacOS/love ./
require('lovetest')
require('classes.suite')
require('classes.test')
require('tests.audio')
require('tests.data')
require('tests.event')
require('tests.filesystem')
require('tests.font')
require('tests.graphics')
require('tests.image')
require('tests.math')
require('tests.physics')
require('tests.sound')
require('tests.system')
require('tests.thread')
require('tests.timer')
require('tests.video')
require('tests.window')

love.load = function(args)

  -- runSpecificMethod [module] [method]
  if args[1] == '--runSpecificMethod' then
    local testsuite = love.test.Suite:new()
    table.insert(love.test.testsuites, testsuite)
    love.test.testsuite = testsuite
    love.test.testsuite:log('grey', '--runSpecificMethod "' .. args[2] .. '" "' .. args[3] .. '"')
    love.test.testsuite:runTests(args[2], args[3])
  end

  -- runSpecificModule [module]
  if args[1] == '--runSpecificModule' then
    local testsuite = love.test.Suite:new()
    table.insert(love.test.testsuites, testsuite)
    love.test.testsuite = testsuite
    love.test.testsuite:log('grey', '--runSpecificModule "' .. args[2] .. '"')
    love.test.testsuite:runTests(args[2])
  end

  -- runSpecificModules [module1] [module2] [module3]
  if args[1] == '--runSpecificModules' then
    local modulelist = {}
    for a=2,#args do
      local testsuite = love.test.Suite:new(args[a])
      table.insert(love.test.testsuites, testsuite)
      table.insert(modulelist, args[a])
    end
    love.test.testsuite = love.test.testsuites[1]
    love.test.testsuite:log('grey', '--runSpecificModules "' .. table.concat(modulelist, '" "') .. '"')
    love.test.testsuite:runTests(love.test.testsuite.module)
  end

  -- runAllTests
  if args[1] == nil or args[1] == '' or args[1] == '--runAllTests' then
    local modules = {
      'audio', 'data', 'event', 'filesystem', 'font', 'graphics',
      'image', 'math', 'objects', 'physics', 'sound', 'system',
      'thread', 'timer', 'video', 'window'
    }
    for m=1,#modules do
      local testsuite = love.test.Suite:new(modules[m])
      table.insert(love.test.testsuites, testsuite)
    end
    love.test.testsuite = love.test.testsuites[1]
    love.test.testsuite:log('grey', '--runAllTests')
    love.test.testsuite:runTests(love.test.testsuite.module)
  end

end

love.update = function(delta)

  -- stagger to between tests
  if love.test.testsuite ~= nil then
    love.test.testsuite.time = love.test.testsuite.time + delta
    if love.test.testsuite.time >= love.test.testsuite.delay then
      love.test.testsuite.time = love.test.testsuite.time - love.test.testsuite.delay
      if love.test.testsuite.start == true then
        -- work through each test method 1 by 1
        if love.test.testsuite.index <= #love.test.testsuite.running then
          -- run method once
          if love.test.testsuite.called[love.test.testsuite.index] == nil then
            love.test.testsuite.called[love.test.testsuite.index] = true
            local method = love.test.testsuite.running[love.test.testsuite.index]
            local test = love.test.Test:new(method, love.test.testsuite)
            -- check method exists in love first
            if love[love.test.testsuite.module] == nil or love[love.test.testsuite.module][method] == nil then
              local tested = 'love.' .. love.test.testsuite.module .. '.' .. method .. '()' 
              local matching = string.sub(love.test.testsuite.spacer, string.len(tested), 40)
              love.test.testsuite:log(love.test.testsuite.colors['FAIL'],
                tested .. matching,
                ' ==> FAIL (0/0) - call failed - method does not exist'
              )
            -- otherwise run the test method then eval the asserts
            else
              love.test[love.test.testsuite.module][method](test)
              test:evaluateTest()
            end
            -- move onto the next test
            love.test.testsuite.index = love.test.testsuite.index + 1
          end
        else
          -- all tests done, print totals
          love.test.testsuite:log('yellow', 'love.' .. love.test.testsuite.module .. '.testsuite.end')
          local failedcol = '\27[31m'
          if love.test.testsuite.failed == 0 then failedcol = '\27[30m' end
          love.test.testsuite:log('green', tostring(love.test.testsuite.passed) .. ' PASSED' .. ' || ' .. failedcol .. tostring(love.test.testsuite.failed) .. ' FAILED || \27[30m' .. tostring(love.test.testsuite.skipped) .. ' SKIPPED')
          love.test.testsuite.start = false
          love.test.testsuite.fakequit = false

          love.test.current = love.test.current + 1
          if #love.test.testsuites >= love.test.current then
            love.test.testsuite = love.test.testsuites[love.test.current]
            love.test.testsuite:runTests(love.test.testsuite.module)
          else 
            love.test.testsuite:log('grey', '\nFINISHED\n')
            local failedcol = '\27[31m'
            if love.test.totals[2] == 0 then failedcol = '\27[30m' end
            love.test.testsuite:log('green', tostring(love.test.totals[1]) .. ' PASSED' .. ' || ' .. failedcol .. tostring(love.test.totals[2]) .. ' FAILED || \27[30m' .. tostring(love.test.totals[3]) .. ' SKIPPED')
            love.event.quit(0)
          end

        end
      end
    end
  end

end


love.draw = function()
  if love.test.testcanvas ~= nil then
    love.graphics.draw(love.test.testcanvas, 0, 0)
  else
    love.graphics.draw(logo_texture, logo_image, 64, 64, 0, 2, 2)
  end
end


love.quit = function()
  if love.test.testsuite.fakequit == true then
    return true
  else
    return false
  end
end