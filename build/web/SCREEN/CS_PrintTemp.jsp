<%@page import="com.cgc.bean.UserBean"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>

    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
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
            var my_window = null;
            var t;
            function openBrown(tableID, SentToShow)
            {
                t = "_Report.jsp?table=" + tableID + "&sentdataToshow=" + SentToShow;
                if (my_window == null)
                    my_window = window.open(t, '', 'status=1,width=560,height=500');
                else {
                    closepopup();
                    my_window = window.open(t, '', 'status=1,width=560,height=500');
                }
            }
            function Chknull() {
                /*if(document.getElementById('job_id').value == ''){
                 alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                 }else*/
                document.report.submit();
            }
        </script>
    </head>

    <body onUnload="closepopup()">


        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-log-in" style="color:white"></span>&nbsp;
                    <b>รายงานการผลิตถ่านกัมมันต์ (CS_PrintTemp)</b>
                </div>                

                <div class="panel-footer">        

                    <form name="report" method="post" action="../JSP/CS_PrintTemp.jsp">

                        <td  colspan="2" class="fcentercenter">
                            <div align="left">
                                <table  cellpadding="0" cellspacing="0" >
                                    <tr>
                                        <td colspan="2"  class="blankspace"></td>
                                    </tr>
                                    <tr>
                                        <td colspan='2'>&nbsp;</td>
                                    </tr><tr>
                                        <td class='columnlabel1'>วันที่การผลิต : &nbsp;</td>
                                        <td class='columnobject'><!--<input name='job_id' type='text' class="inputs" id="job_id" value='' />
                                                      &nbsp;<a href='javascript:;' onClick="openBrown('d_job_order_header','job_id')" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' /></a>-->
                                            <input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' readonly="readonly"/>
                                            &nbsp;<a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>&nbsp;&nbsp;</td></tr>

                                    <tr>
                                        <td colspan='2' class='blankspace' ></td>
                                    </tr>

                                    <tr>
                                        <td colspan='2' class='blankspace' align="right">
                                            <input type="button" class="cgcButton_11" name="myBut" value=" Export Data  " onClick="Chknull()"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace' ></td>
                                    </tr>
                                </table>
                            </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
