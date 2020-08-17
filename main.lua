io.stdout:setvbuf("no")

love.load = function()
  love.window.setFullscreen(true)
  require "initialScreen"
  require "control"
  require "config"
  require "panel"
  require "image"
  --important globals
  controls = {}
  panels = {}
  createInitialScreen()
  drawAnimation = false
  tomatoSize = 3
end

love.draw = function()
  controls.draw()
  for i,v in pairs(panels) do
    v.draw()
  end
  imageBox.draw(tomatoSize)
end

love.update = function(dt)
  if drawAnimation then
    local r,g,b = panels.output.getColor()
    if animationPhase < 2 then
      r,g,b = 1,math.min(g + dt,1),0
    elseif animationPhase < 3 then
      r,g,b = math.max(r - dt,0), 1, 0
    elseif animationPhase < 4 then
      r,g,b = 0,1,math.min(b + dt,1)
    elseif animationPhase < 5 then
      r,g,b = 0, math.max(g - dt,0), 1
    elseif animationPhase < 6 then
      r,g,b = math.min(r + dt,1), 0, 1
    elseif animationPhase < 7 then
      r,g,b = 1,0, math.max(b - dt, 0)
    else
      animationPhase = 1
    end
    animationPhase = animationPhase + dt
    panels.output.setColor(r,g,b)
  end
end


love.touchmoved = function(id,x,y,dx,dy,pressure)
  controls.adjustHeight(x,y,dy)
end

love.mousepressed = function(x,y)
  panels.start.click(x,y)
end
