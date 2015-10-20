# require 'em-websocket'
#
# class IOServer
#
#   def initialize port
#     @clients = []
#
#     EM::WebSocket.start(:host => '0.0.0.0', :port => port) do |ws|
#
#       ws.onopen do |handshake|
#         @clients.push ws
#         ws.send "Connected to #{handshake.path}."
#       end
#
#       ws.onclose do
#         ws.send "Disconnected"
#         @clients.delete ws
#       end
#
#       ws.onmessage do |msg|
#         @clients.each do |client|
#           client.send msg
#         end
#         puts "Recieved: #{msg}"
#       end
#
#     end
#   end
# end