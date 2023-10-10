`/Applications/love_12.app/Contents/MacOS/love ./testing`

## TESTSUITE
- [ ] start object methods
- [ ] setStencilMode to replace setStencilTest

## GRAPHICS
Methods that need a actual graphic pixel checks if possible:
- [ ] make get/set Vsync a notnil check instead as cant garuntee result
- [ ] setDepthMode
- [ ] setFrontFaceWinding
- [ ] setMeshCullMode
- [ ] present
- [ ] drawInstanced

## FUTURE
- [ ] need a platform: format table somewhere for compressed formats (i.e. DXT not supported)

## GITHUB ACTION CI
- [x] MacOS OpenGL
- [ ] MacOS Metal (not currently possible)
- [x] Windows OpenGL (via Mesa3D)
- [ ] Windows Vulkan (via Mesa3D)
- [ ] Linux OpenGL (via xvfb)
- [ ] Linux Vulkan
- [ ] iOS?

## NOTES
Can't run --renderers metal on github action images:
Run love-macos/love.app/Contents/MacOS/love testing --renderers metal
Cannot create Metal renderer: Metal is not supported on this system.
Cannot create graphics: no supported renderer on this system.
Error: Cannot create graphics: no supported renderer on this system.
