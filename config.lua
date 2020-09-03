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
  globalMargin = 60,
  --margins between the four vertical sections
  verticalMargin = 30,
  --relative size of the upper part (the four parts should add up to 1)
  upperPart = 0.2,
  --relative size of the middle part
  middlePart = 0.6,
  --relative size of the lower part 
  lowerPart = 0.12,
  --relative size of the bottom part
  bottomPart = 0.08,
  --margin between the buttons in the lower part
  panelMargin = 30,
  --part of the bottom part that is used for the panel (the rest goes to the ranking module)
  bottomPanelPart = 0.35,
  
  --Options for the controls
  --width
  controlWidth = 40,
  --number of controls
  numOfControls = 10,
  --size of the tomato picture in number of control widths
  imageWidth = 4,
  --margin between between the inner and outer rectangle (even number!)
  controlMargin = 4,
  --space between control and text
  controlTextMargin = 5,
  --size of the control labels
  miniFontSize = 18,
  
  --Options for the panels
  --Font size for the "big font"
  bigFontSize = 38,
  --Font size for the "small font"
  smallFontSize = 24, 
  --minimum space between panel border and text, additional padding
  panelPadding = 10,
  --Length of the color transition cycle, in seconds
  colorTransition = 12,
  
  --Options for the Ranking Module
  --Radius of the circle
  rankingModuleCircleRadius = 10,
  
  --texts
  text_de = {
    help = "Verschiebe die Balken, um die Menge für die 10 Bewässerungsereignisse zu steuern. Du hast immer nur 300 mm Wasser, schiebst du einen Balken nach oben, sinken die Mengen für die anderen Tage. Schaffst du es, die KI zu schlagen?",
    start = "Start",
    ki = "Ertrag mit KI: 9.300 t/ha",
    back = "Beenden",
    controls = "Tag ",
    ranking = "Deine Platzierung: ",
    rankingStart = "Noch keine Platzierung"
  },
  text_en = {
    help = "Touch and move the bars up and down to distribute 300 mm of water over 10 irrigation events. The more water you use in one event the less is left for the other events. Can you beat the AI?",
    start = "start",
    ki = "Yield by AI: 9.300 t/ha",
    back = "close",
    controls = "day ",
    ranking = " Your Ranking: ",
    rankingStart = "No placement yet"
  }
  
  
}
CONFIG = protect(CONFIG)
