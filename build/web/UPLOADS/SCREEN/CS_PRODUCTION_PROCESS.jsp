<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<html>
    <%!    String doc_eff_date, doc_no, user_login;
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- calendar stylesheet -->
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">

            function send_print() {
                if (document.getElementById('job_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสารก่อนพิมพ์');
                    return false;
                } else {
                    getId("doc_id").value = getId("job_id").value;
                    doc_id = getId("job_id").value;
                    //alert("Doc ID = " + getId("doc_id").value);
                    document.report.submit();
                }
            }

            function get_process_data() {
                var IDsend = "";
                if (document.getElementById('job_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสารก่อนประมวลผล');
                    return false;
                } else {
                    IDsend = "testc,job_id,process_for,user_login";
                    getsaveApprove2(URLsend(IDsend, "../JSP/CS_PRODUCTION_PROCESS.jsp"), "report_text");
                    getId("doc_id").value = getId("job_id").value;
                }
            }

        </script>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <title>CS_PRODUCTION_PROCESS</title>
    </head>
    <body>
        <form id="report" name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                UtiDatabase objuti = new UtiDatabase();
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_PRODUCTION_PROCESS");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                DataBean_Screen_Report objscreen = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objscreen = r_p.Fn_Report(objscreen, request.getParameter("submenu_id"));
                objr_p = r_p.Fn_Report(objr_p, "SB04");
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                user_login = userbean.getUsername();
    //_______________________________________________________________report

            %>                   
            <input type="hidden" id="report_code" name="report_code" value="RP_406"/>
            <input type="hidden" id="type_report" name="type_report" value="2"/>
            <input type="hidden" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" name="doc_no" value="<%=doc_no%>">            
            <input type="hidden" id="testc" value="">  
            <input type="hidden" id="user_login" value="<%=user_login%>">   
            <input type="hidden" id="doc_id" name="doc_id" value=""/>             
            <input type="hidden" id="process_for" name="process_for" value="PRODUCTION">                             
            <div align="center">
                <table  cellpadding="0"  cellspacing="0">
                    <tr >
                        <td class="ftopleft"></td>
                        <td  class="ftopcenter" colspan="2">รายงานสรุปการผลิต (CS_PRODUCTION_PROCESS)&nbsp;</td>
                        <td class="ftopright"></td>
                    </tr>
                    <tr >
                        <td class="fcenterleft"></td>
                        <td  colspan="2" class="fcentercenter">
                            <div align="center">
                                <table  cellpadding="0" cellspacing="0" >
                                    <tr>
                                        <td colspan="4" align="right"><b>หมายเลขเอกสาร :<%=objscreen.getDoc_no()%> </b></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="right"><b>วันที่มีผลบังคับใช้ :<%=objscreen.getDoc_eff_date()%></b></td>
                                    </tr>

                                    <tr>    
                                    <tr><td colspan='2'><b>กำหนดเงื่อนไข เพื่อประมวลผล </b></td></tr>                                
                                    <tr>
                                        <td class="columnlabel">ใบแจ้งการผลิต*&nbsp;</td>
                                        <td class="columnobject"><input name='job_id' type='text' class="inputs" id="job_id" value='' size='10'/>                                            
                                            <a href='#' onClick="openBrWindow('Vd_job_order_header&stadment=and+(delete_flag<>\'Y\')', 361, 'Search_Config2.jsp');">
                                                <img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                            <input name='job_id_desc' type='text' class="inputs" id="job_id_desc" value='' size='30' readonly="readonly"/>                                
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">&nbsp;</td>
                                        <td class="columnobject"><textarea class="text_inputs_2" name='report_text' id="report_text" cols="100" rows="5"></textarea></td>
                                    </tr>
                                    <!--tr>
                                        <td class="columnlabel">&nbsp;</td>
                                        <td class="columnobject"><textarea class="text_inputs_2" name='progress_text' id="progress_text" cols="100" rows="5"></textarea></td>
                                    </tr-->                                    
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr> 
                                    <tr>
                                        <td colspan='4' class='blankspace' align="right">                                                                                                                    
                                            <input type="button" class="cgcButton_18" name="process" value="ประมวลผล" onClick="get_process_data();"/>
                                            <input type="button" class="cgcButton_19" name="print" value="พิมพ์รายงาน" onClick="send_print();"/>
                                        </td>
                                    </tr>                                     

                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
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
            </div>
        </form>
    </body>
</html>
