<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Chat Client</title>
    </head>

    <body>
        <div id="chat" scrolling="yes" style="border:1px solid black;height:200px;overflow-y:scroll;">
        </div>
        <div style="text-align:center">
            <textarea id="chatInput" rows="5" cols="60" maxlength="1000" placeholder="Type your message here" autofocus></textarea>
        </div>
        <div style="text-align:center">
            <button id="submitbtn" type="submit">Submit</button>
        </div>
    </body>
    
    <script>
    $(document).ready(function()
    {
        $("#submitbtn").click(function(){
        	submitText();
    	});

    	updateChat();
    	window.setInterval(updateChat, 500);

    	$('#chatInput').keypress(function (e) {
    	    var code = e.keyCode || e.which;
    	    if (code === 13) {
    	        //enter has been pressed
    	        submitText();
    	    };
    	});

    });

    var submitText = function()
    {
            var textBox = $("#chatInput");
        	$.ajax({
                type: "POST",
                url: "/chat/ChatServlet", 
                data: { message: textBox.val()},
                //dataType: "json",
                success: function(json) {
                textBox.val("");
                var chat = $("#chat");
            	chat.empty();
                var messages = json.messages;
                messages.forEach(function(message) {
                	chat.append(message);
                	chat.append("<br>");
                });
        	      var scrollChat = document.getElementById("chat");
        	      scrollChat.scrollTop = scrollChat.scrollHeight;
                },
                error: function(err) {
                    console.log('Error:' + err.responseText + '  Status: ' + err.status);
                }
            });
    };

    var updateChat = function()
    {
        $.ajax({
            type: "GET",
            url: "/chat/ChatServlet", 
            //contentType: "text/html; charset=utf-8",
            success: function(json) {
            	var chat = $("#chat");
            	chat.empty();
                var messages = json.messages;
                messages.forEach(function(message) {
                	chat.append(message);
                	chat.append("<br>");
                });
            	var scrollChat = document.getElementById("chat");
            	scrollChat.scrollTop = scrollChat.scrollHeight;
            },
            error: function(err) {
            	   console.log('Error:\n' + err.responseText + '  Status:\n' + err.status);
            }
        });
    };
</script>
    <!-- var foo = get chat div. food.scrollTop = foo.scrollHeight -->
    <!--
    	$.ajax({
    	    type: "POST",
    	    url: "Servicename.asmx/DoSomeCalculation", 
    	  data: "{param1ID:"+ param1Val+"}",
    	    contentType: "text/html; charset=utf-8",
    	    dataType: "text",
    	    success: function(msg) {
    	        UseReturnedData(msg.d);
    	    },
    	    error: function(err) {
    	        alert(err.toString());
    	        if (err.status == 200) {
    	            ParseResult(err);
    	        }
    	        else { alert('Error:' + err.responseText + '  Status: ' + err.status); }
    	    }
    	});
    -->
</html>