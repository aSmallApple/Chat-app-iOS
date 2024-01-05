var express = require("express");
var app = express();
app.set("view engine", "ejs");
app.set("views", "./views");
app.use(express.static("public"));

var fs = require("fs");
var server =  require("http").Server(app);
var io = require("socket.io")(server);
server.listen(3000);

var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({extended:false}));

io.on("connection", function(socket){
    console.log("New connection: " + socket.id);

    socket.on("khach-dang-chat", function(data){
        console.log("khach-dang-chat: "  +  data);
        io.sockets.emit("server-gui-chat", data);
    });

    socket.on("disconnect", function(){
        console.log(socket.id + " has been disconnected");
    });
});