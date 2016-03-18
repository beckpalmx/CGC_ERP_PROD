<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <title>CGC ERP</title>
        <style type="text/css">
            <!--
            .BorderMain{
                border-radius: 8px; 
                padding: 55px 5px 5px 5px; 
                margin: auto; 
                height: 100px; 
                width: 550px; 
                background-color: #E6E6E6; 
                display: block;
                alignment-adjust: central;
                box-shadow: 2px 2px 2px 2px #808080;
            }
            .myButton {
                width: 120px;
                height: 30px;
                -moz-box-shadow:inset 0px 1px 0px 0px #bee2f9;
                -webkit-box-shadow:inset 0px 1px 0px 0px #bee2f9;
                box-shadow:inset 0px 1px 0px 0px #bee2f9;
                background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #63b8ee), color-stop(1, #468ccf));
                background:-moz-linear-gradient(top, #63b8ee 5%, #468ccf 100%);
                background:-webkit-linear-gradient(top, #63b8ee 5%, #468ccf 100%);
                background:-o-linear-gradient(top, #63b8ee 5%, #468ccf 100%);
                background:-ms-linear-gradient(top, #63b8ee 5%, #468ccf 100%);
                background:linear-gradient(to bottom, #63b8ee 5%, #468ccf 100%);
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#63b8ee', endColorstr='#468ccf',GradientType=0);
                background-color:#63b8ee;
                -moz-border-radius:6px;
                -webkit-border-radius:6px;
                border-radius:6px;
                border:1px solid #3866a3;
                display:inline-block;
                cursor:pointer;
                color:#14396a;
                font-family:arial;
                font-size:15px;
                font-weight:bold;
                padding:6px 24px;
                text-decoration:none;
                text-shadow:0px 1px 0px #7cacde;
            }
            .myButton:hover {
                background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #468ccf), color-stop(1, #63b8ee));
                background:-moz-linear-gradient(top, #468ccf 5%, #63b8ee 100%);
                background:-webkit-linear-gradient(top, #468ccf 5%, #63b8ee 100%);
                background:-o-linear-gradient(top, #468ccf 5%, #63b8ee 100%);
                background:-ms-linear-gradient(top, #468ccf 5%, #63b8ee 100%);
                background:linear-gradient(to bottom, #468ccf 5%, #63b8ee 100%);
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#468ccf', endColorstr='#63b8ee',GradientType=0);
                background-color:#468ccf;
            }
            .myButton:active {
                position:relative;
                top:1px;
            }

            -->
        </style>
    </head>
    <body>
        <div class="BorderMain">
            <form action="CS_Trans_01.jsp" target="_blank" method ="POST">
                Product ID <input type='text' class="inputs" name="x_product_id" size="50" placeholder="กรุณากรอกรหัสสินค้า">

                <input type ="submit" class="myButton" style="width:120px;height: 30px;"  value ="ประมวลผล">

            </form>
        </div>
    </body>
</html>
