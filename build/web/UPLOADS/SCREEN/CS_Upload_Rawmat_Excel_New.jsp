<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript" src="js/jquery/jquery-1.7.1.min.js"></script>  
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>       

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>   

        <link href="../CSS/component.css" rel="stylesheet" type="text/css">

        <script type="text/javascript">

            //function select_file() {
            //document.getElementById("uploadFile").value = this.value;
            //document.getElementById("uploadFile").value = document.getElementById("uploadBtn").value;

            //}

            document.getElementById("uploadBtn").onchange = function() {
                alert("OK");
                document.getElementById("uploadFile").value = this.value;
            };

        </script>            

        <script type="text/javascript">
            function check_file() {
                str = document.getElementById('myfile').value.toUpperCase();
                suffix = ".XLS";
                suffix2 = ".xls";
                if (!(str.indexOf(suffix, str.length - suffix.length) !== -1 ||
                        str.indexOf(suffix2, str.length - suffix2.length) !== -1)) {
                    alert('ไฟล์ที่นำเข้าต้องเป็น Excel ,\nไฟล์ที่เป็นชนิด *.XLS,*.xls เท่านั้น');
                    document.getElementById('myfile').value = '';
                    break;
                }
            }

            function submit_file() {
                document.myform.submit();
            }

        </script>  

        <script type="text/javascript">

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>             

        <style>
            .fileUpload {
                position: relative;
                overflow: hidden;
                margin: 10px;
            }
            .fileUpload input.upload {
                position: absolute;
                top: 0;
                right: 0;
                margin: 0;
                padding: 0;
                font-size: 20px;
                cursor: pointer;
                opacity: 0;
                filter: alpha(opacity=0);
            }
        </style>

    </head>
    <body onunload="closepopup()">
        <form name="myform" action="../JSP/CS_Upload_Rawmat_Excel.jsp" method="post" enctype="multipart/form-data">
            <input type="hidden" id="form_type" name="form_type" value="RAW">

            <div align="left">

                <div class="container">
                    <div class="panel panel-primary">
                        <div class="panel-heading"> <span class="glyphicon glyphicon-save"></span>&nbsp;
                            <b>นำเข้าข้อมูลการปรับยอดวัตถุดิบ (CS_Upload_Rawmat_Excel)</b>
                        </div>                        
                        <div class="panel-footer">            


                            <div align="center">
                                <table  cellpadding="0" cellspacing="0" >
                                    <tr>
                                        <td colspan="2"  class="blankspace"></td>
                                    </tr>

                                    <!--tr>
                                        <td class="columnlabel1"><b>ไฟล์ Excel สำหรับนำเข้า</b>&nbsp;:&nbsp;</td>
                                        <td class="columnobject">
                                            <span class="btn btn-success btn-file" data-toggle="tooltip" title="เลือกไฟล์ Excel ตามรูปแบบที่กำหนด">
                                                <b>เลือกไฟล์ Excel...&nbsp;</b><input type="file" name="myfile" id="myfile" onchange="check_file(myfile)">
                                            </span>
                                            <input type="file" name="myfile" id="myfile" onchange="check_file(myfile)">

                                        </td>
                                    </tr-->

                                    <tr>
                                        <td class="columnlabel1"><b>ไฟล์ Excel สำหรับนำเข้า :</b>&nbsp;&nbsp;</td>
                                        <td class="columnobject">
                                            <input class='inputs' id="uploadFile" placeholder="" readonly="disabled" size='60' />
                                            <div class="fileUpload btn btn-success">
                                                <b>เลือกไฟล์ Excel...&nbsp;</b>
                                                <input id="uploadBtn" type="file" class="upload" />
                                                <!--onClick="select_file();"--> 
                                            </div>              
                                        </td>
                                    </tr>


                                    <tr>
                                        <td class="columnlabel1">&nbsp;</td>
                                    </tr>


                                    <tr>
                                        <td class="columnlabel1">&nbsp;</td>
                                        <td class="columnobject">                                        
                                            <button type="button" class="btn btn-primary btn-block" data-toggle="tooltip" title="เมื่อเลือกไฟล์ Excel แล้วกดปุ่มเพื่อนำข้อมูลเข้าระบบ"  onClick="submit_file();"><b>นำข้อมูลเข้าระบบ</b></button>   
                                        </td>                                    
                                    </tr>

                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
