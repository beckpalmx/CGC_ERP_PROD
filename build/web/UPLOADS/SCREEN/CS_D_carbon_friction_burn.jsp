<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="java.text.DecimalFormat" %>
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
        <link rel="stylesheet" media="all" type="text/css" href="../CSS/ui-lightness/jquery-ui-1.8.17.custom.css" />
        <link rel="stylesheet" media="all" type="text/css" href="../CSS/timepicker.css" />
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

        <script type="text/javascript">
            function ckvalue()
            {
                document.getElementById("Type").value = document.getElementById("type_prod").value;
            }
            function add()
            {
                if (document.getElementById('doc_date').value == '' || document.getElementById('product_id').value == '' || document.getElementById('location_id').value == '' || document.getElementById('wh_id').value == '') {
                    alert('กรุณป้อนข้อมูลให้ครบถ้วน [วันที่เอกสาร,ชนิดถ่าน,โกดัง,กองที่]');
                } else {
                    // var send_data ;
                    // send_data = "weight_carbon_burn_in_6,burn_no_6,channel_6,burn_date_6,weight_carbon_burn_in_7,burn_no_7,channel_7,burn_date_7,weight_carbon_burn_in_8,burn_no_8,channel_8,burn_date_8,weight_carbon_burn_in_9,burn_no_9,channel_9,burn_date_9,weight_carbon_burn_in_10,burn_no_10,channel_10,burn_date_10" ;                    
                    confirmDialogSave(URLsend('complete_flag,doc_id,doc_date,product_id,weight_carbon_in,weight_carbon_friction,weight_carbon_dust,weight_carbon_iron,weight_carbon_total,weight_carbon_bigbag,weight_carbon_burn_in,weight_carbon_real_lost,percent_carbon_real_lost,weight_carbon_lost,percent_carbon_lost,burn_no,channel,wh_id,location_id,remark,percent_moisture,rawmat_emp_id,product_emp_id,username,weight_carbon_burn_in_2,burn_no_2,channel_2,weight_carbon_burn_in_3,burn_no_3,channel_3,weight_carbon_burn_in_4,burn_no_4,channel_4,weight_carbon_burn_in_5,burn_no_5,channel_5,weight_carbon_burn_in_total,burn_date_1,burn_date_2,burn_date_3,burn_date_4,burn_date_5,weight_carbon_burn_in_6,burn_no_6,channel_6,burn_date_6,weight_carbon_burn_in_7,burn_no_7,channel_7,burn_date_7,weight_carbon_burn_in_8,burn_no_8,channel_8,burn_date_8,weight_carbon_burn_in_9,burn_no_9,channel_9,burn_date_9,weight_carbon_burn_in_10,burn_no_10,channel_10,burn_date_10', '../JSP/CS_D_carbon_friction_burn.jsp'));

                }
            }
            function cancle()
            {
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
                        openBrWindow('vd_carbon_friction_burn_detail&stadment=and+complete_flag+<>+\'Y\'', 222, 'Search_Config2.jsp');
                        break;
                    case 2:
                        openBrWindow('vd_carbon_friction_burn_detail&stadment=and+complete_flag+<>+\'N\'', 222, 'Search_Config2.jsp');
                        break;
                    default:
                        break;
                }
            }

            function Chknull() {
                if (document.getElementById('doc_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else
                    document.report.submit();
            }

            function cal_total_weight() {
                if (isNaN((parseFloat(getId("weight_carbon_in").value) - parseFloat(getId("weight_carbon_friction").value) - parseFloat(getId("weight_carbon_dust").value) - parseFloat(getId("weight_carbon_iron").value).toFixed(2)))) {
                    getId("weight_carbon_total").value = 0;
                    getId("weight_carbon_real_lost").value = 0;
                    getId("percent_carbon_real_lost").value = 0;
                } else {
                    //getId("weight_carbon_total").value = (parseFloat(getId("weight_carbon_in").value) - parseFloat(getId("weight_carbon_friction").value) - parseFloat(getId("weight_carbon_dust").value) - parseFloat(getId("weight_carbon_iron").value)).toFixed(2);

                    getId("weight_carbon_burn_in_total").value = (parseFloat(getId("weight_carbon_burn_in").value)
                            + parseFloat(getId("weight_carbon_burn_in_2").value)
                            + parseFloat(getId("weight_carbon_burn_in_3").value)
                            + parseFloat(getId("weight_carbon_burn_in_4").value)
                            + parseFloat(getId("weight_carbon_burn_in_5").value)
                            + parseFloat(getId("weight_carbon_burn_in_6").value)
                            + parseFloat(getId("weight_carbon_burn_in_7").value)
                            + parseFloat(getId("weight_carbon_burn_in_8").value)
                            + parseFloat(getId("weight_carbon_burn_in_9").value)
                            + parseFloat(getId("weight_carbon_burn_in_10").value));

                    getId("weight_carbon_total").value = (parseFloat(getId("weight_carbon_friction").value) + parseFloat(getId("weight_carbon_dust").value) + parseFloat(getId("weight_carbon_iron").value) + parseFloat(getId("weight_carbon_bigbag").value)).toFixed(2);
                    getId("weight_carbon_real_lost").value = (parseFloat(getId("weight_carbon_in").value) - parseFloat(getId("weight_carbon_total").value)).toFixed(2);
                    getId("percent_carbon_real_lost").value = ((parseFloat(getId("weight_carbon_real_lost").value) * 100) / parseFloat(getId("weight_carbon_in").value)).toFixed(2);
                    getId("weight_carbon_lost").value = (parseFloat(getId("weight_carbon_in").value) - parseFloat(getId("weight_carbon_burn_in_total").value)).toFixed(2);
                    getId("percent_carbon_lost").value = ((parseFloat(getId("weight_carbon_lost").value) * 100) / parseFloat(getId("weight_carbon_in").value)).toFixed(2);

                }
            }

            function cal_total_weight_burn_in() {

                getId("weight_carbon_burn_in_total").value = (parseFloat(getId("weight_carbon_burn_in").value)
                        + parseFloat(getId("weight_carbon_burn_in_2").value)
                        + parseFloat(getId("weight_carbon_burn_in_3").value)
                        + parseFloat(getId("weight_carbon_burn_in_4").value)
                        + parseFloat(getId("weight_carbon_burn_in_5").value)
                        + parseFloat(getId("weight_carbon_burn_in_6").value)
                        + parseFloat(getId("weight_carbon_burn_in_7").value)
                        + parseFloat(getId("weight_carbon_burn_in_8").value)
                        + parseFloat(getId("weight_carbon_burn_in_9").value)
                        + parseFloat(getId("weight_carbon_burn_in_10").value));
            }

            function cal_deduct_weight() {

                if (getId("status").value != "Y")
                {
                    getId("deduct_weight_moisture").value = 0;
                    getId("total_weight").value = (parseFloat(getId("net_weight_receive").value) - parseFloat(getId("deduct_weight_moisture").value)).toFixed(2);
                } else {
                    if ((parseFloat(getId("moisture").value) - parseFloat(getId("moisture_std").value)) > 0)
                    {
                        getId("deduct_weight_moisture").value = (((parseFloat(getId("moisture").value) - parseFloat(getId("moisture_std").value)) * parseFloat(getId("net_weight_receive").value)) / 100).toFixed(2);
                        getId("total_weight").value = (parseFloat(getId("net_weight_receive").value) - parseFloat(getId("deduct_weight_moisture").value)).toFixed(2);
                    } else {
                        getId("deduct_weight_moisture").value = 0;
                        getId("total_weight").value = (parseFloat(getId("net_weight_receive").value) - parseFloat(getId("deduct_weight_moisture").value)).toFixed(2);
                    }
                }
            }

            function cal_adjust_decimal() {

                if (isNaN((parseFloat(getId("net_weight_receive").value) - parseFloat(getId("deduct_weight_moisture").value).toFixed(2)))) {
                    getId("total_weight").value = 0;
                } else
                    getId("total_weight").value = (parseFloat(getId("net_weight_receive").value) - parseFloat(getId("deduct_weight_moisture").value).toFixed(2));
            }

            function cal_total_price() {
                var t_price = 0;
                if (isNaN((parseFloat(getId("total_weight").value) - parseFloat(getId("price_unit").value).toFixed(2)))) {
                    getId("total_price").value = 0;
                } else
                    t_price = (parseFloat(getId("total_weight").value) * parseFloat(getId("price_unit").value)).toFixed(2);
                getId("total_price").value = parseFloat(t_price).toFixed(2);
                getId("net_weight_payment").value = ThaiBaht(getId("total_price").value);
            }

            function Checkvalue(thisvalue) {
                if (thisvalue) {
                    getId("complete_flag").value = "Y";
                    alert("เอกสารนี้สมบูรณ์เรียบร้อยแล้ว");
                } else {
                    getId("complete_flag").value = "N"
                    //alert("เอกสารนี้สมบูรณ์เรียบร้อยแล้ว");
                }
            }

            function OpenConfirm(table, URL, dept_id) {
                var dept_id1, dept_id2, status;
                dept_id1 = '09';
                dept_id2 = '10';
                status = 'Y';

                if (dept_id == "1") {
                    table += "&stadment=and+dept_id+=+\'" + dept_id1 + "\'+and+status+=+\'" + status + "\'"
                } else {
                    table += "&stadment=and+dept_id+=+\'" + dept_id2 + "\'+and+status+=+\'" + status + "\'"
                }
                openBrWindow(table, 313, URL);
                //"openBrWindow('Vemployee3', 313, 'Search_Config2.jsp');"
            }


        </script>         
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">

        <title>CGC ERP</title>
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
            <input type="hidden" id="chkNull" value="doc_date,product_id,location_id,wh_id,weight_carbon_in">
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">

            <div align="left">

                <div class="container">
                    <div class="panel panel-primary">
                        <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                            <b><%=objscreen.getName_t() + "(" + objscreen.getPath() + ")"%></b>
                        </div>                        
                        <div class="panel-footer">

                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="4" align="right"><b>หมายเลขเอกสาร :<%=objscreen.getDoc_no()%> </b></td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="right"><b>วันที่มีผลบังคับใช้ :<%=objscreen.getDoc_eff_date()%></b></td>
                                </tr>
                                <!--tr>
                                    <td class="columnlabel1"><B>เอกสารสมบูรณ์</B>&nbsp;</td>
                                    <td class="columnobject"><input id="complete_flag" type="checkbox" onclick="Checkvalue(this.checked)" value="N" name="complete_flag"/></td>
                                </tr-->              

                                <tr>
                                    <td class="columnlabel1"><b>เอกสารสมบูรณ์</b>&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <div class="checkbox checkbox-primary">
                                            <input type="checkbox" id="complete_flag" name="complete_flag" value="N" onClick="Checkvalue(this.checked)">
                                            <label for="complete_flag"></label> 
                                        </div>
                                    </td>
                                </tr>                                    

                                <tr>
                                    <td class="columnlabel1"></td>
                                    <td colspan="3" class="columnobject">
                                        <b>---------------------------- วัตถุดิบ ---------------------------------------------------------</b>
                                    </td>
                                </tr>                                  
                                <tr>
                                    <td width="170" class="columnlabel1"><b>เลขที่เอกสาร</b>&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='doc_id' type='text' class="inputs"  id="doc_id" value='' size='8' readonly="readonly"/>
                                        &nbsp;<a href='#' onClick="Opendoc_id(1)"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;                                        
                                        วันที่เอกสาร*&nbsp;
                                        <input name='doc_date' type='text' class="inputs"  id="doc_date" value='' size='8' readonly="readonly"/>
                                        &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>	          	
                                        <b>เลขที่เอกสาร(เอกสารสมบูรณ์แล้ว)</b>&nbsp;<a href='#' onClick="Opendoc_id(2)" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    </td>
                                </tr>                           


                                <tr>
                                    <td class="columnlabel1">ชนิดถ่าน*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='product_id' type='text' class="inputs"  id="product_id" value='' size='8' readonly="readonly"/>                                                                                
                                        &nbsp;<a href='#' onClick="openBrWindow('vmrawmat', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;&nbsp;&nbsp;<input name='prod_name' type='text' class="inputs"  id="prod_name" value='' size='50' readonly="readonly" />                                
                                    </td>                                        
                                </tr>       

                                <tr>
                                    <td class="columnlabel1">กองที่*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='location_id' type='text' class="inputs"  id="location_id" value='' size='8' readonly />
                                        &nbsp;<a href='javascript:;' onClick="openBrWindow('vmlocation', 289, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                        
                                        &nbsp;<input type="hidden" name="location_name" id="location_name" value="" size="20">                                    
                                    </td>
                                </tr>                                   

                                <tr>
                                    <td class="columnlabel1">โกดัง/โรงสี*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='wh_id' type='text' class="inputs"  id="wh_id" value='' size='8' readonly="readonly"/>                                        
                                        <!--a href='#' onClick="openBrWindow('Mwarehouse&stadment=and+wh_type+=+\'F\'', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='wh_name' type='text' class="inputs"  id="wh_name" value='' size='30' readonly="readonly" />                                </td-->
                                        &nbsp;<a href='#' onClick="openBrWindow('vmwarehouse', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                        <input name='wh_name' type='text' class="inputs"  id='wh_name' value='' size='30' readonly="readonly" />                                
                                    </td>                                        
                                </tr>

                                <tr>
                                    <td class="columnlabel1">% ความชื้น&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='percent_moisture' type='text' class="inputs"  id="percent_moisture" value='0' size='12' onkeypress="IsNuber(this.value, this)" />	          	
                                    </td>
                                </tr>                            
                                <tr>
                                    <td class="columnlabel1">น้ำหนักถ่านเข้า&nbsp;</td>
                                    <td colspan="3" class="columnobject"><input name="weight_carbon_in" type='text' class="inputs"  id="weight_carbon_in" value='0' size="12" onkeypress="IsNuber(this.value, this)"/>
                                        &nbsp; กิโลกรัม
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">น้ำหนักถ่านสี&nbsp;</td>
                                    <td colspan="3" class="columnobject"><input name="weight_carbon_friction" type='text' class="inputs"  id="weight_carbon_friction" value='0' size="12" onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม
                                    </td>
                                </tr>    

                                <tr>
                                    <td class="columnlabel1">น้ำหนักฝุ่น&nbsp;</td>
                                    <td colspan="3" class="columnobject"><input name="weight_carbon_dust" type='text' class="inputs"  id="weight_carbon_dust" value='0' size="12" onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม
                                    </td>
                                </tr>    

                                <tr>
                                    <td class="columnlabel1">น้ำหนักเหล็ก&nbsp;</td>
                                    <td colspan="3" class="columnobject"><input name="weight_carbon_iron" type='text' class="inputs"  id="weight_carbon_iron" value='0' size="12" onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม
                                    </td>
                                </tr>       

                                <tr>
                                    <td class="columnlabel1">น้ำหนักถ่านถุงใหญ่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='weight_carbon_bigbag' type='text' class="inputs"  id="weight_carbon_bigbag" value='0' size='12' onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม	          	
                                    </td>
                                </tr>                                          

                                <tr>
                                    <td class="columnlabel1"><b>รวม</b>&nbsp;</td>
                                    <td colspan="3" class="columnobject"><input name="weight_carbon_total" type='text' class="inputs"  id="weight_carbon_total" value='0' size="12" onkeypress="IsNuber(this.value, this)" readonly="true"/>                                        
                                        &nbsp; กิโลกรัม (น้ำหนักถ่านสี + ฝุ่น + เหล็ก + ถุงใหญ่)
                                        <input type="button" class="cgcButton_9" id="btnet_weight_payment" value="คำนวณ นน.รวม" onclick="cal_total_weight()">                                        
                                    </td>
                                </tr>                                                                                         

                                <tr>
                                    <td class="columnlabel1"></td>
                                    <td colspan="3" class="columnobject">
                                        <b>---------------------------- ผลิต (เตา) ---------------------------------------------------------</b>
                                    </td>
                                </tr>  

                                <tr>
                                    <td class="columnlabel1">เติมเตาครั้งที่ 1 เตาที่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='burn_no' type='text' class="inputs"  id="burn_no" value='' size='5' readonly="readonly"/>                                                                                
                                        <a href='#' onClick="openBrWindow('vm_burn_no', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;ช่องที่&nbsp;&nbsp;<input name='channel' type='text' class="inputs"  id="channel" value='' size='5'/>                                
                                        &nbsp;นน.ถ่านเติมเตา<input name='weight_carbon_burn_in' type='text' class="inputs"  id="weight_carbon_burn_in" value='0' size='8' onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม
                                        &nbsp; วันที่&nbsp;
                                        <input name='burn_date_1' type='text' class="inputs"  id="burn_date_1" value='' size='8' readonly="readonly"/>
                                        &nbsp;<a id='date_11'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'burn_date_1', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_11', singleClick: true, step: 1});</script>	          	                                        
                                    </td>                                        
                                </tr>                                                          

                                <tr>
                                    <td class="columnlabel1">เติมเตาครั้งที่ 2 เตาที่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='burn_no_2' type='text' class="inputs"  id="burn_no_2" value='' size='5' readonly="readonly"/>                                                                                
                                        <a href='#' onClick="openBrWindow('vm_burn_no2', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;ช่องที่&nbsp;&nbsp;<input name='channel_2' type='text' class="inputs"  id="channel_2" value='' size='5'/>                                
                                        &nbsp;นน.ถ่านเติมเตา<input name='weight_carbon_burn_in_2' type='text' class="inputs"  id="weight_carbon_burn_in_2" value='0' size='8' onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม
                                        &nbsp; วันที่&nbsp;
                                        <input name='burn_date_2' type='text' class="inputs"  id="burn_date_2" value='' size='8' readonly="readonly"/>
                                        &nbsp;<a id='date_12'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'burn_date_2', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_12', singleClick: true, step: 1});</script>	          	                                        
                                    </td>                                        
                                </tr>           

                                <tr>
                                    <td class="columnlabel1">เติมเตาครั้งที่ 3 เตาที่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='burn_no_3' type='text' class="inputs"  id="burn_no_3" value='' size='5' readonly="readonly"/>                                                                                
                                        <a href='#' onClick="openBrWindow('vm_burn_no3', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;ช่องที่&nbsp;&nbsp;<input name='channel_3' type='text' class="inputs"  id="channel_3" value='' size='5'/>                                
                                        &nbsp;นน.ถ่านเติมเตา<input name='weight_carbon_burn_in_3' type='text' class="inputs"  id="weight_carbon_burn_in_3" value='0' size='8' onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม
                                        &nbsp; วันที่&nbsp;
                                        <input name='burn_date_3' type='text' class="inputs"  id="burn_date_3" value='' size='8' readonly="readonly"/>
                                        &nbsp;<a id='date_13'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'burn_date_3', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_13', singleClick: true, step: 1});</script>	          	                                        
                                    </td>                                        
                                </tr>                               

                                <tr>
                                    <td class="columnlabel1">เติมเตาครั้งที่ 4 เตาที่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='burn_no_4' type='text' class="inputs"  id="burn_no_4" value='' size='5' readonly="readonly"/>                                                                                
                                        <a href='#' onClick="openBrWindow('vm_burn_no4', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;ช่องที่&nbsp;&nbsp;<input name='channel_4' type='text' class="inputs"  id="channel_4" value='' size='5'/>                                
                                        &nbsp;นน.ถ่านเติมเตา<input name='weight_carbon_burn_in_4' type='text' class="inputs"  id="weight_carbon_burn_in_4" value='0' size='8' onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม
                                        &nbsp; วันที่&nbsp;
                                        <input name='burn_date_4' type='text' class="inputs"  id="burn_date_4" value='' size='8' readonly="readonly"/>
                                        &nbsp;<a id='date_14'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'burn_date_4', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_14', singleClick: true, step: 1});</script>	          	                                        
                                    </td>                                        
                                </tr>     

                                <tr>
                                    <td class="columnlabel1">เติมเตาครั้งที่ 5 เตาที่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='burn_no_5' type='text' class="inputs"  id="burn_no_5" value='' size='5' readonly="readonly"/>                                                                                
                                        <a href='#' onClick="openBrWindow('vm_burn_no5', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;ช่องที่&nbsp;&nbsp;<input name='channel_5' type='text' class="inputs"  id="channel_5" value='' size='5'/>                                
                                        &nbsp;นน.ถ่านเติมเตา<input name='weight_carbon_burn_in_5' type='text' class="inputs"  id="weight_carbon_burn_in_5" value='0' size='8' onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม
                                        &nbsp; วันที่&nbsp;
                                        <input name='burn_date_5' type='text' class="inputs"  id="burn_date_5" value='' size='8' readonly="readonly"/>
                                        &nbsp;<a id='date_15'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'burn_date_5', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_15', singleClick: true, step: 1});</script>	          	                                        
                                    </td>                                        
                                </tr>  

                                <tr>
                                    <td class="columnlabel1">เติมเตาครั้งที่ 6 เตาที่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='burn_no_6' type='text' class="inputs"  id="burn_no_6" value='' size='5' readonly="readonly"/>                                                                                
                                        <a href='#' onClick="openBrWindow('vm_burn_no6', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;ช่องที่&nbsp;&nbsp;<input name='channel_6' type='text' class="inputs"  id="channel_6" value='' size='5'/>                                
                                        &nbsp;นน.ถ่านเติมเตา<input name='weight_carbon_burn_in_6' type='text' class="inputs"  id="weight_carbon_burn_in_6" value='0' size='8' onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม
                                        &nbsp; วันที่&nbsp;
                                        <input name='burn_date_6' type='text' class="inputs"  id="burn_date_6" value='' size='8' readonly="readonly"/>
                                        &nbsp;<a id='date_16'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'burn_date_6', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_16', singleClick: true, step: 1});</script>	          	                                        
                                    </td>                                        
                                </tr>                          

                                <tr>
                                    <td class="columnlabel1">เติมเตาครั้งที่ 7 เตาที่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='burn_no_7' type='text' class="inputs"  id="burn_no_7" value='' size='5' readonly="readonly"/>                                                                                
                                        <a href='#' onClick="openBrWindow('vm_burn_no7', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;ช่องที่&nbsp;&nbsp;<input name='channel_7' type='text' class="inputs"  id="channel_7" value='' size='5'/>                                
                                        &nbsp;นน.ถ่านเติมเตา<input name='weight_carbon_burn_in_7' type='text' class="inputs"  id="weight_carbon_burn_in_7" value='0' size='8' onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม
                                        &nbsp; วันที่&nbsp;
                                        <input name='burn_date_7' type='text' class="inputs"  id="burn_date_7" value='' size='8' readonly="readonly"/>
                                        &nbsp;<a id='date_17'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'burn_date_7', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_17', singleClick: true, step: 1});</script>	          	                                        
                                    </td>                                        
                                </tr>                                     

                                <tr>
                                    <td class="columnlabel1">เติมเตาครั้งที่ 8 เตาที่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='burn_no_8' type='text' class="inputs"  id="burn_no_8" value='' size='5' readonly="readonly"/>                                                                                
                                        <a href='#' onClick="openBrWindow('vm_burn_no8', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;ช่องที่&nbsp;&nbsp;<input name='channel_8' type='text' class="inputs"  id="channel_8" value='' size='5'/>                                
                                        &nbsp;นน.ถ่านเติมเตา<input name='weight_carbon_burn_in_8' type='text' class="inputs"  id="weight_carbon_burn_in_8" value='0' size='8' onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม
                                        &nbsp; วันที่&nbsp;
                                        <input name='burn_date_8' type='text' class="inputs"  id="burn_date_8" value='' size='8' readonly="readonly"/>
                                        &nbsp;<a id='date_18'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'burn_date_8', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_18', singleClick: true, step: 1});</script>	          	                                        
                                    </td>                                        
                                </tr>     

                                <tr>
                                    <td class="columnlabel1">เติมเตาครั้งที่ 9 เตาที่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='burn_no_9' type='text' class="inputs"  id="burn_no_9" value='' size='5' readonly="readonly"/>                                                                                
                                        <a href='#' onClick="openBrWindow('vm_burn_no9', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;ช่องที่&nbsp;&nbsp;<input name='channel_9' type='text' class="inputs"  id="channel_9" value='' size='5'/>                                
                                        &nbsp;นน.ถ่านเติมเตา<input name='weight_carbon_burn_in_9' type='text' class="inputs"  id="weight_carbon_burn_in_9" value='0' size='8' onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม
                                        &nbsp; วันที่&nbsp;
                                        <input name='burn_date_9' type='text' class="inputs"  id="burn_date_9" value='' size='8' readonly="readonly"/>
                                        &nbsp;<a id='date_9'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'burn_date_9', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_9', singleClick: true, step: 1});</script>	          	                                        
                                    </td>                                        
                                </tr>     


                                <tr>
                                    <td class="columnlabel1">เติมเตาครั้งที่ 10 เตาที่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='burn_no_10' type='text' class="inputs"  id="burn_no_10" value='' size='5' readonly="readonly"/>                                                                                
                                        <a href='#' onClick="openBrWindow('vm_burn_no10', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;ช่องที่&nbsp;&nbsp;<input name='channel_10' type='text' class="inputs"  id="channel_10" value='' size='5'/>                                
                                        &nbsp;นน.ถ่านเติมเตา<input name='weight_carbon_burn_in_10' type='text' class="inputs"  id="weight_carbon_burn_in_10" value='0' size='8' onkeypress="IsNuber(this.value, this)" />
                                        &nbsp; กิโลกรัม
                                        &nbsp; วันที่&nbsp;
                                        <input name='burn_date_10' type='text' class="inputs"  id="burn_date_10" value='' size='8' readonly="readonly"/>
                                        &nbsp;<a id='date_110'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'burn_date_10', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_110', singleClick: true, step: 1});</script>	          	                                        
                                    </td>                                        
                                </tr>                                     

                                <tr>
                                    <td class="columnlabel1">น้ำหนักเติมเตา รวม&nbsp;</td>
                                    <td colspan="3" class="columnobject"><input name="weight_carbon_burn_in_total" type='text' class="inputs"  id="weight_carbon_burn_in_total" value='0' size="12" onkeypress="IsNuber(this.value, this)" readonly="true"/>                                        
                                        &nbsp; กิโลกรัม
                                        <input type="button" class="cgcButton_9" id="btnet_weight_payment1" value="คำนวณ นน.รวม" onclick="cal_total_weight()">                                        
                                    </td>
                                </tr>                                 


                                <tr>
                                    <td class="columnlabel1"></td>
                                    <td colspan="3" class="columnobject">
                                        <b>---------------------------- คำนวณ -------------------------------------------------------</b>
                                    </td>
                                </tr>                                  

                                <tr>
                                    <td class="columnlabel1">น้ำหนักสูญเสียจริง&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='weight_carbon_real_lost' type='text' class="inputs"  id="weight_carbon_real_lost" value='0' size='12' readonly/>                                                                                                                        
                                        &nbsp;&nbsp;กิโลกรัม&nbsp;เปอร์เซ็นต์สูญเสียจริง&nbsp;&nbsp;&nbsp;&nbsp;<input name='percent_carbon_real_lost' type='text' class="inputs"  id="percent_carbon_real_lost" value='0' size='12' readonly/>&nbsp;&nbsp;%                               
                                    </td>                                        
                                </tr>  

                                <tr>
                                    <td class="columnlabel1">อัตราการสูญเสีย&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='weight_carbon_lost' type='text' class="inputs"  id="weight_carbon_lost" value='0' size='12' readonly/>                                                                                                                        
                                        &nbsp;&nbsp;กิโลกรัม&nbsp;เปอร์เซ็นต์อัตราสูญเสีย&nbsp;&nbsp;<input name='percent_carbon_lost' type='text' class="inputs"  id="percent_carbon_lost" value='0' size='12'readonly/>&nbsp;&nbsp;%                               
                                    </td>                                        
                                </tr>                                   
                                <tr>
                                    <td class="columnlabel1"></td>
                                    <td colspan="3" class="columnobject">                                        
                                    </td>
                                </tr>  
                                <tr>
                                    <td class="columnlabel1">ผู้ส่ง (หัวหน้าวัตถุดิบ)</td>
                                    <td class="columnobject"><input name="rawmat_emp_id" type='text' class="inputs"  id="rawmat_emp_id" size="10">

                                        <a href='#' onClick="OpenConfirm('Vemployee3', 'Search_Config2.jsp', '1');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        <input name="rawmat_emp_name" type='text' class="inputs"  id="rawmat_emp_name" size="30">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ผู้เบิก (หัวหน้าเตา)</td>
                                    <td class="columnobject"><input name="product_emp_id" type='text' class="inputs"  id="product_emp_id" size="10">
                                        <a href='#' onClick="OpenConfirm('Vemployee4', 'Search_Config2.jsp', '2');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        <input name="product_emp_name" type='text' class="inputs"  id="product_emp_name" size="30">
                                    </td>
                                </tr>                                

                                <tr>
                                    <td class="columnlabel1">หมายเหตุ&nbsp;</td>
                                    <td colspan="3" class="columnobject"><textarea class="text_inputs" name='remark' cols='40' rows='5' id="remark" value='-'"></textarea></td>
                                </tr>

                                <tr>
                                    <td colspan='4' class='blankspace'>
                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle();"><img alt="" class="imgtransparent" src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="add();"><img alt="" class="imgtransparent" src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="confirmDialogDelete(URLsend('doc_id,username,status_d', '../JSP/CS_D_carbon_friction_burn.jsp'));"><img alt="" class="imgtransparent" src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                                            <!--a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" class="imgtransparent" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a-->
                                        </div>
                                        <br>      		  	
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