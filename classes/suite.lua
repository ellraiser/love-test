love.test.Suite = {

  new = function(self, module)
    local testsuite = {
      time = 0,
      delay = 0.1,
      spacer = '                                        ',
      colors = {
        PASS = 'green', FAIL = 'red', SKIP = 'grey'
      },
      colormap = {
        grey = '\27[30m',
        green = '\27[32m',
        red = '\27[31m',
        yellow = '\27[33m'
      },
      tests = {},
      running = {},
      called = {},
      passed = 0,
      failed = 0,
      skipped = 0,
      module = module,
      index = 1,
      start = false,
    }
    setmetatable(testsuite, self)
    self.__index = self
    return testsuite
  end,

  -- seperated out here so we can easily build a GUI if we need to
  -- color for the line, line being the method tested, result being pass/fail
  log = function(self, color, line, result)
    if result == nil then result = '' end
    print(self.colormap[color] .. line .. result)
  end,

  runTests = function(self, module, method)
    self.running = {}
    self.passed = 0
    self.failed = 0
    self.module = module
    if method ~= nil then
      table.insert(self.running, method)
    else
      for i,_ in pairs(love.test[module]) do
        table.insert(self.running, i)
      end
      table.sort(self.running)
    end
    self.index = 1
    self.start = true
    self:log('yellow', '\nlove.' .. self.module .. '.testsuite.start')
  end

}