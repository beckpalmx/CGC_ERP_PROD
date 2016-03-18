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
<%@include file="PageHeader.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
        String inputSQL = " select end_time From t_process_log order by runno desc limit 1 ";
        String Str_Filed = "end_time";
        String EndYear = end_year.substring(6) ;        
        String NextYear = Integer.toString(Integer.parseInt(EndYear) + 1);
        System.out.println("end_year = " + end_year);
        System.out.println("EndYear = " + EndYear);
        System.out.println("NextYear = " + NextYear);
        //String Last_Process_Time = objuti.Last_Create_Date2(inputSQL, Str_Filed);
        //_______________________________________________________________report       

    %>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">

        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>                           

        <link rel="stylesheet" href="../CSS/checkbox/awesome-bootstrap-checkbox.css"/>     


        <script src="../JS/alertify/alertify.js"></script>        

        <link rel="stylesheet" href="../CSS/alertify/alertify.core.css" />

        <!-- alertify theme Section -->
        <!--link rel="stylesheet" href="../CSS/alertify/alertify.bootstrap.css"-->
        <link rel="stylesheet" href="../CSS/alertify/alertify.default.css">

        <link rel="stylesheet" href="../FONTS/css/font-awesome.css" />     
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">        
        <script type="text/javascript">
            function Chknull() {
                document.report.submit();
            }
            function summit_data() {
                var r = confirm("เมื่อประมวลผลเสร็จสิ้นข้อมูลเอกสารต่างๆจะถูกลบออกทั้งหมด คุณต้องการทำต่อหรือไม่ ?");
                if (r)
                {
                    var IDsend = "";
                    IDsend = "testc,doc_date_from,doc_date_to";
                    //getsaveProcess(URLsend('testc', "../JSP/CS_System_Initial.jsp"), 'report');
                    getsaveApprove2(URLsend(IDsend, "../JSP/CS_System_Initial.jsp"), "report");
                }
            }
        </script>        
    </head>

    <body onUnload="closepopup()">
        <!--form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank"-->
        <input name="A_username" type="hidden" id="A_username" value="<%=userbean.getUsername()%>" size="30" readonly/>
        <input type="hidden" name="A_dept_doc_id" id="A_dept_doc_id" value="<%=userbean.getDept_doc_id()%>">
        <input type="hidden" name="report_code" value="<%=path%>">
        <input type="hidden" name="type_report" value="5">
        <input type="hidden" name="lookup" value="<%=lookup%>">
        <input type="hidden" name="doc_eff_date" value="<%=doc_eff_date%>">
        <input type="hidden" name="doc_no" value="<%=doc_no%>">
        <input type="hidden" id="testc">  
        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-wrench" style="color:white"></span>&nbsp;<b>เริ่มต้นระบบใหม่ (ปรับข้อมูลตั้งต้น) (CS_System_Initial)</b></div>
                <div class="panel-footer">        
                    <table  cellpadding="0" cellspacing="0" >
                        <tr>
                            <td colspan="2"  class="blankspace"></td>
                        </tr>
                        <tr>
                            <td class='columnlabel1'><b>ปิดสิ้นปี&nbsp;:&nbsp;</b></td>
                            <td class='columnobject'><input name='EndYear' class='inputs' type='text' id="EndYear" value='<%=EndYear%>' readonly/>
                                &nbsp;&nbsp;<b>ขึ้นปีใหม่</b>&nbsp;&nbsp;&nbsp;&nbsp;<input name='NextYear' class='inputs' type='text' id="NextYear" value='<%=NextYear%>' readonly/>
                            </td>
                        </tr>
                        <tr>
                            <td class='columnlabel1'><b>วันที่ลบข้อมูล&nbsp;:&nbsp;</b></td><td class='columnobject'><input name='doc_date_from' class='inputs' type='text' id="doc_date_from" value='<%=start_year%>' />
                                &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date_from', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>&nbsp;&nbsp;<b>ถึง&nbsp;:&nbsp;</b>
                                <!--input name='doc_date_to' class='inputs' type='text' id="doc_date_to" value='<%=current_date%>' /-->
                                <input name='doc_date_to' class='inputs' type='text' id="doc_date_to" value='<%=end_year%>' />
                                &nbsp;<a id='date_2'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date_to', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_2', singleClick: true, step: 1});</script></td>
                        </tr>
                        <tr>
                            <td class="columnlabel1">&nbsp;</td>
                            <td class="columnobject"><textarea class='text_inputs_3' name='report' id="report" cols="50" rows="5"></textarea></td>
                        </tr>                   
                        <tr>
                            <td colspan='2' class='blankspace' align="right">
                                <input type="button" class="cgcButton_10" name="myBut" value=" Process Transaction  " onClick="summit_data()"/>                                    
                            </td>
                        </tr>
                        <tr>
                            <td colspan='2' class='blankspace' ></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <!--/form-->
    </body>
</html>
