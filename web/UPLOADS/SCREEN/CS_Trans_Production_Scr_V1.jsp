<!DOCTYPE HTML>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <head>
        <%@ include file="PageHeader.jsp" %>
        <title></title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>         

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>                   

        <script type="text/javascript">

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });

        </script>        

        <script>
            $(document).ready(function() {
                $("button").click(function() {
                    if (getId("date_f").value != "" && getId("date_t").value != "") {
                        document.report.date_from.value = format_Date(getId("date_f").value);
                        document.report.date_to.value = format_Date(getId("date_t").value);
                        document.report.submit();
                    } else if (getId("date_f").value == "" && getId("date_t").value == "") {
                        document.report.submit();
                    } else {
                        alert("กรุณาใส่วันที่ให้ครบ");
                    }
                });
            });
        </script>


    </head>

    <body onunload="closepopup()"> 

        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;
                    <b>ประมวลผลรายงานสรุปการผลิต (CS_Trans_Production_Scr_V1)</b>
                </div>                

                <div class="panel-footer">

                    <form name ="report" action="CS_Trans_Production_Prc_V1.jsp" target="_blank" method ="post">
                        <input type="hidden" name="chkNull" id="chkNull" value="date_f,date_t">
                        <input type="hidden" name="date_from" value="">
                        <input type="hidden" name="date_to" value="">          
                        <table  cellpadding="0"  cellspacing="0">                        
                            <tr>                                
                                <td class="columnobject"><b>ใบแจ้งการผลิต*</b>&nbsp;<input name='job_id' type='text' class="inputs" id="job_id" value='' size='10' data-toggle="tooltip" title="เลือกหรือป้อนเลขที่ใบแจ้งการผลิต" />                                            
                                    <a href='#' onClick="openBrWindow('Vd_job_order_header&stadment=and+(delete_flag<>\'Y\')', 361, 'Search_Config2.jsp');" data-toggle="tooltip" title="เลือกหรือป้อนเลขที่ใบแจ้งการผลิต">
                                        <img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                    <input name='job_id_desc' type='text' class="inputs" id="job_id_desc" value='' size='30' readonly="readonly"/>                                
                                </td>
                            </tr>                             

                            <input name="date_f" type='hidden' class="inputs" id="date_f" value="" readonly/>
                            <input name="date_t" type='hidden' class="inputs" id="date_t" value="" readonly/>

                            <td>
                            <td colspan='2' class='blankspace' ></td>
                            </tr> 
                        </table>     

                        <!--button type="button" class="btn btn-primary btn-block" data-toggle="tooltip" title="กดปุ่มเพื่อประมวลผล" onclick="CheckDate()"><b>ประมวลผล</b></button-->
                        <button type="button" class="btn btn-primary btn-block" data-toggle="tooltip" title="กดปุ่มเพื่อประมวลผล" ><b>ประมวลผล</b></button>

                    </form>
                    <!--/div-->
                </div>
            </div>
        </div>
    </body>
</html>
