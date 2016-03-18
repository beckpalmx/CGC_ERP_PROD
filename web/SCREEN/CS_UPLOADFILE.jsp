
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head><title>Upload page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="../JS/myAjaxFramework.js">
        </script>
        <script type="text/javascript">
            function Delete_File(){
                var Deleteflag = "";
                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    Deleteflag += (document.getElementsByName("ckbox")[i].checked)?document.getElementsByName("ckbox")[i].value+",":"";
                }
                if(Deleteflag != ""){
                    getId("delete_file").value = Deleteflag.substring(0, Deleteflag.length -1);
                    getSave(URLsend('delete_file','../JSP/CS_UPLOADFILE.jsp'));
                    getId("show").innerHTML = "";
                }else{
                    getId("show").innerHTML = "";
                }
            }
        </script>
    </head>
    <body>
        <form action="../JSP/CS_UPLOADFILE.jsp" method="post" enctype="multipart/form-data" name="form1" id="form1">
            <center>
                <table border="2">
                    <tr>
                        <td align="center"><b>Multipale file Uploade</b></td>
                    </tr>
                    <tr>
                        <td>
                            Specify file:<input name="myfile" type="file" id="myfile">
                        <td>
                    </tr>
                    <tr>
                        <td>
                            Specify file:<input name="myfile2" type="file" id="myfile2">
                        </td>
                        <!-- <tr>
                                  <td>
                                      Specify file:<input name="file" type="file" id="file">
                                   </td>
                                 </tr>-->
                    <tr>
                        <td align="center">
                            <input type="submit" name="Submit" value="Submit files"/>
                        </td>
                    </tr>

                </table>
                <!--<img src="../IMAGES/SCREEN_LOGIN/Water lilies.jpg" width="150px" height="150px">-->
            </center>
        </form>
        <input type="hidden" id="delete_file" value="">
        <input type="button" onclick="showTableNonPopup('show', 'myfile2', '../JSP/CS_ShowUpload.jsp?test=1');" value="Show">
        <input type="button" onclick="Delete_File()" value="Deletefile"><!--onclick="getSave(URLsend('delete_file','../JSP/CS_UPLOADFILE.jsp'))"-->
        <div id="show" style="width:100%; height: 150px; overflow: auto;" align="center">
        </div>
    </body>
</html>
