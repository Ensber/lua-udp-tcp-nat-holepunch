-- p2p TCP connection
socket = require("socket")

function p2p(ip, port)
  -- connect to connection exchange server to get other end IP & port
  -- also set the option "reuseaddr" to allow other sockets to use the port
  local conSrv = socket.tcp()
  assert(conSrv:setoption("reuseaddr", true))

  --- get other peer's information ---
  assert(conSrv:connect(ip, port))
  assert(conSrv:settimeout(5))
  local recv = assert(conSrv:receive())
  print("Received message: ", recv)
  -- get local and remote address
  cip, cport = conSrv:getsockname()
  rip, rport = recv:match("([^:]+):(.*)") -- parse "ip:port" format
  rport = tonumber(rport)
  print("Remote IP, port  ", rip, rport)

  --- establish a connection with the other peer ---
  print("connecting to peer")
  local p2pCon = socket.tcp()
  assert(p2pCon:setoption("reuseaddr", true))
  print("connecting from " .. cip .. ":" .. cport .. " to " .. rip .. ":" .. rport)
  assert(p2pCon:bind(cip, cport))
  assert(p2pCon:connect(rip, rport))
  return p2pCon
end

con = p2p(error("YOUR PUBLIC IP HERE INSTEAD OF THE ERROR FUNCTION"), 4849)
print("send: ", con:send("Hello There\n"))
print("recv: ", con:receive())