<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <head>       
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <!-- calendar stylesheet -->
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>

        <link rel="stylesheet" href="JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="JS/jquery/jquery-2.1.4.js"></script>
        <script src="JS/bootstrap/js/bootstrap.min.js"></script>     

        <script src="JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="JS/bootstrap_select/css/bootstrap-theme.min.css">          

        <script type="text/javascript">
            function ckvalue()
            {
                document.getElementById("Type").value = document.getElementById("type_prod").value;
                //document.getElementById("Type").value = document.getElementById("type_prod").options[document.getElementById("type_prod").selectedIndex].text;
            }
            function add()
            {
                if (getId("select_mbranch").value == "not") {
                    alert("กรุณาเลือกสถานที่ชำระเงิน");
                } else {
                    getId("carbon_net").value = parseFloat(getId("total_weight").value) - (parseFloat(getId("bag_weight").value) * parseFloat(getId("bag_total").value));
                    confirmDialogSave(URLsend('chkNull,doc_id,doc_date,wh_in,wh_name,supplier_id,position_no,scale_no,car_no,driver_name,type_prod,product_id,total_weight,bag_total,ashes_percent,ashes_weight,dust_percent,dust_weight,volatile_percent,volatile_weight,moise_percent,moise_weight,contamination_percent,contamination_weight,net_weight,remark,username,car_date_in,bag_total,ashes_percent_ch,ashes_weight_ch,dust_percent_ch,dust_weight_ch,volatile_percent_ch,volatile_weight_ch,moise_percent_ch,moise_weight_ch,contamination_percent_ch,contamination_weight_ch,net_weight_ch,bag_weight,car_cbag_weight,car_weight,bag_net,carbon_net,select_mbranch,price_unit,lab_not_check', '../JSP/CS_022.jsp'));
                }
            }
            function cancle()
            {
                //ResetParameter('doc_id,doc_date,wh_in,wh_name,supplier_id,supplier_id_desc,sup_tel_desc,sup_address_desc,position_no,scale_no,car_no,driver_name,type_prod,product_id,product_id_desc,total_weight,bag_weight,ashes_percent,ashes_weight,dust_percent,dust_weight,volatile_percent,volatile_weight,moise_percent,moise_weight,contamination_percent,contamination_weight,net_weight,remark,total_price,username');
                cancelAction();
            }
            function Openproduct()
            {
                openBrWindow('Vproduct&stadment=and+pgroup_id+=+\'G001\'', 22, 'Search_Config2.jsp');
            }
            function Opendoc_id(input)
            {
                switch (input) {
                    case 1:
                        if (getId("select_mbranch").value == "not")
                            openBrWindow('Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'N\'', 22, 'Search_Config2.jsp');
                        else
                            openBrWindow('Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'N\'+and+location_id2+=+\'' + getId("select_mbranch").value + '\'', 22, 'Search_Config2.jsp');
                        break;
                    case 2:
                        if (getId("select_mbranch").value == "not")
                            openBrWindow('Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'Y\'', 22, 'Search_Config2.jsp');
                        else
                            openBrWindow('Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'Y\'+and+location_id2+=+\'' + getId("select_mbranch").value + '\'', 22, 'Search_Config2.jsp');
                        break;
                    default:
                        break;
                }
                //openBrWindow('Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'', 22, 'Search_Config2.jsp');
            }
            /*function Calcultor()
             {
             var URL = "../JSP/CS_022.jsp?scale_no="+getId("scale_no").value+"&product_id="+getId("product_id").value+"&status_cal="+getId("status_cal").value;
             getData_d_rawmatt_receive(URL,'ashes_percent,dust_percent,volatile_percent,moise_percent,contamination_percent,ashes_weight,dust_weight,volatile_weight,moise_weight,contamination_weight,net_weight,remark');
             }*/
            function check_percent(input, input_ch) {
                var output = parseFloat(getId(input).value) - parseFloat(getId(input_ch).value);
                if (output >= 0) {
                    return true;
                }
                else {
                    return false;
                }
            }
            function Calculator_ch(input, input_ch, input_wight_ch, total_weight, bag_weight) {
                var output_weight = parseFloat(getId(total_weight).value) - (parseFloat(getId(bag_weight).value) * parseFloat(getId("bag_total").value));
                if (check_percent(input, input_ch)) {
                    var output_percent = parseFloat(getId(input).value) - parseFloat(getId(input_ch).value);
                    output_weight = output_weight * (output_percent / 100);
                    getId(input_wight_ch).value = output_weight.toFixed(2);
                } else {

                    getId(input_wight_ch).value = "0.00";
                }
                calTotal_wight_ch();
            }

            function Chknull() {
                if (document.getElementById('doc_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else
                    document.report.submit();
            }
            function calTotal_wight_ch() {
                var output_weight = parseFloat(getId("total_weight").value) - (parseFloat(getId("bag_weight").value) * parseFloat(getId("bag_total").value));
                if (getId("ashes_percent_ch").value != "" && getId("dust_percent_ch").value != "" && getId("volatile_percent_ch").value != "" && getId("moise_percent_ch").value != "" && getId("contamination_percent_ch").value != "") {
                    var lose_wight = parseFloat(getId("ashes_weight_ch").value) + parseFloat(getId("dust_weight_ch").value) + parseFloat(getId("volatile_weight_ch").value) + parseFloat(getId("moise_weight_ch").value) + parseFloat(getId("contamination_weight_ch").value);
                    var output_weight = output_weight - lose_wight;
                    getId("net_weight_ch").value = output_weight.toFixed(2);
                }
                else {
                    getId("net_weight_ch").value = "";
                }
            }
            function cal_total_weight() {
                if (isNaN((parseFloat(getId("car_cbag_weight").value) - parseFloat(getId("car_weight").value).toFixed(2)))) {
                    getId("total_weight").value = 0;
                } else {
                    getId("total_weight").value = (parseFloat(getId("car_cbag_weight").value) - parseFloat(getId("car_weight").value)).toFixed(2);
                }

            }
            function cal_bag_net() {
                if (isNaN((parseFloat(getId("bag_total").value) * parseFloat(getId("bag_weight").value).toFixed(2)))) {
                    getId("bag_net").value = 0;
                } else {
                    getId("bag_net").value = (parseFloat(getId("bag_total").value) * parseFloat(getId("bag_weight").value)).toFixed(2);
                    getId("carbon_net").value = parseFloat(getId("total_weight").value) - (parseFloat(getId("bag_weight").value) * parseFloat(getId("bag_total").value));
                }

            }
            function New_Cal(inputValue) {
                var input = ("ashes_percent,dust_percent,volatile_percent,moise_percent,contamination_percent").split(",");
                var output = ("ashes_weight_ch,dust_weight_ch,volatile_weight_ch,moise_weight_ch,contamination_weight_ch").split(",");
                //alert(input.valueOf());
                if (inputValue) {
                    for (var i = 0; i < input.length; i++) {
                        if (i == 2) {
                            //alert(parseFloat(getId(input[i]).value)+parseFloat(getId(input[i+1]).value));
                            if ((parseFloat(getId(input[i]).value) + parseFloat(getId(input[i + 1]).value)).toFixed(2) > 24.00) {
                                getId(input[i] + "_ch").value = ((parseFloat(getId(input[i]).value) + parseFloat(getId(input[i + 1]).value)).toFixed(2) - 24.00).toFixed(2);
                                getId(output[i]).value = parseFloat((parseFloat(getId("total_weight").value) * (parseFloat(getId(input[i] + "_ch").value) / 100)).toFixed(3)).toFixed(2);
                                getId(input[i + 1] + "_ch").value = "0";
                                getId(output[i + 1]).value = "0.00";
                                i++;
                            } else {
                                getId(input[i] + "_ch").value = "0";
                                getId(output[i]).value = "0.00";
                                getId(input[i + 1] + "_ch").value = "0";
                                getId(output[i + 1]).value = "0.00";
                                i++;
                            }
                        } else {
                            Calculator_ch(input[i], input[i] + "_ch", output[i], "total_weight", "bag_weight");
                        }
                    }
                } else {
                    for (var i = 0; i < input.length; i++) {
                        getId(input[i] + "_ch").value = "0";
                        getId(output[i]).value = "0.00";
                    }
                    getId("net_weight_ch").value = "0.00";
                }
            }

            function Lab_Not_Check(inValue) {
                //alert(inValue);
                if (inValue == true) {
                    var input = ("ashes_percent,dust_percent,volatile_percent,moise_percent,contamination_percent").split(",");
                    var input2 = ("ashes_weight,dust_weight,volatile_weight,moise_weight,contamination_weight").split(",");
                    for (var i = 0; i < input.length; i++) {
                        getId(input[i]).value = "0.00";
                        getId(input[i] + "_ch").value = "0.00";
                        getId(input2[i]).value = "0.00";
                        getId(input2[i] + "_ch").value = "0.00";
                        //alert("Check = " + getId(input[i]).value);
                    }
                    getId("net_weight").value = getId("carbon_net").value;
                    getId("net_weight_ch").value = getId("carbon_net").value;
                    getId("lab_not_check").value = "Y";
                    //alert("Check = " + getId("lab_not_check").value);
                } else {
                    getId("lab_not_check").value = "N";
                    //alert("Check = " + getId("lab_not_check").value);
                }
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">        
        <title>CGC</title>
    </head>
    <body onUnload="closepopup();">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
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
                objr_p = r_p.Fn_Report(objr_p, "S501");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report

            %>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" id="status_cal" value="4" >
            <input type="hidden" id="chkNull" value="doc_id,doc_date,wh_in,supplier_id,position_no,scale_no,type_prod,product_id,total_weight,bag_weight">
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">

            <div class="panel panel-info">
                <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;
                    <h3 class="panel-title"><p align="right"><%=objscreen.getName_t() + " (" + objscreen.getPath() + ")"%></p></h3>
                </div>
                <div class="panel-footer">

                    <tr>
                    <div class="columnlabel"><b>เลขที่เอกสาร*</b>&nbsp;</div>
                    <div colspan="3" class="columnobject">
                        <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' />
                        &nbsp;<a href='#' onClick="Opendoc_id(1)"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;
                        วันที่เอกสาร*&nbsp<input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' readonly="readonly"/>
                        &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>	          	
                        &nbsp<a href='#' onClick="Opendoc_id(2)" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาข้อมูลรับวัตถุดิบที่ได้วิเคราะห์' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a> เอกสารที่ LAB วิเคราะห์ฯแล้ว&nbsp;&nbsp;
                        &nbsp;
                    </div>
                </div>                

            </div>
        </div>       
    </form>
</body>
</html>
