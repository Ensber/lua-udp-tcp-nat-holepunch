-- connection detail exchange server
socket = require("socket")

cons  = {}

server = assert(socket.bind(error("YOUR LOCAL IP HERE INSTEAD OF THE ERROR FUNCTION"), 4849))
assert(server:settimeout(0.1))

while true do
  con = server:accept()
  if con then
    local ip, port = con:getpeername()
    print(ip, port)
    table.insert(cons, {ip, port, con})
    if #cons == 2 then
      for i = 1, 2 do
        cons[i%2+1][3]:send(cons[i][1] .. ":" .. cons[i][2] .. "\n")
        print("sending " .. cons[i][1] .. ":" .. cons[i][2])
      end
      cons = {}
    end
  end
end