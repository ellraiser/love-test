`/Applications/love_12.app/Contents/MacOS/love ./testing`


# v0.5

## Changed
- Added TestMethod:assertNotNil() for quick nil checking
- Added time total to the end of each module summary in console log to match file output
- Removed a bunch of unessecary nil checks
- Removed :release() from test methods, collectgarbage("collect") is called between methods instead
- Renamed /output to /examples to avoid confusion
- Replaced love.filesystem.newFile with love.filesystem.openFile
- Replaced love.math.noise with love.math.perlinNoise / love.math.simplexNoise
- Fixed newGearJoint throwing an error in 12 as body needs to be dynamic not static now
- Some general cleanup, incl. better comments and time format in file output

## Todo
- need a platform: format table somewhere for compressed formats (i.e. DXT not supported)