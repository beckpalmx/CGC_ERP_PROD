<!DOCTYPE HTML>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<html>
    <head>        
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

        <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">           

        <script type="text/javascript">

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });

        </script>        

        <script>
            function CheckDate() {
                if (getId("date_f").value != "" && getId("date_t").value != "") {
                    document.report.date_from.value = format_Date(getId("date_f").value);
                    document.report.date_to.value = format_Date(getId("date_t").value);
                    //alert(document.report.date_from.value);
                    //alert(document.report.date_to.value);
                    document.report.submit();
                } else if (getId("date_f").value == "" && getId("date_t").value == "") {
                    document.report.submit();
                } else {
                    alert("กรุณาใส่วันที่ให้ครบ");
                }
            }

            function Chknull() {
                var arryChk = new Array;
                arryChk[0] = "chkNull";
                if (ChkParameter(arryChk))
                {
                    //document.report.submit();
                } else {
                    alert("กรุณาใส่เงื่อนไขให้ครบถ้วน");
                }
            }
        </script>

    </head>

    <body onunload="closepopup()"> 

        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;
                    <b>รายงานสินค้าที่ไม่มีการเคลื่อนไหว (CS_Trans_Not_Movement_Scr_V1)</b>
                </div>                

                <div class="panel-footer">
                    <form name ="report" action="CS_Trans_Not_Movement_Process_V1.jsp" target="_blank" method ="post">
                        <% UtiDatabase objuti = new UtiDatabase();%>
                        <%UserBean userbean = (UserBean) session.getAttribute("user");%>
                        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>            
                        <input type="hidden" name="date_from" value="">
                        <input type="hidden" name="date_to" value="">        
                        <input type="hidden" name="chkNull" id="chkNull" value="price_year,month_id">  
                        <table  cellpadding="0"  cellspacing="0">        
                            <tr>
                                <td>
                                <td colspan='2' class='blankspace' ></td>
                            </tr>                                 

                            <tr>
                                <!--td class="columnlabel"><b>ปี พ.ศ.*&nbsp;</b></td-->        
                                <td class='columnobject'><div align="right" data-toggle="tooltip" title="เลือกปี พ.ศ. "><b>ปี พ.ศ.&nbsp;:</b>&nbsp;</div></td>
                                <td colspan="3" class="columnobject" data-toggle="tooltip" title="เลือกปี พ.ศ. ">                                    
                                    <%=objuti.ShowSelectBox_Bootstrap("select price_year from vmproduct_price_year order by price_year desc", "price_year", "price_year", "price_year", "price_year", "-")%>                                    
                                </td>
                            </tr>    
                            <tr>
                                <td>
                                <td colspan='2' class='blankspace' ></td>
                            </tr>     
                            <tr>
                                <!--td class="columnlabel"><b>เดือน *&nbsp;</b></td-->      
                                <td class='columnobject'><div align="right" data-toggle="tooltip" title="เลือกเดือน "><b>เดือน&nbsp;:</b>&nbsp;</div></td>
                                <td colspan="1" class="columnobject" data-toggle="tooltip" title="เลือกเดือน">
                                    <%=objuti.ShowSelectBox_Bootstrap("select month_id from mmonth order by runno", "month_id", "month_id", "month_id", "month_id", "-")%>                                
                                </td>
                            </tr>


                            <tr>
                                <td>
                                <td colspan='2' class='blankspace' ></td>
                            </tr>           

                        </table>            

                        <button id = "newThread" class="btn btn-primary btn-block" type="submit" data-toggle="tooltip" title="กดปุ่มเพื่อประมวลผล"><b>ประมวลผล</b></button>

                        <!--button type="button" id="button" class="btn btn-primary btn-block" data-toggle="tooltip" title="กดปุ่มเพื่อประมวลผล" onClick="javascript:Chknull();"><b>ประมวลผล</b></button-->

                    </form>
                    <!--/div-->
                </div>
            </div>
        </div>
    </body>
</html>
