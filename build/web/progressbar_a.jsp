<html>
    <head>
        <title>jQuery progressTimer Plugin Demo</title>
        <link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap-theme.min.css">

        <script src="http://code.jquery.com/jquery-2.0.3.min.js"></script> 
        <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script> 
        <script src="JS/jquery/jquery.progressTimer.js"></script> 
        
        
    </head>
    <body>
        
        
        <div id="jquery-script-menu"> </div>        
        <h1 style="margin-top:150px;">Progress</h1>
        <input type="text" id="restTime" value="15" style="width: 50px" />
        <button id="startProgressTimer">Do it!</button>
        <div id="progressTimer"></div>
        
        
        <script>
            $("#startProgressTimer").click(function() {
                $("#progressTimer").progressTimer({
                    timeLimit: $("#restTime").val()
                });
            });
        </script>
    </body>
</html>