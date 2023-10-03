love.test = {
  -- love.test current suite + classes
  testsuites = {},
  testsuite = nil,
  testcanvas = nil,
  current = 1,
  output = '',
  totals = {0, 0, 0},
  time = 0,
  xml = '',
  html = '',
  fakequit = false,
  windowmode = true,
  Suite = nil,
  Test = nil,
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
  objects = {}, -- special for all object class contructor tests
  physics = {},
  sound = {},
  system = {},
  thread = {},
  timer = {},
  touch = {},
  video = {},
  window = {}
}

if love.window ~= nil then
  love.window.setMode(256, 256, {
    fullscreen = false,
    resizable = true,
    centered = true
  })
  if love.graphics ~= nil then
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setLineStyle('rough')
    love.graphics.setLineWidth(1)
    logo_texture = love.graphics.newImage('resources/love.png')
    logo_image = love.graphics.newQuad(0, 0, 64, 64, logo_texture)
  end
end