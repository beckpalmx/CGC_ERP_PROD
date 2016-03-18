<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Bootstrap Example</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>          

        <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">    
    </head>
    <body>

        <div class="container">
            <div class="jumbotron">
                <h1>My first Bootstrap website!</h1>      
                <p>This page will grow as we add more and more components from Bootstrap...</p>      
            </div>


            <h2>Pagination - Sizing</h2>
            <p>Add class .pagination-lg for larger blocks or .pagination-sm for smaller blocks:</p>
            <ul class="pagination pagination-lg">
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li class="active"><a href="#">2</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
            </ul>

            <ul class="pagination pagination-sm">
                <li><a href="#">1</a></li>
                <li class="active"><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
            </ul>


            <h2>Table</h2>
            <p>The .table-responsive class creates a responsive table which will scroll horizontally on small devices (under 768px). When viewing on anything larger than 768px wide, there is no difference:</p>                                                                                      
            <div class="table-responsive">          
                <table class="table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Firstname</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>Anna</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Debbie</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>John</td>
                        </tr>
                    </tbody>
                </table>
            </div>            

        </div>




    </body>
</html>

