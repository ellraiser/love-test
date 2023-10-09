# löve.test
Basic testing suite for the löve APIs, based off of [this issue](https://github.com/love2d/love/issues/1745)

Currently written for löve 12

---

## Primary Goals
- [x] Simple pass/fail tests in Lua with minimal setup 
- [x] Ability to run all tests with a simple command.
- [x] Ability to see how many tests are passing/failing
- [x] No platform-specific dependencies / scripts

## Stretch Goals
- [x] Ability to run a subset of tests
- [x] Ability to easily run an individual test.
- [x] Automatic testing that happens after every commit
- [x] Ability to see all visual results at a glance

---

## Running Tests
The initial pass is to keep things as simple as possible, and just run all the tests inside Löve to match how they'd be used by developers in-engine.
To run the tests, download the repo and then run the main.lua as you would a löve game, i.e:

WINDOWS: `& 'c:\Program Files\LOVE\love.exe' PATH_TO_TESTING_FOLDER --console`  
MACOS: `/Applications/love.app/Contents/MacOS/love PATH_TO_TESTING_FOLDER`

By default all tests will be run for all modules.  

If you want to specify a module you can add:  
`--runSpecificModules filesystem`  
For multiple modules, provide a comma seperate list:  
`--runSpecificModules filesystem,audio,data"`

If you want to specify only 1 specific method only you can use:  
`--runSpecificMethod filesystem write`

All results will be printed in the console per method as PASS, FAIL, or SKIP with total assertions met on a module level and overall level.  

An `XML` file in the style of [JUnit XML](https://www.ibm.com/docs/en/developer-for-zos/14.1?topic=formats-junit-xml-format) will be generated in the `/output` directory, along with a `HTML` and a `Markdown` file with a summary of all tests (including visuals for love.graphics tests).  
> An example of both types of output can be found in the `/examples` folder  

The Markdown file can be used with [this github action](https://github.com/ellraiser/love-test-report) if you want to output the report results to your CI.

---

## Architecture
Each method and object has it's own test method written in `/tests` under the matching module name.

When you run the tests, a single TestSuite object is created which handles the progress + totals for all the tests.  
Each module has a TestModule object created, and each test method has a TestMethod object created which keeps track of assertions for that method. You can currently do the following assertions:
- **assertNotNil**(value)
- **assertEquals**(expected, actual, label)
- **assertNotEquals**(expected, actual, label)
- **assertRange**(actual, min, max, label)
- **assertMatch**({option1, option2, option3 ...}, actual, label) 
- **assertGreaterEqual**(expected, actual, label)
- **assertLessEqual**(expected, actual, label)
- **assertObject**(table)
- **assertPixels**(imgdata, pixeltable, label)

Example test method:
```lua
-- love.filesystem.read test method
-- all methods should be put under love.test.MODULE.METHOD, matching the API
love.test.filesystem.read = function(test)
  -- setup any data needed then run any asserts using the passed test object
  local content, size = love.filesystem.read('resources/test.txt')
  test:assertNotNil(content)
  test:assertEquals('helloworld', content, 'check content match')
  test:assertEquals(10, size, 'check size match')
  content, size = love.filesystem.read('resources/test.txt', 5)
  test:assertNotNil(content)
  test:assertEquals('hello', content, 'check content match')
  test:assertEquals(5, size, 'check size match')
  -- no need to return anything or cleanup, GCC is called after each method
end
```

After each test method is ran, the assertions are totalled up, printed, and we move onto the next method! Once all methods in the suite are run a total pass/fail/skip is given for that module and we move onto the next module (if any)

For sanity-checking, if it's currently not covered or it's not possible to test the method we can set the test to be skipped with `test:skipTest(reason)` - this way we still see the method listed in the test output without it affected the pass/fail totals

---

## Coverage
This is the status of all module tests currently.  
| Module                | Written | Todo | Skipped |
| --------------------- | ------ | ------ | ------- |
| 🟡 audio | 26 | 2 | 0 |
| 🟡 data | 7 | 5 | 0 |
| 🟡 event | 4 | 1 | 1 |
| 🟡 filesystem | 28 | 1 | 2 |
| 🟡 font | 4 | 3 | 0 |
| 🟡 graphics | 92 | 13 | 2 |
| 🟡 image | 3 | 2 | 0 |
| 🟡 math | 17 | 3 | 0 |
| 🟡 physics | 22 | 6 | 0 |
| 🟡 sound | 2 | 2 | 0 |
| 🟢 system | 6 | 0 | 2 |
| 🟡 thread | 3 | 2 | 0 |
| 🟢 timer | 6 | 0 | 0 |
| 🟡 video | 1 | 1 | 0 |
| 🟢 window | 34 | 0 | 2 |

The following modules are not covered as we can't really emulate input nicely:  
`joystick`, `keyboard`, `mouse`, and `touch`

---

## Todo 
Modules with some small bits needed or needing sense checking:
- **love.data** - packing methods need writing cos i dont really get what they are
- **love.event** - love.event.wait or love.event.pump need writing if possible I dunno how to check
- **love.font** - newBMFontRasterizer() wiki entry is wrong so not sure whats expected
- **love.graphics** - still need to do tests for the main drawing methods
- **love.image** - ideally isCompressed should have an example of all compressed files love can take
- **love.math** - linearToGamma + gammaToLinear using direct formulas don't get same value back
- **love.*.objects** - all objects tests still to be done
- **love.graphics.setStencilTest** - deprecated, replaced by setStencilMode()

---

## Future Goals
- [ ] Tests can compare visual results to a reference image (partially done)
- [ ] Ability to test loading different combinations of modules
- [ ] Performance tests
