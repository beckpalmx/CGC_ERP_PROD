<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
        <title></title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <link href="CSS/template-style.css" rel="stylesheet">
        <link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap-theme.min.css">

        <script src="http://code.jquery.com/jquery-2.0.3.min.js"></script> 
        <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script> 
        <script src="JS/jquery/jquery.progressTimer.js"></script>         
    </head>



    <body>

        <div class="wrapper">

            <header class="header">
                <strong>Header:</strong> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras tortor. Praesent dictum, libero ut tempus dictum, neque eros elementum mauris, quis mollis arcu velit ac diam. Etiam neque. Quisque nec turpis. Aliquam arcu nulla, dictum et, lacinia a, mollis in, ante. Sed eu felis in elit tempor venenatis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Ut ultricies porttitor purus. Proin non tellus at ligula fringilla tristique. Fusce vehicula quam. Curabitur vel tortor vitae pede imperdiet ultrices. Sed tortor.
            </header><!-- .header-->

            <div class="middle">

                <div class="container">
                    <main class="content">



                        <div id="jquery-script-menu"> </div>        
                        <h1 style="margin-top:150px;">ProgressTimer Plugin</h1>
                        <input type="text" id="restTime" value="40" style="width: 50px" />
                        <button id="startProgressTimer">Do it!</button>
                        <div id="progressTimer"></div>        


                        <script>
                            $("#startProgressTimer").click(function() {
                                $("#progressTimer").progressTimer({
                                    timeLimit: $("#restTime").val()
                                });
                            });
                        </script>                           

		


                    </main><!-- .content -->

                </div><!-- .container-->

                <aside class="left-sidebar">
                    <strong>Left Sidebar:</strong> Integer velit. Vestibulum nisi nunc, accumsan ut, vehicula sit amet, porta a, mi. Nam nisl tellus, placerat eget, posuere eget, egestas eget, dui. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In elementum urna a eros. Integer iaculis. Maecenas vel elit.
                    <a href="#" class="expand">Expand column</a>		</aside><!-- .left-sidebar -->

            </div><!-- .middle-->

            <footer class="footer">
                <strong>Footer:</strong> Mus elit Morbi mus enim lacus at quis Nam eget morbi. Et semper urna urna non at cursus dolor vestibulum neque enim. Tellus interdum at laoreet laoreet lacinia lacinia sed Quisque justo quis. Hendrerit scelerisque lorem elit orci tempor tincidunt enim Phasellus dignissim tincidunt. Nunc vel et Sed nisl Vestibulum odio montes Aliquam volutpat pellentesque. Ut pede sagittis et quis nunc gravida porttitor ligula.
            </footer><!-- .footer -->

        </div><!-- .wrapper -->

    </body>
</html>