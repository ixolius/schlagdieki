
function readRankingFile()
  local f = io.open("ranking.txt", "rb")
  if not f then 
    local f2 = io.open("ranking.txt", "w")
    if not f2 then error("A readable file called 'ranking' has to exist in the program folder") end
    f2:close()
    f = io.open("ranking.txt", "rb")
  end
  local block = 10
  local eof = false
  local results = {}
  while not eof do
    local bytes = f:read(block*2)
    if not bytes then eof = true else
      local pos,res = 1,0
      local i = 1
      while i <= math.min(#bytes/2,block) do
        res,pos = love.data.unpack("I2",bytes,pos)
        table.insert(results,res)
        i = i+1
      end
    end
  end
  f:close()
  return results
end

function writeRankingFile()
  local f = io.open("ranking.txt","wb")
  for i,v in ipairs(results) do
    f:write(love.data.pack("string","I2",v))
  end
  f:close()
end

--This function places the result AND returns the position
function placeResult(result)
  local i = 1
  while i <= #results do
    if results[i] < result then
      table.insert(results,i,result)
      return i
    end
    i = i + 1
  end
  table.insert(results,i,result)
  return i
end

function createRankingModule(ix,iy,iwidth,iradius)
  local modul = {
    x = ix,
    y = iy,
    width = iwidth,
    radius = iradius,
    xEnd = ix + iwidth
  }
  modul.draw = function()
    if not (ranking == 0) then
      love.graphics.setColor(1,1,1)
      love.graphics.line(modul.x,modul.y,modul.xEnd,modul.y)
      local circleCenter = modul.x + modul.width * (1 - (ranking - 1)/#results)
      love.graphics.circle("fill", circleCenter, modul.y,modul.radius)
    end
  end
  return modul
end


        