
-- Creates a water control, which keeps track of its state/"fill level"
-- The control has the following attributes
--    -x,y,width,height: Dimensions of the "outer rectangle" (white, not filled)
--    -innerX,innerY,...: Dimensions of the "inner rectangle" (blue, filled)
--    -fillLevel: part of the "innner rectangle" which is filled (range from 0 to 1)
-- The control has the following methods:
--    -draw: Draws the control with its actual fillLevel on the screen
--    -adjustHeight(x,y,d) : If x and y are inside the "inner rectangle", changes the fillLevel so that the change represents the distance d in pixels when drawn
function createControl(x,y,width,height,day,font)
  local control = {}
  control.font = font
  control.fillLevel = 0.5
  control.text1 = texts.controls .. tostring(day)
  control.text1Width = control.font:getWidth(control.text1)
  control.x = x
  control.y = y
  control.width = width
  control.height = height
  control.innerX = control.x + CONFIG.controlMargin
  control.innerY = control.y + CONFIG.controlMargin
  control.innerWidth = control.width - CONFIG.controlMargin*2
  control.innerHeight = control.height - CONFIG.controlMargin*2
  control.line1Y = control.y + control.height + CONFIG.controlTextMargin
  control.line2Y = control.line1Y + font:getHeight()
  control.text1X = control.x + (control.width - control.text1Width)/2
  
  control.draw = function()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line",control.x,control.y,control.width,control.height)
    love.graphics.setColor(171/255,210/255,237/255)
    local invisibleHeight = control.innerHeight * (1 - control.fillLevel) -- This is the height of the "invisible" part of the inner bar
    love.graphics.rectangle("fill",control.innerX,control.innerY + invisibleHeight, control.innerWidth, control.innerHeight - invisibleHeight)
    love.graphics.setFont(control.font)
    love.graphics.setColor(1,1,1)
    love.graphics.print(control.text1,control.text1X, control.line1Y)
    local irrigation = string.format("%.2f mm",(300*control.fillLevel)/sum)
    local text2Width = control.font:getWidth(irrigation)
    local text2X = control.x + (control.width - text2Width)/2
    love.graphics.print(irrigation,text2X,control.line2Y)
  end
  control.adjustHeight = function(x,y,d)
    if x > control.x and x < control.x + control.width and y > control.y and y < control.y + control.height then
      control.fillLevel = math.min(math.max(0,control.fillLevel - d/control.innerHeight), 1)
    end
  end
  return control
end

function createControlList(n,initialX,y,width,height,font)
  local controlList = {}
  controlList.table  = {}
  controlList.n = n
  controlList.font = font
  
  local fontHeight = font:getHeight()
  local controlHeight = height - fontHeight*2 -CONFIG.controlTextMargin
  
  local spareWidth = width - (n+2)*CONFIG.controlWidth --Abstand zum Bild und zum linken Rand
  if spareWidth < n + 2 then
    error("To broad controls for this window")
  end
  local distance = math.floor(spareWidth / n)
  local x = initialX + distance
  for i = 1,n do
    table.insert(controlList.table,createControl(x,y,CONFIG.controlWidth,controlHeight,i*10,controlList.font))
    x = x + CONFIG.controlWidth + distance
  end
  controlList.getLevels = function ()
    local result = {}
    for i,v in ipairs(controlList.table) do 
      result[i] = v.fillLevel
    end
    return result
  end
  controlList.adjustHeight = function(x,y,d)
    for i,v in ipairs(controlList.table) do
      v.adjustHeight(x,y,d)
    end
  end
  controlList.draw = function()
    for i,v in ipairs(controlList.table) do
      v.draw()
      local x = v.x + v.width
      local y = v.y+ v.height
    end
  end
  return controlList
end
