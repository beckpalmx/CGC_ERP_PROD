<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">               
        <meta Http-Equiv="Cache-Control" Content="no-cache">
        <meta Http-Equiv="Pragma" Content="no-cache">        


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


        <link href="../JS/bootstrap_grid/jquery.bootgrid.css" rel="stylesheet" />
        <script src="../JS/bootstrap_grid/modernizr-2.8.1.js"></script>
        <style>
            @-webkit-viewport { width: device-width; }
            @-moz-viewport { width: device-width; }
            @-ms-viewport { width: device-width; }
            @-o-viewport { width: device-width; }
            @viewport { width: device-width; }

            body { padding-top: 5px; }

            .column .text { color: #f00 !important; }
            .cell { font-weight: bold; }
        </style>

        <title>Test</title>        
    </head>
    <body>     
        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;<b>ทดสอบ(CS_001)</b></div>

                <div class="panel-footer">                

                    <form>
                        <div class="row"> <!--  Form แต่ละบรรทัด --> 

                            <div class="col-md-2">
                                <label for="email_label" class="control-label">Email address</label>
                            </div>

                            <div class="col-md-4">
                                <input type="text" id="email" name="email" class="form-control input-sm" placeholder="Email Address" autofocus>
                            </div>

                            <div class="col-md-2">
                                <label for="username_label" class="control-label">User Name</label>
                            </div>

                            <div class="col-md-4">
                                <input type="text" id="username" name="username" class="form-control input-sm" placeholder="User Name" autofocus>
                            </div>
                        </div>
                        
                        <div class="row">

                            <div class="col-md-2">
                                <label for="email_label" class="control-label">Email address</label>
                            </div>

                            <div class="col-md-4">
                                <input type="text" id="email" name="email" class="form-control input-sm" placeholder="Email Address" autofocus>
                            </div>

                            <div class="col-md-2">
                                <label for="username_label" class="control-label">User Name</label>
                            </div>

                            <div class="col-md-4">
                                <input type="text" id="username" name="username" class="form-control input-sm" placeholder="User Name" autofocus>
                            </div>
                        </div>                        
                        
                 
                        
                    </form>
                </div>
            </div>
        </div>
    </body>

</html>
