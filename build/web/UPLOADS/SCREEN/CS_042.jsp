<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.bean.UserBean"%>
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
                        getId("cust_id").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                        setTimeout('getId("net_weight_chk").value = "0";getId("net_weight").value = "0";', 1000);
                    }
                    else {
                        SURL = "../JSP/CS_043.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL)
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("cust_id").value = "";
                        getId("doc_id").disabled = false;
                        setTimeout('getId("net_weight_chk").value = "0";getId("net_weight").value = "0";', 1000);
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
            function goDelChild()
            {
                var Deleteflag = "";
                var SURL;
                //alert(getId("chk_all").checked);
                if (getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_043.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    Delete_Line_no_ShowTotal(SURL, 'net_weight');
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show043.jsp?doc_id=");
                    getId("chk_all").checked = false;

                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    //alert("test");
                    SURL = "../JSP/CS_043.jsp?status_d=3&ckbox=";

                    for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                    {
                        if (document.getElementsByName("ckbox")[i].checked == true)
                            Deleteflag += (i + 1).toString() + ",";
                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&username=" + getId("username").value;
                    Delete_Line_no_ShowTotal(SURL, 'net_weight');
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show043.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show043.jsp?doc_id=")', 1000);
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
                    getSave(URLsend('chkNull,doc_id,doc_date,job_id,job_id_desc,cust_address_desc,cust_country_desc,po_no_desc,item_id,wh_in,wh_out,contain_no,contain_type,seal_no,palate_type,approver,approver_desc,payment_prod,payment_prod_desc,receiver,receiver_desc,car_no,net_weight,username,cust_id,complete_flag', '../JSP/CS_042.jsp'));
                    //cancelAction();
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("cust_id").value = "";
                    getId("doc_id").disabled = false;
                    getId("complete_flag").checked = false;
                    getId("complete_flag").value = "N";
                    setTimeout('getId("net_weight_chk").value = "0";getId("net_weight").value = "0";', 1000);

                }
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if (r)
                {
                    getSave(URLsend('doc_id,doc_date,job_id,job_id_desc,cust_address_desc,cust_country_desc,po_no_desc,item_id,wh_in,wh_out,contain_no,contain_type,seal_no,palate_type,approver,approver_desc,payment_prod,payment_prod_desc,receiver,receiver_desc,car_no,net_weight,status_d,username,complete_flag', '../JSP/CS_042.jsp'));
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("cust_id").value = "";
                    getId("doc_id").disabled = false;
                    getId("complete_flag").checked = false;
                    getId("complete_flag").value = "N";
                    setTimeout('getId("net_weight_chk").value = "0";getId("net_weight").value = "0";', 1000);
                }
            }
            function Unload()
            {

                if (getId("doc_id").disabled == true && getId("status_cancle").value != "1" && getId("total_weight_chk").value == "") {
                    var r = confirm("คุณได้ทำการเปลี่ยนหน้าคุณต้องการบันทึกข้อมูลทั้งหมดใช่หรือไม่");
                    if (r == true) {
                        getSave(URLsend('chkNull,doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,burn_no,wh_in,wh_out,total_weight', '../JSP/CS_042.jsp'));
                    }

                    else {
                        var SURL = "../JSP/CS_043.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL);
                    }
                }
                else if (getId("doc_id").disabled == true && getId("status_cancle").value == "1" && getId("net_weight_chk").value != getId("net_weight").value) {
                    getSave(URLsend('chkNull,doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,burn_no,wh_in,wh_out,total_weight', '../JSP/CS_042.jsp'));
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
                    getId("complete_flag").value = "Y";
                    alert("เอกสารนี้สมบูรณ์เรียบร้อยแล้ว");
                } else {
                    getId("complete_flag").value = "N"
                    //alert("เอกสารนี้สมบูรณ์เรียบร้อยแล้ว");
                }
            }

            function Runing_Doc_id() {
                if (document.getElementById('doc_date').value == '') {
                    alert('กรุณาใส่วันที่เอกสาร');
                } else
                    AjaxRun_id("doc_id", "../JSP/CS_042.jsp?runer_id=" + getId("doc_date").value);
            }

        </script>    

        <script type="text/javascript">

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });

        </script>          

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <title>CGC ERP</title>
    </head>
    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_042");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S512");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
            %>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_id,doc_date,job_id,item_id,wh_in,wh_out,contain_no,contain_type,seal_no,contain_type,approver,payment_prod,receiver,car_no">
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
                            <b>ใบเบิกสินค้าเพื่อส่งออก(CS_042)</b>
                        </div>                        
                        <div class="panel-footer">               

                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><b>หมายเลขเอกสาร : <%=objs_p.getIso_no()%> </b></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%></b></td>
                                </tr>
                                
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
                                    <td class="columnlabel1"><b>เลขที่เอกสารอัตโนมัติ</b>&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name="runner" id="runner" class="cgcButton_9" type="button" value="กดสร้างเลขที่เอกสาร"  data-toggle="tooltip" title="เลือกวันที่เอกสารและกดปุ่มนี้เพื่อสร้างเลขที่เอกสารอัตโนมัติ" onclick="Runing_Doc_id();">
                                    </td>
                                </tr>                                 
                                <tr>
                                    <td class="columnlabel1"><b>เลขที่เอกสาร*</b>&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' />
                                        <a href='#' title="ค้นหาข้อมูลที่ทำเบิกสินค้าเพื่อส่งออก" onClick="openBrWindow('vd_requisition_product_header&stadment=and+complete_flag+<>+\'Y\'+and+count_send_complete+=+\'0\'', 42, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        วันที่เอกสาร*&nbsp;:&nbsp;
                                        <input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' readonly="readonly"/>
                                        &nbsp;<a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>&nbsp;&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1"><b>เอกสารที่คลังส่งกลับมาแก้ไข</b>&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <a href='#' title="ค้นหาข้อมูลที่ทำเบิกสินค้าเพื่อส่งออกที่กลับมาแก้ไข" onClick="openBrWindow('vd_requisition_product_header&stadment=and+complete_flag+<>+\'Y\'+and+count_send_complete+<>+\'0\'', 42, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาข้อมูลที่ทำเบิกสินค้าเพื่อส่งออกที่กลับมาแก้ไข' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                    </td>
                                </tr>              
                                <td colspan='2' class='blankspace'></td>
                                <tr>
                                    <td class="columnlabel1"><b>เอกสารที่ส่งคลังแล้ว</b>&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <a href='#' title="ค้นหาข้อมูลที่ทำเบิกสินค้าที่ส่งคลังเรียบร้อยแล้ว" onClick="openBrWindow('vd_requisition_product_header&stadment=and+complete_flag+=+\'Y\'+and+count_send_complete+<>+\'0\'', 42, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาข้อมูลที่ทำเบิกสินค้าเพื่อส่งออกที่กลับมาแก้ไข' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td class="columnlabel1">ใบแจ้งการผลิต*&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='job_id' type='text' class="inputs" id="job_id" value='' size='10' readonly="readonly" />
                                        <input type="hidden" name="cust_id" id="cust_id" value=""/>
                                        <a href='#' onClick="openBrWindow('Vd_job_order_header&stadment=and+complete_flag+<>+\'Y\'', 42, 'Search_Config2.jsp');">
                                        <img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        <input name='job_id_desc' type='text' class="inputs" id="job_id_desc" value='' size='50' readonly="readonly"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ที่อยู่ลูกค้า&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <textarea class="text_inputs" name='cust_address_desc' cols='40' rows='5' id="cust_address_desc" readonly="readonly"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ประเทศ&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='cust_country_desc' type='text' class="inputs" id="cust_country_desc" value='' size='30' readonly="readonly"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ใบสั่งซื้อ&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='po_no_desc' type='text' class="inputs" id="po_no_desc" value='' size='30' />
                                    </td>
                                </tr>

                                <tr>
                                    <td class="columnlabel1">ITEM*&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='item_id' type='text' class="inputs" id="item_id" value='' size='10' />
                                    </td>
                                </tr>

                                <tr>
                                    <td class="columnlabel1">คลังจ่าย&nbsp;:&nbsp;</td>
                                    <td class="columnobject"><input type="hidden" size="10" id="wh_in" name="wh_in" value="<%=objs_p.getWarehouse_begin_id()%>" >
                                        <input type='text' class="inputs" size="20"  id="wh_in_desc" name="wh_in_desc" value="<%=objs_p.getWarehouse_begin_name()%>">
                                        <a href='#' onClick="openBrWindow('Wh_bg&stadment=and+warehouse_id+=+\'<%=objs_p.getWarehouse_begin_id()%>\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a> &nbsp;&nbsp;&nbsp;<b>คลังรับ</b>&nbsp;:&nbsp;
                                        <input type="hidden" size="10"  id="wh_out" name="wh_out" value="<%=objs_p.getWarehouse_end_id()%>">
                                        <input type='text' class="inputs"  size="20"  id="wh_out_desc" name="wh_out_desc" value="<%=objs_p.getWarehouse_end_name()%>">
                                        <a href='#' onClick="openBrWindow('Wh_en&stadment=and+warehouse_id+=+\'<%=objs_p.getWarehouse_end_id()%>\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">Container No.&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='contain_no' type='text' class="inputs" id="contain_no" value='' size='10' />
                                        &nbsp;&nbsp;
                                        <b>ประเภทตู้</b>&nbsp;:&nbsp;
                                        <select class='select_cgc2' name='contain_type' id="contain_type">
                                            <option value='20'>20</option><option value='40'>40</option><option value='40 HQ'>40 HQ</option></select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">Seal No.&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='seal_no' type='text' class="inputs" id="seal_no" value='' size='10' />
                                        &nbsp;&nbsp;
                                        <b>ประเภทไม้พาเลท</b>&nbsp;:&nbsp;
                                        <select class='select_cgc' name='palate_type' id="palate_type">
                                            <option value='1'>อบน้ำยา/อบความร้อน Certificate</option><option value='2'>พลาสติก</option><option value='3'>อื่นๆ</option></select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ผู้อนุมัติ*&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='approver' type='text' class="inputs" id="approver" value='' size='10' readonly="readonly"/>
                                        &nbsp;<a href='#' onClick="javascript:openBrWindow('Vemployee', 42, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='approver_desc' type='text' class="inputs" id="approver_desc" value='' size='30' readonly="readonly"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ผู้จ่ายสินค้า*&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='payment_prod' type='text' class="inputs" id="payment_prod" value='' size='10' readonly="readonly"/>
                                        &nbsp;<a href='#' onClick="javascript:openBrWindow('Vemployee1', 42, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE5' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='payment_prod_desc' type='text' class="inputs" id="payment_prod_desc" value='' size='30' readonly="readonly"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ผู้รับสินค้า*&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='receiver' type='text' class="inputs" id="receiver" value='' size='10' readonly="readonly"/>
                                        &nbsp;<a href='#' onClick="javascript:openBrWindow('Vemployee2', 42, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE6' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='receiver_desc' type='text' class="inputs" id="receiver_desc" value='' size='30' readonly="readonly"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ทะเบียนรถ&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='car_no' type='text' class="inputs" id="car_no" value='' size='10' />
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
                                                    <td colspan="3" class="h_multi"></td>
                                                    <td colspan="4" class="btn_multi">
                                                        <input type='button' class="cgcButton_4" name='but1' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,doc_date,wh_in,wh_out,net_weight,status_a,username', 'CS_043.jsp'));"/>
                                                        <input type='button' class="cgcButton_3" name='but2' value='  ลบ  ' onclick='javascript:goDelChild();'/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="headergrid" colspan="17">ข้อมูลการเบิก</td>
                                                </tr>                                                  

                                                <tr>
                                                    <td class="row3" width="3px"><input name="chk_all" type="checkbox" id="chk_all" onClick="ckall(this.checked)" value="chk_all"/></td>
                                                    <td class="row3" width="7%">ลำดับ&nbsp;</td>
                                                    <td class="row3" width="20%">รหัสถ่าน&nbsp;</td>
                                                    <td class="row3" width="15%">น้ำหนักบรรจุ(Kg)&nbsp;</td>
                                                    <td class="row3" width="15%">จำนวนกระสอบ&nbsp;</td>
                                                    <td class="row3" width="10%">Lot No.&nbsp;</td>
                                                    <td class="row3" width="30%">หมายเหตุ&nbsp;</td>
                                                </tr>

                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">

                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right">
                                        <b>น้ำหนักรวม*</b>&nbsp;:&nbsp;
                                        <input name='net_weight' type='text' class="inputs" id="net_weight" value='0' size='10' />
                                        &nbsp;(Kg)
                                        <input name='net_weight_chk' type='hidden' id="net_weight_chk" value='0' size='10' />

                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'>

                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="AddHeader()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="Delete()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" class="imgtransparent" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a></div>
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