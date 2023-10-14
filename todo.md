`/Applications/love_12.app/Contents/MacOS/love ./testing`

## GENERAL
- [ ] check 12.0 wiki page for new methods
- [ ] need a platform: format table somewhere for compressed formats (i.e. DXT not supported)

## OBJECT TESTS
- [ ] physics.Body, physics.Contact, physics.Fixture,
      physics.Joint, physics.Shape, physics.World
- [ ] graphics.Canvas, graphics.Font, graphics.Image, graphics.Mesh, 
      graphics.ParticleSystem, graphics.Quad, graphics.Shader, 
      graphics.SpriteBatch, graphics.Text, graphics.Texture, graphics.Video

## METHOD TESTS
- [ ] event.wait
- [ ] graphics.present 
- [ ] graphics.drawInstanced

## DEPRECATED
- [ ] deprecated setStencilTest (use setStencilMode)
- [ ] deprecated physics methods

## GRAPHIC TESTS
Methods that need a actual graphic pixel checks if possible:
- [ ] setDepthMode
- [ ] setFrontFaceWinding
- [ ] setMeshCullMode
