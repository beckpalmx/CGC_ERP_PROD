<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                //document.getElementById("Type").value = document.getElementById("type_prod").options[document.getElementById("type_prod").selectedIndex].text;
            }
            function add()
            {
                //if (getId("select_mbranch").value == "not") {
                //    alert("กรุณาเลือกสถานที่ชำระเงิน");
                //} else {
                //getId("carbon_net").value = parseFloat(getId("total_weight").value) - (parseFloat(getId("bag_weight").value) * parseFloat(getId("bag_total").value));
                confirmDialogSave(URLsend('doc_id,doc_date,wh_in,supplier_id,position_no,scale_no,car_no,driver_name,car_date_in,car_time_in,car_date_out,car_time_out,product_id,price_unit,total_price,car_weight_in,car_weight_out,total_weight,moisture,moisture_std,deduct_weight_moisture,reporter_id,checker1,remark,net_weight_receive,net_weight_payment,status,complete_flag,username', '../JSP/CS_FULE_Receive.jsp'));
                //}
            }
            function cancle()
            {
                cancelAction();
            }
            function Openproduct()
            {
                openBrWindow('Vproduct&stadment=and+pgroup_id+=+\'G001\'', 22, 'Search_Config2.jsp');
            }
            /*           
             function Opendoc_id(input)
             {
             switch (input) {
             case 1:
             //openBrWindow('Vd_fuel_receive&stadment=and+complete_flag+=+\'N\'', 22, 'Search_Doc_id.jsp');
             openBrWindow('Vd_fuel_receive&stadment', 22, 'Search_Doc_id.jsp');
             break;
             case 2:
             openBrWindow('Vd_fuel_receive&stadment=and+complete_flag+=+\'Y\'', 22, 'Search_Doc_id.jsp');
             break;
             }
             
             }            
             */


            function Opendoc_id(input)
            {
                switch (input) {
                    case 1:
                        openBrWindow('Vd_fuel_receive&stadment=and+complete_flag+<>+\'Y\'', 22, 'Search_Config2.jsp');
                        break;
                    case 2:
                        openBrWindow('Vd_fuel_receive&stadment=and+complete_flag+<>+\'N\'', 22, 'Search_Config2.jsp');
                        break;
                    case 3:
                        openBrWindow('vd_ticketbuy_fuel&stadment=and+doc_type+=+\'N\'', 221, 'Search_Config2.jsp');
                    default:
                        break;
                }

            }




            function Chknull() {
                if (document.getElementById('doc_id').value === '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else
                    document.report.submit();
            }

            function cal_total_weight() {
                if (isNaN((parseFloat(getId("car_weight_in").value) - parseFloat(getId("car_weight_out").value).toFixed(2)))) {
                    getId("total_weight").value = 0;
                    getId("net_weight_receive").value = 0;
                } else {
                    getId("net_weight_receive").value = (parseFloat(getId("car_weight_in").value) - parseFloat(getId("car_weight_out").value)).toFixed(2);
                    getId("total_weight").value = (parseFloat(getId("car_weight_in").value) - parseFloat(getId("car_weight_out").value)).toFixed(2);
                }
            }

            function cal_deduct_weight() {

                if (getId("status").value !== "Y")
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
                    getId("complete_flag").value = "N";
                    //alert("เอกสารนี้สมบูรณ์เรียบร้อยแล้ว");
                }
            }


            function getStatus() {
                //สถานะใช้งานปกติ = Y เลิกใช้ = N
                if (document.getElementById("radio2").checked) {
                    document.getElementById("status").value = "N";
                    document.getElementById("deduct_weight_moisture").value = "";
                    document.getElementById("moisture_std").value = "";
                } else if ((document.getElementById("radio1").checked)) {
                    document.getElementById("status").value = "Y";
                }
            }

            function ThaiBaht(Number)
            {
                //ตัดสิ่งที่ไม่ต้องการทิ้งลงโถส้วม
                for (var i = 0; i < Number.length; i++)
                {
                    Number = Number.replace(",", ""); //ไม่ต้องการเครื่องหมายคอมมาร์
                    Number = Number.replace(" ", ""); //ไม่ต้องการช่องว่าง
                    Number = Number.replace("บาท", ""); //ไม่ต้องการตัวหนังสือ บาท
                    Number = Number.replace("฿", ""); //ไม่ต้องการสัญลักษณ์สกุลเงินบาท
                }
                //สร้างอะเรย์เก็บค่าที่ต้องการใช้เอาไว้
                var TxtNumArr = new Array("ศูนย์", "หนึ่ง", "สอง", "สาม", "สี่", "ห้า", "หก", "เจ็ด", "แปด", "เก้า", "สิบ");
                var TxtDigitArr = new Array("", "สิบ", "ร้อย", "พัน", "หมื่น", "แสน", "ล้าน");
                var BahtText = "";
                //ตรวจสอบดูซะหน่อยว่าใช่ตัวเลขที่ถูกต้องหรือเปล่า ด้วย isNaN == true ถ้าเป็นข้อความ == false ถ้าเป็นตัวเลข
                if (isNaN(Number))
                {
                    return "ข้อมูลนำเข้าไม่ถูกต้อง";
                } else
                {
                    //ตรวสอบอีกสักครั้งว่าตัวเลขมากเกินความต้องการหรือเปล่า
                    if ((Number - 0) > 9999999.9999)
                    {
                        return "ข้อมูลนำเข้าเกินขอบเขตที่ตั้งไว้";
                    } else
                    {
                        //พรากทศนิยม กับจำนวนเต็มออกจากกัน (บาปหรือเปล่าหนอเรา พรากคู่เขา)
                        Number = Number.split(".");
                        //ขั้นตอนต่อไปนี้เป็นการประมวลผลดูกันเอาเองครับ แบบว่าขี้เกียจจะจิ้มดีดแล้ว อิอิอิ
                        if (Number[1].length > 0)
                        {
                            Number[1] = Number[1].substring(0, 2);
                        }
                        var NumberLen = Number[0].length - 0;
                        for (var i = 0; i < NumberLen; i++)
                        {
                            var tmp = Number[0].substring(i, i + 1) - 0;
                            if (tmp !== 0)
                            {
                                if ((i === (NumberLen - 1)) && (tmp === 1))
                                {
                                    BahtText += "เอ็ด";
                                } else
                                if ((i === (NumberLen - 2)) && (tmp === 2))
                                {
                                    BahtText += "ยี่";
                                } else
                                if ((i === (NumberLen - 2)) && (tmp === 1))
                                {
                                    BahtText += "";
                                } else
                                {
                                    BahtText += TxtNumArr[tmp];
                                }
                                BahtText += TxtDigitArr[NumberLen - i - 1];
                            }
                        }
                        BahtText += "บาท";
                        if ((Number[1] === "0") || (Number[1] === "00"))
                        {
                            BahtText += "ถ้วน";
                        } else
                        {
                            DecimalLen = Number[1].length - 0;
                            for (var i = 0; i < DecimalLen; i++)
                            {
                                var tmp = Number[1].substring(i, i + 1) - 0;
                                if (tmp !== 0)
                                {
                                    if ((i === (DecimalLen - 1)) && (tmp === 1))
                                    {
                                        BahtText += "เอ็ด";
                                    } else
                                    if ((i === (DecimalLen - 2)) && (tmp === 2))
                                    {
                                        BahtText += "ยี่";
                                    } else
                                    if ((i === (DecimalLen - 2)) && (tmp === 1))
                                    {
                                        BahtText += "";
                                    } else
                                    {
                                        BahtText += TxtNumArr[tmp];
                                    }
                                    BahtText += TxtDigitArr[DecimalLen - i - 1];
                                }
                            }
                            BahtText += "สตางค์";
                        }
                        return BahtText;
                    }
                }
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
            <input type="hidden" id="chkNull" value="doc_date,wh_in,supplier_id,position_no,scale_no,product_id,car_weight_in,car_weight_out,total_weight,car_date_in,car_date_out,car_time_in,car_time_out">
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
                                <tr>
                                    <td class="columnlabel1"><b>เอกสารสมบูรณ์&nbsp;</b></td>
                                    <td class="columnobject"><input id="complete_flag" type="checkbox" onclick="Checkvalue(this.checked)" value="N" name="complete_flag"/></td>
                                </tr>                                
                                <!--tr>
                                    <td class="columnlabel1">สถานที่ชำระเงิน*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                <%=objuti.ShowSelectBox("select branch_id,name_t from mbranch order by runno", "branch_id", "name_t", "select_mbranch", "not", "ทั้งหมด")%>
                            </td>
                        </tr-->
                                <tr>
                                    <td width="170" class="columnlabel1"><b>เลขที่เอกสาร</b>&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' readonly="readonly"/>
                                        &nbsp;<a href='#' onClick="Opendoc_id(1)"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;                                        
                                        วันที่เอกสาร*&nbsp;
                                        <input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' readonly="readonly"/>
                                        &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>	          	
                                        <b>เลขที่เอกสาร(เอกสารสมบูรณ์แล้ว)</b>&nbsp;<a href='#' onClick="Opendoc_id(2)" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    </td>
                                </tr>                           

                                <tr>
                                    <td class="columnlabel1"><b>เลขที่ใบชั่งน้ำหนัก*</b>&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='scale_no' type='text' class="inputs" id="scale_no" value='' size='15' />	          	
                                        &nbsp;<a href='#' onClick="Opendoc_id(3)" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                        
                                    </td>
                                </tr>                                   

                                <tr>
                                    <td class="columnlabel1">ชื่อ Supplier*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='supplier_id' type='text' class="inputs" id="supplier_id" value='' size='10' readonly="readonly"/>
                                        &nbsp;<a href='#' onClick="openBrWindow('Vsupplier', 221, 'Search_Config.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='supplier_id_desc' type='text' class="inputs" id="supplier_id_desc" value='' size='20' readonly="readonly" />
                                        โทรศัพท์<input name='sup_tel_desc' type='text' class="inputs" id="sup_tel_desc" value='' size='15'  readonly="readonly"/>	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ที่อยู่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <textarea class="text_inputs" name='sup_address_desc' cols='40' rows='5' id="sup_address_desc" readonly="readonly"></textarea>	          	</td>
                                </tr>         
                                <tr>
                                    <td class="columnlabel1">วันที่รถเข้า*</td>
                                    <td colspan="3" class="columnobject"><input name="car_date_in" type='text' class="inputs" id="car_date_in" size="10" readonly><a id='date_2'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'car_date_in', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_2', singleClick: true, step: 1});</script>
                                        เวลา*&nbsp;
                                        <input name='car_time_in' type='text' class="inputs" id="car_time_in" value='' size='7' onkeypress="Time_picker(this.id)"/></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">วันที่รถออก*</td>
                                    <td colspan="3" class="columnobject"><input name="car_date_out" type='text' class="inputs" id="car_date_out" size="10" readonly><a id='date_3'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'car_date_out', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_3', singleClick: true, step: 1});</script>
                                        เวลา*&nbsp;
                                        <input name='car_time_out' type='text' class="inputs" id="car_time_out" value='' size='7' onkeypress="Time_picker(this.id)"/></td>
                                </tr>                                         
                                <tr>
                                    <td class="columnlabel1"><span class="columnobject">เลขทะเบียนรถ*</span></td>
                                    <td colspan="3" class="columnobject"><input name='car_no' type='text' class="inputs" id="car_no" value='' size='40' />
                                        &nbsp;&nbsp;
                                        ชื่อคนขับ*&nbsp;
                                        <input name='driver_name' type='text' class="inputs" id="driver_name" value='' size='30' /></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ประเภทเชื้อเพลิง*&nbsp;</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select product_id,name_t from m_fuel order by runno", "product_id", "name_t", "product_id")%>
                                        <input type="hidden" id="product_id" value="">
                                    </td>
                                </tr>                                

                                <tr>
                                    <td class="columnlabel1">คลัง/โกดัง/สถานที่จัดเก็บ*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <!--input name='wh_in' type='text' class="inputs" id="wh_in" value='<%=objs_p.getWarehouse_begin_id()%>' size='10' readonly="readonly"/>                                        
                                        <a href='#' onClick="openBrWindow('Mwarehouse&stadment=and+wh_type+=+\'F\'', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='wh_name' type='text' class="inputs" id="wh_name" value='<%=objs_p.getWarehouse_begin_name()%>' size='30' readonly="readonly" />                                </td-->
                                        <input name='wh_in' type='text' class="inputs" id="wh_in" value='' size='10' readonly="readonly"/>                                        
                                        <a href='#' onClick="openBrWindow('Mwarehouse&stadment=and+wh_type+=+\'F\'', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='wh_name' type='text' class="inputs" id="wh_name" value='' size='30' readonly="readonly" />                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">เลขกอง&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='position_no' type='text' class="inputs" id="position_no" value='-' size='10' />	          	</td>
                                </tr>    

                                <tr>
                                    <td class="columnlabel1">น้ำหนักเข้า*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='car_weight_in' type='text' class="inputs" id="car_weight_in" value='' size='10' />&nbsp;กิโลกรัม&nbsp;	          	
                                        น้ำหนักออก*&nbsp;                                    
                                        <input name='car_weight_out' type='text' class="inputs" id="car_weight_out" value='' size='10' onBlur="cal_total_weight()"/>&nbsp;กิโลกรัม&nbsp;	          	</td>
                                </tr>  

                                <tr>
                                    <td class="columnlabel1">น้ำหนักเข้า - น้ำหนักออก&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='net_weight_receive' type='text' class="inputs" id="net_weight_receive" value='' size='10' readonly="readonly"/>&nbsp;กิโลกรัม&nbsp;	          	</td>
                                </tr>                                 

                                <tr>
                                    <td class="columnlabel1"><b>สถานะการหักค่าความชื้น*</b>&nbsp;</td>
                                    <td class="columnobject"><input type="hidden" name="status" id="status">
                                        <input type="radio" name="radio" id="radio2" value="radio" onClick="getStatus()" checked>
                                        ไม่หัก
                                        <input type="radio" name="radio" id="radio1" value="radio" onClick="getStatus()">
                                        หัก</td>
                                </tr>          

                                <tr>
                                    <td class="columnlabel1">ค่าความชื้น&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='moisture' type='text' class="inputs" id="moisture" value='' size='3' onBlur="cal_deduct_weight()"/>&nbsp;%&nbsp;
                                        เกณฑ์ค่าความชื้น&nbsp; 
                                        <input name='moisture_std' type='text' class="inputs" id="moisture_std" value='' size='3' onBlur="cal_deduct_weight()"/>&nbsp;%&nbsp;
                                        หักน้ำหนักค่าความชื้น&nbsp; 
                                        <input name='deduct_weight_moisture' type='text' class="inputs" id="deduct_weight_moisture" value='' size='10' onBlur="cal_adjust_decimal()"/>&nbsp;กิโลกรัม&nbsp;	          	
                                    </td>
                                </tr>                                  
                                <tr>
                                    <td class="columnlabel1">น้ำหนักสุทธิ*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='total_weight' type='text' class="inputs" id="total_weight" value='' size='10' />&nbsp;กิโลกรัม&nbsp;	          	</td>
                                </tr>    
                                <tr>
                                    <td class="columnlabel1">ราคา/หน่วย&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='price_unit' type='text' class="inputs" id="price_unit" value='' size='10' onBlur="cal_total_price()"/>&nbsp;บาท&nbsp;	          
                                        จำนวนเงินรวม&nbsp;                                    
                                        <input name='total_price' type='text' class="inputs" id="total_price" value='' size='10' />&nbsp;บาท&nbsp;
                                    </td>
                                </tr>          

                                <tr>
                                    <td class="columnlabel1">จำนวนเงินรวม (ตัวอักษร)&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='net_weight_payment' type='text' class="inputs" id="net_weight_payment" value='' size='70' />&nbsp;&nbsp;	          	
                                    </td>
                                </tr>                                  

                                <tr>
                                    <td class="columnlabel1">ผู้รายงาน</td>
                                    <td class="columnobject"><input name="reporter_id" type='text' class="inputs" id="reporter_id" size="10">
                                        <a href='#' onClick="openBrWindow('Vemployee', 313, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        <input name="reporter_id_desc" type='text' class="inputs" id="reporter_id_desc" size="30">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ผู้ตรวจสอบ</td>
                                    <td class="columnobject"><input name="checker1" type='text' class="inputs" id="checker1" size="10">
                                        <a href='#' onClick="openBrWindow('Vemployee2', 313, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        <input name="checker1_desc" type='text' class="inputs" id="checker1_desc" size="30">
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
                                            <a href="javascript:;" onClick="confirmDialogDelete(URLsend('doc_id,username,status_d', '../JSP/CS_FULE_Receive.jsp'));"><img alt="" class="imgtransparent" src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" class="imgtransparent" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a></div>
                                        <br>      		  	</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>