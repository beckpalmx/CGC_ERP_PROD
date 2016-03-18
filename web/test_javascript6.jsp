<!DOCTYPE html>
<html>
    <head>    
    <h1 id="message"></h1>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="CSS/MENU.css" rel="stylesheet" type="text/css">
    <link href="CSS/BT.css" rel="stylesheet" type="text/css">
    <script language="javascript" src="JS/myAjaxFramework.js"></script>

    <link rel="stylesheet" href="JS/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="JS/bootstrap/css/bootstrap-theme.min.css"> 

    <script src="JS/jquery/jquery-2.1.4.js"></script>
    <script src="JS/bootstrap/js/bootstrap.min.js"></script>                                   

    <link rel="stylesheet" href="CSS/checkbox/awesome-bootstrap-checkbox.css"/>     


    <script src="JS/alertify/alertify.js"></script>        

    <link rel="stylesheet" href="CSS/alertify/alertify.core.css" />

    <!-- alertify theme Section -->
    <!--link rel="stylesheet" href="CSS/alertify/alertify.bootstrap.css"-->
    <link rel="stylesheet" href="CSS/alertify/alertify.default.css">

    <link rel="stylesheet" href="FONTS/css/font-awesome.css" />                

    <script src="https://google.github.io/traceur-compiler/bin/traceur.js"></script>
    <script src="https://google.github.io/traceur-compiler/src/bootstrap.js"></script>

    <script type="module">
        class Greeter {
        constructor(message) {
        this.message = message;
        }

        greet() {
        var element = document.querySelector('#message');
        element.innerHTML = this.message;        
        }
        };

        var greeter = new Greeter('Hello, world!');
        for (let v of [1, 2, 3]) { console.log(v); }
        greeter.greet();
    </script>
</head>

<div>                            
    <button type="button" class="btn btn-success" onclick="" data-toggle="tooltip" title="Test"><b>Test</b></button>
</div>         

</html>