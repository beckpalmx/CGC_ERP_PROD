<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <head>
        <style>
            .thumb {
                height: 75px;
                border: 1px solid #000;
                margin: 10px 5px 0 0;
            }
        </style>
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js">
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" >
            function test(input){
                alert(input.files[0].rea)
            }


        </script>
    </head>
    <body onUnload="closepopup()">
        <form action="../JSP/CS_UPLOADFILE.jsp" method="post" enctype="multipart/form-data" name="form1" id="form1">
        <%UserBean userbean = (UserBean) session.getAttribute("user");%>
        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
        <input type="hidden" id="status_u" value ="2">
        <input type = "hidden" id ="status_d" value ="3">
        <table  cellpadding="0"  cellspacing="0">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ทะเบียนเครื่องจักร&nbsp;(CS_200)</td>
                <td class="ftopright"></td>
            </tr>
            <tr >
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter">
                    <div align="center">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ชื่อรูปภาพ&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" id="pic_name" name="pic_name" value="" size="30"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">&nbsp;</td>
                                <td class="columnobject"><!--<input name="myfile" type="file" id="myfile" onchange="test(this)"><input type="button" value="preview" ><div id="showpicture"><img src="file://C:\Documents and Settings\All Users\Documents\My Pictures\Sample Pictures\Winter.jpg" id="privewimg" name='privewimg' width='100' height='100' border='0' align='middle' ></div>-->
                                    <input type="file" id="files" name="files[]"  />
                                    <div id="list"></div></td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace' >
                                    <br>
                                    <div align="center">
                                        <a href="javascript:;" onClick="cancelAction()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogSave(URLsend('chkNull,machine_id,name_t,remark,username','../JSP/CS_200.jsp'))"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogDelete(URLsend('machine_id,name_t,remark,status_d,username','../JSP/CS_200.jsp'))"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>                                    </div>
                                    <br>
                                    <input type="submit" value="upload">
                                </td>
                            </tr>
                        </table>
                    </div></td>
                <td class="fcenterright"></td>
            </tr>
            <tr bordercolor="0069B3">
                <td class="ffootleft"></td>
                <td  class="ffootcenter" colspan="2"></td>
                <td class="ffootright"></td>
            </tr>
        </table>
</form>
    </body>
    <script type="text/javascript" >
        function handleFileSelect(evt) {
            //alert(getId('files').files[0])
            var files = evt.target.files; // FileList object

            // Loop through the FileList and render image files as thumbnails.
            for (var i = 0, f; f = files[i]; i++) {

                // Only process image files.
                if (!f.type.match('image.*')) {
                    continue;
                }

                var reader = new FileReader();
                // Closure to capture the file information.
                reader.onload = (function(theFile) {
                    return function(e) {
                        // Render thumbnail.

                        var span = document.createElement('span');
                        document.getElementById('list').innerHTML = ['<img class="thumb" src="', e.target.result,
                            '" title="', escape(theFile.name), '"/>'].join('');
                        //document.getElementById('list').innerHTML = span.innerHTML;
                    };
                })(f);

                // Read in the image file as a data URL.
                reader.readAsDataURL(f);
            }
        }
        //if(document.getElementById('files').addEventListener){
            document.getElementById('files').addEventListener('change', handleFileSelect, false);
        //}else{
        //    document.getElementById('files').attachEvent('onchange',handleFileSelect);
        //}

    </script>
</html>
