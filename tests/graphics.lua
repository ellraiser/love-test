-- love.graphics


-- DRAWING

-- love.graphics.rectangle
love.test.graphics.rectangle = function(test)
  -- setup, draw a 16x16 red rectangle with a green border
  local canvas = love.graphics.newCanvas(16, 16)
  love.graphics.setCanvas(canvas)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle('fill', 0, 0, 16, 16, nil, nil, nil)
    love.graphics.setColor(0, 0, 1, 1)
    love.graphics.rectangle('fill', 6, 6, 4, 4, nil, nil, nil)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.rectangle('line', 1, 1, 15, 15, nil, nil, nil)
    love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setCanvas()
  local imgdata = canvas:newImageData()
  local comparedata = love.image.newImageData('resources/love-test-graphics-rectangle.png')
  -- test, check green border, red bg, and blue central square
  local comparepixels = {
    {0, 0}, {15, 0}, {15, 15}, {0, 15},
    {1, 1}, {14, 1}, {14, 14}, {1, 14},
    {6, 6}, {9, 6}, {9, 9}, {6, 9}
  }
  for c=1,#comparepixels do
    local pos = comparepixels[c]
    local cr, cg, cb, ca = comparedata:getPixel(pos[1], pos[2])
    local tr, tg, tb, ta = imgdata:getPixel(pos[1], pos[2])
    local compare_id = tostring(pos[1]) .. 'x,' .. tostring(pos[2]) .. 'y'
    test:assertEquals(cr, tr, 'check ' .. compare_id .. ' R')
    test:assertEquals(cg, tg, 'check ' .. compare_id .. ' G')
    test:assertEquals(cb, tb, 'check ' .. compare_id .. ' B')
    test:assertEquals(ca, ta, 'check ' .. compare_id .. ' A')
  end
end

-- love.graphics.arc
-- love.graphics.circle
-- love.graphics.clear
-- love.graphics.discard
-- love.graphics.draw
-- love.graphics.drawInstanced
-- love.graphics.drawInstanced
-- love.graphics.drawLayer
-- love.graphics.ellipse
-- love.graphics.flushBatch
-- love.graphics.line
-- love.graphics.points
-- love.graphics.polygon
-- love.graphics.present
-- love.graphics.print
-- love.graphics.printf
-- love.graphics.rectangle

-- love.graphics.captureScreenshot
-- love.graphics.newArrayImage
-- love.graphics.newCanvas
-- love.graphics.newCubeImage
-- love.graphics.newFont
-- love.graphics.newImage
-- love.graphics.newImageFont
-- love.graphics.newMesh
-- love.graphics.newParticleSystem
-- love.graphics.newQuad
-- love.graphics.newShader
-- love.graphics.newSpriteBatch
-- love.graphics.newText
-- love.graphics.newVideo
-- love.graphics.newVolumeImage
-- love.graphics.setNewFont
-- love.graphics.validateShader

-- love.graphics.getBackgroundColor
-- love.graphics.getBlendMode
-- love.graphics.getCanvas
-- love.graphics.getColor
-- love.graphics.getColorMask
-- love.graphics.getDefaultFilter
-- love.graphics.getDepthMode
-- love.graphics.getFont
-- love.graphics.getFrontFaceWinding
-- love.graphics.getLineJoin
-- love.graphics.getLineStyle
-- love.graphics.getLineWidth
-- love.graphics.getMeshCullMode
-- love.graphics.getPointSize
-- love.graphics.getScissor
-- love.graphics.getShader
-- love.graphics.getStackDepth
-- love.graphics.getStencilTest
-- love.graphics.intersectScissor
-- love.graphics.isActive
-- love.graphics.isGammaCorrect
-- love.graphics.isSupported
-- love.graphics.isWireframe
-- love.graphics.reset
-- love.graphics.setBackgroundColor
-- love.graphics.setBlendMode
-- love.graphics.setCanvas
-- love.graphics.setColor
-- love.graphics.setColorMask
-- love.graphics.setDefaultFilter
-- love.graphics.setDepthMode
-- love.graphics.setFont
-- love.graphics.setFrontFaceWinding
-- love.graphics.setLineJoin
-- love.graphics.setLineStyle
-- love.graphics.setLineWidth
-- love.graphics.setMeshCullMode
-- love.graphics.setPointStyle
-- love.graphics.setScissor
-- love.graphics.setShader
-- love.graphics.setStencilTest
-- love.graphics.setWireframe

-- love.graphics.applyTransform
-- love.graphics.inverseTransformPoint
-- love.graphics.origin
-- love.graphics.pop
-- love.graphics.push
-- love.graphics.replaceTransform
-- love.graphics.rotate
-- love.graphics.scale
-- love.graphics.shear
-- love.graphics.transformPoint
-- love.graphics.translate

-- love.graphics.getDPIScale
-- love.graphics.getDimensions
-- love.graphics.getHeight
-- love.graphics.getPixelDimensions
-- love.graphics.getPixelHeight
-- love.graphics.getPixelWidth
-- love.graphics.getWidth

-- love.graphics.getCanvasformats
-- love.graphics.getImageFormats
-- love.graphics.getRendererInfo
-- love.graphics.getStats
-- love.graphics.getSupported
-- love.graphics.getSystemLimits
-- love.graphics.getTextureTypes