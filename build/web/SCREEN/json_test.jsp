<%-- 
    Document   : json_test
    Created on : Feb 20, 2015, 9:52:14 PM
    Author     : beckpalmx
--%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="../JS/cgc_jsframework.js">
        </script>        
        <title>CGC ERP</title>
    </head>
    <body>
        <h1>Cricketer Details</h1>
        <table class="src">
            <tr><th>Name</th><th>Country</th></tr>
            <tr><td><div id="Name">Sachin</div></td>
                <td><div id="Country">India</div></td></tr>
        </table>

        <div class="central">
            <button type="button" onclick="loadJSON()">Update Details </button>
    </body>
</html>
