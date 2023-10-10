`/Applications/love_12.app/Contents/MacOS/love ./testing`

## TESTSUITE
- [ ] start object methods
- [ ] setStencilMode to replace setStencilTest

## GRAPHICS
Methods that need a actual graphic pixel checks if possible:
- [ ] setDepthMode
- [ ] setFrontFaceWinding
- [ ] setMeshCullMode
- [ ] present
- [ ] drawInstanced
- [ ] flushBatch
      Here's possible idea for testing love.graphics.flushBatch:
      Call love.graphics.flushBatch().
      Query drawcall from love.graphics.getStats
      Draw something
      Call love.graphics.flushBatch()
      Query drawcall again from love.graphics.getStats
      Compare values between step 2 and 5. It should increase by 1.

## FUTURE
- [ ] need a platform: format table somewhere for compressed formats (i.e. DXT not supported)

## GITHUB ACTION CI
- [x] MacOS OpenGL
- [ ] MacOS Metal (not currently possible)
- [x] Windows OpenGL
- [x] Windows OpenGLES 
- [x] Windows Vulkan
- [x] Linux OpenGL
- [x] Linux OpenGLES
- [ ] Linux Vulkan
- [ ] iOS?
