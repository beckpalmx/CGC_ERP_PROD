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

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });

        </script>                        
        
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
                    }
                    else {
                        SURL = "../JSP/CS_035.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL)
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
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
                if (getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_035.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show035.jsp?doc_id=");
                    getId("chk_all").checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    //alert("test");
                    SURL = "../JSP/CS_035.jsp?status_d=3&ckbox=";

                    for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                    {
                        Deleteflag += (document.getElementsByName("ckbox")[i].checked) ? (i + 1).toString() + "," : "";
                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&username=" + getId("username").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show035.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show035.jsp?doc_id=")', 500);
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
                    getSave(URLsend('chkNull,doc_id,doc_date,doc_time,work_type,wh_in,wh_out,prd_emp_id,prd_emp_id_desc,wh_emp_id,wh_emp_id_desc,wh_sup_id,wh_sup_id_desc,username,complete_flag', '../JSP/CS_034.jsp'));
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                    getId("complete_flag").checked = false;
                    getId("complete_flag").value = "N";

                }
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if (r)
                {
                    getSave(URLsend('doc_id,doc_date,doc_time,work_type,wh_in,wh_out,prd_emp_id,prd_emp_id_desc,wh_emp_id,wh_emp_id_desc,wh_sup_id,wh_sup_id_desc,status_d,username', '../JSP/CS_034.jsp'));
                    cancelAction();
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                }
            }
            function Unload()
            {

                if (getId("doc_id").disabled == true && getId("status_cancle").value != "1") {
                    var r = confirm("คุณได้ทำการเปลี่ยนหน้าคุณต้องการบันทึกข้อมูลทั้งหมดใช่หรือไม่");
                    if (r == true) {
                        getSave(URLsend('chkNull,doc_id,doc_date,doc_time,work_type,wh_in,wh_out,prd_emp_id,prd_emp_id_desc,wh_emp_id,wh_emp_id_desc,wh_sup_id,wh_sup_id_desc', '../JSP/CS_034.jsp'));
                    }

                    else {
                        var SURL = "../JSP/CS_035.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL);
                    }
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
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_034");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S508");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
            %>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_id,doc_date,doc_time,work_type,wh_in,wh_out">
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
                            <b>ใบแจ้งการเบิกถ่านกัมมันต์ไปใช้ในการผลิต(CS_034)</b>
                        </div>                        
                        <div class="panel-footer">               
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><b>หมายเลขเอกสาร : <%=objs_p.getIso_no()%> </b></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%> </b></td>
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
                                    <td class="columnlabel1"><b>เลขที่เอกสาร*</b>&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' />
                                        &nbsp;<a href='#' onClick="javascript:openBrWindow('vd_carbon_withdraw_header&stadment=and+complete_flag+<>+\'Y\'+and+count_send_complete+=+\'0\'', 34, 'Search_Doc_id.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' data-toggle="tooltip" title="เอกสารที่ยังไม่ได้ส่งเข้าคลังสินค้า"></a>&nbsp;&nbsp;
                                        <a href='#' title="ค้นหาข้อมูลที่ทำเบิกที่กลับมาแก้ไข"  onClick="openBrWindow('vd_carbon_withdraw_header&stadment=and+complete_flag+<>+\'Y\'+and+count_send_complete+<>+\'0\'', 34, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาข้อมูลที่ทำเบิกที่กลับมาแก้ไข' name='IMAGE1' width='20' height='20' border='0' align='middle' data-toggle="tooltip" title="เอกสารที่คลังสินค้าส่งกลับมาเพื่อแก้ไข" ></a>
                                        วันที่เอกสาร*&nbsp;
                                        <input type='text' class="inputs" name='doc_date' size='10' value='' id="doc_date" readonly="readonly" />&nbsp;<a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>&nbsp;&nbsp;
                                        เวลา*&nbsp;
                                        <input name='doc_time' type='text' class="inputs" id="doc_time" value='' size='10' />                                
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ประเภทงาน&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='work_type' type='text' class="inputs" id="work_type" value='' size='10' />
                                        &nbsp;<a href='#' onClick="javascript:openBrWindow('mjob_type', 34, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;&nbsp;
                                        <!--input name='work_type' type='text' class="inputs" id="work_type" value='' size='10' /><a href='#' onClick="javascript:openBrWindow('mjob_type', 34, 'Search_Config2.jsp')">
                                        <img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a-->
                                    </td>
                                <input name='work_type_id' type='hidden' id="work_type_id" value='' size='10' />
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
                                    <td class="columnlabel1">หัวหน้าแผนกผลิต&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='prd_emp_id' type='text' class="inputs" id="prd_emp_id" value='' size='10' readonly="readonly" />
                                        &nbsp;<a href='#' onClick="javascript:openBrWindow('Vemployee', 34, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='prd_emp_id_desc' type='text' class="inputs" id="prd_emp_id_desc" value='' size='30' readonly="readonly" />
                                        &nbsp;&nbsp;                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">พนักงานคลังสินค้า&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='wh_emp_id' type='text' class="inputs" id="wh_emp_id" value='' size='10' readonly="readonly" />
                                        &nbsp;<a href='#'onclick="javascript:openBrWindow('Vemployee1', 34, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='wh_emp_id_desc' type='text' class="inputs" id="wh_emp_id_desc" value='' size='30' readonly="readonly" />
                                        &nbsp;&nbsp;                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">หัวหน้าแผนกคลังสินค้า&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='wh_sup_id' type='text' class="inputs" id="wh_sup_id" value='' size='10' readonly="readonly" />
                                        &nbsp;<a href='#'onclick="javascript:openBrWindow('Vemployee2', 34, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE5' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='wh_sup_id_desc' type='text' class="inputs" id="wh_sup_id_desc" value='' size='30' readonly="readonly" />
                                        &nbsp;&nbsp;                                </td>
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
                                                        <input type='button' class="cgcButton_4" name='but1' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,doc_date,status_a,work_type_id,work_type,username', 'CS_035.jsp'));"/>
                                                        <input type='button' class="cgcButton_3" name='but2' value='  ลบ  ' onclick='goDelChild()'/>                                                </td>
                                                </tr>
                                                <tr>
                                                    <td class="headergrid" colspan="17">ข้อมูลการเบิก</td>
                                                </tr>                                                  
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">        
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <tr>
                                                    <td class="row3" width="3%"><input type="checkbox" name="chk_all" id="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                    <td class="row3" width="7%">ลำดับ&nbsp;</td>
                                                    <td class="row3" width="15%">รหัสถ่าน</td>
                                                    <td class="row3" width="5%">ชนิดถ่าน&nbsp;</td>
                                                    <td class="row3" width="15%">ขนาดถ่าน&nbsp;</td>
                                                    <td class="row3" width="15%">เกรดไอโอดีน&nbsp;</td>
                                                    <td class="row3" width="10%">กระสอบ&nbsp;</td>
                                                    <td class="row3" width="10%">น้ำหนัก&nbsp;</td>
                                                    <td class="row3" width="10%">เครื่องผลิต&nbsp;</td>                                                    
                                                    <td class="row3" width="20%">ใบแจ้งผลิต&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>                                
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