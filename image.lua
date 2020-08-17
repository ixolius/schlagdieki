
function createImageBox(x,y,width,availableHeight)
  local imageBox = {}
  imageBox.imageList = {}
  imageBox.imageList[1] = love.graphics.newImage("Abbildungen/Tomate_sehr_klein_transparent.png")
  imageBox.imageList[2] = love.graphics.newImage("Abbildungen/Tomate_klein_transparent.png")
  imageBox.imageList[3] = love.graphics.newImage("Abbildungen/Tomate_mittel_transparent.png")
  imageBox.imageList[4] = love.graphics.newImage("Abbildungen/Tomate_groß_transparent.png")
  imageBox.scale = imageBox.imageList[1]:getWidth()/width
  local height = imageBox.imageList[1]:getHeight()*imageBox.scale
  imageBox.y = y + (availableHeight - height)/2
  
  imageBox.draw = function(i)
    love.graphics.draw(imageBox.imageList[i],x,imageBox.y,0,imageBox.scale, imageBox.scale)
  end
  return imageBox
end
