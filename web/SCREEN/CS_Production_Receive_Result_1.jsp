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
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>        
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">          
    </head>

    <script type="text/javascript">

        function send_print() {
            if (document.getElementById('job_id').value == '') {
                alert('กรุณาใส่ข้อมูลเลขที่เอกสารก่อนพิมพ์');
                return false;
            } else {
                getId("doc_id").value = getId("job_id").value;
                alert("getId("doc_id").value = " + getId("doc_id").value);
                        document.report.submit();
            }
        }

        function submit_data() {
            var IDsend = "";
            if (document.getElementById('job_id').value == '') {
                alert('กรุณาใส่ข้อมูลเลขที่เอกสารก่อนประมวลผล');
                return false;
            } else {
                IDsend = "testc,job_id,process_for";
                getsaveApprove2(URLsend(IDsend, "../JSP/CS_Production_Receive_Result.jsp"), "report_text");
                getId("doc_id").value = getId("job_id").value;
            }
        }

    </script>

    <body>        
        <form id="report" name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                UtiDatabase objuti = new UtiDatabase();
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_022");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                DataBean_Screen_Report objscreen = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objscreen = r_p.Fn_Report(objscreen, request.getParameter("submenu_id"));
                objr_p = r_p.Fn_Report(objr_p, "S807");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report

            %>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="text" id="report_code" name="report_code"  value="RP_406">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">            
            <input type="hidden" id="testc" value="">  
            <input type="text" id="doc_id" value="">  
            <input type="hidden" id="process_for" name="process_for" value="PRODUCTION">                 

            <table  cellpadding="0"  cellspacing="0">
                <tr>
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รายงานสรุปการผลิต&nbsp;</td>
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
                                    <td class="columnobject"><textarea class="text_inputs" name='report_text' id="report_text" cols="50" rows="5"></textarea></td>
                                </tr>         
                                <tr>
                                    <td class="columnlabel">&nbsp;</td>
                                    <td class="columnobject">&nbsp;</td>
                                </tr>                                 
                                <tr>
                                    <td colspan='4' class='blankspace' align="right">                                                                                                                    
                                        <input type="button" class="cgcButton_19" name="process" value="ประมวลผล" onClick="submit_data();"/>
                                        <input type="button" class="cgcButton_18" name="print" value="พิมพ์รายงาน" onClick="send_print();"/>
                                    </td>
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
        </form>
    </body>
</html>
