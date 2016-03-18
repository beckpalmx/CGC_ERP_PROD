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

        <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">            
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
    </head>
    <body onunload="closepopup()">        
        <form name="myform" action="../JSP/CS_Upload_Rawmat_Excel.jsp" method="post" enctype="multipart/form-data">
            <input type="hidden" id="form_type" name="form_type" value="RAW">

            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-save" style="color:white"></span>&nbsp;
                        <b>นำเข้าข้อมูลการปรับยอดวัตถุดิบ (CS_Upload_Rawmat_Excel)</b>
                    </div>                   
                    <div class="panel-footer">                  
                        <div align="center">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2"  class="blankspace"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1"><b>Excel File Name*</b>&nbsp;</td>
                                    <td class="columnobject">
                                        <input type="file" name="myfile" id="myfile" size='45' onchange="check_file(myfile)">
                                        <!--input type="file" name="myfile" id="myfile" size='45'-->
                                    </td>
                                </tr>
                                <!--tr>
                                    <td class='columnlabel1'><b>วันที่เอกสาร</b></td>
                                    <td class='columnobject'><input name='doc_date_from' type='text' class="inputs" id="doc_date_from" value='' />
                                        &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date_from',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>&nbsp;&nbsp;
                                    </td>
                                </tr-->                                
                                <tr>
                                    <td class="columnlabel1">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">&nbsp;</td>
                                    <td class="columnobject"><!--input type="submit" name="Submit" value="Submit files"/-->
                                        <input TYPE="image" SRC="../IMAGES/upload-btn.png" width="150" height="47" border="0" ALT="SUBMIT" onClick="submit_file();">                                         
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
        </form>
    </body>
</html>
