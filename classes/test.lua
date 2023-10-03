love.test.Test = {

    -- create new test class
    new = function(self, method, testsuite)
      local test = {
        testsuite = testsuite,
        asserts = {},
        method = method,
        start = love.timer.getTime(),
        finish = 0,
        count = 0,
        passed = false,
        skipped = false,
        skipreason = '',
        fatal = '',
        message = nil,
        result = {}
      }
      setmetatable(test, self)
      self.__index = self
      return test
    end,

    -- check 2 values are equal
    assertEquals = function(self, expected, actual, testmsg)
      self.count = self.count + 1
      table.insert(self.asserts, {
        key = 'assert #' .. tostring(self.count),
        passed = expected == actual,
        message = 'expected \'' .. tostring(expected) .. '\' got \'' .. tostring(actual) .. '\'',
        test = testmsg
      })
    end,

    -- check two values are not equal
    assertNotEquals = function(self, expected, actual, testmsg)
      self.count = self.count + 1
      table.insert(self.asserts, {
        key = 'assert #' .. tostring(self.count),
        passed = expected ~= actual,
        message = 'avoiding \'' .. tostring(expected) .. '\' got \'' .. tostring(actual) .. '\'',
        test = testmsg
      })
    end,

    -- check a value is within a range
    assertRange = function(self, actual, min, max, testmsg)
      self.count = self.count + 1
      table.insert(self.asserts, {
        key = 'assert #' .. tostring(self.count),
        passed = actual >= min and actual <= max,
        message = 'value \'' .. tostring(actual) .. '\' out of range \'' .. tostring(min) .. '-' .. tostring(max) .. '\'',
        test = testmsg
      })
    end,

    -- check a value is in a list
    assertMatch = function(self, list, actual, testmsg)
      self.count = self.count + 1
      local found = false
      for l=1,#list do
        if list[l] == actual then found = true end;
      end
      table.insert(self.asserts, {
        key = 'assert #' .. tostring(self.count),
        passed = found == true,
        message = 'value \'' .. tostring(actual) .. '\' not found in \'' .. table.concat(list, ',') .. '\'',
        test = testmsg
      })
    end,

    -- check a value is >= a number
    assertGreaterEqual = function(self, value, actual, testmsg)
      self.count = self.count + 1
      local passing = false
      if value ~= nil and actual ~= nil then
        passing = actual >= value
      end
      table.insert(self.asserts, {
        key = 'assert #' .. tostring(self.count),
        passed = passing,
        message = 'value \'' .. tostring(actual) .. '\' not >= \'' .. tostring(value) .. '\'',
        test = testmsg
      })
    end,

    -- check a value is <= a number
    assertLessEqual = function(self, value, actual, testmsg)
      self.count = self.count + 1
      local passing = false
      if value ~= nil and actual ~= nil then
        passing = actual <= value
      end
      table.insert(self.asserts, {
        key = 'assert #' .. tostring(self.count),
        passed = passing,
        message = 'value \'' .. tostring(actual) .. '\' not <= \'' .. tostring(value) .. '\'',
        test = testmsg
      })
    end,

    -- check a table is a love object
    assertObject = function(self, table)
      self:assertNotEquals(nil, table, 'check not nill')
      self:assertEquals('userdata', type(table), 'check is userdata')
      self:assertNotEquals(nil, table:type(), 'check has :type()')
    end,

    -- skip a test, either todo later or cos it can't be tested easily
    skipTest = function(self, reason)
      self.skipped = true
      self.skipreason = reason
    end,

    -- evaluate the test class and all asserts for a final pass/fail
    evaluateTest = function(self)
      local failure = ''
      local failures = 0
      for a=1,#self.asserts do
        -- @TODO just return first failed assertion msg? or all?
        -- currently just shows the first assert that failed
        if self.asserts[a].passed == false and self.skipped == false then
          if failure == '' then failure = self.asserts[a] end
          failures = failures + 1
        end
      end
      if self.fatal ~= '' then failure = self.fatal end
      local passed = #self.asserts - failures
      local total = '(' .. tostring(passed) .. '/' .. tostring(#self.asserts) .. ')'

      if self.skipped == true then
        self.testsuite.skipped = self.testsuite.skipped + 1
        love.test.totals[3] = love.test.totals[3] + 1
        self.result = { total = '', result = "SKIP", passed = false, message = '(0/0) - method skipped [' .. self.skipreason .. ']'}
      else
        if failure == '' and #self.asserts > 0 then
          self.passed = true
          self.testsuite.passed = self.testsuite.passed + 1
          love.test.totals[1] = love.test.totals[1] + 1
          self.result = { total = total, result = 'PASS', passed = true, message = nil}
        else
          self.passed = false
          self.testsuite.failed = self.testsuite.failed + 1
          love.test.totals[2] = love.test.totals[2] + 1
          if #self.asserts == 0 then
            local msg = 'no asserts defined'
            if self.fatal ~= '' then msg = self.fatal end
            self.result = { total = total, result = 'FAIL', passed = false, key = 'test', message = msg }
          else
            self.result = { total = total, result = 'FAIL', passed = false, key = failure['key'] .. ' [' .. failure['test'] .. ']', message = failure['message'] }
          end
        end
      end

      self:printResult()
    end,

    -- print result all pretty
    printResult = function(self)
      -- time taken for test? not used currently, could slap before the ==>?
      self.finish = love.timer.getTime() - self.start
      love.test.time = love.test.time + self.finish
      self.testsuite.time = self.testsuite.time + self.finish
      local endtime = tostring(math.floor((love.timer.getTime() - self.start)*1000))
      if string.len(endtime) == 1 then endtime = '   ' .. endtime end
      if string.len(endtime) == 2 then endtime = '  ' .. endtime end
      if string.len(endtime) == 3 then endtime = ' ' .. endtime end

      local failure = ''
      local msg = ''
      if self.passed == false and self.skipped == false then
        failure = '\t\t\t<failure message="' .. self.result.key .. ' ' ..  self.result.message .. '"></failure>\n'
        msg = self.result.key .. ' ' ..  self.result.message
      end
      if msg == '' and self.skipped == true then
        msg = self.skipreason
      end

      self.testsuite.xml = self.testsuite.xml .. '\t\t<testclass classname="' .. self.method .. 
        '" name="' .. self.method .. 
        '" time="' .. tostring(self.finish*1000) .. '">\n' .. failure .. '\t\t</testclass>\n'

      local preview = ''
      if self.testsuite.module == 'graphics' then
        local filename = 'love_test_graphics_rectangle'
        preview = '<div class="preview"><img src="' .. filename .. '_expected.png"/><p>Expected</p></div>' ..
          '<div class="preview"><img src="' .. filename .. '_actual.png"/><p>Actual</p></div>'
      end

      local status = '🔴'
      local cls = 'red'
      if self.passed == true then status = '🟢'; cls = '' end
      if self.skipped == true then status = '🟡'; cls = '' end
      self.testsuite.html = self.testsuite.html .. '<tr class=" ' .. cls .. '"><td>' .. status .. '</td>' ..
        '<td>' .. self.method .. '</td>' ..
        '<td>' .. tostring(self.finish*1000) .. 'ms</td>' ..
        '<td>' .. msg .. preview .. '</td></tr>'

      -- add message if assert failed
      local msg = ''
      if self.result.message ~= nil and self.skipped == false then 
        msg = ' - ' .. self.result.key .. ' failed - (' .. self.result.message .. ')' 
      end
      if self.skipped == true then
        msg = self.result.message
      end
      -- i know its hacky but its neat soz
      local tested = 'love.' .. self.testsuite.module .. '.' .. self.method .. '()' 
      local matching = string.sub(self.testsuite.spacer, string.len(tested), 40)
      self.testsuite:log(
        self.testsuite.colors[self.result.result],
        '  ' .. tested .. matching,
        ' ==> ' .. self.result.result .. ' - ' .. endtime .. 'ms ' .. self.result.total .. msg
      )
    end

  }