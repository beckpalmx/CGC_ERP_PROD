<%-- 
    Document   : json_send_data
    Created on : Feb 22, 2015, 8:12:13 AM
    Author     : beckpalmx
--%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script src="jquery.serializeJSON.min.js"></script>
        <script>
            $(document).ready(function() {
                $("#simplepost").click(function(e)
                {
                    var MyForm = $("#ajaxform").serializeJSON();
                    console.log(MyForm);
                    $.ajax(
                            {
                                url: "submit.php",
                                type: "POST",
                                data: {valArray: MyForm},
                                success: function(maindta)
                                {

                                    alert(maindta);

                                },
                                error: function(jqXHR, textStatus, errorThrown)
                                {
                                }
                            });
                    e.preventDefault(); //STOP default action

                });
            });</script>
    </body>
    <div id="message"> </div>
    <form name="ajaxform" id="ajaxform" method="POST">
        First Name: <input type="text" name="fname" value =""/> <br/>
        Last Name: <input type="text" name="lname" value ="" /> <br/>
        Email : <input type="text" name="email" value=""/> <br/>
        <input type="button" class="btn btn-info" id="simplepost" value="Run Code"></form>
</html>

<span style="text-align: justify;">
