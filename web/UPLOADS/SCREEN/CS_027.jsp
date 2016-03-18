<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no, user_dept_doc_id;
    %>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
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
        <script type="text/javascript">
            function Chknull() {
                if (document.getElementById('doc_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else
                    document.report.submit();
            }
            function goAddChild(URLSend)
            {
                var arryChk = new Array;
                arryChk[0] = "chkNull"
                if (ChkParameter(arryChk))
                {
                    window.open(URLSend[0]);
                }

            }
            function cancle()
            {

                var SURL;
                var r = confirm("คุณต้องการยกเลิกข้อมูลทั้งหมดหรือไม่");
                if (r)
                {
                    if (getId("status_cancle").value === "1")
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
                        SURL = "../JSP/CS_028.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
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
                    SURL = "../JSP/CS_028.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    Delete_Line_no_ShowTotal(SURL, 'total_weight');
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show028.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show028.jsp?doc_id=")', 500);
                    getId("chk_all").checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_028.jsp?status_d=3&ckbox=";
                    for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                    {
                        Deleteflag += (document.getElementsByName("ckbox")[i].checked) ? (i + 1).toString() + "," : "";
                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&username=" + getId("username").value;
                    Delete_Line_no_ShowTotal(SURL, 'total_weight');
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show028.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show028.jsp?doc_id=")', 500);
                }
            }
            function Display_Detail() {
                //alert("OK");
                showTableNonPopup("show", "doc_id", "../JSP/CS_Show028.jsp?doc_id=");
            }

            function OpenEdit(URLSend)
            {
                window.open(URLSend[0]);
            }
            function AddHeader()
            {
                var r = confirm("คุณต้องการบันทึกหรือไม่");
                if (r)
                {
                    getSave(URLsend('chkNull,doc_id,date_ck,child_ck,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,burn_no,wh_in,wh_out,total_weight,username,tank_qty,operate_id,remark,bu,iod,complete_flag', '../JSP/CS_027.jsp'));
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                    getId("complete_flag").value = "N";
                    getId("complete_flag").checked = false;
                    setTimeout('getId("total_weight").value = "0";getId("total_weight_chk").value = "0"', 1000);
                    //setTimeout('window.location.reload()',1000);
                }

            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่");
                if (r)
                {
                    getSave(URLsend('doc_id,doc_date,date_ck,child_ck,time_from,time_to,runner_id,runner_id_desc,shift,burn_no,wh_in,wh_out,total_weight,status_d,username,tank_qty,operate_id', '../JSP/CS_027.jsp'))
                    getId("date_ck").value = "";
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                    setTimeout('getId("total_weight").value = "0";getId("total_weight_chk").value = "0"', 1000);
                }
            }
            function Unload()
            {

                if (getId("doc_id").disabled == true && getId("status_cancle").value !== "1" && getId("total_weight_chk").value === "0") {
                    var r = confirm("คุณได้ทำการเปลี่ยนหน้าคุณต้องการบันทึกข้อมูลทั้งหมดใช่หรือไม่");
                    if (r === true) {
                        getSave(URLsend('chkNull,doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,burn_no,wh_in,wh_out,total_weight', '../JSP/CS_027.jsp'));
                    }

                    else {
                        var SURL = "../JSP/CS_028.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL);
                    }
                }
                else if (getId("doc_id").disabled === true && getId("status_cancle").value === "1" && getId("total_weight_chk").value !== getId("total_weight").value) {
                    getSave(URLsend('chkNull,doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,burn_no,wh_in,wh_out,total_weight', '../JSP/CS_027.jsp'));
                }
            }
            function OpenDoc_id(case_input)
            {

                //alert("user_dept_doc_id = " + user_dept_doc_id.value);

                if (case_input === 1) {
                    openBrWindow('vd_carbon_burn_in_header&stadment=and+complete_flag+=+\'N\'+and+count_send_complete+=+\'0\'', 27, 'Search_Doc_id.jsp');
                } else if (case_input === 2) {
                    openBrWindow('vd_carbon_burn_in_header&stadment=and+complete_flag+=+\'N\'+and+count_send_complete+<>+\'0\'', 27, 'Search_Doc_id.jsp');
                } else {
                    openBrWindow('vd_carbon_burn_in_header&stadment=and+complete_flag+=+\'Y\'+and+count_send_complete+<>+\'0\'', 27, 'Search_Doc_id.jsp');
                }


                /*if(getId("date_ck").value != getId("doc_date").value || getId("child_ck").value == "1" || getId("total_weight_chk").value != getId("total_weight").value && getId("doc_id").disabled == true && getId("status_cancle").value == "1"){
                 alert("มีการเปลี่ยนแปลงข้อมูลกรุณาบันทึกข้อมูล");
                 }
                 else if(getId("date_ck").value != getId("doc_date").value || getId("child_ck").value == "1" || getId("total_weight_chk").value != getId("total_weight").value && getId("doc_id").disabled == true && getId("status_cancle").value == ""){
                 alert("ถ้าต้องการเลือกข้อมูลอื่นกรุณาบันทึกข้อมูลหรือยกเลิกข้อมูล");
                 }
                 else{
                 openBrWindow('vd_carbon_burn_in_header&stadment=and+complete_flag+=+\'N\'', 27, 'Search_Doc_id.jsp');
                 }*/
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
            function ChkDoc_id() {
                if (getId("doc_id").value.length !== 12) {
                    alert("กรุณาใส่เลขที่เอกสารให้ถูกต้อง");
                    setTimeout("getId('doc_id').select();", 10);
                }
            }
        </script>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">

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

        <title>CGC ERP</title>
    </head>
    <body onUnload="Unload()">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_027");
                UtiDatabase objuti = new UtiDatabase();
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S504");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                user_dept_doc_id = userbean.getDept_id();
                //_______________________________________________________________report
            %>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="date_ck" name="date_ck" value="">
            <input type="hidden" id="child_ck" name="child_ck" value="">
            <input type="hidden" id="chkNull" value="doc_id,doc_date,time_from,time_to,runner_id,shift,burn_no,wh_in,wh_out">
            <input type="hidden" id="status_a" value="1"><!-- เป็นการเพิ่มข้อมูลเข้าไป-->
            <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" id="status_cancle" value=""><!-- status_cancle = 1 คือค่าที่นำมา Edit แต่ถ้า ="" จะเป็นการ Insert -->
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">
            <input type="hidden" id="user_dept_doc_id" name="user_dept_doc_id" value="<%=user_dept_doc_id%>">

            <div align="left">

                <div class="container">
                    <div class="panel panel-primary">
                        <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                            <b>ใบบันทึกถ่านเติมเตา(CS_027)</b>
                        </div>                        
                        <div class="panel-footer">                            

                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><b>หมายเลขเอกสาร : <%=objs_p.getIso_no()%></b></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%></b></td>
                                </tr>

                                <!--tr>
                                    <td class="columnlabel1">เอกสารสมบูรณ์ :&nbsp;</td>
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

                                <td width="150" class="columnlabel1"><b>เลขที่เอกสาร*</b> :&nbsp;</td>
                                <td width="607" class="columnobject">
                                    <input name='doc_id' class='inputs' type='text' class="inputs" id="doc_id" value='' size='15' onBlur="ChkDoc_id();"/>
                                    &nbsp;<a href='#' onClick="OpenDoc_id(1)"  ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    <a href='#' onClick="OpenDoc_id(2)"  ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาเอกสารที่ถูกตีกลับเพื่อทำการแก้ไข' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    วันที่เอกสาร* :&nbsp;
                                    <input name='doc_date' class='inputs' type='text' class="inputs" id="doc_date" value='' size='10' readonly="readonly"/>
                                    &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>&nbsp;&nbsp;                                
                                    <b>เอกสารที่ส่งคลังแล้ว*</b> :&nbsp;<a href='#' onClick="OpenDoc_id(3)"  ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาเอกสารที่ถูกตีกลับเพื่อทำการแก้ไข' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;                                    
                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">เวลา :&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='time_from' class='inputs' type='text' class="inputs" id="time_from" value='' size='10' maxlength="5" />
                                        &nbsp;&nbsp;&nbsp;
                                        ถึง&nbsp;&nbsp;&nbsp;
                                        <input name='time_to' class='inputs' type='text' class="inputs" id="time_to" value='' size='10' maxlength="5" />                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ผู้บันทึก :&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='runner_id' class='inputs' type='text' class="inputs" id="runner_id" value='' size='10' readonly="readonly" />
                                        <!--&nbsp;&nbsp;&nbsp;<a href='#' onClick="openBrWindow('Vemployee', 27, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='runner_id_desc' class='inputs' type='text' class="inputs" id="runner_id_desc" value='' size='30' readonly="readonly" /-->
                                        &nbsp;&nbsp;&nbsp;<a href='#' onClick="openBrWindow('Vemployee&stadment=and+(dept_id+=+\'10\'or+dept_id+=+\'08\'or+dept_id+=+\'11\'or+dept_id+=+\'12\'or+dept_id+=+\'13\')and+status+=+\'Y\'', 27, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='runner_id_desc' class='inputs' type='text' class="inputs" id="runner_id_desc" value='' size='30' readonly="readonly">
                                    </td>

                                </tr>
                                <tr>
                                    <td class="columnlabel1">ช่วงเวลาทำงาน(กะ) :&nbsp;</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select shift_id,name_t from mshift where shift_grp = '3' order by runno", "shift_id", "name_t", "shift")%>
                                        <!--select name='shift' id="shift">
                                            <option value='1'>เช้า</option><option value='2'>บ่าย</option><option value='3'>ดึก</option></select>-->&nbsp;&nbsp;&nbsp;
                                        หมายเลขเตาเผา&nbsp;
                                        <input name='burn_no' class='inputs' type='text' class="inputs" id="burn_no" value='' size='10' />                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">คลังจ่าย :&nbsp;</td>
                                    <td class="columnobject">
                                        <input type="hidden" size="10" id="wh_in" name="wh_in" value="<%=objs_p.getWarehouse_begin_id()%>" ><input class='inputs' type='text' class="inputs" size="20"  id="wh_in_desc" name="wh_in_desc" value="<%=objs_p.getWarehouse_begin_name()%>">
                                        <a href='#' onClick="openBrWindow('Wh_bg&stadment=and+warehouse_id+=+\'<%=objs_p.getWarehouse_begin_id()%>\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;&nbsp;&nbsp;คลังรับ :&nbsp;
                                        <input type="hidden" size="10"  id="wh_out" name="wh_out" value="<%=objs_p.getWarehouse_end_id()%>"><input class='inputs' type='text' class="inputs"  size="20"  id="wh_out_desc" name="wh_out_desc" value="<%=objs_p.getWarehouse_end_name()%>">
                                        <a href='#' onClick="openBrWindow('Wh_en&stadment=and+warehouse_id+=+\'<%=objs_p.getWarehouse_end_id()%>\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                                                      
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">Butane (เป้าหมาย) :&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='bu' class='inputs' type='text' class="inputs" id="bu" value='' size='20' maxlength="50" />                                                                                
                                        &nbsp;&nbsp;&nbsp;Iodine (เป้าหมาย) :&nbsp;
                                        <input name='iod' class='inputs' type='text' class="inputs" id="iod" value='' size='20' maxlength="50" />
                                        <a href='#' onClick="openBrWindow('m_iodine', 27, 'Search_Config3.jsp');">
                                            <img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                    </td>
                                </tr>                            
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td height="200" colspan="2" align="center">
                                        <div style="width:100%;">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <tr>
                                                    <td colspan="4" class="h_multi"></td>
                                                    <td colspan="5" class="btn_multi">
                                                        <input type='button' class="cgcButton_4" name='but1' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,total_weight,status_a,username', 'CS_028.jsp'));"/>
                                                        <input type='button' class="cgcButton_3" name='but2' value='  ลบ  ' onclick='goDelChild()'/>                                                
                                                        <input type='button' class="cgcButton_7" name='but3' value='  แสดง  ' onclick='Display_Detail()'/>                                                
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="headergrid" colspan="17">ข้อมูลถ่านเติมเตา</td>
                                                </tr>                                                   
                                                <tr>
                                                    <td class="row3" width="3px"><input type="checkbox" name="chk_all" id="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                    <td class="row3" width="7%">ลำดับที่&nbsp;</td>
                                                    <td class="row3" width="7%">ถังที่&nbsp;</td>
                                                    <td class="row3" width="10%">โกดัง&nbsp;</td>
                                                    <td class="row3" width="25%">ถ่าน&nbsp;</td>
                                                    <td class="row3" width="15%">กองที่&nbsp;</td>
                                                    <td class="row3" width="15%">น้ำหนักถัง+ถ่าน&nbsp;</td>
                                                    <td class="row3" width="10%">น้ำหนักถัง&nbsp;</td>
                                                    <td class="row3" width="10%">น้ำหนักถ่าน&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">                                    
                                        </div>                                
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ผู้ปฏิบัติงาน :&nbsp;</td>
                                    <td class="columnobject">
                                        <input name="operate_id" type='text' class="inputs" id="operate_id" size="10">
                                        <a href='#' onClick="openBrWindow('Vemployee1', 27, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        <input type='text' class="inputs" name="operate_id_desc" id="operate_id_desc">                                        
                                    </td>                                    
                                </tr>                                
                                <tr>
                                    <td colspan="2" align="right">&nbsp;&nbsp;จำนวนถัง :&nbsp;
                                        <input name="tank_qty" type='text' class="inputs" id="tank_qty" size="10">
                                        &nbsp;&nbsp;ถัง&nbsp;น้ำหนักรวม* :&nbsp;
                                        <input name='total_weight' type='text' class="inputs" id="total_weight" value='0' size='10' readonly="readonly"/>
                                        &nbsp;(Kg)
                                        <input name="total_weight_chk" type="hidden" id="total_weight_chk" value="0" size="10"/></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"></td>
                                </tr>                                
                                <tr>
                                    <td class="columnlabel1">หมายเหตุ :&nbsp;</td>
                                    <td class="columnobject"><input type='text' class="inputs" id="remark" name="remark" size="70"></td>                                    
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"></td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'>
                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="AddHeader()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="Delete()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onclick="Chknull()"><img alt="พิมพ์เอกสาร" class="imgtransparent" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a></div>
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