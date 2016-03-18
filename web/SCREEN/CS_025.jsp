<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;%>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <title>CGC ERP</title>
        <script type="text/javascript">
            function Chknull() {
                if (document.getElementById('doc_id').value === '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else
                    document.report.submit();
            }
            function goAddChild(URLSend)
            {
                if (getId("status_cancle").value === "1") {
                    var arryChk = new Array;
                    arryChk[0] = "chkNull";
                    if (ChkParameter(arryChk))
                    {
                        window.open(URLSend[0]);
                    }
                } else {
                    alert("กรุณาบันทึกหัวเอกสารก่อน");
                }

            }
            function cancle()
            {

                var SURL;
                var r = confirm("คุณต้องการยกเลิกข้อมูลทั้งหมดหรือไม่");
                if (r)
                {
                    if (getId("status_cancle").value === "1" && getId("child_ck").value === "")
                    {
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                    }
                    else if (getId("status_cancle").value === "1" && getId("child_ck").value === "1")
                    {
                        alert("มีการเปลี่ยนแปลงข้อมูลกรุณาบันทึกข้อมูล");
                    }
                    else {
                        SURL = "../JSP/CS_026.jsp?status_d=3&chk_all=1&username" + getId("username").value;
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL);
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                    }


                }

            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }
            function goDelChild()
            {
                var Deleteflag = "";
                var SURL;
                if (getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_026.jsp?status_d=3&chk_all=1&username" + getId("username").value;
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    Delete_Line_no(SURL);
                    getId("show").innerHTML = "";
                    //showTableNonPopup("show", "doc_id", "../JSP/CS_Show026.jsp?doc_id=");
                    getId("chk_all").checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_026.jsp?status_d=3&ckbox=";

                    for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                    {
                        Deleteflag += (document.getElementsByName("ckbox")[i].checked) ? (i + 1).toString() + "," : "";
                    }

                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);

                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&username=" + getId("username").value;
                    //alert(SURL);
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show026.jsp?doc_id=");
                    for (var i = 0; i <= 3; i++) {
                        showTableNonPopup("show", "doc_id", "../JSP/CS_Show026.jsp?doc_id=");
                    }
                    //showTableNonPopup("show", "doc_id", "../JSP/CS_Show026.jsp?doc_id=");
                    //setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show026.jsp?doc_id=")', 100);
                }
            }
            function OpenEdit(URLSend)
            {
                window.open(URLSend[0]);
            }
            function AddHeader()
            {
                var strId = "";
                var strId1 = "";
                var r = confirm("คุณต้องการบันทึกหรือไม่");
                if (r)
                {
                    var formInputs = document.getElementsByTagName('input');
                    for (var i = 0; i < formInputs.length; i++) {

                        var theInput = formInputs[i];
                        if (theInput.type === 'text' && theInput.id.toString().indexOf("loc_c") !== -1 || theInput.id.toString().indexOf("loc_p") !== -1 || theInput.id.toString().indexOf("loc_u") !== -1 || theInput.id.toString().indexOf("_weight") !== -1) {
                            if (getId(theInput.id.toString()).value !== "") {
                                strId += theInput.id.toString() + ",";
                            }
                        }
                    }
                    if (getId("loc_total").value === "") {
                        alert("กรุณาระบุจำนวนกองทั้งหมดถ้าไม่มีให้ใส่ 0");
                        getId("loc_total").value = "0";
                        getId("loc_total").focus();
                    } else if (parseInt(getId("loc_total").value) > 3) {
                        alert("ระบุจำนวนกองได้มากที่สุดแค่ 3 กอง");
                        getId("loc_total").focus();
                    } else {
                        for (var i = 1; i <= parseInt(getId("loc_total").value); i++) {
                            strId += "loc_" + i.toString() + "," + "s_bag_loc" + i.toString() + "," + "q_bag_loc" + i.toString() + "," + "w_bag_loc" + i.toString() + "," + "loc_" + i.toString() + "_desc" + ",";
                        }
                        if (strId !== "") {
                            strId = strId.substr(0, strId.length - 1);
                        }
                        if (parseInt(getId("loc_total").value) !== 0) {
                            if (cknull(strId)) {
                                getSave(URLsend('chkNull,complete_flag,doc_id,doc_date,time_from,time_to,runner_id,shift,wh_in,wh_out,loc_total,remark,username,' + strId, '../JSP/CS_025.jsp'));
                                setTimeout('getId("complete_flag").value="N"', 1000);
                                getId("show").innerHTML = "";
                                getId("doc_id").disabled = false;
                                getId("status_cancle").value = "";
                                getId("child_ck").value = "";
                            }
                        } else {
                            Clear_Value(getId("loc_total").value);
                            for (var i = 1; i <= 3; i++) {
                                strId += ",loc_" + i.toString() + "," + "s_bag_loc" + i.toString() + "," + "q_bag_loc" + i.toString() + "," + "w_bag_loc" + i.toString() + "," + "loc_" + i.toString() + "_desc" + "";
                            }
                            strId1 += ",c_bag_qty,c_bag_weight,p_bag_qty,p_bag_weight,u_bag_qty,u_bag_weight,c_bag_qty1,c_bag_weight1,p_bag_qty1,p_bag_weight1,u_bag_qty1,u_bag_weight1";
                            getSave(URLsend('chkNull,complete_flag,doc_id,doc_date,time_from,time_to,runner_id,shift,wh_in,wh_out,loc_total,remark,username,' + strId + strId1, '../JSP/CS_025.jsp'));
                            setTimeout('getId("complete_flag").value="N"', 1000);
                            getId("show").innerHTML = "";
                            getId("doc_id").disabled = false;
                            getId("status_cancle").value = "";
                            getId("child_ck").value = "";
                        }

                    }

                }
            }
            function cknull(obj) {
                var returnvalue = true;
                var strchk = (obj.length !== 0) ? obj.split(",") : "";
                for (var i = 0; i < strchk.length; i++) {
                    if (getId(strchk[i]).value === "") {
                        returnvalue = false;
                        alert("กรุณากรองข้อมูลให้ครบ");
                        getId(strchk[i]).focus();
                        break;
                    }
                }
                return returnvalue;
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่");
                if (r)
                {
                    getSave(URLsend('doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,wh_in,wh_out,loc_total,loc_1,s_bag_loc1,q_bag_loc1,w_bag_loc1,loc_1_desc,loc_2,s_bag_loc2,q_bag_loc2,w_bag_loc2,loc_2_desc,loc_3,s_bag_loc3,q_bag_loc3,w_bag_loc3,loc_3_desc,c_weight1,c_weight2,c_weight3,c_weight4,c_weight5,p_weight1,p_weight2,p_weight3,p_weight4,p_weight5,u_weight1,u_weight2,u_weight3,u_weight4,u_weight5,remark,child_ck,status_cancle,status_d,username', '../JSP/CS_025.jsp'));
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                    getId("child_ck").value = "";
                    setTimeout('getId("child_ck").value = "";', 1000);
                }
            }
            function Unload()
            {

                if (getId("doc_id").disabled === true && getId("status_cancle").value !== "1") {
                    var r = confirm("คุณได้ทำการเปลี่ยนหน้าคุณต้องการบันทึกข้อมูลทั้งหมดใช่หรือไม่");
                    if (r === true) {
                        getSave(URLsend('chkNull,doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,wh_in,wh_out,loc_total,loc_1,s_bag_loc1,q_bag_loc1,w_bag_loc1,loc_1_desc,loc_2,s_bag_loc2,q_bag_loc2,w_bag_loc2,loc_2_desc,loc_3,s_bag_loc3,q_bag_loc3,w_bag_loc3,loc_3_desc,c_weight1,c_weight2,c_weight3,c_weight4,c_weight5,p_weight1,p_weight2,p_weight3,p_weight4,p_weight5,u_weight1,u_weight2,u_weight3,u_weight4,u_weight5,remark,child_ck,status_cancle,,username', '../JSP/CS_025.jsp'));
                    }
                    else {
                        SURL = "../JSP/CS_026.jsp?status_d=3&chk_all=1&username" + getId("username").value;
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL);
                    }
                }
                closepopup();
            }
            function OpenDoc_id()
            {

                /*if(getId("child_ck").value == "1" && getId("doc_id").disabled == true && getId("status_cancle").value == "1"){
                 alert("มีการเปลี่ยนแปลงข้อมูลกรุณาบันทึกข้อมูล");
                 }
                 else if(getId("child_ck").value == "1" && getId("doc_id").disabled == true && getId("status_cancle").value == ""){
                 alert("ถ้าต้องการเลือกข้อมูลอื่นกรุณาบันทึกข้อมูลหรือยกเลิกข้อมูล");
                 }
                 else{*/
                openBrWindow('vd_carbon_friction_receive_header&stadment=and+complete_flag+<>+\'Y\'', 25, 'Search_Doc_id.jsp');
                //}
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
            function Clear_Value(value) {
                //IsNumber2(this.value, this);
                if (parseInt(value, 10) === 0) {
                    for (var i = 1; i <= 3; i++) {
                        getId("loc_" + i.toString(10)).value = "";
                        getId("loc_p" + i.toString(10)).value = "";
                        getId("s_bag_loc" + i.toString(10)).value = "";
                        getId("q_bag_loc" + i.toString(10)).value = "";
                        getId("w_bag_loc" + i.toString(10)).value = "";
                        getId("loc_" + i.toString(10) + "_desc").value = "";
                    }
                }
            }


            function cal_c_weight() {
                if (isNaN((parseFloat(getId("c_bag_qty").value) - parseFloat(getId("c_bag_weight").value).toFixed(2)))) {
                    getId("c_weight1").value = 0;
                } else {
                    getId("c_weight1").value = (parseFloat(getId("c_bag_qty").value) * parseFloat(getId("c_bag_weight").value));
                }

            }

            function cal_p_weight() {
                if (isNaN((parseFloat(getId("p_bag_qty").value) - parseFloat(getId("p_bag_weight").value).toFixed(2)))) {
                    getId("p_weight1").value = 0;
                } else {
                    getId("p_weight1").value = (parseFloat(getId("p_bag_qty").value) * parseFloat(getId("p_bag_weight").value));
                }

            }

            function cal_u_weight() {
                if (isNaN((parseFloat(getId("u_bag_qty").value) - parseFloat(getId("u_bag_weight").value).toFixed(2)))) {
                    getId("u_weight1").value = 0;
                } else {
                    getId("u_weight1").value = (parseFloat(getId("u_bag_qty").value) * parseFloat(getId("u_bag_weight").value));
                }

            }
            function cal_c_weight1() {
                if (isNaN((parseFloat(getId("c_bag_qty1").value) - parseFloat(getId("c_bag_weight1").value).toFixed(2)))) {
                    getId("c_weight6").value = 0;
                } else {
                    getId("c_weight6").value = (parseFloat(getId("c_bag_qty1").value) * parseFloat(getId("c_bag_weight1").value));
                }

            }

            function cal_p_weight1() {
                if (isNaN((parseFloat(getId("p_bag_qty1").value) - parseFloat(getId("p_bag_weight1").value).toFixed(2)))) {
                    getId("p_weight6").value = 0;
                } else {
                    getId("p_weight6").value = (parseFloat(getId("p_bag_qty1").value) * parseFloat(getId("p_bag_weight1").value));
                }

            }

            function cal_u_weight1() {
                if (isNaN((parseFloat(getId("u_bag_qty1").value) - parseFloat(getId("u_bag_weight1").value).toFixed(2)))) {
                    getId("u_weight6").value = 0;
                } else {
                    getId("u_weight6").value = (parseFloat(getId("u_bag_qty1").value) * parseFloat(getId("u_bag_weight1").value));
                }

            }

        </script>

    </head>
    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UtiDatabase objuti = new UtiDatabase();
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_025");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S503");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                        //_______________________________________________________________report
%>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,wh_in,wh_out">
            <input type="hidden" id="date_ck" name="date_ck" value="">
            <input type="hidden" id="status_a" value="1"><!-- เป็นการเพิ่มข้อมูลเข้าไป-->
            <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" id="status_cancle" value=""><!-- status_cancle = 1 คือค่าที่นำมา Edit แต่ถ้า ="" จะเป็นการ Insert -->
            <input type="hidden" id="child_ck" name="child_ck" value="">
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">
            <div align="center">

                <table  cellpadding="0"  cellspacing="0">
                    <tr >
                        <td class="ftopleft"></td>
                        <td  class="ftopcenter" colspan="2">รายงานการสีถ่านดิบ(CS_025)&nbsp;</td>
                        <td class="ftopright"></td>
                    </tr>
                    <tr >
                        <td class="fcenterleft"></td>
                        <td  colspan="2" class="fcentercenter">
                            <div align="center">
                                <table  cellpadding="0" cellspacing="0" >
                                    <tr>
                                        <td colspan="2" align="right"><b>หมายเลขเอกสาร : <%=objs_p.getIso_no()%></b></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%></b></td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">เอกสารนี้สมบูรณ์แล้ว</td>
                                        <td class="columnobject"><span class="columnlabel">
                                                <input type="checkbox" name="complete_flag" id="complete_flag" value="N" onClick="Checkvalue(this.checked)">
                                            </span></td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel"><b>เลขที่เอกสาร*</b>&nbsp;</td>
                                        <td class="columnobject">
                                            <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='17' />
                                            &nbsp;<a href='javascript:;' onClick="OpenDoc_id();"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                            วันที่เอกสาร*&nbsp;
                                            <input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' />
                                            &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>&nbsp;&nbsp;	          	</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">เวลา&nbsp;</td>
                                        <td class="columnobject">
                                            <input name='time_from' type='text' class="inputs" id="time_from" value='' size='10' />
                                            &nbsp;&nbsp;
                                            ถึง&nbsp;
                                            <input name='time_to' type='text' class="inputs" id="time_to" value='' size='10' />	            </td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">ผู้บันทึก&nbsp;</td>
                                        <td class="columnobject">
                                            <input name='runner_id' type='text' class="inputs" id="runner_id" value='' size='10' />
                                            &nbsp;<a href='javascript:;' onClick="openBrWindow('Vemployee', 25, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                            <input name='runner_id_desc' type='text' class="inputs" id="runner_id_desc" value='' size='30' />	          	</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">ช่วงเวลาทำงาน(กะ)&nbsp;</td>
                                        <td class="columnobject">
                                            <%=objuti.ShowSelectBox("select shift_id,name_t from mshift where shift_grp = '3' order by runno", "shift_id", "name_t", "shift")%>
                                            <!-- <select name='shift' id="shift">
                                                 <option value='1'>เช้า</option><option value='2'>บ่าย</option><option value='3'>ดึก</option></select>	-->          	</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">คลังจ่าย&nbsp;</td>
                                        <td class="columnobject">
                                            <input type="hidden" size="10" id="wh_in" name="wh_in" value="<%=objs_p.getWarehouse_begin_id()%>" ><input type='text' class="inputs" size="20"  id="wh_in_desc" name="wh_in_desc" value="<%=objs_p.getWarehouse_begin_name()%>">
                                            <a href='#' onClick="openBrWindow('Wh_bg&stadment=and+warehouse_id+=+\'<%=objs_p.getWarehouse_begin_id()%>\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                            &nbsp;&nbsp;&nbsp;คลังรับ&nbsp;
                                            <input type="hidden" size="10"  id="wh_out" name="wh_out" value="<%=objs_p.getWarehouse_end_id()%>"><input type='text' class="inputs"  size="20"  id="wh_out_desc" name="wh_out_desc" value="<%=objs_p.getWarehouse_end_name()%>">
                                            <a href='#' onClick="openBrWindow('Wh_en&stadment=and+warehouse_id+=+\'<%=objs_p.getWarehouse_end_id()%>\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                            <!--<select name='wh_in' id="wh_in">">
                                                 <option value='' selected></option></select>	              &nbsp;
                                คลังรับ&nbsp;
                                             <select name='wh_out' id="wh_out">
                                                 <option value='' selected></option></select>
                                             &nbsp;&nbsp; --></td></tr>
                                    <tr>
                                        <td class="columnlabel"></td>
                                        <td class="columnobject">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">&nbsp;</td>
                                        <td rowspan="8" class="columnobject"><table width="200" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td colspan="6">การบรรจุถ่านวัตถุดิบจากไซโลใส่ถุงจัมโบ้รวม &nbsp;
                                                        <input name='loc_total' type='text' class="inputs" id="loc_total" value='' size='10' onkeypress="" onblur="IsNumber2(this.value, this);
                                                                Clear_Value(this.value);"/>
                                                        กอง</td>
                                                </tr>
                                                <tr>
                                                    <td width="11%"><input name='loc_1' type='text' class="inputs" id="loc_1" value='' size='10' /></td>
                                                    <td width="17%"><div align="right">บรรจุกระสอบขนาด</div></td>
                                                    <td width="19%"><input name='s_bag_loc1' type='text' class="inputs" id="s_bag_loc1" value='' size='7' onBlur="IsNuber(this.value, this);"/>
                                                        kg.</td>
                                                    <td width="15%"><div align="right">จำนวน </div></td>
                                                    <td width="13%"><div align="left">
                                                            <input name='q_bag_loc1' type='text' class="inputs" id="q_bag_loc1" value='' size='7' onBlur="IsNuber(this.value, this);"/>
                                                        </div></td>
                                                    <td width="25%">กระสอบ</td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td><div align="right">น้ำหนักรวม</div></td>
                                                    <td><input name='w_bag_loc1' type='text' class="inputs" id="w_bag_loc1" value='' size='7' onBlur="IsNuber(this.value, this);"/>
                                                        kg.</td>
                                                    <td><div align="right">สถานที่จัดเก็บ</div></td>
                                                    <td>
                                                        <div align="left">
                                                            <input name='loc_1_desc' type='text' class="inputs" id="loc_1_desc" value='' size='7' readonly/>
                                                            <input name='loc_1_name' type='hidden' id="loc_1_name" value='' size='7' />
                                                        </div></td>
                                                    <td><a href='#' onClick="openBrWindow('Warehouse', 25, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a></td>
                                                </tr>
                                                <tr>
                                                    <td><input name='loc_2' type='text' class="inputs" id="loc_2" value='' size='10' /></td>
                                                    <td><div align="right">บรรจุกระสอบขนาด</div></td>
                                                    <td><input name='s_bag_loc2' type='text' class="inputs" id="s_bag_loc2" value='' size='7' onBlur="IsNuber(this.value, this);"/>
                                                        kg.</td>
                                                    <td><div align="right">จำนวน </div></td>
                                                    <td>
                                                        <div align="left">
                                                            <input name='q_bag_loc2' type='text' class="inputs" id="q_bag_loc2" value='' size='7' onBlur="IsNuber(this.value, this);"/>
                                                        </div></td>
                                                    <td>กระสอบ</td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td><div align="right">น้ำหนักรวม</div></td>
                                                    <td><input name='w_bag_loc2' type='text' class="inputs" id="w_bag_loc2" value='' size='7' onBlur="IsNuber(this.value, this);"/>
                                                        kg.</td>
                                                    <td><div align="right">สถานที่จัดเก็บ</div></td>
                                                    <td>
                                                        <div align="left">
                                                            <input name='loc_2_desc' type='text' class="inputs" id="loc_2_desc" value='' size='7' readonly/>
                                                            <input name='loc_2_name' type='hidden' id="loc_2_name" value='' size='7' />
                                                        </div></td>
                                                    <td><a href='#' onClick="openBrWindow('Warehouse1', 25, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a></td>
                                                </tr>
                                                <tr>
                                                    <td><input name='loc_3' type='text' class="inputs" id="loc_3" value='' size='10' /></td>
                                                    <td><div align="right">บรรจุกระสอบขนาด</div></td>
                                                    <td><input name='s_bag_loc3' type='text' class="inputs" id="s_bag_loc3" value='' size='7' onBlur="IsNuber(this.value, this);"/>
                                                        kg.</td>
                                                    <td><div align="right">จำนวน </div></td>
                                                    <td>
                                                        <div align="left">
                                                            <input name='q_bag_loc3' type='text' class="inputs" id="q_bag_loc3" value='' size='7' onBlur="IsNuber(this.value, this);"/>
                                                        </div></td>
                                                    <td> กระสอบ</td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td><div align="right">น้ำหนักรวม</div></td>
                                                    <td><input name='w_bag_loc3' type='text' class="inputs" id="w_bag_loc3" value='' size='7' onBlur="IsNuber(this.value, this);"/>
                                                        kg.</td>
                                                    <td><div align="right">สถานที่จัดเก็บ</div></td>
                                                    <td>
                                                        <div align="left">
                                                            <input name='loc_3_desc' type='text' class="inputs" id="loc_3_desc" value='' size='7' readonly/>
                                                            <input name='loc_3_name' type='hidden' id="loc_3_name" value='' size='7' />
                                                        </div></td>
                                                    <td><a href='#' onClick="openBrWindow('Warehouse2', 25, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a></td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                            </table></td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">กองที่&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">กองที่&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">กองที่&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td height="42" class="columnlabel">&nbsp;</td>
                                        <td class="columnobject"><table width="92%" border="0" cellpadding="0" cellspacing="0">

                                                <tr>
                                                    <td width="16%"><div align="right">C : กะลา ฝุ่นสี : จำนวน</div></td>
                                                    <td width="17%"><input name='c_bag_qty' type='text' class="inputs" id="c_bag_qty" value='' size='3' onKeyUp="IsNuber(this.value, this)" onBlur="cal_c_weight()"/>
                                                        ถุง&nbsp;&nbsp;                                                       
                                                        <input name='c_bag_weight' type='text' class="inputs" id="c_bag_weight" value='' size='3' onKeyUp="IsNuber(this.value, this)" onBlur="cal_c_weight()" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kg.</td>
                                                    <td width="17%"><div align="right">P : ปาล์ม ฝุ่นสี : จำนวน</div></td>
                                                    <td width="17%"><input name='p_bag_qty' type='text' class="inputs" id="p_bag_qty" value='' size='3' onKeyUp="IsNuber(this.value, this)" onBlur="cal_p_weight()"/>
                                                        ถุง&nbsp;&nbsp;
                                                        <input name='p_bag_weight' type='text' class="inputs" id="p_bag_weight" value='' size='3' onKeyUp="IsNuber(this.value, this)" onBlur="cal_p_weight()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kg.</td>
                                                    <td width="16%"><div align="right">U : ยูคาฯ  ฝุ่นสี : จำนวน</div></td>
                                                    <td width="17%"><input name='u_bag_qty' type='text' class="inputs" id="u_bag_qty" value='' size='3' onKeyUp="IsNuber(this.value, this)" onBlur="cal_u_weight()"/>
                                                        ถุง&nbsp;&nbsp;
                                                        <input name='u_bag_weight' type='text' class="inputs" id="u_bag_weight" value='' size='3' onKeyUp="IsNuber(this.value, this)" onBlur="cal_u_weight()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kg.</td> 
                                                </tr> 
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td><div align="right">กองที่</div></td>
                                                    <td>&nbsp;</td>
                                                    <td><div align="right">กองที่</div></td>
                                                    <td>&nbsp;</td>
                                                    <td><div align="right">กองที่</div></td>
                                                </tr>                                                
                                                <tr>
                                                    <td width="16%"><div align="right">C : กะลา ฝุ่นสี : </div></td>
                                                    <td width="17%"><input name='c_weight1' type='text' class="inputs" id="c_weight1" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.                                                       
                                                        <input name='loc_c1' type='text' class="inputs" id="loc_c1" value='' size='3' /></td>
                                                    <td width="17%"><div align="right">P : ปาล์ม ฝุ่นสี : </div></td>
                                                    <td width="17%"><input name='p_weight1' type='text' class="inputs" id="p_weight1" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_p1' type='text' class="inputs" id="loc_p1" value='' size='3' onBlur="IsNuber(this.value, this);"/></td>
                                                    <td width="16%"><div align="right">U : ยูคาฯ  ฝุ่นสี&nbsp;</div></td>
                                                    <td width="17%"><input name='u_weight1' type='text' class="inputs" id="u_weight1" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_u1' type='text' class="inputs" id="loc_u1" value='' size='3' onBlur="IsNuber(this.value, this);"/></td>
                                                </tr>
                                                <tr>
                                                    <td><div align="right">ฝุ่นเครี่องดูดฝุ่น&nbsp;</div></td>
                                                    <td><input name='c_weight2' type='text' class="inputs" id="c_weight2" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_c2' type='text' class="inputs" id="loc_c2" value='' size='3' /></td>
                                                    <td><div align="right">ฝุ่นเครี่องดูดฝุ่น&nbsp;</div></td>
                                                    <td><input name='p_weight2' type='text' class="inputs" id="p_weight2" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_p2' type='text' class="inputs" id="loc_p2" value='' size='3' onBlur="IsNuber(this.value, this);"/></td>
                                                    <td><div align="right">ฝุ่นเครี่องดูดฝุ่น&nbsp;</div></td>
                                                    <td><input name='u_weight2' type='text' class="inputs" id="u_weight2" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_u2' type='text' class="inputs" id="loc_u2" value='' size='3' onBlur="IsNuber(this.value, this);"/></td>
                                                </tr>
                                                <tr>
                                                    <td><div align="right">จำนวนสี  &nbsp;</div></td>
                                                    <td><input name='c_weight3' type='text' class="inputs" id="c_weight3" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_c3' type='text' class="inputs" id="loc_c3" value='' size='3' /></td>
                                                    <td><div align="right">จำนวนสี  &nbsp;</div></td>
                                                    <td><input name='p_weight3' type='text' class="inputs" id="p_weight3" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_p3' type='text' class="inputs" id="loc_p3" value='' size='3' onBlur="IsNuber(this.value, this);"/></td>
                                                    <td><div align="right">จำนวนสี  &nbsp;</div></td>
                                                    <td><input name='u_weight3' type='text' class="inputs" id="u_weight3" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_u3' type='text' class="inputs" id="loc_u3" value='' size='3' onBlur="IsNuber(this.value, this);"/></td>
                                                </tr>
                                                <tr>
                                                    <td><div align="right">แม่เหล็ก 1นน.&nbsp;</div></td>
                                                    <td><input name='c_weight4' type='text' class="inputs" id="c_weight4" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_c4' type='text' class="inputs" id="loc_c4" value='' size='3' /></td>
                                                    <td><div align="right">แม่เหล็ก 1นน.&nbsp;</div></td>
                                                    <td><input name='p_weight4' type='text' class="inputs" id="p_weight4" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_p4' type='text' class="inputs" id="loc_p4" value='' size='3' onBlur="IsNuber(this.value, this);"/></td>
                                                    <td><div align="right">แม่เหล็ก 1นน.&nbsp;</div></td>
                                                    <td><input name='u_weight4' type='text' class="inputs" id="u_weight4" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_u4' type='text' class="inputs" id="loc_u4" value='' size='3' onBlur="IsNuber(this.value, this);"/></td>
                                                </tr>
                                                <tr>
                                                    <td><div align="right">แม่เหล็ก 2นน.&nbsp;</div></td>
                                                    <td><input name='c_weight5' type='text' class="inputs" id="c_weight5" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_c5' type='text' class="inputs" id="loc_c5" value='' size='3' /></td>
                                                    <td><div align="right">แม่เหล็ก 2นน.&nbsp;</div></td>
                                                    <td><input name='p_weight5' type='text' class="inputs" id="p_weight5" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_p5' type='text' class="inputs" id="loc_p5" value='' size='3' onBlur="IsNuber(this.value, this);"/></td>
                                                    <td><div align="right">แม่เหล็ก 2นน.&nbsp;</div></td>
                                                    <td><input name='u_weight5' type='text' class="inputs" id="u_weight5" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_u5' type='text' class="inputs" id="loc_u5" value='' size='3' onBlur="IsNuber(this.value, this);"/></td>
                                                </tr>

                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td><div align="right">&nbsp;</div></td>
                                                    <td>&nbsp;</td>
                                                    <td><div align="right">&nbsp;</div></td>
                                                    <td>&nbsp;</td>
                                                    <td><div align="right">&nbsp;</div></td>
                                                </tr>      

                                                <tr>
                                                    <td><div align="right"> ฝุ่นร่อน:จำนวน </div></td>
                                                    <td><input name='c_bag_qty1' type='text' class="inputs" id="c_bag_qty1" value='' size='3' onKeyUp="IsNuber(this.value, this)" onBlur="cal_c_weight1()"/>
                                                        ถุง&nbsp;&nbsp;
                                                        <input name='c_bag_weight1' type='text' class="inputs" id="c_bag_weight1" value='' size='3' onKeyUp="IsNuber(this.value, this)" onBlur="cal_c_weight1()" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kg.</td>
                                                    <td><div align="right"> ฝุ่นร่อน:จำนวน </div></td>
                                                    <td><input name='p_bag_qty1' type='text' class="inputs" id="p_bag_qty1" value='' size='3' onKeyUp="IsNuber(this.value, this)" onBlur="cal_p_weight1()"/>
                                                        ถุง&nbsp;&nbsp;
                                                        <input name='p_bag_weight1' type='text' class="inputs" id="p_bag_weight1" value='' size='3' onKeyUp="IsNuber(this.value, this)" onBlur="cal_p_weight1()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kg.</td>
                                                    <td><div align="right"> ฝุ่นร่อน:จำนวน </div></td>
                                                    <td><input name='u_bag_qty1' type='text' class="inputs" id="u_bag_qty1" value='' size='3' onKeyUp="IsNuber(this.value, this)" onBlur="cal_u_weight1()"/>
                                                        ถุง&nbsp;&nbsp;
                                                        <input name='u_bag_weight1' type='text' class="inputs" id="u_bag_weight1" value='' size='3' onKeyUp="IsNuber(this.value, this)" onBlur="cal_u_weight1()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kg.</td>
                                                </tr>  
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td><div align="right">กองที่</div></td>
                                                    <td>&nbsp;</td>
                                                    <td><div align="right">กองที่</div></td>
                                                    <td>&nbsp;</td>
                                                    <td><div align="right">กองที่</div></td>
                                                </tr>                                                
                                                <tr>
                                                    <td><div align="right"> ฝุ่นร่อน: </div></td>
                                                    <td><input name='c_weight6' type='text' class="inputs" id="c_weight6" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_c6' type='text' class="inputs" id="loc_c6" value='' size='3' /></td>
                                                    <td><div align="right"> ฝุ่นร่อน: </div></td>
                                                    <td><input name='p_weight6' type='text' class="inputs" id="p_weight6" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_p6' type='text' class="inputs" id="loc_p6" value='' size='3' onBlur="IsNuber(this.value, this);"/></td>
                                                    <td><div align="right"> ฝุ่นร่อน: </div></td>
                                                    <td><input name='u_weight6' type='text' class="inputs" id="u_weight6" value='' size='3' onBlur="IsNuber(this.value, this);"/>
                                                        kg.
                                                        <input name='loc_u6' type='text' class="inputs" id="loc_u6" value='' size='3' onBlur="IsNuber(this.value, this);"/></td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                            </table></td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">&nbsp;</td>
                                        <td class="columnobject">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">หมายเหตุ&nbsp;</td>
                                        <td class="columnobject"><textarea class="text_inputs" name='remark' cols='40' rows='5' id="remark"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <div style="width:100%;">
                                                <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                    <tr>
                                                        <td colspan="3" class="h_multi">ข้อมูลการใช้ถ่าน</td>
                                                        <td colspan="4" class="btn_multi">
                                                            <input type='button' name='but1' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,status_a,username', 'CS_026.jsp'));"/>
                                                            <input type='button' name='but2' value='  ลบ  ' onclick='javascript:goDelChild();'/>		    			  		</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="row3" width="3px"><input type="checkbox" name="chk_all" id="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                        <td class="row3" width="7%">ลำดับที่&nbsp;</td>
                                                        <td class="row3" width="45%">ถ่าน&nbsp;</td>
                                                        <!--
                                                        <td class="row3" width="15%">รับเข้า&nbsp;</td>
                                                        -->
                                                        <td class="row3" width="15%">คงเหลือ&nbsp;</td>
                                                        <td class="row3" width="15%">ไซโล&nbsp;</td>
                                                        <td class="row3" width="15%">เลขกอง&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div style="width:100%; height: 150px; overflow: auto;" id="show">                                        </div>		    		</td>
                                    </tr>

                                    <tr>
                                        <td colspan='2' class='blankspace'>
                                            <br>
                                            <div align="center">
                                                <a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;" onClick="AddHeader()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a></div>
                                            <br>                                    </td>
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

