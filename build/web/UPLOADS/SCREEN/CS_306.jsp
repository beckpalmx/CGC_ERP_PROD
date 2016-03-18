<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>

<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<html>
    <META Http-Equiv="Cache-Control" Content="no-cache">
    <META Http-Equiv="Pragma" Content="no-cache">
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <head>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>

        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>     

        <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">             

        <script src="../JS/angularjs/angular.min.js"></script>                

        <script src="../JS/alertify/alertify.min.js"></script>        
        <link rel="stylesheet" href="../CSS/alertify/alertify.core.css" />
        <link rel="stylesheet" href="../CSS/alertify/alertify.default.css" />           

        <link rel="stylesheet" href="../CSS/checkbox/awesome-bootstrap-checkbox.css"/>     
        <link rel="stylesheet" href="../FONTS/css/font-awesome.css" /> 

        <script type="text/javascript">
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
                        getId("show2").innerHTML = "";
                        getId("doc_id").disabled = false;
                        setTimeout('getId("total_bag_withdraw").value = "0";getId("total_bag_withdraw_edit").value = "0";getId("total_weight_withdraw").value = "0";getId("total_weight_withdraw_edit").value = "0";getId("total_bag").value = "0";getId("total_bag_edit").value = "0";getId("total_weight").value = "0";getId("total_weight_edit").value = "0";', 1000);
                        getId("document_confirm_flag").value = "N";
                        getId("document_confirm_flag").checked = false;
                    }
                    else {
                        SURL = "../JSP/CS_307.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no_ShowTotal2(SURL, 'total_bag_withdraw,total_weight_withdraw');
                        SURL = "../JSP/CS_308.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no_ShowTotal2(SURL, 'total_bag,total_weight');
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("show2").innerHTML = "";
                        getId("doc_id").disabled = false;
                        setTimeout('getId("total_bag_withdraw").value = "0";getId("total_bag_withdraw_edit").value = "0";getId("total_weight_withdraw").value = "0";getId("total_weight_withdraw_edit").value = "0";getId("total_bag").value = "0";getId("total_bag_edit").value = "0";getId("total_weight").value = "0";getId("total_weight_edit").value = "0";', 1000);
                        getId("document_confirm_flag").value = "N";
                        getId("document_confirm_flag").checked = false;
                    }
                    getId("doc_id").disabled = false;
                }

            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }
            function ckall2(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for (var i = 0; i < document.getElementsByName("ckbox2").length; i++)
                {
                    document.getElementsByName("ckbox2")[i].checked = Value;
                }

            }
            function goDelChild()
            {
                var Deleteflag = "";
                var SURL;
                if (getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_307.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    Delete_Line_no_ShowTotal2(SURL, 'total_bag_withdraw,total_weight_withdraw');
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show307.jsp?doc_id=");
                    getId("chk_all").checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_307.jsp?status_d=3&ckbox=";

                    for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                    {
                        Deleteflag += (document.getElementsByName("ckbox")[i].checked) ? (i + 1).toString() + "," : "";
                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&username=" + getId("username").value;
                    //alert(SURL);
                    Delete_Line_no_ShowTotal2(SURL, 'total_bag_withdraw,total_weight_withdraw');
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show307.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show307.jsp?doc_id=")', 500);
                }
            }
            function goDelChild2()
            {
                var Deleteflag = "";
                var SURL;
                if (getId("chk_all2").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_308.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    Delete_Line_no_ShowTotal2(SURL, 'total_bag,total_weight');
                    showTableNonPopup("show2", "doc_id", "../JSP/CS_Show308.jsp?doc_id=");
                    getId("chk_all2").checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_308.jsp?status_d=3&ckbox=";
                    for (var i = 0; i < document.getElementsByName("ckbox2").length; i++)
                    {
                        Deleteflag += (document.getElementsByName("ckbox2")[i].checked) ? (i + 1).toString() + "," : "";
                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&username=" + getId("username").value;
                    Delete_Line_no_ShowTotal2(SURL, 'total_bag,total_weight');
                    showTableNonPopup("show2", "doc_id", "../JSP/CS_Show308.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show2", "doc_id", "../JSP/CS_Show308.jsp?doc_id=")', 500);
                }
            }
            function OpenEdit(URLSend)
            {
                window.open(URLSend[0]);
            }
            function AddHeader()
            {
                var r = confirm("คุณต้องการบันทึกหรือไม่")
                if (r)
                {
                    //alert("test")
                    getSave(URLsend('chkNull,doc_id,doc_date,job_id,job_id_desc,time_from,time_to,emp_id,emp_id_desc,shift,wh_in,wh_out,lost_weight,total_bag_withdraw,total_weight_withdraw,total_bag,total_weight,username,runner_id,return_complete_flag,document_confirm_flag', '../JSP/CS_306.jsp'));
                    getId("doc_id").disabled = false;
                    getId("return_complete_flag").value = "N";
                    getId("return_complete_flag").checked = false;
                    getId("show").innerHTML = "";
                    getId("show2").innerHTML = "";
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    setTimeout('getId("total_bag_withdraw").value = "0";getId("total_bag_withdraw_edit").value = "0";getId("total_weight_withdraw").value = "0";getId("total_weight_withdraw_edit").value = "0";getId("total_bag").value = "0";getId("total_bag_edit").value = "0";getId("total_weight").value = "0";getId("total_weight_edit").value = "0";', 1000);
                    getId("document_confirm_flag").value = "N";
                    getId("document_confirm_flag").checked = false;
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
                    //alert("test");
                }
            }
            function Chknull() {
                if (document.getElementById('doc_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else
                    document.report.submit();
            }
            function Checkvalue(thisvalue) {
                if (thisvalue) {
                    getId("return_complete_flag").value = "Y";
                    alert("ทำการส่งเอกสารกลับเพื่อทำการแก้ไขข้อมูล");
                } else {
                    getId("return_complete_flag").value = "N";
                }
            }
            function Checkvalue_document_confirm(objthis) {
                if (objthis.checked) {
                    alert("ยืนยันการแก้ไขเอกสาร");
                    objthis.value = "Y";
                } else {
                    objthis.value = "N";
                }
                //alert(objthis.value);
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
                UtiDatabase objuti = new UtiDatabase();
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_040");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S511");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
            %>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_id,doc_date,job_id,time_from,time_to,emp_id,shift,wh_in,wh_out,lost_weight">
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
                            <b>รายงานการบรรจุถ่านกัมมันต(คลังสินค้า)(CS_306)</b>
                        </div>                        
                        <div class="panel-footer">               
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><b>หมายเลขเอกสาร :<%=objs_p.getIso_no()%> </b></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%> </b></td>
                                </tr>

                                <tr>
                                    <td class="columnlabel1"><b>ส่งเอกสารกลับเพื่อแก้ไขข้อมูล</b>&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <div class="checkbox checkbox-primary">
                                            <input type="checkbox" id="return_complete_flag" name="return_complete_flag" value="N" onClick="Checkvalue(this.checked)">
                                            <label for="return_complete_flag"></label> 
                                        </div>
                                    </td>
                                </tr>                                    

                                <tr>
                                    <td width="150" class="columnlabel1"><b>เลขที่เอกสาร*</b>&nbsp;:&nbsp;</td>
                                    <td width="607" class="columnobject">
                                        <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10'  readonly/>
                                        &nbsp;
                                        <a href='#' onClick="openBrWindow('vd_packing_product_header_wh&stadment=and+complete_flag+=+\'N\'+and+doc_type+=+\'N\'', 306, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;
                                        <a href='#' onClick="openBrWindow('vd_packing_product_header_wh&stadment=and+complete_flag+=+\'N\'+and+doc_type+=+\'Y\'', 306, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;<b>วันที่เอกสาร*</b>&nbsp;
                                        <input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10'  readonly/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ใบแจ้งการผลิต*&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='job_id' type='text' class="inputs" id="job_id" value='' size='10' readonly/>
                                        &nbsp;&nbsp;&nbsp;<input name='job_id_desc' type='text' class="inputs" id="job_id_desc" value='' size='50' readonly/>                                
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">เวลา*&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='time_from' type='text' class="inputs" id="time_from" value='' size='10' readonly="true"/>
                                        &nbsp;&nbsp;<b>ถึง</b>&nbsp;&nbsp;
                                        <input name='time_to' type='text' class="inputs" id="time_to" value='' size='10' readonly="true"/>                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ผู้บันทึก*&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='emp_id' type='text' class="inputs" id="emp_id" value='' size='10' readonly/>                                        
                                        &nbsp;&nbsp;&nbsp;<input name='emp_id_desc' type='text' class="inputs" id="emp_id_desc" value='' size='30' readonly/>                                
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ช่วงเวลาทำงาน(กะ)&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <select class="select_cgc2" name='shift' id="shift">
                                            <option value='1'>เช้า</option>
                                            <option value='2'>บ่าย</option>
                                            <option value='3'>ดึก</option>
                                        </select>                                    
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">คลังจ่าย&nbsp;:&nbsp;</td>
                                    <td class="columnobject"><input type="hidden" size="10" id="wh_in" name="wh_in" value="<%=objs_p.getWarehouse_begin_id()%>" >
                                        <input type='text' class="inputs" size="20"  id="wh_in_desc" name="wh_in_desc" value="<%=objs_p.getWarehouse_begin_name()%>">
                                        &nbsp;&nbsp;&nbsp;<b>คลังรับ</b>&nbsp;:&nbsp;
                                        <input type="hidden" size="10"  id="wh_out" name="wh_out" value="<%=objs_p.getWarehouse_end_id()%>">
                                        <input type='text' class="inputs"  size="20"  id="wh_out_desc" name="wh_out_desc" value="<%=objs_p.getWarehouse_end_name()%>">                                    
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">สูญเสีย  น้ำหนัก&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='lost_weight' type='text' class="inputs" id="lost_weight" value='' size='10' />
                                        &nbsp;Kg.                                </td>
                                </tr>
                                <input name='sum_pack_month' type='hidden' id="sum_pack_month" value='0'>
                                <input name='sum_pack_year' type='hidden' id="sum_pack_year" value='0'>               

                                <tr>
                                    <td class="columnlabel1">ยืนยันเอกสาร&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <div class="checkbox checkbox-primary">
                                            <input type="checkbox" id="document_confirm_flag" name="document_confirm_flag" value="N" onclick="Checkvalue_document_confirm(this)">
                                            <label for="document_confirm_flag"></label> 
                                        </div>
                                    </td>
                                </tr>                                  


                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <div style="width:100%;">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <tr>
                                                    <td colspan="7" class="h_multi"></td>
                                                    <td colspan="5" class="btn_multi">
                                                        <input type='button' class="cgcButton_4" name='but1' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,total_bag_withdraw,total_weight_withdraw,status_a,username', 'CS_307.jsp'));"/>
                                                        <input type='button' class="cgcButton_3" name='but2' value='  ลบ  ' onclick='goDelChild()'/>                                                </td>
                                                </tr>
                                                <tr>
                                                    <td class="headergrid" colspan="17">ถ่านเบิก</td>
                                                </tr>                                                   
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 250px; overflow: auto;" id="show">                                    

                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <tr>
                                                    <td class="row3" width="3%"><input name="chk_all" type="checkbox" id="chk_all" onClick="javascript:ckall(this.checked);" value="chk_all"/></td>
                                                    <td class="row3" width="5%">ลำดับ&nbsp;</td>
                                                    <td class="row3" width="12%">คลัง&nbsp;</td>
                                                    <td class="row3" width="7%">ชนิดถ่าน&nbsp;</td>
                                                    <td class="row3" width="10%">แหล่งผลิต&nbsp;</td>
                                                    <td class="row3" width="10%">พาเลทที่&nbsp;</td>
                                                    <td class="row3" width="5%">I2&nbsp;</td>
                                                    <td class="row3" width="8%">รหัสผลิต&nbsp;</td>
                                                    <td class="row3" width="10%">ขนาด&nbsp;</td>
                                                    <td class="row3" width="10%">จำนวนถุง&nbsp;</td>
                                                    <td class="row3" width="8%">เศษถุง<br>(กิโลกรัม)&nbsp;</td>                                                    
                                                    <td class="row3" width="10%">น้ำหนัก<br>(กิโลกรัม)&nbsp;</td>
                                                    <td class="row3" width="3%"><br>&nbsp;</td>
                                                </tr>
                                            </table>                                                

                                        </div>                                
                                    </td>
                                </tr>                                
                                <tr>
                                    <td colspan="2" align="right">
                                        รวมถ่านเบิก(บรรจุ)&nbsp;:&nbsp;
                                        <input name="total_bag_withdraw" type='text' class="inputs" id="total_bag_withdraw" value="0" size="10" readonly/>
                                        <input name="total_bag_withdraw_edit" type="hidden" id="total_bag_withdraw_edit" value="0" size="10" />
                                        &nbsp;ถุง &nbsp;&nbsp;&nbsp;
                                        น้ำหนัก&nbsp;:&nbsp;
                                        <input name="total_weight_withdraw" type='text' class="inputs" id="total_weight_withdraw" value="0" size="10" readonly/>
                                        <input name="total_weight_withdraw_edit" type="hidden" id="total_weight_withdraw_edit" value="0" size="10" />
                                        &nbsp;Kg.                                        
                                    </td>
                                </tr>                                    


                                <tr>
                                    <td colspan="2" align="right">
                                        รวมเบิก Pack เกินของเก่าเอามาใช้&nbsp;:&nbsp;
                                        <input name="total_bag_withdraw_over" type='text' class="inputs" id="total_bag_withdraw_over" value="0" align="right" size="10" readonly/>
                                        &nbsp;ถุง &nbsp;&nbsp;&nbsp;
                                        น้ำหนัก&nbsp;:&nbsp;
                                        <input name="total_withdraw_over" type='text' class="inputs" id="total_withdraw_over" value="0" align="right" size="10" readonly/>
                                        &nbsp;Kg.                                        
                                    </td>
                                </tr>                                    

                                <tr>
                                    <td colspan="2" align="right">
                                        รวมถ่านเบิก(คลังสินค้า)&nbsp;:&nbsp;
                                        <input name="total_bag_withdraw_wh" type='text' class="inputs" id="total_bag_withdraw_wh" value="0" size="10" readonly/>
                                        <input name="total_bag_withdraw_edit2" type="hidden" id="total_bag_withdraw_edit2" value="0" size="10" />
                                        &nbsp;ถุง &nbsp;&nbsp;&nbsp;
                                        น้ำหนัก&nbsp;:&nbsp;
                                        <input name="total_weight_withdraw_wh" type='text' class="inputs" id="total_weight_withdraw_wh" value="0" size="10" readonly/>
                                        <input name="total_weight_withdraw_edit2" type="hidden" id="total_weight_withdraw_edit2" value="0" size="10" />
                                        &nbsp;Kg.                                        
                                    </td>
                                </tr>    
                                <!-- ******************  Double ************************* -->
                                <tr>
                                    <td colspan="2" align="center">
                                        <div style="width:100%;">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <tr>
                                                    <td colspan="5" class="h_multi"></td>
                                                    <td colspan="5" class="btn_multi">
                                                        <input type='button' class="cgcButton_4" name='but3' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,total_bag,total_weight,status_a,username', 'CS_308.jsp'));"/>
                                                        <input type='button' class="cgcButton_3" name='but4' value='  ลบ  ' onclick='goDelChild2()'/>                                                </td>
                                                </tr>
                                                <tr>
                                                    <td class="headergrid" colspan="17">ถ่านได้</td>
                                                </tr>                                                   
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 200px; overflow: auto;" id="show2">               
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <tr>
                                                    <td class="row3" width="3%"><input type="checkbox" name="chk_all2" value="chk_all2" id="chk_all2" onClick="javascript:ckall2(this.checked);"/></td>
                                                    <td class="row3" width="7%">ลำดับ&nbsp;</td>
                                                    <td class="row3" width="15%">คลัง&nbsp;</td>
                                                    <td class="row3" width="10%">ชนิดถ่าน&nbsp;</td>
                                                    <td class="row3" width="10%">ขนาด&nbsp;</td>
                                                    <td class="row3" width="5%">I2&nbsp;</td>
                                                    <td class="row3" width="10%">รหัสผลิต&nbsp;</td>
                                                    <td class="row3" width="15%">น้ำหนัก/หน่วย<br>(กิโลกรัม)&nbsp;</td>
                                                    <td class="row3" width="10%">จำนวนถุง&nbsp;</td>                                                    
                                                    <td class="row3" width="15%">น้ำหนัก<br>(กิโลกรัม)&nbsp;</td>
                                                    <td class="row3" width="3%">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>                                
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right">รวมถ่านได้(คลังสินค้า)&nbsp;:&nbsp;
                                        <input name="total_bag_wh" type='text' class="inputs" id="total_bag_wh" value="0" size="10"  readonly/>
                                        <input name="total_bag_edit2" type="hidden" id="total_bag_edit2" value="0" size="10" />
                                        &nbsp;ถุง &nbsp;&nbsp;&nbsp;
                                        น้ำหนัก&nbsp;:&nbsp;
                                        <input name="total_weight_wh" type='text' class="inputs" id="total_weight_wh" value="0" size="10" readonly/>
                                        <input name="total_weight_edit2" type="hidden" id="total_weight_edit2" value="0" size="10" />
                                        &nbsp;Kg. 
                                    </td>
                                </tr>    
                                <tr>
                                    <td colspan="2" align="right">รวมถ่านได้ (บรรจุ)&nbsp;:&nbsp;
                                        <input name="total_bag" type='text' class="inputs" id="total_bag" value="0" size="10"  readonly/>
                                        <input name="total_bag_edit" type="hidden" id="total_bag_edit" value="0" size="10" />
                                        &nbsp;ถุง &nbsp;&nbsp;&nbsp;
                                        น้ำหนัก&nbsp;:&nbsp;
                                        <input name="total_weight" type='text' class="inputs" id="total_weight" value="0" size="10" readonly/>
                                        <input name="total_weight_edit" type="hidden" id="total_weight_edit" value="0" size="10" />
                                        &nbsp;Kg. 
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ผู้รายงาน&nbsp;:&nbsp;</td>
                                    <td class="columnobject"><input name="runner_id" type='text' class="inputs" id="runner_id" size="10" readonly><!--
                                  &nbsp;<a href='#' onClick="javascript:openBrWindow('Vemployee1', 40, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>-->&nbsp;&nbsp;&nbsp;
                                        <input name="runner_id_desc" type='text' class="inputs" id="runner_id_desc" size="30" readonly></td>
                                </tr>
                                <!-- ***************************************************** -->
                                <tr>
                                    <td colspan='2' class='blankspace'>
                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="AddHeader()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                            <!--<a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>-->
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