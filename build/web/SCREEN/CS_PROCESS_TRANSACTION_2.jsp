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


<!DOCTYPE HTML>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <%
        lookup = (String) request.getParameter("lookup");
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
        <script type="text/javascript">
            var my_window = null;
            var t;
            function openBrown(tableID,SentToShow)
            {
                t = "../SEARCHSCREEN/Search_Report.jsp?table="+tableID+"&sentdataToshow="+SentToShow;
                if(my_window == null)
                    my_window = window.open(t,'','status=1,width=560,height=500');
                else{
                    closepopup();
                    my_window = window.open(t,'','status=1,width=560,height=500');
                }
            }
            function Chknull(){
                document.report.submit();
            }
            function summit_data(){   
                var IDsend = "";                
                IDsend = "testc,doc_date_from,doc_date_to";                
                //getsaveProcess(URLsend('testc', "../JSP/CS_PROCESS_TRANSACTION.jsp"), 'report');
                getsaveApprove2(URLsend(IDsend, "../JSP/CS_PROCESS_TRANSACTION.jsp"), "report");
            }
        </script>        
    </head>

    <body onUnload="closepopup()">
        <!--form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank"-->
            <input name="A_username" type="hidden" id="A_username" value="<%=userbean.getUsername()%>" size="30" readonly/>            
            <input type="hidden" name="report_code" value="<%=path%>">
            <input type="hidden" name="type_report" value="5">
            <input type="hidden" name="lookup" value="<%=lookup%>">
            <input type="hidden" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" name="doc_no" value="<%=doc_no%>">
            <input type="hidden" id="testc">  
            <table  cellpadding="0"  cellspacing="0">
                <tr>
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">ประมวลผลข้อมูลคลังสินค้า&nbsp;</td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <div align="left">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2"  class="blankspace"></td>
                                </tr>
                                <tr>
                                    <td colspan='2'><b>&nbsp;</b></td>
                                </tr>
                                <tr>
                                    <td class='columnlabel'><b>วันที่เริ่มต้น</b></td><td class='columnobject'><input name='doc_date_from' type='text' class="inputs" id="doc_date_from" value='01-01-2558' readonly/>
                                        &nbsp;<!--a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date_from',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>&nbsp;&nbsp;--><b>ถึง</b>
                                        <input name='doc_date_to' type='text' class="inputs" id="doc_date_to" value='' />
                                        &nbsp;<a id='date_2'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date_to',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_2',singleClick:true,step:1});</script></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">&nbsp;</td>
                                    <td class="columnobject"><textarea class="text_inputs" name='report' id="report" cols="50" rows="5"></textarea></td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace' align="right">
                                        <!--input type="button" name="cgcButton" value=" Process Transaction  " onClick="summit_data()"/-->  
                                        <input type ="submit" class="cgcButton" style="width:120px;height: 30px;"  value ="ประมวลผล" onclick="summit_data()"></td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace' ></td>
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
        <!--/form-->
    </body>
</html>
