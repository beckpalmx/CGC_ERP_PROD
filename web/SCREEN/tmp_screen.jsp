<!DOCTYPE HTML>
<%@page import="com.cgc.Util.HeaderScreen_Report_Param"%>
<%@page import="com.cgc.bean.ReportParamBean"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <%        lookup = (String) request.getParameter("lookup");
        path = (String) request.getParameter("report_code");

        //doc_eff_date = (String) request.getParameter("doc_eff_date");
        //doc_no = (String) request.getParameter("doc_no");
        // _______________________________________________________________report
        DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
        HeaderScreen_Report_Param r_p = new HeaderScreen_Report_Param();
        UserBean userbean = (UserBean) session.getAttribute("user");
        objr_p = r_p.Fn_Report(objr_p, path);
        //path = objr_p.getPath();
        lookup = objr_p.getLookup();
        doc_eff_date = objr_p.getDoc_eff_date();
        doc_no = objr_p.getDoc_no();
        UtiDatabase objuti = new UtiDatabase();
        //_______________________________________________________________report       

    %>
    <head>
        <%@ include file="PageHeader.jsp" %>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>        

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>             

        <script type="text/javascript">
            var my_window = null;
            var t;
            function openBrown(tableID, SentToShow)
            {
                t = "../SEARCHSCREEN/Search_Report.jsp?table=" + tableID + "&sentdataToshow=" + SentToShow;
                if (my_window == null)
                    my_window = window.open(t, '', 'status=1,width=560,height=500');
                else {
                    closepopup();
                    my_window = window.open(t, '', 'status=1,width=560,height=500');
                }
            }
            function Chknull() {
                document.report.submit();
            }
            function load() {
                //AjaxRun_id('doc_date_to', '../JSP/CS_util.jsp?runer_id=1')
                //getId("doc_date_to").value  = AjaxRun_id('doc_date_to', '../JSP/CS_util.jsp?runer_id=1');
                getId("doc_date_to").value = MyCurrentDate('tha');
                alert
            }
            function summit_data() {
                var IDsend = "";
                IDsend = "testc,doc_date_from,doc_date_to,A_username,process_for";
                //getsaveProcess(URLsend('testc', "../JSP/CS_PROCESS_TRANSACTION.jsp"), 'report');
                getsaveApprove2(URLsend(IDsend, "../JSP/CS_PROCESS_TRANSACTION_WH_SUMMARY.jsp"), "report");
            }
        </script>        

        <script>
            function addDate() {
                date = new Date();
                var month = date.getMonth() + 1;
                var day = date.getDate();
                var year = date.getFullYear() + 543;

                if (day < 10) {
                    day = '0' + day
                }

                if (month < 10) {
                    month = '0' + month
                }

                if (document.getElementById('doc_date_to').value == '') {
                    document.getElementById('doc_date_to').value = day + '-' + month + '-' + year;
                }
            }
        </script>


        <script type="text/javascript">

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });

        </script>    

    </head>

    <body onload="">
        <!--body onload="addDate();"-->
        <!--form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank"-->
        <input name="A_username" type="hidden" id="A_username" value="<%=userbean.getUsername()%>" size="30" readonly/>            
        <input type="hidden" id="process_for" name="process_for" value="WAREHOUSE">            
        <input type="hidden" name="report_code" value="<%=path%>">
        <input type="hidden" name="type_report" value="5">
        <input type="hidden" name="lookup" value="<%=lookup%>">
        <input type="hidden" name="doc_eff_date" value="<%=doc_eff_date%>">
        <input type="hidden" name="doc_no" value="<%=doc_no%>">
        <input type="hidden" id="testc">  

        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;
                    <b>ประมวลผลข้อมูลมูลค่าสินค้ารายวัน (CS_PROCESS_TRANSACTION_WH_SUMMARY)</b>
                </div>                

                <div class="panel-footer">                    


                    <div align="left">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td colspan='2'><b>&nbsp;</b></td>
                            </tr>
                            <tr>
                                <td class='columnobject'><b>วันที่เริ่มต้น</b></td><td class='columnobject'><input name='doc_date_from' type='text' class="inputs" id="doc_date_from" value="<%=start_current_month%>" readonly/>
                                    &nbsp;<a id='date_1' data-toggle="tooltip" title="เริ่มวันที่"><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date_from', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>&nbsp;&nbsp;<b>ถึงวันที่</b>
                                    <input name='doc_date_to' type='text' class="inputs" id="doc_date_to" value="<%=end_current_month%>" />
                                    &nbsp;<a id='date_2' data-toggle="tooltip" title="ถึงวันที่"><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date_to', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_2', singleClick: true, step: 1});</script></td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace' ></td>
                            </tr>                            
                            <tr>
                                <td class="columnobject">&nbsp;</td>
                                <td class="columnobject"><textarea class="text_inputs" name='report' id="report" cols="100" rows="5" data-toggle="tooltip" title="แสดงข้อมูลการประมวลผล"></textarea></td>
                            </tr>

                            <!--tr>
                                <td colspan='2' class='blankspace' align="right">                                    
                                    <input type ="submit" class="cgcButton_18" value ="ประมวลผล" onclick="summit_data()">
                                </td>
                            </tr-->

                            <tr>
                                <td colspan='2' class='blankspace' ></td>
                            </tr>
                        </table>
                        <button type="submit" class="btn btn-primary btn-block" onclick="summit_data()" data-toggle="tooltip" title="กดปุ่มเพื่อประมวลผล"><b>ประมวลผล</b></button>     
                    </div>
                </div>
            </div>
        </div>



        <!--/form-->
    </body>
</html>
