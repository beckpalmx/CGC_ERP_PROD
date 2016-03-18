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

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>             

        <script type="text/javascript">
            function ckvalue()
            {
                document.getElementById("Type").value = document.getElementById("type_prod").value;
                //document.getElementById("Type").value = document.getElementById("type_prod").options[document.getElementById("type_prod").selectedIndex].text;
            }
            function add()
            {
                //alert(arg)
                //ashes_percent_ch,ashes_weight_ch,dust_percent_ch,dust_weight_ch,volatile_percent_ch,volatile_weight_ch,moise_percent_ch,moise_weight_ch,contamination_percent_ch,contamination_weight_ch,net_weight_ch
                getId("carbon_net").value = parseFloat(getId("total_weight").value) - (parseFloat(getId("bag_weight").value) * parseFloat(getId("bag_total").value));
                confirmDialogSave(URLsend('chkNull,doc_id,price_flag,price_unit,total_price,payment_method,bank_id,payment_no,text_price,cheque_no,bank_acc_no,net_weight_payment,username', '../JSP/CS_022_2.jsp'));
                setTimeout('getId("price_flag").checked = false;getId("price_flag").value = ""', 1000);
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
            function Openbank_id()
            {
                openBrWindow('vmbank&', 222, 'Search_Config2.jsp');
            }
            function Opendoc_id(input)
            {
                switch (input) {
                    case 1:
                        if (getId("select_mbranch").value === "not") {
                            //openBrWindow('Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'Y\'+and+price_flag+=+\'N\'', 222, 'Search_Config2.jsp');
                            openBrWindow('Vd_rawmatt_receive&stadment=and+doc_type+=+\'Y\'+and+price_flag+=+\'N\'', 224, 'Search_Config2.jsp');
                        } else {
                            //openBrWindow("Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'Y\'+and+price_flag+=+\'N\'+and+location_id2+=+\'"+getId("select_mbranch").value+"\'", 222, 'Search_Config2.jsp');
                            openBrWindow("Vd_rawmatt_receive&stadment=and+doc_type+=+\'Y\'+and+price_flag+=+\'N\'+and+location_id2+=+\'" + getId("select_mbranch").value + "\'", 224, 'Search_Config2.jsp');
                        }
                        break;
                    case 2:
                        if (getId("select_mbranch").value === "not") {
                            //openBrWindow('Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'Y\'+and+price_flag+=+\'Y\'', 222, 'Search_Config2.jsp');
                            openBrWindow('Vd_rawmatt_receive&stadment=and+doc_type+=+\'Y\'+and+price_flag+=+\'Y\'', 224, 'Search_Config2.jsp');
                        } else {
                            //openBrWindow("Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'Y\'+and+price_flag+=+\'Y\'+and+location_id2+=+\'"+getId("select_mbranch").value+"\'", 222, 'Search_Config2.jsp');
                            openBrWindow("Vd_rawmatt_receive&stadment=and+doc_type+=+\'Y\'+and+price_flag+=+\'Y\'+and+location_id2+=+\'" + getId("select_mbranch").value + "\'", 224, 'Search_Config2.jsp');
                        }
                        break;
                    default:
                        break;
                }

            }

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
                if (document.getElementById('doc_id').value === '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else
                    document.report.submit();
            }

            function calTotal_wight_ch() {
                var output_weight = parseFloat(getId("total_weight").value) - (parseFloat(getId("bag_weight").value) * parseFloat(getId("bag_total").value));
                if (getId("ashes_percent_ch").value !== "" && getId("dust_percent_ch").value !== "" && getId("volatile_percent_ch").value !== "" && getId("moise_percent_ch").value !== "" && getId("contamination_percent_ch").value !== "") {
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
                }

            }

            function cal_total_price() {
                var t_price = 0;
                //getId("net_weight_acc").value = getId("net_weight_ch").value;
                if (isNaN((parseFloat(getId("price_unit").value) * parseFloat(getId("net_weight_payment").value).toFixed(2)))) {
                    getId("total_price").value = 0;
                } else {
                    t_price = (parseFloat(getId("price_unit").value) * parseFloat(getId("net_weight_payment").value)).toFixed(2);
                    getId("total_price").value = parseInt(t_price).toFixed(2);
                    //alert(parseFloat(getId("total_price").value).toFixed(2));
                    getId("text_price").value = ThaiBaht(getId("total_price").value);
                }

            }

            function Price_check(thisvalue, thisid) {
                //alert(thisvalue);
                if (thisvalue) {
                    alert("ชำระเงินเรียบร้อยแล้ว");
                    getId(thisid).value = "Y";
                } else {
                    getId(thisid).value = "N";
                }
            }

            function getPayMethod() {
                if (document.getElementById("radio1").checked) {
                    document.getElementById("payment_method").value = "0";
                    document.getElementById("bank_id").value = "";
                    document.getElementById("bank_name").value = "";
                    document.getElementById("cheque_no").value = "";
                    document.getElementById("bank_acc_no").value = "";
                    //alert("0");
                } else if ((document.getElementById("radio2").checked)) {
                    document.getElementById("payment_method").value = "1";
                    //alert("1");
                } else if ((document.getElementById("radio3").checked)) {
                    document.getElementById("payment_method").value = "2";
                    //alert("2");
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
                        
                        Number = Number.split(".");
                        
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
            function value_net_weight_payment() {
                if (getId("doc_id").value === "") {
                    alert("กรุณาเลือกรหัสเอกสาร");
                } else if (getId("select_mbranch").value === "not") {
                    alert("กรุณาเลือกสถานที่ชำระเงิน");
                } else {
                    //getId("net_weight_payment").value = getId("net_weight_ch").value ;
                    getId("net_weight_payment").value = getId("select_mbranch").value === "K" ? getId("net_weight_ch").value :
                            getId("net_weight_acc").value;
                    //AjaxRun_id('net_weight_payment', '../JSP/CS_022_2.jsp?doc_id='+getId('doc_id').value+'&status_cal=5');                       
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
            <input type="hidden" id="chkNull" value="doc_id,doc_date,wh_in,supplier_id,position_no,scale_no,type_prod,product_id,total_weight,bag_weight">
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
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>[ หมายเลขเอกสาร : <%=objscreen.getDoc_no()%></b>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>วันที่มีผลบังคับใช้ : <%=objscreen.getDoc_eff_date()%> ]</b>
                        </div>                   
                        <div class="panel-footer">                  
                            <table  cellpadding="0" cellspacing="0" >
                                <!--tr>
                                    <td colspan="4" align="right"><b>หมายเลขเอกสาร :<%=objs_p.getIso_no()%> </b></td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="right"><b>วันที่มีผลบังคับใช้ :<%=objs_p.getEffective_date()%></b></td>
                                </tr-->
                                <tr>
                                    <td class="columnlabel1">สถานที่ชำระเงิน*&nbsp;</td>                               
                                    <td colspan="3" class="columnobject">
                                        <%=objuti.ShowSelectBox("select branch_id,name_t from mbranch order by runno", "branch_id", "name_t", "select_mbranch", "not", "ทั้งหมด")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="170" class="columnlabel1"><b>เลขที่เอกสาร (ยังไม่ได้จ่ายเงิน)</b>&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;<a href='#' onClick="Opendoc_id(1)"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                </tr>
                                <tr>
                                    <td width="170" class="columnlabel1"><b>เลขที่เอกสาร (จ่ายเงินแล้ว)</b>&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' readonly/>
                                        &nbsp;<a href='#' onClick="Opendoc_id(2)"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                        วันที่เอกสาร*&nbsp;
                                        <input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' readonly="readonly"/>
                                        <!--&nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>-->
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ชื่อ Supplier*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='supplier_id' type='text' class="inputs" id="supplier_id" value='' size='10' readonly="readonly"/>
                                        <!--&nbsp;<a href='#' onClick="openBrWindow('Vsupplier', 22, 'Search_Config.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;-->&nbsp;&nbsp;<input name='supplier_id_desc' type='text' class="inputs" id="supplier_id_desc" value='' size='35' readonly="readonly" />
                                        โทรศัพท์<input name='sup_tel_desc' type='text' class="inputs" id="sup_tel_desc" value='' size='15'  readonly="readonly"/>	          	
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ที่อยู่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <textarea class="text_inputs" name='sup_address_desc' cols='40' rows='5' id="sup_address_desc" readonly="readonly"></textarea>	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">เลขกอง*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='position_no' type='text' class="inputs" id="position_no" value='' size='10' readonly/>	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">โกดัง&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='wh_in' type='text' class="inputs" id="wh_in" value='' size='10' readonly="readonly"/>
                                        <!--<a href='#' onClick="openBrWindow('Mwarehouse&stadment=and+warehouse_id+=+\'\'', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;-->&nbsp;&nbsp;<input name='wh_name' type='text' class="inputs" id="wh_name" value='' size='30' readonly="readonly" />                               </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">วันที่รถถ่านเข้า*</td>
                                    <td colspan="3" class="columnobject"><input name="car_date_in" type='text' class="inputs" id="car_date_in" size="10" readonly><!--<a id='date_2'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'car_date_in',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_2',singleClick:true,step:1});</script>-->
                                        เลขที่ใบชั่งถ่าน*&nbsp;
                                        <input name='scale_no' type='text' class="inputs" id="scale_no" value='' size='10' readonly/></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1"><span class="columnobject">เลขทะเบียนรถ*</span></td>
                                    <td colspan="3" class="columnobject"><input name='car_no' type='text' class="inputs" id="car_no" value='' size='10' readonly/>
                                        &nbsp;&nbsp;
                                        ชื่อคนขับ*&nbsp;
                                        <input name='driver_name' type='text' class="inputs" id="driver_name" value='' size='20' readonly/></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ประเภท&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <%=objuti.ShowSelectBox("select type_id,name_t from mtype order by runno", "type_id", "name_t", "type_prod")%>                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ชื่อสินค้า*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <!--<input name='product_id' type='text' class="inputs" id="product_id" value='' size='10' />
                                        &nbsp;<a href='javascript:#;'  onClick="Openproduct()" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='product_id_desc' type='text' class="inputs" id="product_id_desc" value='' size='30' readonly="readonly"/>-->	          	
                                        <select class='select_cgc' name="product_id" id="product_id">
                                            <option value="C" selected>ถ่านกะลา</option>
                                            <option value="P">ถ่านปาล์ม</option>
                                            <option value="U">ถ่านไม้ยูคาฯ</option>
                                            <option value="B">ถ่านไม้ไผ่</option>
                                        </select>                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">น.นถ่าน+น.น.รถ+น.น.กระสอบ</td>
                                    <td colspan="3" class="columnobject"><input name="car_cbag_weight" type='text' class="inputs" id="car_cbag_weight" size="10" onKeyUp="IsNuber(this.value, this)" onBlur="cal_total_weight()" readonly>
                                        &nbsp;กิโลกรัม                            </tr>
                                <tr>
                                    <td class="columnlabel1">น.น.รถ</td>
                                    <td colspan="3" class="columnobject"><input name="car_weight" type='text' class="inputs" id="car_weight" size="10" onKeyUp="IsNuber(this.value, this)" onBlur="cal_total_weight()" readonly>
                                        &nbsp;กิโลกรัม                             </tr>
                                <tr>
                                    <td class="columnlabel1">น.น.กระสอบ</td>
                                    <td colspan="3" class="columnobject"><input name='bag_weight' type='text' class="inputs" id="bag_weight" value='' size='10' onKeyUp="IsNuber(this.value, this)" onBlur="cal_bag_net()" readonly/>
                                        &nbsp;น.น.กระสอบ/ใบ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;จำนวนกระสอบ&nbsp;
                                        <input name="bag_total" type='text' class="inputs" id="bag_total" size="10" onKeyUp="IsNumber2(this.value, this)" onBlur="cal_bag_net()" readonly>
                                        ใบ</tr>
                                <tr>
                                    <td class="columnlabel1">น.น.ถ่าน+น.น.กระสอบ&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='total_weight' type='text' class="inputs" id="total_weight" value='' size='10' readonly/>
                                        &nbsp;กิโลกรัม<!--<input type="button" value="คำนวณ" onclick="Calcultor()"></td>-->                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;น.น.&nbsp;กระสอบทั้งหมด
                                        <input name="bag_net" type='text' class="inputs" id="bag_net" size="10" readonly>
                                        กิโลกรัม</tr>
                                <tr>
                                    <td class="columnlabel1"></td>
                                    <td colspan="3" class="columnobject">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(น.น.ถ่าน+น.น.กระสอบ)&nbsp;-&nbsp;น.น.&nbsp;กระสอบทั้งหมด<input name="carbon_net" type='text' class="inputs" id="carbon_net" size="10" readonly>
                                        กิโลกรัม</td>
                                </tr>
                                <tr><td></td></tr>
                                <tr>
                                    <td class="columnlabel1">&nbsp;</td>
                                    <td width="182" class="columnobject"><span class="label label-success">ผลจากการวิเคราะห์</span></td>
                                    <td width="91" class="columnobject">&nbsp;</td>
                                    <td width="314" class="columnobject"><span class="label label-success">%ตามข้อกำหนด</span></td>
                                </tr>
                                <tr><td></td></tr>
                                <tr>
                                    <td class="columnlabel1">ขี้เถ้า%&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='ashes_percent' type='text' class="inputs" id="ashes_percent" value='' size='5' readonly ="readonly"/>
                                        &nbsp;&nbsp;
                                        <input name='ashes_weight' type='text' class="inputs" id="ashes_weight" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม</td>
                                    <td class="columnobject"><div align="right"><span class="columnlabel1">ขี้เถ้า%</span></div></td>
                                    <td class="columnobject"><input name='ashes_percent_ch' type='text' class="inputs" id="ashes_percent_ch" value='' size='5' onKeyUp="IsNuber(this.value, this)" onBlur="javascript:Calculator_ch('ashes_percent', 'ashes_percent_ch', 'ashes_weight_ch', 'total_weight', 'bag_weight');" readonly/>
                                        &nbsp;&nbsp;
                                        <input name='ashes_weight_ch' type='text' class="inputs" id="ashes_weight_ch" value='' size='10' readonly ="readonly" />
                                        &nbsp;กิโลกรัม</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ฝุ่น%&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='dust_percent' type='text' class="inputs" id="dust_percent" value='' size='5' readonly ="readonly"/>
                                        &nbsp;&nbsp;
                                        <input name='dust_weight' type='text' class="inputs" id="dust_weight" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม</td>
                                    <td class="columnobject"><div align="right"><span class="columnlabel1">ฝุ่น%&nbsp;</span></div></td>
                                    <td class="columnobject"><input name='dust_percent_ch' type='text' class="inputs" id="dust_percent_ch" value='' size='5' onKeyUp="IsNuber(this.value, this)" onBlur="javascript:Calculator_ch('dust_percent', 'dust_percent_ch', 'dust_weight_ch', 'total_weight', 'bag_weight');" readonly/>
                                        &nbsp;&nbsp;
                                        <input name='dust_weight_ch' type='text' class="inputs" id="dust_weight_ch" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">การระเหย%&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='volatile_percent' type='text' class="inputs" id="volatile_percent" value='' size='5' readonly ="readonly"/>
                                        &nbsp;&nbsp;
                                        <input name='volatile_weight' type='text' class="inputs" id="volatile_weight" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม	          	</td>
                                    <td class="columnobject"><div align="right"><span class="columnlabel1">การระเหย%&nbsp;</span></div></td>
                                    <td class="columnobject"><input name='volatile_percent_ch' type='text' class="inputs" id="volatile_percent_ch" value='' size='5' onKeyUp="IsNuber(this.value, this)" onBlur="javascript:Calculator_ch('volatile_percent', 'volatile_percent_ch', 'volatile_weight_ch', 'total_weight', 'bag_weight');" readonly/>
                                        &nbsp;&nbsp;
                                        <input name='volatile_weight_ch' type='text' class="inputs" id="volatile_weight_ch" value='' size='10' readonly ="readonly"/>                                    &nbsp;กิโลกรัม </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ความชื้นเฉลี่ย%&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='moise_percent' type='text' class="inputs" id="moise_percent" value='' size='5' readonly ="readonly"/>
                                        &nbsp;&nbsp;
                                        <input name='moise_weight' type='text' class="inputs" id="moise_weight" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม	          	</td>
                                    <td class="columnobject"><div align="right"><span class="columnlabel1">ความชื้นเฉลี่ย%&nbsp;</span></div></td>
                                    <td class="columnobject"><input name='moise_percent_ch' type='text' class="inputs" id="moise_percent_ch" value='' size='5' onKeyUp="IsNuber(this.value, this)" onBlur="javascript:Calculator_ch('moise_percent', 'moise_percent_ch', 'moise_weight_ch', 'total_weight', 'bag_weight');" readonly/>
                                        &nbsp;&nbsp;
                                        <input name='moise_weight_ch' type='text' class="inputs" id="moise_weight_ch" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">สิ่งเจือปน%&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='contamination_percent' type='text' class="inputs" id="contamination_percent" value='' size='5' readonly ="readonly" />
                                        &nbsp;&nbsp;
                                        <input name='contamination_weight' type='text' class="inputs" id="contamination_weight" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม	          	</td>
                                    <td class="columnobject"><div align="right">สิ่งเจือปน%</div></td>
                                    <td class="columnobject"><input name='contamination_percent_ch' type='text' class="inputs" id="contamination_percent_ch" value='' size='5' onKeyUp="IsNuber(this.value, this)"  onBlur="javascript:Calculator_ch('contamination_percent', 'contamination_percent_ch', 'contamination_weight_ch', 'total_weight', 'bag_weight');" readonly/>
                                        &nbsp;&nbsp;
                                        <input name='contamination_weight_ch' type='text' class="inputs" id="contamination_weight_ch" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">น้ำหนักสุทธิ&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='net_weight' type='text' class="inputs" id="net_weight" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม	          	</td>
                                    <td class="columnobject"><div align="right"><span class="columnlabel1">น้ำหนักสุทธิ&nbsp;</span></div></td>
                                    <td class="columnobject"><input name='net_weight_ch' type='text' class="inputs" id="net_weight_ch" value='' size='10' readonly/>
                                        &nbsp;กิโลกรัม </td>
                                </tr>

                                <tr>
                                    <td class="columnlabel1">หมายเหตุ&nbsp;</td>
                                    <td colspan="3" class="columnobject"><textarea class="text_inputs" name='remark' cols='40' rows='5' id="remark" readonly ="readonly"></textarea></td>
                                </tr>

                                <tr>
                                    <td class="columnlabel1"><b>ยืนยันการชำระเงิน&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        <input type="checkbox" name="price_flag" id="price_flag" value="N" onclick="Price_check(this.checked, this.id)">
                                        <b>เลขที่ใบสำคัญจ่าย</b>&nbsp<input name='payment_no' type='text' class="inputs" id="payment_no" value='' size='15'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1"><b>จ่ายโดย</b></td>
                                    <td colspan="3" class="columnobject">&nbsp;&nbsp;                                    
                                        <input type="hidden" id="payment_method" >
                                        <input type="radio" name="radio" id="radio1" onClick="getPayMethod()">
                                        <b>เงินสด</b>&nbsp
                                        <input type="radio" name="radio" id="radio2" onClick="getPayMethod()">
                                        <b>เช็ค    ธนาคาร</b>&nbsp
                                        <input type="radio" name="radio" id="radio3" onClick="getPayMethod()">
                                        <b>โอนเงิน    ธนาคาร</b>&nbsp
                                        <!--/td>
                                      <td colspan="2" class="columnobject"-->
                                        <input name='bank_id' type='text' class="inputs" id="bank_id" value='' size='10' readonly/>
                                        &nbsp;<a href='#' onClick="Openbank_id()"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                        &nbsp;
                                        <input name='bank_name' type='text' class="inputs" id="bank_name" value='' size='25' readonly="readonly"/>
                                    </td>                                    
                                </tr>       
                                <tr>                                  
                                    <td class="columnlabel1"><b>เลขที่เช็ค</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='cheque_no' type='text' class="inputs" id="cheque_no" value='' size='20'/>                                       	          	
                                    </td>
                                </tr>                                                

                                <tr>                                  
                                    <td class="columnlabel1"><b>เลขที่บัญชีธนาคาร Supplier</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='bank_acc_no' type='text' class="inputs" id="bank_acc_no" value='' size='20'/>                                       	          	
                                    </td>
                                </tr>    

                                <tr>
                                    <td class="columnobject"><div align="right"><span class="columnlabel1"><input type="button" class="cgcButton_9" id="btnet_weight_payment" value="น้ำหนักสุทธิ (จ่ายเงิน)" onclick="value_net_weight_payment()"><!--<b>น้ำหนักสุทธิ (จ่ายเงิน)&nbsp;</b--></span></div></td>
                                    <td colspan="3" class="columnobject">&nbsp;&nbsp;<input name='net_weight_payment' type='text' class="inputs" id="net_weight_payment" value='' size='10' />
                                        <b>&nbsp;กิโลกรัม </b></td>
                                </tr>

                                <input name='net_weight_acc' type='hidden' id="net_weight_acc" value='' size='10' />

                                <tr>                                     
                                    <td class="columnlabel1"><b>ราคา/หน่วย</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='price_unit' type='text' class="inputs" id="price_unit" value='' size='10' onKeyUp="IsNuber(this.value, this)" onBlur="cal_total_price()"/>
                                        &nbsp;<b>บาท</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1"><B>รวมราคา</B> </td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='total_price' type='text' class="inputs" id="total_price" value='' size='20' readonly="readonly" onKeyUp="IsNuber(this.value, this)" />
                                        &nbsp;<B>บาท</B>	          	
                                    </td>                                    
                                </tr>

                                <tr>
                                    <td class="columnlabel1"><b>จำนวนเงิน(ตัวอักษร) </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='text_price' type='text' class="inputs" id="text_price" value='' size='70' readonly="readonly"/>
                                        &nbsp;	          	
                                    </td>                                    
                                </tr>
                                <tr>
                                    <td colspan='4' class='blankspace'>
                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle();"><img alt="" class="imgtransparent" src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="add();"><img alt="" class="imgtransparent" src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                            <!--<a href="javascript:;" onClick="confirmDialogDelete(URLsend('doc_id,doc_date,wh_in,wh_name,supplier_id,supplier_id_desc,sup_tel_desc,sup_address_desc,position_no,scale_no,car_no,driver_name,type_prod,product_id,total_weight,bag_weight,ashes_percent,ashes_weight,dust_percent,dust_weight,volatile_percent,volatile_weight,moise_percent,moise_weight,contamination_percent,contamination_weight,net_weight,remark,total_price,status_d,username','../JSP/CS_022.jsp'));"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>-->
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