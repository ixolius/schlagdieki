
-- Creates a panel that can be button, label and panel at once

function createPanel(x,y,width,height,text,font,callback)
  local panel = {}
  panel.font = font
  local fontHeight = panel.font:getHeight() --intermidate values, no need to make them attributes, since panel sizes don't change
  local fontWidth = panel.font:getWidth(text)
  panel.x = x
  panel.y = y
  panel.width = width
  panel.height = height
  panel.text = text
  
  local doublePadding = CONFIG.panelPadding * 2
  local numberOfLines = math.ceil(fontWidth / (width - doublePadding))
  local textHeight = fontHeight*numberOfLines
  if textHeight + doublePadding > height then
    error("Too much text in a panel: " .. text)
  end
  panel.textY =  panel.y + (panel.height - textHeight) /2
  
  panel.colorR, panel.colorG, panel.colorB = 1,1,1
  panel.bgColorR, panel.bgColorG, panel.bgColorB = 0,0,0
  
  panel.draw = function()
    local linewidth = love.graphics.getLineWidth()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line",panel.x,panel.y,panel.width,panel.height)
    love.graphics.setColor(panel.bgColorR,panel.bgColorG,panel.bgColorB)
    love.graphics.rectangle("fill",panel.x + linewidth, panel.y + linewidth, panel.width - 2*linewidth, panel.height - 2*linewidth)
    love.graphics.setColor(panel.colorR,panel.colorG,panel.colorB)
    love.graphics.setFont(panel.font)
    love.graphics.printf(panel.text,panel.x + CONFIG.panelPadding, panel.textY,panel.width - doublePadding, "center")
  end
  
  panel.setText = function(text)
    panel.text = text
  end
  
  panel.setColor = function (r,g,b)
    panel.colorR = r
    panel.colorG = g
    panel.colorB = b
  end
  
  panel.setBackgroundColor = function(r,g,b)
    panel.bgColorR = r
    panel.bgColorG = g
    panel.bgColorB = b
  end
  
  panel.getBackgroundColor = function()
    return panel.bgColorR, panel.bgColorG, panel.bgColorB
  end
  
  panel.click = function(x,y)
    if x > panel.x and x < panel.x + panel.width and
          y > panel.y and y < panel.y + panel.height then
      callback()
    end
  end
  return panel
end