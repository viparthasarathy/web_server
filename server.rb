require 'socket'

server = TCPServer.open(2000)
loop {
  client = server.accept
  request_message = client.read_nonblock(256)
  header, body = request_message.split("\r\n\r\n", 2)
  request_method = header.split[0]
  request_file = header.split[1][1..-1]

  if File.exists?(request_file)

    file = File.open(request_file)

    if request_method == "GET"
      client.puts("HTTP/1.0 200 OK \r\nDate: #{Time.now.ctime} \r\nContent-Type: text/html \r\nContent-Length: #{File.size(file)} \r\n\r\n#{file.read}")
    end

  else
  	client.puts("HTTP/1.0 404 Not Found \r\nDate: #{time.now.ctime}")
  end

  client.close
}