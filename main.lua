io.stdout:setvbuf("no")

love.load = function(arg)
  love.window.setFullscreen(true)
  require "initialScreen"
  require "control"
  require "config"
  require "panel"
  require "image"
  --important globals
  if arg [1] == "de" then
    texts = CONFIG.text_de
  else
    texts = CONFIG.text_en
  end
  controls = {}
  panels = {}
  sum = 0
  drawAnimation = false
  tomatoSize = 3
  calculationRunning = false
  
  createInitialScreen()
  
end

love.draw = function()
  controls.draw()
  for i,v in pairs(panels) do
    v.draw()
  end
  imageBox.draw(tomatoSize)
end

love.update = function(dt)
  local fillValues = controls.getLevels()
  sum = 0
  for i,v in ipairs(fillValues) do
    sum = sum + v
  end
  if sum == 0 then
    sum = 10
  end
  local colorProgress = dt*6 / CONFIG.colorTransition
  if drawAnimation then
    local r,g,b = panels.output.getColor()
    if animationPhase < 2 then
      r,g,b = 1,math.min(g + colorProgress,1),0
    elseif animationPhase < 3 then
      r,g,b = math.max(r - colorProgress,0), 1, 0
    elseif animationPhase < 4 then
      r,g,b = 0,1,math.min(b + colorProgress,1)
    elseif animationPhase < 5 then
      r,g,b = 0, math.max(g - colorProgress,0), 1
    elseif animationPhase < 6 then
      r,g,b = math.min(r + colorProgress,1), 0, 1
    elseif animationPhase < 7 then
      r,g,b = 1,0, math.max(b - colorProgress, 0)
    else
      animationPhase = 1
    end
    animationPhase = animationPhase + colorProgress
    panels.output.setColor(r,g,b)
  end
end


love.touchmoved = function(id,x,y,dx,dy,pressure)
  controls.adjustHeight(x,y,dy)
end

love.mousepressed = function(x,y)
  panels.start.click(x,y)
  panels.back.click(x,y)
end
