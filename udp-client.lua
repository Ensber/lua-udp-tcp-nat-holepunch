socket = require("socket")
udp = socket.udp()

assert(udp:setsockname(error("YOUR LOCAL IP HERE INSTEAD OF THE ERROR FUNCTION"), 0))
assert(udp:settimeout(0.2))
udp:sendto("a", error("YOUR PUBLIC IP HERE INSTEAD OF THE ERROR FUNCTION"), 4848)

while true do
  msg, ip, port = udp:receivefrom()
  if msg then
    print(msg)
    _oip, _oport = msg:match("OTHER;([^;]+);([^;]+)")
    if _oip then
      oip = _oip
      oport = _oport
    end
  end
  socket.sleep(0.2)
  if oip then
    print(udp:sendto("b", oip, oport))
    print(udp:getsockname())
    print(oip, oport)
  end
end