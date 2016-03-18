<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>

<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
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
                        getId("show").innerHTML = "";
                        getId("show2").innerHTML = "";
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                    }
                    else {
                        SURL = "../JSP/CS_037.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL);
                        SURL = "../JSP/CS_045.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL);
                        cancelAction();
                        getId("show").innerHTML = "";
                        getId("show2").innerHTML = "";
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
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
                showTableNonPopup("show", "doc_id", "../JSP/CS_Show037_2.jsp?doc_id=");
            }
            function goDelChild2()
            {
                var Deleteflag = "";
                var SURL;
                if (getId("chk_all2").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_045_2.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show2", "doc_id", "../JSP/CS_Show045_2.jsp?doc_id=");
                    getId("chk_all2").checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    //alert("test");
                    SURL = "../JSP/CS_045_2.jsp?status_d=3&ckbox=";

                    for (var i = 0; i < document.getElementsByName("ckbox2").length; i++)
                    {
                        Deleteflag += (document.getElementsByName("ckbox2")[i].checked) ? (i + 1).toString() + "," : "";
                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&username=" + getId("username").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show2", "doc_id", "../JSP/CS_Show045_2.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show2", "doc_id", "../JSP/CS_Show045_2.jsp?doc_id=")', 500);
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
                    getSave(URLsend('chkNull,doc_id,return_document,confirm_document,username', '../JSP/CS_036_2.jsp'));
                    getId("show").innerHTML = "";
                    getId("show2").innerHTML = "";
                    getId("return_document").value = "N";
                    getId("return_document").checked = false;
                    getId("confirm_document").value = "N";
                    getId("confirm_document").checked = false;
                    /*var formInputs = document.getElementsByTagName('input');
                     //alert(getId("job_id_end").value);
                     if(getId("job_id_end").value == "Y"){
                     getsave_imgload(URLsend('chkNull,doc_id,doc_date,job_id,product_id,size,ctc_i2,inc_bal,palate_no,wh_in,wh_out,username,mashed_machine_chk,mashed_machine,pan_chk,pan,ball_mill_chk,ball_mill,pill_flat_chk,pill_flat,mag_chk,mag,job_edit_chk,job_edit,wash_chk,wash,roast_chk,roast,roast_edit_chk,roast_edit,job_id_complete,remark,job_id_end','../JSP/CS_036_2.jsp'));
                     }else{
                     if( getId("job_id_end").value == "" ){
                     getId("job_id_end").value = "N"
                     }
                     getSave(URLsend('chkNull,doc_id,doc_date,job_id,product_id,size,ctc_i2,inc_bal,palate_no,wh_in,wh_out,username,mashed_machine_chk,mashed_machine,pan_chk,pan,ball_mill_chk,ball_mill,pill_flat_chk,pill_flat,mag_chk,mag,job_edit_chk,job_edit,wash_chk,wash,roast_chk,roast,roast_edit_chk,roast_edit,job_id_complete,remark,job_id_end','../JSP/CS_036.jsp'));
                     }
                     getId("doc_id").disabled = false;
                     getId("show").innerHTML = "";
                     getId("show2").innerHTML = "";
                     getId("status_cancle").value = "";
                     getId("child_ck").value = "";
                     getId("job_id_complete").checked=false;
                     getId("job_id_complete").value="N";
                     getId("job_id_end").checked=false;
                     getId("job_id_end").value="N";
                     for(var i = 0;i<formInputs.length;i++){
                     var theinput = formInputs[i];
                     if(theinput.type ==  "checkbox" && theinput.id != "chk_all2" && theinput.id != "chk_all"){
                     getId(theinput.id).value = "N";
                     }
                     }*/
                }
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if (r)
                {/*
                 var formInputs = document.getElementsByTagName('input');
                 //status_d
                 getSave(URLsend('doc_id,doc_date,job_id,product_id,size,ctc_i2,inc_bal,palate_no,wh_in,wh_out,username,mashed_machine_chk,mashed_machine,pan_chk,pan,ball_mill_chk,ball_mill,pill_flat_chk,pill_flat,mag_chk,mag,job_edit_chk,job_edit,wash_chk,wash,roast_chk,roast,roast_edit_chk,roast_edit,job_id_complete,status_d,remark,job_id_end','../JSP/CS_036.jsp'))
                 getId("doc_id").disabled = false;
                 getId("show").innerHTML = "";
                 getId("show2").innerHTML = "";
                 getId("status_cancle").value = "";
                 getId("child_ck").value = "";
                 getId("job_id_complete").checked=false;
                 getId("job_id_complete").value="N";
                 getId("job_id_end").checked=false;
                 getId("job_id_end").value="N";
                 for(var i = 0;i<formInputs.length;i++){
                 var theinput = formInputs[i];
                 if(theinput.type ==  "checkbox" && theinput.id != "chk_all2" && theinput.id != "chk_all"){
                 getId(theinput.id).value = "N";
                 }
                 }*/
                }
            }
            function Unload()
            {

            }
            function Chk_insert_value(checkbox_name, text_name) {
                if (getId(checkbox_name).checked) {
                    getId(checkbox_name).value = "Y";
                    getId(text_name).disabled = false;
                } else {
                    getId(checkbox_name).value = "N";
                    getId(text_name).disabled = true;
                    getId(text_name).value = "";
                }
            }
            function Chknull() {
                if (document.getElementById('doc_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else {
                    document.report.submit();
                }
            }
            function Checkvalue(thisvalue) {
                if (thisvalue) {
                    getId("return_document").value = "Y";
                    getId("confirm_document").value = "N";
                    getId("confirm_document").checked = false;
                    alert("ทำการส่งเอกสารกลับเพื่อทำการแก้ไข");
                } else {
                    getId("return_document").value = "N";
                }
            }
            function Checkvalue2(objthis) {
                if (objthis.checked) {
                    objthis.value = "Y";
                    getId("return_document").value = "N";
                    getId("return_document").checked = false;
                    alert("ยืนยันการแก้ไขเอกสารสมบูรณ์");
                } else {
                    objthis.value = "N";
                }
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <title>CGC ERP</title>
    </head>
    <body >
        <div  id="imgLoading" style="display: none" align="center" ><img src="../IMAGES/spinner.gif">กำลังประมวลผล...กรุณารอสักครู่</div>
        <div  id="showpage" style="display: '' ">
            <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
                <%
                    UserBean userbean = (UserBean) session.getAttribute("user");
                    DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                    HeaderScreen_Process h_p = new HeaderScreen_Process();
                    objs_p = h_p.selectheaderscreen_process(objs_p, "CS_036");
                    UtiDatabase objuti = new UtiDatabase();
                    // _______________________________________________________________report
                    DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                    HeaderScreen_Report r_p = new HeaderScreen_Report();
                    objr_p = r_p.Fn_Report(objr_p, "S509");
                    path = objr_p.getPath();
                    lookup = objr_p.getLookup();
                    doc_eff_date = objr_p.getDoc_eff_date();
                    doc_no = objr_p.getDoc_no();
                    //_______________________________________________________________report
%>
                <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
                <input type="hidden" id="chkNull" value="doc_id,doc_date,job_id,product_id,size,ctc_i2,inc_bal,palate_no,wh_in,wh_out">
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
                                <b>รายงานการรับถ่านกำมันต์จากการผลิต(คลังสินค้า)(CS_036_2)</b>
                            </div>                        
                            <div class="panel-footer">                      
                                <div align="center">                        

                                    <table  cellpadding="0" cellspacing="0" >
                                        <tr>
                                            <td colspan="2" align="right"><b>หมายเลขเอกสาร : <%=objs_p.getIso_no()%></b></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%></b></td>
                                        </tr>
                                        <tr>
                                            <td class="columnlabel1">ทำการคืนเอกสารเพื่อทำการแก้ไข&nbsp;</td>
                                            <td class="columnobject"><input name="return_document" type="checkbox" id="return_document" value="N" onClick="Checkvalue(this.checked)">

                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="columnlabel1">จบใบแจ้งการผลิต&nbsp;</td><td class="columnobject">
                                                <input type="checkbox" id="job_id_end" name="job_id_end" value="N">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="columnlabel1">หมายเหตุ&nbsp;</td>
                                            <td class="columnobject"><input type='text' class="inputs" name="remark" id="remark" size="50"></td>
                                        </tr>
                                        <tr>
                                            <td class="columnlabel1"><b>เลขที่เอกสาร*</b>&nbsp;</td>
                                            <td class="columnobject">
                                                <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='25' readonly/>
                                                &nbsp;<a href='#' onClick="openBrWindow('vd_product_receive_header_wh&stadment=and+complete_flag+=+\'N\'+and+doc_type+=+\'N\'', 36, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                                <a href='#' onClick="openBrWindow('vd_product_receive_header_wh&stadment=and+complete_flag+=+\'N\'+and+doc_type+=+\'Y\'', 36, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                                วันที่เอกสาร*&nbsp;
                                                <input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' readonly="readonly" />
                                                <!--&nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>&nbsp;&nbsp;-->                                </td>
                                        </tr>
                                        <tr>
                                            <td class="columnlabel1">ใบแจ้งการผลิต*&nbsp;</td>
                                            <td class="columnobject"><input name='job_id' type='text' class="inputs" id="job_id" value='' size='10' readonly="readonly"/>
                                                <!--&nbsp;<a href='#' onClick="openBrWindow('Vd_job_order_header&stadment=and+complete_flag+<>+\'Y\'+and+(doc_type+is+null+or+doc_type<>\'Y\')', 36, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;-->&nbsp;&nbsp;<input name='job_id_desc' type='text' class="inputs" id="job_id_desc" value='' size='30' readonly="readonly"/>                                </td>
                                        </tr>
                                        <tr>
                                            <td class="columnlabel1">ถ่าน*&nbsp;</td>
                                            <td class="columnobject">
                                                <%=objuti.ShowSelectBox("select product_id,prodname,name_t from v_rawmaterial where pgroup_id = 'RAW' order by ptype_id,runno", "product_id", "prodname", "product_id")%>                                        
                                                &nbsp;&nbsp;
                                                ขนาด*&nbsp;
                                                <input name='size' type='text' class="inputs" id="size" value='' size='10' readonly/>                                </td>
                                        </tr>

                                        <tr>
                                            <td class="columnlabel1">I2*&nbsp;</td>
                                            <td class="columnobject">
                                                <input name='ctc_i2' type='text' class="inputs" id="ctc_i2" value='' size='10' />
                                                &nbsp;&nbsp;
                                                ยอดยกมา*&nbsp;
                                                <input name='inc_bal' type='text' class="inputs" id="inc_bal" value='' size='10' />                                </td>
                                        </tr>
                                        <tr>
                                            <td class="columnlabel1">พาเลทที่ยกมา*&nbsp;</td>
                                            <td class="columnobject">
                                                <input name='palate_no' type='text' class="inputs" id="palate_no" value='' size='10' />                                </td>
                                        </tr>
                                        <tr>
                                            <td class="columnlabel1">คลังจ่าย&nbsp;</td>
                                            <td class="columnobject"><input type="hidden" size="10" id="wh_in" name="wh_in" value="<%=objs_p.getWarehouse_begin_id()%>" >
                                                <input type='text' class="inputs" size="20"  id="wh_in_desc" name="wh_in_desc" value="<%=objs_p.getWarehouse_begin_name()%>">
                                                <a href='#' onClick="openBrWindow('Wh_bg&stadment=and+warehouse_id+=+\'<%=objs_p.getWarehouse_begin_id()%>\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a> &nbsp;&nbsp;&nbsp;คลังรับ&nbsp;
                                                <input type="hidden" size="10"  id="wh_out" name="wh_out" value="<%=objs_p.getWarehouse_end_id()%>">
                                                <input type='text' class="inputs"  size="20"  id="wh_out_desc" name="wh_out_desc" value="<%=objs_p.getWarehouse_end_name()%>">
                                                <a href='#' onClick="openBrWindow('Wh_en&stadment=and+warehouse_id+=+\'<%=objs_p.getWarehouse_end_id()%>\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a></td>
                                        </tr>
                                        <tr>
                                            <td class="columnlabel1">&nbsp;</td>
                                            <td class="columnobject">
                                                <div class='col-md-2'><input name="mashed_machine_chk" type="checkbox" id="mashed_machine_chk" value="N" onClick="Chk_insert_value(this.name, 'mashed_machine')">&nbsp;&nbsp;เครื่องบด</div>                                            
                                                <div class='col-md-2'><input name="mashed_machine" class='inputs' class='inputs' type='text' class="inputs" id="mashed_machine" size="10" disabled></div>
                                                <div class='col-md-2'><input type="checkbox" name="pan_chk" id="pan_chk" value="N" onClick="Chk_insert_value(this.name, 'pan')">&nbsp;&nbsp;ร่อน</div>                                            
                                                <div class='col-md-2'><input name="pan" class='inputs' class='inputs' type='text' class="inputs" id="pan" size="10" disabled></div>
                                                <div class='col-md-2'><input type="checkbox" name="ball_mill_chk" id="ball_mill_chk" value="N" onClick="Chk_insert_value(this.name, 'ball_mill')">&nbsp;&nbsp;บอลมิล</div>                                            
                                                <div class='col-md-2'><input name="ball_mill" class='inputs' class='inputs' type='text' class="inputs" id="ball_mill" size="10" disabled></div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="columnlabel1">&nbsp;</td>
                                            <td class="columnobject">
                                                <div class='col-md-2'><input type="checkbox" name="pill_flat_chk" id="pill_flat_chk" value="N" onClick="Chk_insert_value(this.name, 'pill_flat')">&nbsp;&nbsp;เม็ดแบน</div>
                                                <div class='col-md-2'><input name="pill_flat" class='inputs' class='inputs' type='text' class="inputs" id="pill_flat" size="10" disabled></div>
                                                <div class='col-md-2'><input type="checkbox" name="mag_chk" id="mag_chk" value="N" onClick="Chk_insert_value(this.name, 'mag')">&nbsp;&nbsp;MAG</div>                                            
                                                <div class='col-md-2'><input name="mag" class='inputs' class='inputs' type='text' class="inputs" id="mag" size="10" disabled></div>
                                                <div class='col-md-2'><input type="checkbox" name="job_edit_chk" id="job_edit_chk" value="N" onClick="Chk_insert_value(this.name, 'job_edit')">&nbsp;&nbsp;งานแก้</div>
                                                <div class='col-md-2'><input name="job_edit" class='inputs' class='inputs' type='text' class="inputs" id="job_edit" size="10" disabled></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="columnlabel1">&nbsp;</td>
                                            <td class="columnobject">
                                                <div class='col-md-2'><input type="checkbox" name="wash_chk" id="wash_chk" value="N" onClick="Chk_insert_value(this.name, 'wash')">&nbsp;&nbsp;ล้าง</div>
                                                <div class='col-md-2'><input name="wash" class='inputs' class='inputs' type='text' class="inputs" id="wash" size="10" disabled></div>
                                                <div class='col-md-2'><input type="checkbox" name="roast_chk" id="roast_chk" value="N" onClick="Chk_insert_value(this.name, 'roast')">&nbsp;&nbsp;อบแห้ง</div>
                                                <div class='col-md-2'><input name="roast" class='inputs' class='inputs' type='text' class="inputs" id="roast" size="10" disabled></div>
                                                <div class='col-md-2'><input name="roast_edit_chk" type="checkbox" id="roast_edit_chk" value="N" onClick="Chk_insert_value(this.name, 'roast_edit')">&nbsp;&nbsp;อบแห้งแก้</div>
                                                <div class='col-md-2'><input name="roast_edit" class='inputs' class='inputs' type='text' class="inputs" id="roast_edit" size="10" disabled></div>
                                            </td>
                                        </tr>                                        

                                        <tr>
                                            <td class="columnlabel1"><b>ยืนยันเอกสารสมบูรณ์</b>&nbsp;</td>
                                            <td class="columnobject">
                                                <input name='confirm_document' type='checkbox' id="confirm_document" value='N'  onclick="Checkvalue2(this)"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan='2' class='blankspace'></td>
                                        </tr>

                                        <!-- ******************  Double ************************* -->
                                        <tr>
                                            <td colspan="2" align="center">
                                                <div style="width:100%;">
                                                    <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                        <tr>
                                                            <td colspan="5" class="h_multi"></td>
                                                            <td colspan="6" class="btn_multi">
                                                                <input type='button' class="cgcButton_4" name='but3' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,wh_in,wh_out,doc_date,status_a,username', 'CS_045_2.jsp'));"/>
                                                                <input type='button' class="cgcButton_3" name='but4' value='  ลบ  ' onClick="goDelChild2()"/>                                                </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="headergrid" colspan="17">ถ่านได้</td>
                                                        </tr>                                                      
                                                        <tr>
                                                            <td class="row3" width="3%"><input name="chk_all2" type="checkbox" id="chk_all2" onClick="javascript:ckall2(this.checked);" value="chk_all2"/></td>
                                                            <td class="row3" width="7%">ลำดับ&nbsp;</td>
                                                            <td class="row3" width="10%">ขนาด&nbsp;</td>
                                                            <td class="row3" width="10%">น้ำหนัก(Kg)&nbsp;</td>
                                                            <td class="row3" width="10%">ประเภทงาน</td>
                                                            <td class="row3" width="5%">กะ&nbsp;</td>
                                                            <td class="row3" width="15%">รหัสครบพาเลท&nbsp;</td>
                                                            <td class="row3" width="10%">พาเลทที่&nbsp;</td>
                                                            <td class="row3" width="10%">ครบพาเลท&nbsp;</td>
                                                            <td class="row3" width="10%">I2&nbsp;</td>
                                                            <td class="row3" width="10%">หน่วยบรรจุ&nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style="width:100%; height: 150px; overflow: auto;" id="show2"></div>                                </td>
                                        </tr>
                                        <!-- ***************************************************** -->
                                        <tr>
                                            <td colspan='2' class='blankspace'>
                                                <br>
                                                <div align="center">
                                                    <a href="javascript:;" onClick="cancle()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                                    <a href="javascript:;" onClick="AddHeader()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                                    <!--<a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>-->
                                                    <a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" class="imgtransparent"  src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a></div>
                                                <br>                                </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>