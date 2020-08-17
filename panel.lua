
-- Creates a panel that can be button, label and panel at once

function createPanel(x,y,width,height,text,size,callback)
  local panel = {}
  panel.font = love.graphics.newFont("bahnschrift.ttf", size)
  local fontHeight = panel.font:getHeight() --intermidate values, no need to make them attributes, since panel sizes don't change
  local fontWidth = panel.font:getWidth(text)
  panel.x = x
  panel.y = y
  panel.width = width
  panel.height = height
  panel.text = text
  
  local numberOfLines = math.ceil(fontWidth / (width -20))
  print(numberOfLines)
  local textHeight = fontHeight*numberOfLines
  if textHeight + 20 > height then
    error("Too much text in a panel: " .. text)
  end
  panel.textY = panel.y + (height - textHeight) / 2
  
  panel.colorR = 171/255
  panel.colorG = 210/255
  panel.colorB = 237/255
  
  panel.draw = function()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line",panel.x,panel.y,panel.width,panel.height)
    love.graphics.setColor(panel.colorR,panel.colorG,panel.colorB)
    love.graphics.setFont(panel.font)
    love.graphics.printf(panel.text,panel.x + 10, panel.textY,panel.width -20, "center")
  end
  
  panel.setText = function(text)
    panel.text = text
  end
  
  panel.setColor = function (r,g,b)
    panel.colorR = r
    panel.colorG = g
    panel.colorB = b
  end
  
  panel.click = function(x,y)
    if x > panel.x and x < panel.x + panel.width and
          y > panel.y and y < panel.y + panel.height then
      callback()
    end
  end
  return panel
end