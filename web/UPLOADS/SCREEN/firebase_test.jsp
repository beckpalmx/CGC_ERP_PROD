<!doctype html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="java.sql.Date"%>

<html>
    <head>
        <script src='https://cdn.firebase.com/js/client/2.2.1/firebase.js'></script>
        <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'></script>
        <link rel='stylesheet' type='text/css' href='/resources/tutorial/css/example.css'>
    </head>
    <body>
        <form>
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
            %>
            <div id='messagesDiv'></div>            
            <input type='text' id='nameInput' value="<%=userbean.getUsername()%>" size="20" readonly>
            <input type='text' id='messageInput' placeholder='พิมพ์ข้อความที่นี่' size="100" >
            <script>
                var myDataRef = new Firebase('https://eh3yjg9kfl7.firebaseio-demo.com/');
                $('#messageInput').keypress(function(e) {
                    if (e.keyCode == 13) {
                <%
                    Timestamp ts = (new Timestamp(new java.util.Date().getTime()));
                    System.out.println("ts = " + ts);
                %>
                        var name = $('#nameInput').val();
                        var text = $('#messageInput').val();
                        myDataRef.push({name: name, text: text});
                        $('#messageInput').val('');
                    }
                });
                myDataRef.on('child_added', function(snapshot) {
                    var message = snapshot.val();
                    displayChatMessage(message.name, message.text);
                });
                function displayChatMessage(name, text) {
                    $('<div/>').text(text).prepend($('<em/>').text(name + ': ')).appendTo($('#messagesDiv'));
                    $('#messagesDiv')[0].scrollTop = $('#messagesDiv')[0].scrollHeight;
                }
                ;
            </script>
        </form>
    </body>
</html>