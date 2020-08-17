io.stdout:setvbuf("no")

local startFunction = function()
  local fillValues = controls.getLevels()
  local sum = 0
  for i,v in ipairs(fillValues) do
    sum = sum + v
  end
  if sum == 0 then
    sum = 300
  end
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
  if numericalResult < 6.000 then
    panels.output.setColor(1,0.64,0)
  elseif numericalResult < 8.500 then
    panels.output.setColor(0.2,0.8,0.2)
  elseif numericalResult < 9.758 then
    panels.output.setColor(1,0.84,0)
  else
    panels.output.setColor(1,1,1)
  end
end

love.load = function()
  love.window.setFullscreen(true)
  require "control"
  controls = createControlList(10,40)
  require "panel"
  panels = {}
  local width,height = love.graphics.getDimensions()
  panels.output = createPanel(20+width*0.3,height*0.75 + 20,width*0.3,height*0.2, "? t/ha", 50)
  panels.start = createPanel(10,height*0.75 + 20, width*0.3, height*0.2, "Start", 50, startFunction)
  panels.ki = createPanel(30+width*0.6, height*0.75 + 20, width*0.3, height*0.2, "Ertrag mit KI: 9.758", 50)
  local helptext = "Verschiebe die Balken, um die Bewässeungsmenge für die 10 Bewässerungstage zu steuern. "
  helptext = helptext .. "Du hast immer nur 300mm Wasser, schiebst du einen Balken nach oben, sinken die Mengen für die anderen Tage. "
  helptext = helptext .. "Schaffst du es, die KI zu schlagen?"
  panels.help = createPanel(10,10,width - 20, height * 0.22, helptext, 30)
end

love.draw = function()
  controls.draw()
  for i,v in pairs(panels) do
    v.draw()
  end
  
end

love.touchmoved = function(id,x,y,dx,dy,pressure)
  controls.adjustHeight(x,y,dy)
end

love.mousepressed = function(x,y)
  panels.start.click(x,y)
end
