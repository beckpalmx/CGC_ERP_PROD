
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<!DOCTYPE HTML>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Screen</title>

        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <!--link href="../CSS/MENU.css" rel="stylesheet" type="text/css"-->
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 


        <!-- calendar stylesheet -->
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes adding a calendar a matter of 1 or 2 lines of code. -->

        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">

        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>                           

        <link rel="stylesheet" href="../CSS/checkbox/awesome-bootstrap-checkbox.css"/>     

        <script src="../JS/alertify/alertify.js"></script>        

        <link rel="stylesheet" href="../CSS/alertify/alertify.core.css" />

        <!-- alertify theme Section -->
        <!--link rel="stylesheet" href="../CSS/alertify/alertify.bootstrap.css"-->
        <link rel="stylesheet" href="../CSS/alertify/alertify.default.css">

        <link rel="stylesheet" href="../FONTS/css/font-awesome.css" />
        
    </head>
    <body>

        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-wrench" style="color:white"></span>&nbsp;<b>หน้าจอการทำงาน (CS_001)</b></div>
                <input type="hidden" id="chkNull" value="screen_id,name_t_screen,process_id,dept_id">             
                <input type="hidden" id="chkstatus" value="1">
                <div class="panel-footer">        

                    <div class="bs-example">
                        <input type="button" class="btn btn-primary" data-toggle="collapse" data-target="#toggleDemo" value="Toggle Button">

                        <div id="toggleDemo" class="collapse in">

                            <div class="row">
                                <label class="control-label col-md-1 columnlabel1">รหัส Process*&nbsp;:&nbsp;</label>
                                <div class="col-md-6">                                
                                    <input type='text' class="inputs" name='process_id' id="process_id" size='10' value='' readonly/>&nbsp;&nbsp;
                                    <a href=javascript:openBrWindow('Process',1,'Search_Config.jsp');><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    <input type='text' class="inputs" name='name_t_process' id="name_t_process" size='30' value='' />                                    
                                </div>
                            </div>   


                            <div class="row">
                                <label class="control-label col-md-1 columnlabel1">รหัสแผนก*&nbsp;:&nbsp;</label>
                                <div class="col-md-6">                                
                                    <input type='text' class="inputs" name='dept_id' id="dept_id" size='10' value='' readonly/>&nbsp;&nbsp;
                                    <a href=javascript:openBrWindow('Department',1,'Search_Config.jsp');><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle'></a>&nbsp;&nbsp;
                                    <input type='text' class="inputs" name='name_t_dept' id="name_t_dept" size='30' value='' />                                  
                                </div>
                            </div>                    

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>