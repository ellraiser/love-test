love.test.Test = {

    -- create new test class
    new = function(self, method, testsuite)
      local test = {
        testsuite = testsuite,
        asserts = {},
        method = method,
        start = love.timer.getTime(),
        count = 0,
        passed = false,
        skipped = false,
        message = nil,
        result = {}
      }
      setmetatable(test, self)
      self.__index = self
      return test
    end,

    -- check 2 values are equal
    assertEquals = function(self, expected, actual)
      self.count = self.count + 1
      table.insert(self.asserts, {
        key = 'assert #' .. tostring(self.count),
        passed = expected == actual,
        message = 'expected "' .. tostring(expected) .. '" got "' .. tostring(actual) .. '"'
      })
    end,

    -- check two values are not equal
    assertNotEquals = function(self, expected, actual)
      self.count = self.count + 1
      table.insert(self.asserts, {
        key = 'assert #' .. tostring(self.count),
        passed = expected ~= actual,
        message = 'avoiding "' .. tostring(expected) .. '" got "' .. tostring(actual) .. '"'
      })
    end,

    -- check a value is within a range
    assertRange = function(self, actual, min, max)
      self.count = self.count + 1
      table.insert(self.asserts, {
        key = 'assert #' .. tostring(self.count),
        passed = actual >= min and actual <= max,
        message = 'value "' .. tostring(actual) .. '" out of range "' .. tostring(min) .. '-' .. tostring(max) .. '"'
      })
    end,

    -- check a value is in a list
    assertMatch = function(self, list, actual)
      self.count = self.count + 1
      local found = false
      for l=1,#list do
        if list[l] == actual then found = true end;
      end
      table.insert(self.asserts, {
        key = 'assert #' .. tostring(self.count),
        passed = found == true,
        message = 'value "' .. tostring(actual) .. '" not found in "' .. table.concat(list, ',') .. '"'
      })
    end,

    -- check a value is >= a number
    assertGreaterEqual = function(self, value, actual)
      self.count = self.count + 1
      local passing = false
      if value ~= nil and actual ~= nil then
        passing = actual >= value
      end
      table.insert(self.asserts, {
        key = 'assert #' .. tostring(self.count),
        passed = passing,
        message = 'value "' .. tostring(actual) .. '" not >= "' .. tostring(value) .. '"'
      })
    end,

    -- check a value is <= a number
    assertLessEqual = function(self, value, actual)
      self.count = self.count + 1
      local passing = false
      if value ~= nil and actual ~= nil then
        passing = actual <= value
      end
      table.insert(self.asserts, {
        key = 'assert #' .. tostring(self.count),
        passed = passing,
        message = 'value "' .. tostring(actual) .. '" not <= "' .. tostring(value) .. '"'
      })
    end,

    -- skip a test, either todo later or cos it can't be tested easily
    skipTest = function(self)
      self.skipped = true
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
      local passed = #self.asserts - failures
      local total = '(' .. tostring(passed) .. '/' .. tostring(#self.asserts) .. ')'
      if self.skipped == true then
        self.testsuite.skipped = self.testsuite.skipped + 1
        love.test.totals[3] = love.test.totals[3] + 1
        self.result = { total = '', result = "SKIP", passed = false, message = '(0/0) method skipped'}
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
            self.result = { total = total, result = 'FAIL', passed = false, key = 'test', message = 'no asserts defined' }
          else
            self.result = { total = total, result = 'FAIL', passed = false, key = failure['key'], message = failure['message'] }
          end
        end
      end
      self:printResult()
    end,

    -- print result all pretty
    printResult = function(self)
      -- time taken for test? not used currently, could slap before the ==>?
      local endtime = tostring(math.floor((love.timer.getTime() - self.start)*1000)) .. 'ms'
      if string.len(endtime) == 3 then endtime = '0' .. endtime end
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
        ' ==> ' .. self.result.result .. ' ' .. self.result.total .. msg
      )
    end

  }