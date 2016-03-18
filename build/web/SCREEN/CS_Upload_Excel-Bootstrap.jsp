<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8"/>
        <title>UPLOAD FILE EXCEL</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
        <link href="../JS/bootstrap-fileinput-master/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />  
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="../JS/bootstrap-fileinput-master/js/fileinput.min.js" type="text/javascript"></script>
        <script src="../JS/bootstrap-fileinput-master/js/fileinput_locale_fr.js" type="text/javascript"></script>
        <script src="../JS/bootstrap-fileinput-master/js/fileinput_locale_es.js" type="text/javascript"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js" type="text/javascript"></script>     

        <script>
            $("#myfile").fileinput({
                uploadUrl: '#', // you must set a valid URL here else you will get an error
                //allowedFileExtensions : ['jpg', 'png','gif'],
                allowedFileExtensions: ['xls', 'xlsx', 'XLS', 'XLSX'],
                overwriteInitial: false,
                maxFileSize: 1000,
                maxFilesNum: 10,
                //allowedFileTypes: ['image', 'video', 'flash'],
                slugCallback: function(filename) {
                    return filename.replace('(', '_').replace(']', '_');
                }
            });

            function submit_file() {
                document.myform.submit();
            }

        </script>      


    </head>
    <body>

        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;
                    <b>Upload File (CS_Upload_Excel)</b>
                </div>                

                <div class="panel-footer">                      
                    <form name="myform" action="../JSP/CS_Upload_Excel.jsp" method="post" enctype="multipart/form-data">
                        <input type="hidden" id="form_type" name="form_type" value="RAW">
                        <div class="form-group">
                            <input name="myfile" id="myfile" type="file" multiple class="file" data-overwrite-initial="false" data-min-file-count="2">
                        </div>
                    </form>    
                    <br>
                    <button type="submit" class="btn btn-primary btn-block" onclick="submit_file()" data-toggle="tooltip" title="UPLOAD FILE"><b>UPLOAD FILE</b></button>                         
                </div>                    
                </body>
            </div>
        </div>
    </div>

</html>