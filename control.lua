
-- Creates a water control, which keeps track of its state/"fill level"
-- The control has the following attributes
--    -x,y,width,height: Dimensions of the "outer rectangle" (white, not filled)
--    -innerX,innerY,...: Dimensions of the "inner rectangle" (blue, filled)
--    -fillLevel: part of the "innner rectangle" which is filled (range from 0 to 1)
-- The control has the following methods:
--    -draw: Draws the control with its actual fillLevel on the screen
--    -adjustHeight(x,y,d) : If x and y are inside the "inner rectangle", changes the fillLevel so that the change represents the distance d in pixels when drawn
function createControl(x,y,width,height)
  local control = {}
  control.fillLevel = 0.5
  control.x = x
  control.y = y
  control.width = width
  control.height = height
  control.innerX = control.x + CONFIG.controlMargin
  control.innerY = control.y + CONFIG.controlMargin
  control.innerWidth = control.width - CONFIG.controlMargin*2
  control.innerHeight = control.height - CONFIG.controlMargin*2
  control.draw = function()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line",control.x,control.y,control.width,control.height)
    love.graphics.setColor(171/255,210/255,237/255)
    local invisibleHeight = control.innerHeight * (1 - control.fillLevel) -- This is the height of the "invisible" part of the inner bar
    love.graphics.rectangle("fill",control.innerX,control.innerY + invisibleHeight, control.innerWidth, control.innerHeight - invisibleHeight)
    --love.graphics.print(tostring(control.fillLevel),control.x + 10, control.y + control.height + 10)
  end
  control.adjustHeight = function(x,y,d)
    if x > control.x and x < control.x + control.width and y > control.y and y < control.y + control.height then
      control.fillLevel = math.min(math.max(0,control.fillLevel - d/control.innerHeight), 1)
    end
  end
  return control
end

function createControlList(n,initialX,y,width,height)
  local controlList = {}
  controlList.table  = {}
  controlList.n = n
  
  local spareWidth = width - (n+1)*CONFIG.controlWidth --Abstand zum Bild
  if spareWidth < n + 2 then
    error("To broad controls for this window")
  end
  local distance = math.floor(spareWidth / n)
  local x = initialX
  for i = 1,n do
    table.insert(controlList.table,createControl(x,y,CONFIG.controlWidth,height))
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
