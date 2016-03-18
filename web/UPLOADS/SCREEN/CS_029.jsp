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
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
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
                var r = confirm("คุณต้องการยกเลิกข้อมูลทั้งหมดหรือไม่")
                if (r)
                {
                    if (getId("status_cancle").value == "1")
                    {
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                        getId("complete_flag").value = "N";
                        setTimeout('getId("total_weight").value = "0";getId("total_weight_chk").value = "0";getId("lost_weight").value = "0";getId("lost_weight_chk").value = "0";', 1000);
                    }

                    else {
                        SURL = "../JSP/CS_030.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL)
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                        getId("complete_flag").value = "N";
                        setTimeout('getId("total_weight").value = "0";getId("total_weight_chk").value = "0";getId("lost_weight").value = "0";getId("lost_weight_chk").value = "0";', 1000);
                    }
                }

            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {
                //alert(document.getElementsByName("ckbox")[0].checked)
                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }
            function goDelChild()
            {
                var Deleteflag = "";
                var SURL;
                //alert(getId("chk_all").checked);
                if (getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_030.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    Delete_Line_no_ShowTotal2(SURL, 'total_weight,lost_weight');
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show030.jsp?doc_id=");
                    getId("chk_all").checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_030.jsp?status_d=3&ckbox=";
                    for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                    {
                        Deleteflag += (document.getElementsByName("ckbox")[i].checked) ? (i + 1).toString() + "," : "";
                    }

                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&username=" + getId("username").value;
                    //alert(SURL);
                    Delete_Line_no_ShowTotal2(SURL, 'total_weight,lost_weight');
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show030.jsp?doc_id=");
                    //setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show030.jsp?doc_id=")', 500);
                }
            }
            function OpenEdit(URLSend)
            {
                window.open(URLSend[0]);
            }
            function AddHeader()
            {
                if (parseFloat(getId("lost_weight").value) > 50) {
                    alert("ไม่สามารถบันทึกข้อมูลได้กรุณาตรวจสอบน้ำหนักสูญเสียต้องไม่เกิน 50 KG.");
                } else {
                    var r = confirm("คุณต้องการบันทึกหรือไม่ ?")
                    if (r)
                    {
                        getSave(URLsend('chkNull,doc_id,doc_date,work_date,time_from,time_to,runner_id,shift,wh_in,wh_out,burn_no,product_id,ch_from,ch_to,weight_split,burn_out_date,lost_weight,total_weight,username,report_id,complete_flag', '../JSP/CS_029.jsp'));
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                        setTimeout('getId("total_weight").value = "0";getId("total_weight_chk").value = "0";getId("lost_weight").value = "0";getId("lost_weight_chk").value = "0";', 1000);
                        getId("complete_flag").value = "N";
                    }
                }
            }

            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if (r)
                {
                    getSave(URLsend('doc_id,doc_date,work_date,time_from,time_to,runner_id,shift,wh_in,wh_out,burn_no,product_id,ch_from,ch_to,weight_split,burn_out_date,lost_weight,total_weight,status_d,username', '../JSP/CS_029.jsp'))
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                    getId("complete_flag").value = "N";
                    setTimeout('getId("total_weight").value = "0";getId("total_weight_chk").value = "0";getId("lost_weight").value = "0";getId("lost_weight_chk").value = "0";', 1000);
                }
            }
            function Unload()
            {

                if (getId("doc_id").disabled == true && getId("status_cancle").value != "1" && getId("total_weight_chk").value == "") {
                    var r = confirm("คุณได้ทำการเปลี่ยนหน้าคุณต้องการบันทึกข้อมูลทั้งหมดใช่หรือไม่");
                    if (r == true) {
                        getSave(URLsend('chkNull,doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,burn_no,wh_in,wh_out,total_weight', '../JSP/CS_029.jsp'));
                    }

                    else {
                        var SURL = "../JSP/CS_030.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL);
                    }
                }
                else if (getId("doc_id").disabled == true && getId("status_cancle").value == "1" && getId("total_weight_chk").value != getId("total_weight").value) {
                    getSave(URLsend('chkNull,doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,burn_no,wh_in,wh_out,total_weight', '../JSP/CS_029.jsp'));
                }
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
            function ChkDoc_id() {
                if (getId("doc_id").value.length != 12) {
                    alert("กรุณาใส่เลขที่เอกสารให้ถูกต้อง");
                    setTimeout("getId('doc_id').select();", 10);
                }
            }

            function Display_Detail() {
                //alert("OK");
                showTableNonPopup("show", "doc_id", "../JSP/CS_Show030.jsp?doc_id=");
            }

        </script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <title>CGC ERP</title>
    </head>
    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_029");
                UserBean userbean = (UserBean) session.getAttribute("user");
                UtiDatabase objuti = new UtiDatabase();
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S505");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
            %>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_id,doc_date,work_date,time_from,time_to,runner_id,shift,wh_in,wh_out,burn_no,product_id,ch_from,ch_to,weight_split,burn_out_date">
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

            <div align="left">

                <div class="container">
                    <div class="panel panel-primary">
                        <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                            <b>รายงานถ่านออกจากเตา(CS_029)</b>
                        </div>                        
                        <div class="panel-footer">               

                            <table   cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><b>หมายเลขเอกสาร : <%=objs_p.getIso_no()%> </b></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%> </b></td>
                                </tr>
                                
                                <!--tr>
                                    <td class="columnlabel1">เอกสารสมบูรณ์&nbsp;</td>
                                    <td class="columnobject"><input name="complete_flag" type="checkbox" id="complete_flag" value="N" onClick="Checkvalue(this.checked)"></td>
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
                                    <td width="150" class="columnlabel1"><b>เลขที่เอกสาร*</b>&nbsp;</td>
                                    <td width="607" class="columnobject">
                                        <input name='doc_id' class='inputs' type='text' class="inputs" id="doc_id" value='' size='15' onBlur="ChkDoc_id();"/> &nbsp;
                                        &nbsp;<a href='#' onClick="openBrWindow('vd_carbon_burn_out_header&stadment=and+complete_flag+<>+\'Y\'', 29, 'Search_Doc_id2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                        <a href='#' title="ค้นหาข้อมูลที่ทำเบิกที่กลับมาแก้ไข"  onClick="openBrWindow('vd_carbon_burn_out_header&stadment=and+complete_flag+<>+\'Y\'+and+count_send_complete+<>+\'0\'', 29, 'Search_Doc_id2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาข้อมูลที่ทำเบิกที่กลับมาแก้ไข' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        วันที่เอกสาร*&nbsp;
                                        <input name='doc_date' class='inputs' type='text' class="inputs" id="doc_date" value='' size='10' readonly="readonly"/>
                                        &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>&nbsp;&nbsp;	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">วันที่ทำงาน&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='work_date' class='inputs' type='text' class="inputs" id="work_date" value='' size='10' readonly="readonly"/>
                                        &nbsp;<a id='date_2' ><img name='IMAGE3' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'work_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_2', singleClick: true, step: 1});</script>&nbsp;&nbsp;&nbsp;
                                        เวลา&nbsp;
                                        <input name='time_from' class='inputs' type='text' class="inputs" id="time_from" value='' size='10' maxlength="5" />
                                        &nbsp;&nbsp;
                                        ถึง&nbsp;&nbsp;
                                        <input name='time_to' class='inputs' type='text' class="inputs" id="time_to" value='' size='10' maxlength="5" />	            </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ผู้บันทึก&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='runner_id' class='inputs' type='text' class="inputs" id="runner_id" value='' size='10' readonly="readonly" />
                                        &nbsp;&nbsp;&nbsp;<a href='#' onClick="openBrWindow('Vemployee1&stadment=and+dept_id+=+\'08\'and+status+=+\'Y\'', 29, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='runner_id_desc' class='inputs' type='text' class="inputs" id="runner_id_desc" value='' size='30' readonly="readonly"/>	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ช่วงเวลาทำงาน(กะ)&nbsp;</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select shift_id,name_t from mshift where shift_grp = '1' order by runno", "shift_id", "name_t", "shift")%>
                                        <!--<select name='shift' id="shift">
                                            <option value='1'>เช้า</option><option value='2'>บ่าย</option><option value='3'>ดึก</option></select>-->&nbsp;&nbsp;	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">คลังจ่าย&nbsp;</td>
                                    <td class="columnobject">
                                        <input type="hidden" size="10" id="wh_in" name="wh_in" value="<%=objs_p.getWarehouse_begin_id()%>" ><input class='inputs' type='text' class="inputs" size="20"  id="wh_in_desc" name="wh_in_desc" value="<%=objs_p.getWarehouse_begin_name()%>">
                                        <a href='#' onClick="openBrWindow('Wh_bg&stadment=and+warehouse_id+=+\'<%=objs_p.getWarehouse_begin_id()%>\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;&nbsp;&nbsp;คลังรับ&nbsp;
                                        <input type="hidden" size="10"  id="wh_out" name="wh_out" value="<%=objs_p.getWarehouse_end_id()%>"><input class='inputs' type='text' class="inputs"  size="20"  id="wh_out_desc" name="wh_out_desc" value="<%=objs_p.getWarehouse_end_name()%>">
                                        <a href='#' onClick="openBrWindow('Wh_en&stadment=and+warehouse_id+=+\'<%=objs_p.getWarehouse_end_id()%>\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                       	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ถ่านจากเตา&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='burn_no' class='inputs' type='text' class="inputs" id="burn_no" value='' size='10' />
                                        &nbsp;&nbsp;
                                        วัตถุดิบ&nbsp;<!--select name="product_id" id="product_id">
                                            <option value="C" selected>ถ่านกะลา</option>
                                            <option value="P">ถ่านปาล์ม</option>
                                            <option value="U">ถ่านไม้ยูคาฯ</option>
                                        </select-->
                                        <%=objuti.ShowSelectBox("select product_id,prodname,name_t from v_rawmaterial where pgroup_id = 'RAW' order by ptype_id,runno", "product_id", "prodname", "product_id")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ช่องที่*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='ch_from' class='inputs' type='text' class="inputs" id="ch_from" value='' size='10' />
                                        &nbsp;&nbsp;
                                        ถึง*&nbsp;&nbsp;&nbsp;&nbsp;
                                        <input name='ch_to' class='inputs' type='text' class="inputs" id="ch_to" value='' size='10' />	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">น้ำหนักก่อนร่อนแยก*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='weight_split' class='inputs' type='text' class="inputs" id="weight_split" value='0' size='10' onBlur="IsNumber2(this.value, this);"/>
                                        &nbsp;&nbsp;
                                        วันที่*&nbsp;
                                        <input class='inputs' type='text' class="inputs" name='burn_out_date' id="burn_out_date" size='10' value='' readonly="readonly"/>&nbsp;<a id='date_3' ><img name='IMAGE6' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'burn_out_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_3', singleClick: true, step: 1});</script>	          	</td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <div style="width:100%;">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <tr>
                                                    <td colspan="5" class="h_multi"></td>
                                                    <td colspan="6" class="btn_multi">
                                                        <input type='button' class="cgcButton_4" name='but1' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,wh_in,wh_out,doc_date,total_weight,lost_weight,status_a,username', 'CS_030.jsp'));"/>
                                                        <input type='button' class="cgcButton_3" name='but2' value='  ลบ  ' onclick='goDelChild()'/>
                                                        <input type='button' class="cgcButton_7" name='but3' value='  แสดง  ' onclick='Display_Detail()'/>                                                
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="headergrid" colspan="17">ข้อมูลถ่านออกจากเตา</td>
                                                </tr>                                                 
                                                <!--tr>
                                                    <td class="row3" width="3px"><input type="checkbox" name="chk_all"  id="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                    <td class="row3" width="7%">ลำดับที่&nbsp;</td>
                                                    <td class="row3" width="15%">รหัส&nbsp;</td>
                                                    <td class="row3" width="10%">ขนาด&nbsp;</td>
                                                    <td class="row3" width="10%">รหัสยกมา&nbsp;</td>
                                                    <td class="row3" width="10%">ยอดยกมา&nbsp;</td>
                                                    <td class="row3" width="10%">I2&nbsp;</td>
                                                    <td class="row3" width="10%">หน่วยบรรจุ&nbsp;</td>
                                                    <td class="row3" width="10%">น้ำหนัก&nbsp;</td>
                                                    <td class="row3" width="15%">หมายเหตุ&nbsp;</td>
                                                </tr-->
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 250px; overflow: auto;" id="show">                                    
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <tr>
                                                    <td class="row3" width="3px"><input type="checkbox" name="chk_all"  id="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                    <td class="row3" width="7%">ลำดับที่&nbsp;</td>
                                                    <td class="row3" width="15%">รหัส&nbsp;</td>
                                                    <td class="row3" width="10%">ขนาด&nbsp;</td>
                                                    <td class="row3" width="10%">รหัสยกมา&nbsp;</td>
                                                    <td class="row3" width="10%">ยอดยกมา&nbsp;</td>
                                                    <td class="row3" width="10%">I2&nbsp;</td>
                                                    <td class="row3" width="10%">หน่วยบรรจุ&nbsp;</td>
                                                    <td class="row3" width="10%">น้ำหนัก&nbsp;</td>
                                                    <td class="row3" width="15%">หมายเหตุ&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>                                
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right">
                                        ผู้รายงาน
                                        <input name="report_id" class='inputs' type='text' class="inputs" id="report_id" size="10">
                                        <a href='#' onClick="openBrWindow('Vemployee&stadment=and+(dept_id+=+\'10\'or+dept_id+=+\'08\'or+dept_id+=+\'11\'or+dept_id+=+\'12\'or+dept_id+=+\'13\')', 29, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>
                                        <input name="report_id_desc" class='inputs' type='text' class="inputs" id="report_id_desc" size="20">
                                        &nbsp;&nbsp;&nbsp;&nbsp;สูญเสีย*&nbsp;
                                        <input name='lost_weight' class='inputs' type='text' class="inputs" id="lost_weight" value='0' size='10' readonly="readonly" />
                                        <input name='lost_weight_chk' type='hidden' id="lost_weight_chk" value='0' size='10' readonly="readonly"/>
                                        &nbsp;(  Kg )&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        น้ำหนักรวม*&nbsp;
                                        <input name='total_weight' class='inputs' type='text' class="inputs" id="total_weight" value='0' size='10' readonly="readonly" />
                                        <input name="total_weight_chk" type="hidden" id="total_weight_chk" value="0" size="10" readonly="readonly"/>
                                        &nbsp;(  Kg)
                                        <!--
                                <input class='inputs' type='text' class="inputs" name='____total_weight' size='10' value='' />
                                        -->	          	</td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'>
                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="AddHeader()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="Delete()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" class="imgtransparent" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a></div>
                                        <br>                                </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>