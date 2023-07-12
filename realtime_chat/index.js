const app = require('express')()
const http = require('http').createServer(app)
app.get('/', (req, res) => {
   res.send("Node Server is running. Yay!!")
})
//Socket Logic
//The connection event is triggered whenever a socket is connected to our app.
//We then add a listener to the send_message event which forwards any data that is sent to it to receive_message event.
const socketio = require('socket.io')(http)

socketio.on("connection", (userSocket) => {
    userSocket.on("send_message", (data) => {
        userSocket.broadcast.emit("receive_message", data)
    })
})

http.listen(process.env.PORT)