<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <%!        UtiDatabase objuti = new UtiDatabase();
        String path, lookup;
    %>
    <%
        lookup = (String) request.getParameter("lookup");
        path = (String) request.getParameter("report_code");
    %>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>

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
            function openBrown(tableID, SentToShow) {
                if (my_window === null) {
                    my_window = window.open("../SEARCHSCREEN/Search_Report.jsp?table=" + tableID + "&sentdataToshow=" + SentToShow, '', 'status=1,width=560,height=500');
                } else {
                    closepopup();
                    my_window = window.open("../SEARCHSCREEN/Search_Report.jsp?table=" + tableID + "&sentdataToshow=" + SentToShow, '', 'status=1,width=560,height=500');
                }
            }

            function CheckDate() {

                var da1 = new Date(document.report.date_f.value);
                var da2 = new Date(document.report.date_t.value);

                //alert(d1.valueOf());

                var d1 = document.report.date_f.value;
                var d2 = document.report.date_t.value;
                //var p1 = document.report.param_f.value;
                //var p2 = document.report.param_t.value;




                if (da1 <= da2 || d1 === '' || d2 === '') {
                    if (d1 !== '' || d2 !== '') {
                        if (d1 !== '') {
                            if (d2 === '') {
                                alert("กรุณาใส่ข้อมูลวันที่สิ้นสุดการออกรายงาน");
                            } else {
                                document.report.date_form.value = format_Date(d1);//dateFormat(da1.format,'yyyy-mm-dd').tostring;
                                document.report.date_to.value = format_Date(d2);//dateFormat(da2,'yyyy-mm-dd').tostring;
                                document.report.submit();
                            }
                        } else if (d2 !== '') {
                            if (d1 === '')
                            {
                                alert("กรุณาใส่ข้อมูลวันที่เริ่มต้นการออกรายงาน");
                            } else {
                                document.report.date_form.value = format_Date(d1);
                                document.report.date_to.value = format_Date(d2);
                                document.report.submit();
                            }
                        }
                    }
                } else
                {
                    document.report.date_form.value = format_Date(d1);
                    document.report.date_to.value = format_Date(d2);
                    document.report.submit();
                }
            }

            function getStatus() {
                if (document.getElementById("radio1").checked) {
                    document.getElementById("status").value = 0;
                } else if ((document.getElementById("radio2").checked)) {
                    document.getElementById("status").value = 1;
                }
            }

            function Chknull() {
                document.report.submit();
            }

        </script>
    </head>

    <body onUnload="closepopup()">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input type="hidden" name="report_code" value="<%=path%>">
            <input type="hidden" name="lookup" value="<%=lookup%>">
            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-print" style="color:white"></span>&nbsp;
                        <b>รายงาน 5</b>
                    </div>                

                    <div class="panel-footer">     

                        <div align="center">
                            <input type="hidden" name="type_report" value="5">
                            <input type="hidden" name="date_form" value="">
                            <input type="hidden" name="date_to" value="">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="5"  class="blankspace"></td>
                                </tr>

                                <tr><td colspan='5'><b>กำหนดเงื่อนไข การออกรายงาน</b></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ปี พ.ศ.</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select year_document from vm_year_carbon_burn_out", "year_document", "year_document", "year_document")%>&nbsp; 
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='5' class='blankspace' ></td>
                                </tr>

                                <tr>
                                    <td colspan='5' class='blankspace' align="right">
                                        <input type="button" class="cgcButton_11" name="myBut" value=" พิมพ์รายงาน  " onClick="Chknull();"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='5' class='blankspace' ></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>