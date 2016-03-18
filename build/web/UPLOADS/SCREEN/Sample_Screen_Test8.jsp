<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<!DOCTYPE HTML>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CGC Export Data</title>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>          

        <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">                            
        
        <script src="../JS/bootstrap_checkbox/js/bootstrap-checkbox.js"></script>                      

    </head>    
    <body>
        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;
                    <b>ทดสอบ</b>
                </div>                

                <div class="panel-footer">        

                    <form id="userForm" class="form-horizontal">

                        <div class="form-group form-group-sm">
                            <label class="control-label col-md-1 columnlabel1">ชื่อ :</label>
                            <div class="col-md-3"><input type="text" class="form-control input-medium input-sm" /></div>
                            <label class="control-label col-md-1 columnlabel1">ชื่อ :</label>
                            <div class="col-md-3"><input type="text" class="form-control input-medium input-sm" /></div>                            
                        </div>       
                        
                        <div class="form-group form-group-sm">
                                <label class="control-label col-md-1 columnlabel1">ชื่อ :</label>                                                                   
                                <div class="col-md-3"><input type="checkbox" data-style="btn-group-justified" value=""></div>                                                                
                        </div>                        

                        <div class="form-group form-group-sm">
                            <label class="control-label col-md-1 columnlabel1">ชื่อ :</label>
                            <div class="col-md-3"><input type="text" class="form-control input-medium input-sm" /></div>
                            <label class="control-label col-md-1 columnlabel1">ชื่อ :</label>
                            <div class="col-md-3"><input type="text" class="form-control input-medium input-sm" /></div>
                        </div>                        

                    </form>
                </div>
            </div>
        </div>

    </body>
</html>
