server = require('http').Server()
io = require('socket.io').listen(server)
server.listen(9000);

handleMessage = (messageCommand, messageArgs, socket) ->
    if messageCommand == 'ECHO'
        message = {
            'command' : 'ECHO_ECHO',
            'args' : messageArgs
        }
        socket.emit 'message', JSON.stringify(message)
    else
        message = {
            'command' : 'OTHER_COMMAND',
            'args' : ['other', 'command']
        }
        socket.emit 'message', JSON.stringify(message)

io.sockets.on 'connection', (socket) ->
    console.log("connection received: " + socket.id)
    socket.on 'message', (data) ->
        console.log("message received: " + data)
        message = JSON.parse data
        handleMessage message.command, message.args, socket

    socket.on 'forceDisconnect', ->
        socket.disconnect()
