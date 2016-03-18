
<!DOCTYPE HTML>
<%@page import="com.cmms.Util.HeaderScreen_Report"%>
<%@page import="com.cmms.bean.DataBean_Screen_Report"%>
<%@page import="com.cmms.Util.UtiDatabase"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cmms.bean.DataBean_Screen_Process"%>
<%@page import="com.cmms.Util.HeaderScreen_Process"%>
<%@page import="com.cmms.bean.UserBean"%>
<%@page import="com.cmms.Util.DateUtil"%>
<%@page import="com.cmms.Util.PeriodDate"%>
<html>
    <%!    String lookup, doc_eff_date, doc_no;
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <link rel="stylesheet" media="all" type="text/css" href="../CSS/ui-lightness/jquery-ui-1.8.17.custom.css" />
        <link rel="stylesheet" media="all" type="text/css" href="../CSS/timepicker.css" />
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type="text/javascript" src="../JS/myAjaxFramework.js"></script><!-- calendar stylesheet -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script><!-- language for the calendar -->
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script type="text/javascript" src="../JS/jquery/jquery-1.7.1.min.js"></script>
        <script type="text/javascript" src="../JS/jquery/jquery-ui-1.8.17.custom.min.js"></script>
        <script type="text/javascript" src="../JS/jquery/jquery-ui-timepicker-addon.js"></script>
        <script type="text/javascript" src="../JS/jquery/jquery-ui-sliderAccess.js"></script>
        <script type="text/javascript" src="../JS/TimeFramwork.js"></script>

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

        <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">         


        <link href="../CSS/cgc_button.css?v=1.00a" rel="stylesheet" type="text/css">   
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">                        

        <script type="text/javascript">

            function cancal() {
                //cancelAction();                
                getId("A_Part_Group").value = "-";
                getId("A_part_id").value = "";
                getId("A_part_desc").value = "";
                getId("show1").innerHTML = "";
                //getId("show2").innerHTML = "";
            }

            function OpenDoc_id()
            {
                var str = "vd_job_order_header";
                openBrWindow(str, 281, 'Search_Config_Center.jsp');
            }

            //function get_search() {
            //showTableNonPopup("show1", "A_Delay_Date", "../JSP/MA_CS_Store_Balance.jsp?select_case=1&A_Delay_Date=");
            //showTableNonPopup("show2", "A_doc_id", "../JSP/MA_CS_Store_Balance.jsp?select_case=2&A_doc_id=");                
            //}

            function get_search_Multi_Param() {
                //showTableNonPopup2("show1", "A_doc_date,A_Part_Group,A_part_id", "../JSP/MA_CS_Store_Balance.jsp?A_doc_date=" + getId("A_doc_date").value + "&A_Part_Group=" + getId("A_Part_Group").value);
                //alert("A_Company = " + getId("A_Company").value);
                showTableNonPopup2("show1", "A_Company,A_doc_date,A_Part_Group,A_part_id", "../JSP/MA_CS_Store_Balance_By_Company.jsp");
                //showTableNonPopup("show2", "search_date", "../JSP/CS_Show_Report_d_carbon_carbon_send_qc.jsp?select_case=2&search_date=");
            }

            function send_print(doc_id, report_code) {
                getId("doc_id").value = doc_id;
                getId("report_code").value = report_code;
                document.report.submit();
            }

            function send_print_withdraw(receive_no, report_code) {
                getId("doc_id").value = receive_no;
                getId("report_code").value = report_code;
                document.report.submit();
            }

            function Search_Part_Id() {

                //str = "vm_part&stadment=+part_group_id+=+\'" + getId("A_Part_Group").value + "\'";
                //openBrWindow(str, 0, 'Search_Doc_Job_Init_id.jsp');

                if (getId("A_Part_Group").value === '-') {
                    str = "vm_part&stadment=and+delete_flag+=+\'N\'";
                } else {
                    str = "vm_part&stadment=and+delete_flag+=+\'N\'+and+part_group_id+=+\'" + getId("A_Part_Group").value + "\'";
                }
                //alert(str); 
                if (getId("A_Company").value === '001') {
                    openBrWindow(str, 0, 'Search_Doc_Job_Init_id.jsp');
                } else {
                    openBrWindow(str, 0, 'Search_Calgon_ID.jsp');

                }

            }

        </script>
        <title>Insert title here</title>
    </head>
    <!--body onload="get_search_Multi_Param();"-->
    <body onload="">  
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "");
                UtiDatabase objuti = new UtiDatabase();
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S1");
                //path = objr_p.getPath();
                //System.out.println("path : " + path);
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
            %>

            <%
                String current_date;
                DateUtil ObjDate = new DateUtil();
                current_date = ObjDate.Return_Date_Now_full();
                String start_year;
                PeriodDate ObjPeriod = new PeriodDate();
                start_year = ObjPeriod.Start_Year("S");
            %>            

            <input name="A_username" type="hidden" id="A_username" value="" size="30" readonly/>
            <input type="hidden" name="chkNull" id="chkNull" value="A_doc_id">
            <input type="hidden" name="I_status" id="I_status" value="1"><!-- เป็นการเพิ่มข้อมูลเข้าไป-->
            <input type="hidden" name="D_status" id="D_status" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" name="status_cancle" id="status_cancle" value=""><!-- status_cancle = 1 คือค่าที่นำมา Edit แต่ถ้า ="" จะเป็นการ Insert -->
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="doc_id" name="doc_id" value=""/>
            <input type="hidden" id="receive_no" name="receive_no" value=""/>
            <input type="hidden" id="report_code" name="report_code" value="MA_202_NEW">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="-">
            <input type="hidden" id="doc_no" name="doc_no" value="-">
            <input type="hidden" name="maxline" value="0" id="maxline">
            <input type="hidden" name="shift" id="shift" value ="1,2,3">
            <input type="hidden" name="shift_value" id="shift_value" value="เช้า,บ่าย,ดึก">

            <input type="hidden" name="complete_flag_id" id="complete_flag_id" value ="N">
            <input type="hidden" name="job_init_flag_id" id="job_init_flag_id" value ="-">
            <input type="hidden" name="A_repair_type" id="A_repair_type" value ="">
            <input type="hidden" name="A_mjob_cat_id" id="A_mjob_cat_id" value ="">
            <input type="hidden" name="A_machine_id" id="A_machine_id" value ="">
            <input type="hidden" name="date_f" id="date_f" value ="">
            <input type="hidden" name="date_t" id="date_t" value ="">            

            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"><span class="glyphicon glyphicon-search" style="color:white"></span>&nbsp;<b>สอบถามยอดคงเหลือพัสดุ/อะไหล่ (ตามบริษัท) (MA_CS_Store_Balance_By_Company)</b></div>
                    <div class="panel-footer">            
                        <div align="left">
                            <table  cellpadding="0" cellspacing="0" >                                  

                                <tr>                       

                                    <td align="left" width="40%"><b>บริษัท &nbsp;&nbsp;:</b>&nbsp;&nbsp;
                                        <select class="select_cgc" name="A_Company" id="A_Company">
                                            <option value="001" selected>C.Gigantic Carbon</option>
                                            <option value="002">Calgon Carbon</option>
                                        </select>
                                    </td>
                                </tr>                                  

                                <tr>                       

                                    <td align="left" width="40%"><b>ช่วงวันที่ :</b>&nbsp;
                                        <input name='A_doc_date_from' class='inputs' type='text' id="A_doc_date_from" value='<%=start_year%>' size='10' readonly="readonly" />
                                        &nbsp;-&nbsp;
                                        <input name='A_doc_date' class='inputs' type='text' id="A_doc_date" value='<%=current_date%>' size='10' readonly="readonly" />
                                        <a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'A_doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>
                                        <b>หมวดพัสดุ/อะไหล่ :&nbsp;&nbsp;</b><%=objuti.ShowSelectBox_Class1("select part_group_id,name_t,part_name_group from vm_part_group where part_group_id <> 'ZZ' order by part_group_id", "part_group_id", "part_name_group", "A_Part_Group")%><input type="hidden" id="select_dept_doc_id" value="">
                                    </td>
                                </tr>  

                                <tr>                       
                                    <td align="left" width="40%"><b>รหัสพัสดุ/อะไหล่ :</b>&nbsp;
                                        <input name='A_part_id' class='inputs' type='text' id="A_part_id" value="" size='22' readonly/>
                                        &nbsp;<a href='#'><img align='middle' border='0' width='20' height='20' onclick="Search_Part_Id();" name='IMAGE4' alt='ค้นหา' src='../IMAGES/BUTTON/MAIN/SEARCH20.png'></a>
                                        &nbsp;<input name='A_part_desc' class='inputs' type='text' id="A_part_desc" value="" size='40' readonly/>
                                        &nbsp;<input type='button' class="cgcButton_6" name='search' onClick="get_search_Multi_Param();" value='ค้นหา'/>
                                        &nbsp;<input type="button" class="cgcButton_3" id="cancel" name="cancel" value="ยกเลิก" onclick="cancal()">   
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="2" align="center">
                                        <div width="100%">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">
                                                <tr>
                                                    <td class="headergrid" colspan="14">รายการพัสดุ/อะไหล่</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 300px; overflow: auto;" id="show1"></div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>