<%@page import="com.cgc.Util.ProgressDisplay"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<html>
<head>
  <meta charset="utf-8" />
  <title>jQuery UI Progressbar Random</title>
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <style>
  .ui-progressbar {
    position: relative;
  }
  .progress-label {
    position: absolute;
    left: 50%;
    top: 4px;
    font-weight: bold;
    text-shadow: 1px 1px 0 #fff;
  }
  </style>
  <script>
  var pval=0;
  $(function() {
    var progressbar = $( "#progressbar" ),
      progressLabel = $( ".progress-label" );
  
    progressbar.progressbar({
      value: false,
      change: function() {
        progressLabel.text( progressbar.progressbar( "value" ) + "%" );
      },
      complete: function() {
        progressLabel.text( "Complete!" );
      }
    });
  progress();
   
function progress() {
 var xmlhttp;
if (window.XMLHttpRequest)
  {
  xmlhttp=new XMLHttpRequest();
  }
else
  {
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
      pval=xmlhttp.responseText;//getting result from servlet
      progressbar.progressbar( "value",parseInt(pval));//converting string result to integer
    }
  }
    xmlhttp.open("GET","ProgressDisplay?pval="+pval,true);//value sending to servlet
    xmlhttp.send();   
     var val=parseInt(pval);
     if ( val < 100 ) {
        setTimeout( progress, 1000 );
      }
    }
     
  });
  </script>
</head>
<body>
 <div id="progressbar"><div class="progress-label"></div></div>
</body>
</html>