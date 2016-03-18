<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <title>ERP</title>
        <script type="text/javascript">
            function Chknull() {
                if (document.getElementById('doc_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else
                    document.report.submit();
            }

            function goGenDoc_id(doc_date_val)
            {
                if (document.getElementById('doc_date').value == '' || document.getElementById('doc_time').value == '') {
                    alert('กรุณาใส่ข้อมูลวันที่เอกสารและเวลา');
                }
                else {
                    getId("doc_id").value = doc_date_val.substring(8, 10) + doc_date_val.substring(3, 5) + doc_date_val.substring(0, 2);
                }
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
                    if (getId("status_cancle").value == "1" && getId("child_ck").value == "")
                    {
                        cancelAction();
                        getId("show").innerHTML = "";
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("doc_id").disabled = false;
                    }
                    else if (getId("status_cancle").value == "1" && getId("child_ck").value == "1")
                    {
                        alert("มีการเปลี่ยนแปลงข้อมูลกรุณาบันทึกข้อมูล");
                    }
                    else {
                        SURL = "../JSP/CS_058.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL)
                        cancelAction();
                        getId("show").innerHTML = "";
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
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
                    SURL = "../JSP/CS_058.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show058.jsp?doc_id=");
                    getId("chk_all").checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_058.jsp?status_d=3&ckbox=";
                    for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                    {
                        Deleteflag += (document.getElementsByName("ckbox")[i].checked) ? (i + 1).toString() + "," : "";
                    }

                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&username=" + getId("username").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show058.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show058.jsp?doc_id=")', 100);
                }
            }
            function OpenEdit(URLSend)
            {
                window.open(URLSend[0]);
            }
            function AddHeader()
            {
                if (getId('doc_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else {
                    var r = confirm("คุณต้องการบันทึกหรือไม่")
                    if (r)
                    {
                        getSave(URLsend('complete_flag,chkNull,doc_id,doc_date,date_ck,status_cancle,child_ck,doc_time,wh_in,wh_out,runner_id,p_type,remark,username,rawmat_emp,rawmat_emp_name', '../JSP/CS_057.jsp'));
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                        setTimeout('getId("child_ck").value = "";getId("date_ck").value= ""', 1000);
                    }
                }
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if (r)
                {
                    getSave(URLsend('complete_flag,doc_id,doc_date,status_cancle,date_ck,child_ck,doc_time,wh_in,wh_out,runner_id,runner_id_desc,p_type,remark,status_d,username,rawmat_emp,rawmat_emp_name', '../JSP/CS_057.jsp'))
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                    setTimeout('getId("child_ck").value = "";getId("date_ck").value= ""', 1000);
                }
            }
            function Unload()
            {

                if (getId("doc_id").disabled == true && getId("status_cancle").value != "1") {
                    var r = confirm("คุณได้ทำการเปลี่ยนหน้าคุณต้องการบันทึกข้อมูลทั้งหมดใช่หรือไม่");
                    if (r == true) {
                        getSave(URLsend('chkNull,doc_id,doc_date,status_cancle,doc_time,wh_in,wh_out,runner_id,runner_id_desc,p_type,p_type_desc,remark,username,rawmat_emp,rawmat_emp_name', '../JSP/CS_057.jsp'));
                    }
                    else {
                        var SURL = "../JSP/CS_058.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL);
                    }
                }
                closepopup();
            }

            function OpenDoc_id(input)
            {
                switch (input) {
                    case 1:
                        openBrWindow('vd_rawmatt_bigbag_withdraw_header&stadment=and+complete_flag+=+\'N\'', 23, 'Search_Doc_id.jsp');
                        break;
                    case 2:
                        openBrWindow('vd_rawmatt_bigbag_withdraw_header&stadment=and+complete_flag+=+\'Y\'', 23, 'Search_Doc_id.jsp');
                        break;
                    default:
                        break;
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

            function Runing_Doc_id() {
                if (document.getElementById('doc_date').value == '') {
                    alert('กรุณาใส่วันที่เอกสาร');
                } else
                    AjaxRun_id("doc_id", "../JSP/CS_057.jsp?runer_id=" + getId("doc_date").value);
            }

        </script>           
    </head>

    <body onUnload="Unload()" >
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">

            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_057");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S515");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
            %>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_id,doc_date,doc_time,runner_id,p_type">
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

            <div align="left">

                <div class="container">
                    <div class="panel panel-primary">
                        <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                            <b>บันทึกการเบิกวัตถุดิบถุงใหญ่(CS_057)</b>
                        </div>                        
                        <div class="panel-footer">   

                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><strong>หมายเลขเอกสาร :<%=objs_p.getIso_no()%> </strong></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><strong>วันที่มีผลบังคับใช้ :<%=objs_p.getEffective_date()%></strong></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1"><b>เอกสารสมบูรณ์</b>&nbsp;</td>
                                    <td class="columnobject"><input name="complete_flag" type="checkbox" id="complete_flag" value="N" onClick="Checkvalue(this.checked)"></td>
                                </tr>             
                                <tr>       
                                    <td class="columnlabel1"><b>เลขที่เอกสารอัตโนมัติ</b>&nbsp;</td>
                                    <td class="columnobject">
                                        <input name="runner" id="runner" class="cgcButton_9" type="button" value="กดสร้างเลขที่เอกสาร" onclick="Runing_Doc_id();">
                                    </td>
                                </tr>                                   
                                <tr>
                                    <td class="columnlabel1"><strong>เลขที่เอกสาร*</strong>&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' readonly="true" />
                                        &nbsp;<a href='#' onClick="OpenDoc_id(1)" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;วันที่เอกสาร*&nbsp;
                                        <input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' readonly="readonly" />
                                        &nbsp;<a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>
                                        &nbsp;&nbsp;เวลา*&nbsp;
                                        <input name='doc_time' type='text' class="inputs" id="doc_time" value='' size='10' maxlength="5" onKeyUp="IsNumeric(this.value, this)"/>
                                        <!--input type='button' class="cgcButton_8" name='btn1' value='เลขที่เอกสาร' onClick="javascript:goGenDoc_id((doc_date).value);"/-->                                                    
                                    </td>
                                </tr>                           

                                <tr>
                                    <td class="columnlabel1"><b>เอกสารที่อนุมัติแล้ว</b></td>
                                    <td class="columnobject">&nbsp;<a href='#' onClick="OpenDoc_id(2)" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE2' width='20' height='20' border='0' align='middle' ></a>                                                                        
                                    </td>
                                </tr>

                                <tr>
                                    <td class="columnlabel1">คลังจ่าย&nbsp;</td>
                                    <td class="columnobject">
                                        <input type="hidden" size="10" id="wh_in" name="wh_in" value="<%=objs_p.getWarehouse_begin_id()%>" ><input type='text' class="inputs" size="20"  id="wh_in_desc" name="wh_in_desc" value="<%=objs_p.getWarehouse_begin_name()%>">
                                        <a href='#' onClick="openBrWindow('Wh_bg&stadment=and+wh_type+=+\'R\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;&nbsp;&nbsp;คลังรับ&nbsp;
                                        <input type="hidden" size="10"  id="wh_out" name="wh_out" value="<%=objs_p.getWarehouse_end_id()%>"><input type='text' class="inputs"  size="20"  id="wh_out_desc" name="wh_out_desc" value="<%=objs_p.getWarehouse_end_name()%>">
                                        <a href='#' onClick="openBrWindow('Wh_en&stadment=', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">พนักงานคลัง </td>
                                    <td class="columnobject">
                                        <input type='text' class="inputs" id="rawmat_emp"" name='rawmat_emp' size='10' value='' readonly="readonly"/>&nbsp;&nbsp;
                                        <!--a href='#' onClick="javascript:openBrWindow('Vemployee&stadment=and+emp_id+between+\'0001\'+and+\'0008\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class="inputs" name='runner_id_desc' id="runner_id_desc" size='30' value='' readonly="readonly"/-->
                                        <a href='#' onClick="javascript:openBrWindow('Vemployee1&stadment=and+dept_id+=+\'09\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class="inputs" name='runner_id_desc' id="rawmat_emp_name" size='30' value='' readonly="readonly"/>
                                    </td>
                                </tr>                            
                                <tr>
                                    <td class="columnlabel1">ผู้เบิก </td>
                                    <td class="columnobject">
                                        <input type='text' class="inputs" id="runner_id" name='runner_id' size='10' value='' readonly="readonly"/>&nbsp;&nbsp;
                                        <!--a href='#' onClick="javascript:openBrWindow('Vemployee&stadment=and+emp_id+between+\'0001\'+and+\'0008\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class="inputs" name='runner_id_desc' id="runner_id_desc" size='30' value='' readonly="readonly"/-->
                                        <a href='#' onClick="javascript:openBrWindow('Vemployee&stadment=and+dept_id+=+\'10\'or+dept_id+=+\'09\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class="inputs" name='runner_id_desc' id="runner_id_desc" size='30' value='' readonly="readonly"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ประเภท&nbsp;</td>


                                    <td class="columnobject">
                                        <select class='select_cgc' name="p_type" id="p_type">
                                            <option value="CF" selected>ถ่านกะลาถุงใหญ่</option>
                                            <option value="PA">ปาล์มดิบถุงใหญ่</option>
                                            <option value="PF">ถ่านปาล์มถุงใหญ่</option>
                                            <option value="UF">ถ่านไม้ยูคาฯถุงใหญ่</option>
                                            <option value="BF">ถ่านไม้ไผ่</option>
                                            <option value="KF">ถ่านไม้โกงกาง</option>
                                        </select>
                                        <!--<input name='p_type' type='text' class="inputs" id="p_type" value='' size='10' readonly="readonly" />
                                        &nbsp;&nbsp;<a href='#' onClick="javascript:openBrWindow('Mproduct_type', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='p_type_desc' type='text' class="inputs" id="p_type_desc" value='' size='30' readonly="readonly" />-->
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">หมายเหตุ </td>
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
                                                    <td colspan="3" class="h_multi">ข้อมูลการเบิก</td>
                                                    <td colspan="4" class="btn_multi">
                                                        <input type='button' class="cgcButton_4" name='but1' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,wh_in,wh_out,wh_in_desc,wh_out_desc,username,status_a', 'CS_058.jsp'));"/>
                                                        <input type='button' class="cgcButton_3" name='but2' value='   ลบ  ' onclick='javascript:goDelChild();'/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <tr>
                                                    <td class="row3" width="3px"><input type="checkbox" id="chk_all" name="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                    <td class="row3" width="7%">ลำดับที่</td>
                                                    <td class="row3" width="15%">ถ่าน</td>
                                                    <td class="row3" width="15%">จ่ายจาก โกดัง/คลัง</td>
                                                    <td class="row3" width="15%">รับเข้า โกดัง/คลัง</td>
                                                    <td class="row3" width="15%">เลขกอง</td>
                                                    <td class="row3" width="15%">เลขที่กระสอบ/ถุง&nbsp;</td>
                                                    <td class="row3" width="15%">น้ำหนัก(Kg)</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'>
                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_CANCEL_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="AddHeader()"><img alt="" class="imgtransparent"  src="../IMAGES/BTN_SAVE_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="Delete()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_DEL_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                            <a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" class="imgtransparent" src="../IMAGES/BTN_PRINT_90.png" class="imgtransparent" width="80" height="30" border="0"></a></div>
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
