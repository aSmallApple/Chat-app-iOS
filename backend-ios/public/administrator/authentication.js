$(document).ready(function(){
    $("#btnLogin").click(function(){
        var un = $("#txt_Username").val();
        var pw = $("#txt_Password").val();
        $.post("./login", {
            Email:un,
            Password:pw
        }, function(data){
            console.log(data);
            if(data.result==1){
                setCookie("TOKEN", data.token);
                window.location="./admin";
            }else{
                alert(data.message);
            }
        });
    });
});