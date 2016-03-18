<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Example of Bootstrap 3 Vertical Form Layout</title>
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>     
        <style type="text/css">
            .bs-example{
                margin: 20px;
            }
        </style>

        <script type="text/javascript">

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });

        </script>                 


        <script>
            var popupWindow = null;
            $(document).ready(function() {
                $("button").click(function() {
                    popupWindow = window.open('msgbox.jsp', "_blank", "directories=no, status=no, menubar=no, scrollbars=yes, resizable=no,width=600, height=280,top=200,left=200");
                });
            });
        </script>        

    </head>
    <body>
        <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;
            <b>(Test)</b>
        </div>                

        <div class="panel-footer">        
            <div class="bs-example">
                <form>
                    <div class="form-group">
                        <label for="inputEmail">Email</label>
                        <input type="email" class="form-control" id="inputEmail" placeholder="Email">
                    </div>
                    <div class="form-group">
                        <label for="inputPassword">รหัสผ่าน</label>
                        <input type="password" class="form-control" id="inputPassword" placeholder="Password">
                    </div>
                    <div class="checkbox">
                        <label><input type="checkbox"> Remember me</label>
                    </div>
                    <button type="button" class="btn btn-primary btn-block" data-toggle="tooltip" title="Login"><b>Login</b></button>
                </form>
            </div>
        </div>            
    </body>
</html>                                		
