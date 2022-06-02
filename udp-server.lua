local socket = require("socket")
local udp    = socket.udp()

buffer = {}

function handle(ip, port)
  if not buffer[1] or not (buffer[1][1] == ip and buffer[1][2] == port) then
    table.insert(buffer, {ip, port})
  end
  if #buffer == 2 then
    for i = 1, 2 do 
      udp:sendto("OTHER;" .. buffer[i % 2 + 1][1] .. ";" .. buffer[i % 2 + 1][2], buffer[i][1], buffer[i][2])
    end
    buffer = {}
  end
end

cons = {}

assert(udp:settimeout(0.2))
assert(udp:setsockname(error("YOUR LOCAL IP HERE INSTEAD OF THE ERROR FUNCTION"), 4848))
while true do
  local res = {udp:receivefrom()}
  if res[1] ~= nil or res[2] ~= "timeout" then
    print(unpack(res))
    res[1] = "ECHO " .. res[1]
    handle(res[2], res[3])
  end
  socket.sleep(0.2)
end