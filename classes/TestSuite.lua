TestSuite = {


  -- @method - TestSuite:new()
  -- @desc - creates a new TestSuite object that handles all the tests
  -- @return {table} - returns the new TestSuite object
  new = function(self)
    local test = {

      -- testsuite internals
      modules = {},
      module = nil,
      test = nil,
      testcanvas = nil,
      current = 1,
      output = '',
      totals = {0, 0, 0},
      time = 0,
      xml = '',
      html = '',
      mdrows = '',
      mdfailures = '',
      delayed = nil,
      fakequit = false,
      windowmode = true,

      -- love modules to test
      audio = {},
      data = {},
      event = {},
      filesystem = {},
      font = {},
      graphics = {},
      image = {},
      joystick = {},
      math = {},
      mouse = {},
      physics = {},
      sound = {},
      system = {},
      thread = {},
      timer = {},
      touch = {},
      video = {},
      window = {}

    }
    setmetatable(test, self)
    self.__index = self
    return test
  end,


  -- @method - TestSuite:runSuite()
  -- @desc - called in love.update, runs through every method or every module
  -- @param {number} delta - delta from love.update to track time elapsed
  -- @return {nil}
  runSuite = function(self, delta)

      -- stagger between tests
    if self.module ~= nil then
      self.module.timer = self.module.timer + delta
      if self.module.timer >= self.module.delay then
        self.module.timer = self.module.timer - self.module.delay
        if self.module.start == true then

          -- work through each test method 1 by 1
          if self.module.index <= #self.module.running then

            -- run method once
            if self.module.called[self.module.index] == nil then
              self.module.called[self.module.index] = true
              local method = self.module.running[self.module.index]
              self.test = TestMethod:new(method, self.module)
              TextRun:set('love.' .. self.module.module .. '.' .. method)

              -- check method exists in love first
              if love[self.module.module] == nil then
                local tested = 'love.' .. self.module.module .. '.' .. method .. '()' 
                local matching = string.sub(self.module.spacer, string.len(tested), 40)
                self.module:log(self.module.colors['FAIL'],
                  tested .. matching,
                  ' ==> FAIL (0/0) - call failed - method does not exist'
                )
              -- otherwise run the test method
              else
                local ok, chunk, err = pcall(self[self.module.module][method], self.test)
                if ok == false then
                  print("FATAL", chunk, err)
                  self.test.fatal = tostring(chunk) .. tostring(err)
                end
              end

            -- once we've run check delay + eval
            else

              -- @TODO use coroutines?
              -- if we have a test method that needs a delay
              -- we wait for the delay to run out first
              if self.delayed ~= nil then
                self.delayed.delay = self.delayed.delay - 1
                -- re-run the test method again when delay ends
                -- its up to the test to handle the :isDelayed() property
                if self.delayed.delay <= 0 then
                  local ok, chunk, err = pcall(self[self.module.module][self.delayed.method], self.test)
                  if ok == false then
                    print("FATAL", chunk, err)
                    self.test.fatal = tostring(chunk) .. tostring(err)
                  end
                  self.delayed = nil
                end
              else

                -- now we're all done evaluate the test 
                local ok, chunk, err = pcall(self.test.evaluateTest, self.test)
                if ok == false then
                  print("FATAL", chunk, err)
                  self.test.fatal = tostring(chunk) .. tostring(err)
                end
                -- save having to :release() anything we made in the last test
                -- 7251ms > 7543ms
                collectgarbage("collect")
                -- move onto the next test
                self.module.index = self.module.index + 1

              end

            end

          -- once all tests have run
          else

            -- print module results and add to output
            self.module:printResult()

            -- if we have more modules to go run the next one
            self.current = self.current + 1
            if #self.modules >= self.current then
              self.module = self.modules[self.current]
              self.module:runTests()

            -- otherwise print the final results and export output
            else
              self:printResult()
              love.event.quit(0)
            end
  
          end
        end
      end
    end
  end,


  -- @method - TestSuite:printResult()
  -- @desc - prints the result of the whole test suite as well as writes
  --         the MD, XML + HTML of the testsuite output
  -- @return {nil}
  printResult = function(self)
    local finaltime = UtilTimeFormat(self.time)
    
    local md = '<!-- PASSED ' .. tostring(self.totals[1]) ..
      ' || FAILED ' .. tostring(self.totals[2]) ..
      ' || SKIPPED ' .. tostring(self.totals[3]) ..
      ' || TIME ' .. finaltime .. ' -->\n\n' ..
      '**' .. tostring(self.totals[1] + self.totals[2] + self.totals[3]) .. '** tests were completed in **' ..
      finaltime .. 's** with **' ..
      tostring(self.totals[1]) .. '** passed, **' ..
      tostring(self.totals[2]) .. '** failed, and **' ..
      tostring(self.totals[3]) .. '** skipped\n\n### Report\n' ..
      '| Module                | Pass | Fail | Skip | Time   |\n' ..
      '| --------------------- | ------ | ------ | ------- | ------ |\n' ..
      self.mdrows .. '\n\n### Failures\n' .. self.mdfailures

    local xml = '<testsuites name="love.test" tests="' .. tostring(self.totals[1]) .. 
      '" failures="' .. tostring(self.totals[2]) .. 
      '" skipped="' .. tostring(self.totals[3]) .. 
      '" time="' .. finaltime .. '">\n'

    local status = '🔴'
    if self.totals[2] == 0 then status = '🟢' end
    local html = '<html><head><style>* { font-family: monospace; margin: 0; font-size: 11px; padding: 0; } body { margin: 50px; } h1 { padding-bottom: 10px; font-size: 13px; } h2 { padding: 20px 0 10px 0; font-size: 12px; } .summary { list-style: none; margin: 0; padding: 0; } .summary li { float: left; background: #eee; padding: 5px; margin-right: 10px; } table { background: #eee; margin-top: 10px; width: 100%; max-width: 800px; border-collapse: collapse } table thead { background: #ddd; } table th, table td { padding: 2px; } tr.red { color: red } .wrap { max-width: 800px; margin: auto; } .preview { width: 64px; height: 80px; float: left; margin-right: 10px; } .preview img { width: 100% } .preview p { text-align: center; }</style></head><body><div class="wrap"><h1>' .. status .. '&nbsp;love.test</h1><ul class="summary">'
    html = html .. 
      '<li>🟢&nbsp;' .. tostring(self.totals[1]) .. ' Tests</li>' ..
      '<li>🔴&nbsp;' .. tostring(self.totals[2]) .. ' Failures</li>' ..
      '<li>🟡&nbsp;' .. tostring(self.totals[3]) .. ' Skipped</li>' ..
      '<li>' .. finaltime .. 's</li></ul><br/><br/>'

    love.filesystem.write('tempoutput/' .. self.output .. '.xml', xml .. self.xml .. '</testsuites>')
    love.filesystem.write('tempoutput/' .. self.output .. '.html', html .. self.html .. '</div></body></html>')
    love.filesystem.write('tempoutput/' .. self.output .. '.md', md)

    self.module:log('grey', '\nFINISHED - ' .. finaltime .. 's\n')
    local failedcol = '\27[31m'
    if self.totals[2] == 0 then failedcol = '\27[37m' end
    self.module:log('green', tostring(self.totals[1]) .. ' PASSED' .. ' || ' .. failedcol .. tostring(self.totals[2]) .. ' FAILED || \27[37m' .. tostring(self.totals[3]) .. ' SKIPPED')

  end


}
