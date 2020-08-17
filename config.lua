function protect(tbl)
    return setmetatable({}, {
        __index = tbl,
        __newindex = function(t, key, value)
            error("attempting to change constant " ..
                   tostring(key) .. " to " .. tostring(value), 2)
        end
    })
end


-- START OF THE CONFIGURATION
CONFIG = {
  
  --Window proportions
  --global margins (even number!)
  globalMargin = 40,
  --margins between the three vertical sections
  verticalMargin = 40,
  --relative size of the upper part (the three parts should add up to 1)
  upperPart = 0.2,
  --relative size of the middle part
  middlePart = 0.6,
  --relative size of the lower part
  lowerPart = 0.2,
  --margin between the buttons in the lower
  
  --Options for the controls
  --width
  controlWidth = 40,
  --number of controls
  numOfControls = 10,
  --size of the tomato picture in number of control widths
  imageWidth = 4,
  --margin between between the inner and outer rectangle (even number!)
  controlMargin = 4,
  
  --Options for the panels
  --Font size for the "big font"
  bigFontSize = 42,
  --Font size for the "small font"
  smallFontSize = 30,
  --margin between rectangle and text (even number!)
  panelMargin = 10 
  
}
CONFIG = protect(CONFIG)
