
function createImageBox(x,y,width,availableHeight)
  local imageBox = {}
  imageBox.imageList = {}
  imageBox.imageList[1] = love.graphics.newImage("Abbildungen/Tomate_mittel_transparent.png")
  imageBox.imageList[2] = love.graphics.newImage("Abbildungen/Tomate_1_transparent.png")
  imageBox.imageList[3] = love.graphics.newImage("Abbildungen/Tomate_3_transparent.png")
  imageBox.imageList[4] = love.graphics.newImage("Abbildungen/Tomate_4_transparent.png")
  imageBox.imageList[5] = love.graphics.newImage("Abbildungen/Tomate_5_transparent.png")
  imageBox.scale = width/imageBox.imageList[5]:getWidth()
  local height = imageBox.imageList[1]:getHeight()*imageBox.scale
  imageBox.y = y + (availableHeight - height)/2
  
  imageBox.draw = function(i)
    love.graphics.draw(imageBox.imageList[i],x,imageBox.y,0,imageBox.scale, imageBox.scale)
  end
  return imageBox
end
