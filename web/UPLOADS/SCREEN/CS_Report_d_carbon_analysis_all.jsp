<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>

<html>
    <%!    String lookup, doc_eff_date, doc_no, path, doc_eff_date_u, doc_no_u, lookup_u, path_u, doc_eff_date_v, doc_no_v, lookup_v, path_v;
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
            function cancal() {
                cancelAction();
                getId("show1").innerHTML = "";
                getId("show2").innerHTML = "";
            }
            function get_search() {
                showTableNonPopup("show1", "search_date", "../JSP/CS_Show_Report_d_carbon_analysis_all.jsp?select_case=1&search_date=");
                showTableNonPopup("show2", "search_date", "../JSP/CS_Show_Report_d_carbon_analysis_all.jsp?select_case=2&search_date=");
            }
            function send_print(doc_id, report_code) {

                if (report_code == "RP_098") {
                    getId("doc_no").value = getId('doc_no_v').value;
                    getId("doc_eff_date").value = getId('doc_eff_date_v').value;
                } else {
                    getId("doc_no").value = getId('doc_no_u').value;
                    getId("doc_eff_date").value = getId('doc_eff_date_u').value;
                }

                getId("doc_id").value = doc_id;
                getId("report_code").value = report_code;

                document.report.submit();
            }

            function send_print_all(search_date, report_code) {
                //alert("search_date = " + search_date);                
                //alert("report_code = " + report_code);
                if (report_code == "RP_098_BY_DASTE") {
                    getId("doc_no").value = getId('doc_no_v').value;
                    getId("doc_eff_date").value = getId('doc_eff_date_v').value;
                } else {
                    getId("doc_no").value = getId('doc_no_u').value;
                    getId("doc_eff_date").value = getId('doc_eff_date_u').value;
                }

                getId("doc_id").value = search_date;
                getId("report_code").value = report_code;

                document.report.submit();
            }

        </script>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>                  

        <title>CGC ERP</title>
    </head>
    <body>
        <form id="report" name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">

            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                DataBean_Screen_Process objs_v = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_Report_d_job_request");
                objs_v = h_p.selectheaderscreen_process(objs_v, "CS_Report_d_job_request");
                UtiDatabase objuti = new UtiDatabase();
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                DataBean_Screen_Report objr_v = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S808");
                path_u = objr_p.getPath();
                System.out.println("path_u : " + path_u);
                doc_eff_date_u = objr_p.getDoc_eff_date();
                doc_no_u = objr_p.getDoc_no();
                System.out.println("doc_eff_date_u : " + doc_eff_date_u);
                System.out.println("doc_no_u : " + doc_no_u);

                objr_v = r_p.Fn_Report(objr_p, "S357");
                path_v = objr_v.getPath();
                System.out.println("path_v : " + path_v);
                doc_eff_date_v = objr_v.getDoc_eff_date();
                doc_no_v = objr_v.getDoc_no();
                System.out.println("doc_eff_date_v : " + doc_eff_date_v);
                System.out.println("doc_no_v : " + doc_no_v);
                //_______________________________________________________________report
            %>            

            <input type="hidden" id="doc_id" name="doc_id" value=""/>
            <input type="hidden" id="report_code" name="report_code" value=""/>
            <input type="hidden" id="type_report" name="type_report" value="2"/>
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date"  value="<%=doc_eff_date%>">            

            <input type="hidden" id="doc_no_u" name="doc_no_u" value="<%=doc_no_u%>">
            <input type="hidden" id="doc_eff_date_u" name="doc_eff_date_u" value="<%=doc_eff_date_u%>">

            <input type="hidden" id="doc_no_v" name="doc_no_v" value="<%=doc_no_v%>">                   
            <input type="hidden" id="doc_eff_date_v" name="doc_eff_date_v" value="<%=doc_eff_date_v%>">

            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-search" style="color:white"></span>&nbsp;
                        <b>รายการผลวิเคราะห์คุณภาพถ่าน (CS_Report_d_carbon_analysis_all)</b>
                    </div>
                    <div class="panel-footer">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2" align="right"><b>หมายเลขเอกสาร : </b></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : </b></td>
                            </tr>
                            <tr>
                                <td width="30%" align="right">วันที่*&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" id="search_date" name="search_date" value="" size="10" ><a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'search_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>
                                    <input type='button' class="cgcButton_6" name='search' onClick="get_search();" value='ค้นหา'/>
                                    <input type="button" class="cgcButton_3" id="cancel" name="cancel" value="ยกเลิก" onclick="cancal()">
                                </td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'></td>
                            </tr>

                            <tr>
                                <td colspan="2" align="center">
                                    <div width="100%">
                                        <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">
                                            <tr>
                                                <td class="headergrid" colspan="14">รายงานถ่านออกจากเตา</td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div style="width:100%; height: 150px; overflow: auto;" id="show1"></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace'></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">                                            
                                    <div width="100%">                                                   
                                        <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">                                                    
                                            <tr>
                                                <td class="headergrid" colspan="14">รายงานการวิเคราะห์ถ่าน</td>

                                            </tr>

                                            <tr>
                                                <td class="row5" width="5%">No.&nbsp;</td>
                                                <td class="row5" width="18%">เลขที่เอกสาร&nbsp;</td>
                                                <td class="row5" width="15%">วันที่&nbsp;</td>
                                                <td class="row5" width="25%">ผู้รายงาน&nbsp;</td>
                                                <td class="row5" width="25%">ผู้ตรวจสอบ&nbsp;</td>
                                                <td class="row5" width="10%">สถานะการตรวจสอบ&nbsp;</td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div style="width:100%; height: 150px; overflow: auto;" id="show2"></div>
                                </td>                                        
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace'></td>
                            </tr>
                            <td colspan='2' align="right">

                            </td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>            
        </form>
    </body>
</html>
