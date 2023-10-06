`/Applications/love_12.app/Contents/MacOS/love ./testing`

## TESTSUITE
- [ ] finish graphics state methods
- [ ] start graphics drawing methods
- [ ] start object methods

## FUTURE
- [ ] pass in err string returns to the test output
  maybe even assertNotNil could use the second value automatically
  test:assertNotNil(love.filesystem.openFile('file2', 'r')) wouldn't have to change
- [ ] some joystick/input stuff could be at least nil checked maybe?
- [ ] need a platform: format table somewhere for compressed formats (i.e. DXT not supported)
  could add platform as global to command and then use in tests?

## GITHUB ACTION CI
- [ ] add test run to linux (opengl+vulkan) + ios builds (opengl+metal)

Can't run --renderers metal on github action images:
Run love-macos/love.app/Contents/MacOS/love testing --renderers metal
Cannot create Metal renderer: Metal is not supported on this system.
Cannot create graphics: no supported renderer on this system.
Error: Cannot create graphics: no supported renderer on this system.

Can't run test suite on windows as it stands:
Unable to create renderer
This program requires a graphics card and video drivers which support OpenGL 2.1 or OpenGL ES 2.
