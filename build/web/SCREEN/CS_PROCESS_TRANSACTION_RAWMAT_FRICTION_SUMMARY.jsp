
<!DOCTYPE HTML>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.HeaderScreen_Report_Param"%>
<%@page import="com.cgc.bean.ReportParamBean"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="java.util.Random"%>

<html>
    <%!    String path, lookup, doc_eff_date, doc_no, date_from, date_to, report_code;
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
        String Last_Process_Time = objuti.Last_Create_Date("tmp_stock_rawmat_friction_daily");
        Random r = new Random();
        String r_create = Long.toString(Math.abs(r.nextLong()), 36);
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
                if (my_window === null)
                    my_window = window.open(t, '', 'status=1,width=560,height=500');
                else {
                    closepopup();
                    my_window = window.open(t, '', 'status=1,width=560,height=500');
                }
            }

            function send_print() {
                if (document.getElementById('doc_date_from').value === '' || document.getElementById('doc_date_to').value === '') {
                    alert('กรุณาใส่วันที่ก่อนพิมพ์');
                    return false;
                } else {
                    document.report.date_form.value = format_Date(getId("doc_date_from").value);
                    document.report.date_to.value = format_Date(getId("doc_date_to").value);
                    document.report.submit();
                }
            }

            function load() {
                //AjaxRun_id('doc_date_to', '../JSP/CS_util.jsp?runer_id=1')
                //getId("doc_date_to").value  = AjaxRun_id('doc_date_to', '../JSP/CS_util.jsp?runer_id=1');
                getId("doc_date_to").value = MyCurrentDate('tha');
            }

            function summit_data() {
                if (getId("doc_date_to").value.substring(0, 2) < 28) {
                    alert("กรุณาเลือกวันที่สิ้นสุดเป็นสิ้นเดือน");
                } else {
                    var IDsend = "";
                    IDsend = "testc,doc_date_from,doc_date_to,A_username,process_for,r_create";
                    getId("time_process").value = getId("time_process").value + 1;
                    //alert("Before = " + getId("time_process").value);
                    if (getId("time_process").value === '11') {
                        getsaveApprove2(URLsend(IDsend, "../JSP/CS_PROCESS_TRANSACTION_RAWMAT_FRICTION_SUMMARY.jsp"), "report");
                        //alert("A = " + getId("time_process").value);
                    } else {
                        if (parseInt(getId('rs_txtForJs2').value) >= 5) {
                            alert("ประมวลผลเสร็จสิ้น กรุณาออกจากหน้าจอ");
                        } else {
                            alert("กำลังทำการประมวลผล กรุณารอสักครู่ ...");
                        }

                    }
                }
            }


        </script>        

        <script>
            function addDate() {
                date = new Date();
                var month = date.getMonth() + 1;
                var day = date.getDate();
                var year = date.getFullYear() + 543;

                if (day < 10) {
                    day = '0' + day;
                }

                if (month < 10) {
                    month = '0' + month;
                }

                if (document.getElementById('doc_date_to').value === '') {
                    document.getElementById('doc_date_to').value = day + '-' + month + '-' + year;
                }
            }

            function Process_Progress_bak() {

                var res = countTextJs2(getId('report').value, 140);
                //alert("res = " + res);
                var Count = 0;
                if (res === true) {
                    getId('rs_txtForJs2').value = parseInt(getId('rs_txtForJs2').value) + 1;
                    Count = parseInt(getId('rs_txtForJs2').value);
                }
                //alert("Count = " + Count);
                //alert("OK time_process = " + getId("time_process").value);
                if (getId("time_process").value === '11' && Count <= 5) {
                    //alert("doc_date_to = " + getId("doc_date_to").value);
                    AjaxRun_id("report", "../JSP/Count_Stock_Friction_Daily_Rec.jsp?runer_id='" + getId("r_create").value + "-" + getId("doc_date_to").value.substring(0, 2) + "-RAW'");
                }
            }

            function Process_Progress() {

                var res = countTextJs2(getId('report').value, 140);
                //alert("res = " + res);
                var Count = 0;
                if (res === true) {
                    getId('rs_txtForJs2').value = parseInt(getId('rs_txtForJs2').value) + 1;
                    Count = parseInt(getId('rs_txtForJs2').value);
                }

                if (getId("time_process").value === '11' && Count <= 5) {
                    //alert("doc_date_to = " + getId("doc_date_to").value);
                    AjaxRun_id("report", "../JSP/Count_Stock_Friction_Daily_Rec.jsp?runer_id='" + getId("r_create").value + "-" + getId("doc_date_to").value.substring(0, 2) + "-RAW'");
                }
            }

            function Chk_Last_Process_Time() {
                //alert("OK time_process = " + getId("time_process").value);
                //if (getId("time_process").value === '11') {
                //alert("doc_date_to = " + getId("doc_date_to").value);
                AjaxRun_id("Last_Process_Time", "../JSP/CS_Check_Last_Time_Process.jsp?runer_id=2");
                //}
            }

            function Start_Check_Process_Progress() {

                myVar = setInterval(function() {
                    Process_Progress();
                    //Chk_Last_Process_Time();
                }, 5000);
            }

            function countTextJs2(txtForJs2, Text_Lenght) {//ฟังก์ชั่นนับจำนวนตัวอักษรไม่รวมช่องว่าง
                //var txtForJs2 = document.getElementById('report').value;
                var re = false;
                var countTxtNull = 0;
                var countTxt = 0;
                try {
                    countTxtNull = txtForJs2.match(/\s/g).length;//นับจำนวนช่องว่าง
                } catch (e) {
                }
                countTxt = txtForJs2.length - countTxtNull;//จำนวนตัวอักษรทั้งหมด-จำนวนช่องว่าง=จำนวนตัวอักษรไม่รวมช่องว่าง
                //alert(countTxt);
                if (countTxt >= Text_Lenght) {
                    re = true;
                }

                return re;

            }

        </script>

        <script type="text/javascript">

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });

        </script>    

    </head>

    <body onload="Start_Check_Process_Progress();">

        <!--body onload="Chk_Last_Process_Time();"-->
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">

            <input name="A_username" type="hidden" id="A_username" value="<%=userbean.getUsername()%>" size="30" readonly/>            
            <input type="hidden" id="process_for" name="process_for" value="RAWMAT_FRICTION">            
            <!--input type="hidden" name="report_code" value="<%=path%>"-->
            <input type="hidden" name="report_code" value="RP_VTMP_STOCK_RAWMAT_FRICTION_DAILY">  
            <input type="hidden" name="type_report" value="4">
            <input type="hidden" name="lookup" value="<%=lookup%>">
            <input type="hidden" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" name="doc_no" value="<%=doc_no%>">
            <input type="hidden" id="testc">  
            <input type="hidden" name="price_year" value="-">
            <input type="hidden" name="date_form" value="">
            <input type="hidden" name="date_to" value="">                            
            <input type="hidden" name="product_id" value="-">
            <input type="hidden" name="pgroup_id" value="-">
            <input type="hidden" name="warehouse_id" value="">
            <input type="hidden" name="branch" value="K">            
            <input type="hidden" name="location_id" value="-">            
            <input type="hidden" name="friction_house" value="-">    
            <input type="hidden" id="time_process" value="1">       
            <!--input type="hidden" id="Last_Process_Time" value="<%=Last_Process_Time%>"-->
            <input type="hidden" name="r_create" id="r_create" value="<%=r_create%>">    
            <input type="hidden" id="rs_txtForJs2" value="1">  

            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;
                        <b>ประมวลผลข้อมูลมูลค่าวัตถุดิบรายวัน (ถ่านสี)(CS_PROCESS_TRANSACTION_RAWMAT_FRICTION_SUMMARY)</b>
                    </div>                
                    <div class="panel-footer">                    
                        <div align="left">
                            <table  cellpadding="0" cellspacing="0" >
                                <!--tr>
                                    <td colspan="2"  class="blankspace"></td>
                                </tr-->
                                <tr>
                                    <td class='columnobject'><b>วันที่เริ่มต้น&nbsp;: </b></td><td class='columnobject'><input name='doc_date_from' type='text' class="inputs" id="doc_date_from" value="<%=start_current_month%>" readonly/>
                                        &nbsp;<a id='date_1' data-toggle="tooltip" title="เริ่มวันที่"><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date_from', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>&nbsp;&nbsp;<b>ถึงวันที่&nbsp;:</b>
                                        <input name='doc_date_to' type='text' class="inputs" id="doc_date_to" value="<%=end_current_month%>" />
                                        &nbsp;<a id='date_2' data-toggle="tooltip" title="ถึงวันที่"><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date_to', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_2', singleClick: true, step: 1});</script></td>
                                </tr>



                                <tr>
                                    <td colspan='2' class='blankspace' ></td>
                                </tr>                                             

                                <tr>
                                    <td class="columnobject">&nbsp;</td>
                                    <td class="columnobject"><textarea class="text_inputs_3" name='report' id="report" cols="100" rows="5" data-toggle="tooltip" title="แสดงข้อมูลการประมวลผล"></textarea></td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace' ></td>
                                </tr>                                  

                                <tr>
                                    <td class='columnobject'><b>ประมวลผลครั้งล่าสุด&nbsp;: </b></td><td class='columnobject'>
                                        <input name='Last_Process_Time' type='text' class="inputs" id="Last_Process_Time" value="<%=Last_Process_Time%>" size = "55" readonly/>
                                        <!--label id="Last_Process_Time"><b><%=Last_Process_Time%></b></label-->
                                    </td>
                                </tr>                                       

                            </table>
                            <div>            
                                <button type="button" class="btn btn-primary btn-block" onclick="summit_data()" data-toggle="tooltip" title="กดปุ่มเพื่อประมวลผล"><b>ประมวลผล</b></button>     
                            </div> 

                            <table>
                                <tr>
                                    <td></td>
                                </tr>
                            </table>

                            <div>
                                <button type="button" class="btn btn-success btn-block" onclick="send_print()" data-toggle="tooltip" title="กดปุ่มเพื่อพิมพ์รายงาน"><b>พิมพ์รายงาน</b></button>     
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
