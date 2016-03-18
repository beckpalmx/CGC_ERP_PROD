<html>
    <head>
        <script type='text/javascript'>
            
            var progress = setInterval(function() {
                var $bar = $('.bar');

                if ($bar.width() == 400) {
                    clearInterval(progress);
                    $('.progress').removeClass('active');
                    window.location.replace("http://localhost:8080/CGC_ERP/progressbar.jsp");
                } else {
                    $bar.width($bar.width() + 40);
                    switch ($bar.width()) {
                        case 40:
                            $("#status").html("Uploading Personal Details");
                            break;
                        case 80:
                            $("#status").html("Checking Email ID");
                            break;
                        case 120:
                            $("#status").html("Generating user ID");
                            break;
                            // other case statements...
                        case 400:
                            $("#status").html("Finished");
                            break;
                    }
                }
                $bar.text($bar.width() / 4 + "%");
            }, 800);
            
        </script>
    </head>
    <body>

        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">

        <!-- Optional theme -->
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">

        <!-- Latest compiled and minified JavaScript -->
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script> 


        <div class="container">
            <br>
            <b>Bootstrap Progress Bar</b>
            <div class="progress progress-success">
                <div class="bar" style="float: left; width: 0%; " data-percentage="40"></div>
            </div>
            <br>
            <span id="status">
        </div>
    </body>
</html>