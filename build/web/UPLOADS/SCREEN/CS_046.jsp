<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.DB.D_rawmatt_analyze_detailDAO"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
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


            function getStatus() {
                if (document.getElementById("radio1").checked) {
                    document.getElementById("approve_status").value = "N";
                } else if ((document.getElementById("radio2").checked)) {
                    document.getElementById("approve_status").value = "Y";
                    alert("ตรวจสอบเอกสารเรียบร้อยแล้ว " + document.getElementById("approve_status").value);
                }
            }
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
                        getId("radio1").disabled = false;
                        getId("radio2").disabled = false;
                    }
                    else {
                        SURL = "../JSP/CS_047.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL)
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                        getId("radio1").disabled = false;
                        getId("radio2").disabled = false;
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
                    SURL = "../JSP/CS_047.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show047.jsp?doc_id=");
                    AjaxRun_id("moisture_average", "../JSP/CS_046.jsp?status_cal=" + getId("doc_id").value);
                    getId("chk_all").checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_047.jsp?status_d=3&ckbox=";

                    for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                    {
                        if (document.getElementsByName("ckbox")[i].checked == true)
                            Deleteflag += (i + 1).toString() + ",";
                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                    //alert(Deleteflag);
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&username=" + getId("username").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show047.jsp?doc_id=");
                    AjaxRun_id("moisture_average", "../JSP/CS_046.jsp?status_cal=" + getId("doc_id").value);
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show047.jsp?doc_id=")', 100);
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
                    if (approve_status == '') {
                        approve_status = "N"
                    }
                    ;
                    getSave(URLsend('chkNull,doc_id,doc_date,car_no,c_type,sender_id,report_id,approve_id,approve_status,username,car_date_in,moisture_average', '../JSP/CS_046.jsp'));
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                }
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if (r)
                {
                    getSave(URLsend('doc_id,doc_date,car_no,c_type,sender_id,report_id,approve_id,approve_status,status_d,username', '../JSP/CS_046.jsp'))
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                }
            }
            function Unload()
            {

                if (getId("doc_id").disabled == true && getId("status_cancle").value != "1") {
                    var r = confirm("คุณได้ทำการเปลี่ยนหน้าคุณต้องการบันทึกข้อมูลทั้งหมดใช่หรือไม่");
                    if (r == true) {
                        getSave(URLsend('chkNull,doc_id,doc_date,car_no,c_type,sender_id,report_id,approve_id,approve_status,username', '../JSP/CS_046.jsp'));
                    }

                    else {
                        var SURL = "../JSP/CS_047.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL);
                    }
                    document.getElementById("approve_status").value = "N";
                    closepopup();
                }

            }
            function OpenBrown()
            {
                cancelAction();
                getId("show").innerHTML = "";
                openBrWindow('Vd_rawmatt_receive&stadment=and+complete_flag+=+\'N\'+and+lab_not_check+<>+\'Y\'+and+doc_type+=+\'N\'+and+check_doc_transfer IS NULL', 46, 'Search_Config2.jsp');
            }

            function Cal_Moise_Avg()
            {
                if (getId("doc_id").value == '') {
                    alert("เลือกเลขที่เอกสาร");
                } else {
                    AjaxRun_id("moisture_average", "../JSP/CS_046.jsp?status_cal=" + getId("doc_id").value);
                }
            }

        </script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <title>CGC ERP</title>
    </head>
    <body onUnload="Unload()">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_046");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S801");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
            %>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_id,doc_date,car_no,c_type,sender_id">
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
            <input type="hidden" id="approve_status" name="approve_status" value="">


            <div align="left">

                <div class="container">
                    <div class="panel panel-primary">
                        <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                            <b>ใบวิเคราะห์คุณภาพวัตถุดิบ(CS_046)</b>
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
                                    <td class="columnlabel1">สถานะการตรวจสอบ</td>
                                    <td class="columnobject">&nbsp;&nbsp;
                                        <input type="hidden" id="approve_status" >
                                        <input type="radio" name="radio" id="radio1" onClick="getStatus()" checked>
                                        ยังไม่ได้ตรวจสอบ 
                                        <input type="radio" name="radio" id="radio2" onClick="getStatus()">
                                        ตรวจสอบแล้ว
                                    </td>
                                </tr>                               
                                <tr>
                                    <td class="columnlabel1"><b>เลขที่ใบรับถ่าน*</b>&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' />
                                        &nbsp;<a href='#' onClick="OpenBrown()" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาเลขที่ใบชั้งถ่านจากใบรับวัตถุดิบ' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;
                                        &nbsp;<a href='#' onClick="openBrWindow('vd_rawmatt_analyze_header', 46, 'Search_Doc_id3.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาเลขที่ใบชั้งจากใบวิเคราะห์วัตถุดิบ' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;                                        
                                        <!--a href='#' onClick="openBrWindow('vd_rawmatt_analyze_header&stadment=and+complete_flag+<>+\'Y\'', 46, 'Search_Doc_id.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาเลขที่ใบชั้งจากใบวิเคราะห์วัตถุดิบ' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a-->
                                        วันที่วิเคราะห์ฯ*&nbsp;
                                        <input type='text' class="inputs" name='doc_date' id="doc_date" size='10' value='' />&nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>&nbsp;&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">เอกสารที่ส่งผลวิเคราะห์แล้ว&nbsp;
                                    </td>
                                    <td class="columnobject">
                                        &nbsp;<a href='#' onClick="openBrWindow('vd_rawmatt_analyze_header&stadment=and+complete_flag+=+\'Y\'+and+approve_status+=+\'Y\'', 46, 'Search_Doc_id.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาเลขที่ใบชั้งจากใบวิเคราะห์วัตถุดิบ' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;                                
                                    </td>
                                </tr>                             



                                <tr>
                                    <td class="columnlabel1">ทะเบียนรถ*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='car_no' type='text' class="inputs" id="car_no" value='' size='10' />
                                        &nbsp;&nbsp;&nbsp;
                                        ชนิดถ่าน*&nbsp;
                                        <input name='c_type' type='text' class="inputs" id="c_type" value='' size='10' />
                                        &nbsp;&nbsp;วันที่รถเข้า<input name="car_date_in" type='text' class="inputs" id="car_date_in" size="10">                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ผู้ส่ง&nbsp;
                                    </td>
                                    <td class="columnobject">
                                        <input name='sender_id' type='text' class="inputs" id="sender_id" value='' size='10' />
                                        <!--<a href='#' onClick="openBrWindow('Vemployee', 46, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาเลขที่ใบชั้งถ่านจากใบรับวัตถุดิบ' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>-->
                                        <input name='sender_id_desc' type='text' class="inputs" id="sender_id_desc" value='' size='50' />
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <div style="width:100%;">

                                            <table width="100%" align="center" border="5" cellpadding="0" cellspacing="1" class="inner" id="tbExp" >
                                                <tr>
                                                    <td colspan="4" class="h_multi"></td>
                                                    <td colspan="5" class="btn_multi">

                                                        <input type='button' class="cgcButton_4" name='but1' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,doc_date,status_a,username', 'CS_047.jsp'));"/>
                                                        <input type='button' class="cgcButton_3" name='but2' value='  ลบ  ' onClick="goDelChild()"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="headergrid" colspan="17">ผลการวิเคราะห์</td>
                                                </tr>                                                   
                                                <tr>
                                                    <td class="row3" width="3%"><input name="chk_all" type="checkbox" id="chk_all" onClick="ckall(this.checked)" value="chk_all"/></td>
                                                    <td class="row3" width="7%">ตัวอย่าง&nbsp;</td>
                                                    <td class="row3" width="10%">น้ำหนัก&nbsp;</td>
                                                    <td class="row3" width="10%">ความชื้น%&nbsp;</td>
                                                    <td class="row3" width="10%">ขี้เถ้า%&nbsp;</td>
                                                    <td class="row3" width="10%">ฝุ่น%&nbsp;</td>
                                                    <td class="row3" width="10%">การระเหย%&nbsp;</td>
                                                    <td class="row3" width="10%">สิ่งเจือปน%&nbsp;</td>
                                                    <td class="row3" width="30%" align="center">หมายเหตุ&nbsp;</td>
                                                </tr>


                                            </table>
                                        </div>
                                        <div style="width:100%; height: 350px; overflow: auto;" id="show">

                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="columnlabel1">ความชื้นเฉลี่ย&nbsp;
                                    </td>
                                    <td class="columnobject">
                                        <input name='moisture_average' type='text' class="inputs" id="moisture_average" value='' size='10' readonly="true"/>   
                                        &nbsp;%&nbsp;
                                        <input type='button' class="cgcButton_11" name='but_moisture_average' value='คำนวณความชื้นเฉลี่ย' onClick="Cal_Moise_Avg()"/>
                                    </td>
                                </tr>

                                <input name='moisture_average' type='hidden' class="inputs" id="moisture_average" value='' size='10' readonly="true"/>   

                                <tr>
                                    <td class="columnlabel1">ผู้รายงาน&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='report_id' type='text' class="inputs" id="report_id" value='' size='10' />
                                        <a href='#' onClick="openBrWindow('Vemployee1&stadment=and+status+=+\'Y\'and+dept_id+=+\'06\'', 46, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาเลขที่ใบชั้งถ่านจากใบรับวัตถุดิบ' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        <input name='report_id_desc' type='text' class="inputs" id="report_id_desc" value='' size='15' />
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        ผู้ตรวจ&nbsp;
                                        <input name='approve_id' type='text' class="inputs" id="approve_id" value='' size='10' />
                                        <a href='#' onClick="openBrWindow('Vemployee2', 46, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาเลขที่ใบชั้งถ่านจากใบรับวัตถุดิบ' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        <input name='approve_id_desc' type='text' class="inputs" id="approve_id_desc" value='' size='15' />
                                    </td>
                                </tr>

                                <tr>
                                    <td class="columnlabel1"></td>
                                    <td class="columnobject">

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