local startFunction = function()
  local fillValues = controls.getLevels()
  local command = "perl C:/_Schlag_die_KI/write_schedule_aquacrop.pl"
  local val = 0.0
  for i,v in ipairs(fillValues) do
    val = tostring((300*v)/sum)
    command = command .. " " .. val
  end
  --print(command)
  os.execute(command)
  os.execute("perl C:/_Schlag_die_KI/calc_aquacrop.pl")
  os.execute("perl C:/_Schlag_die_KI/cut_head.pl C:/_Schlag_die_Ki/ACsaV40/OUTP/OptimPRO.OUT")
  os.execute("perl C:/_Schlag_die_KI/cut_head.pl C:/_Schlag_die_Ki/ACsaV40/OUTP/OptimPRO.OUT")
  local file = io.open("result.txt")
  local result = file:read("*l")
  file:close()
  panels.output.setText(result .. " t/ha")
  --love.window.setFullscreen(true)
  local numericalResult = tonumber(result)
  drawAnimation = false
  --THE SETTINGS FOR COLORS, TOMATO IMAGES AND CORRESPONDING VALUES ARE BELOW
  panels.output.setColor(0,0,0)
  if numericalResult < 7.000 then
    tomatoSize = 1
    panels.output.setBackgroundColor(1,0,0)
  elseif numericalResult < 8.500 then
    tomatoSize = 2
    panels.output.setBackgroundColor(1,0.64,0)
  elseif numericalResult < 9.000 then
    tomatoSize = 3
    panels.output.setBackgroundColor(1,0.84,0)
  elseif numericalResult < 9.2 then
    tomatoSize = 4
    panels.output.setBackgroundColor(0.2,0.8,0.2)
  else
    tomatoSize = 4
    panels.output.setBackgroundColor(1,0,0)
    drawAnimation = true
    animationPhase = 1
  end
end

function createInitialScreen()
  --calculate  dimensions
  local totalWidth,totalHeight = love.graphics.getDimensions()
  local availableWidth = totalWidth - 2*CONFIG.globalMargin
  local availableHeight = totalHeight - 2*(CONFIG.globalMargin + CONFIG.verticalMargin)
  local upperHeight = availableHeight * CONFIG.upperPart
  local upperY = CONFIG.globalMargin
  local middleHeight = availableHeight * CONFIG.middlePart
  local middleY = upperY + CONFIG.verticalMargin + upperHeight
  local lowerHeight = availableHeight * CONFIG.lowerPart
  local lowerY = middleY + CONFIG.verticalMargin + middleHeight
  
  local imageWidth = CONFIG.controlWidth*CONFIG.imageWidth
  local imageX = totalWidth - imageWidth - CONFIG.globalMargin
  
  local availablePanelWidth = availableWidth - 3*CONFIG.panelMargin
  local panelWidth = availablePanelWidth/4
  local panel1X = CONFIG.globalMargin
  local panel2X = panel1X + CONFIG.panelMargin + panelWidth
  local panel3X = panel2X + CONFIG.panelMargin + panelWidth
  local panel4X = panel3X + CONFIG.panelMargin + panelWidth
  
  --load fonts
  local miniFont = love.graphics.newFont("DIN Regular.otf", CONFIG.miniFontSize)
  local smallFont = love.graphics.newFont("DIN Regular.otf", CONFIG.smallFontSize)
  local bigFont = love.graphics.newFont("DINBd___.ttf",CONFIG.bigFontSize)
  
  imageBox = createImageBox(imageX, middleY, imageWidth, middleHeight)
  
  controls = createControlList(CONFIG.numOfControls,CONFIG.globalMargin,middleY,availableWidth - imageWidth,middleHeight,miniFont)
 
  panels.output = createPanel(panel2X, lowerY, panelWidth, lowerHeight, "? t/ha", bigFont)
  panels.start = createPanel(panel1X, lowerY, panelWidth, lowerHeight, texts.start, bigFont, startFunction)
  panels.ki = createPanel(panel3X, lowerY, panelWidth, lowerHeight, texts.ki, smallFont)
  panels.back = createPanel(panel4X,lowerY,panelWidth,lowerHeight,texts.back,bigFont, function() love.event.quit(0) end)
  panels.help = createPanel(CONFIG.globalMargin,upperY,availableWidth, upperHeight, texts.help, smallFont)
  panels.help.setColor(171/255,210/255,237/255)
end