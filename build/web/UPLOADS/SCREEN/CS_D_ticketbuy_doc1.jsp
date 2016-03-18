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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>               
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
                        SURL = "../JSP/CS_D_ticketbuy_doc.jsp?status_d=3&chk_all=1";
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
                    SURL = "../JSP/CS_D_ticketbuy_doc.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show117.jsp?doc_id=");
                    getId("chk_all").checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    //alert("test");
                    SURL = "../JSP/CS_D_ticketbuy_doc.jsp?status_d=3&ckbox=";

                    for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                    {
                        Deleteflag += (document.getElementsByName("ckbox")[i].checked) ? (i + 1).toString() + "," : "";
                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&username=" + getId("username").value;
                    //alert(SURL);
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show117.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show117.jsp?doc_id=")', 500);
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
                    getSave(URLsend('complete_flag,chkNull,doc_id,doc_date,doc_type,doc_time,remark,username', '../JSP/CS_D_ticketbuy_doc.jsp'));
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                    getId("runner").disabled = false;
                }
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if (r)
                {
                    getSave(URLsend('complete_flag,doc_id,doc_date,doc_type,doc_time,remark,username,status_d', '../JSP/CS_D_ticketbuy_doc.jsp'));
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
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
        <!--link href="../CSS/MENU.css" rel="stylesheet" type="text/css"-->
        <!--link href="../CSS/BT.css" rel="stylesheet" type="text/css"-->
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
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_D_ticketbuy_doc");
                // _______________________________________________________________report

                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S518");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();

                 //_______________________________________________________________report
%>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_id,doc_date,doc_time,doc_type">
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
            <input type="hidden" id="doc_type" name="doc_type" value="R">
            <input type="hidden" id="remark" name="remark" value="-">
            <input type="hidden" id="cred_code" name="cred_code" value="000380"> <!-- C.Gigantic Carbon -->

            <div align="left">

                <div class="container">
                    <div class="panel panel-primary">
                        <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                            <b>บันทึกรับไม้ฟืน(CS_D_ticketbuy_doc)</b>
                        </div>                        
                        <div class="panel-footer">     


                            <div class="row">
                                <div class="col-md-4">
                                    <label class="control-label col-md-1 columnlabel1">เลขที่เอกสาร&nbsp;:&nbsp;</label>
                                    <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' readonly="readonly"/>
                                    <a href='#' onClick="javascript:openBrWindow('vd_ticketbuy_doc_not_cgc&stadment=and+complete_flag+<>+\'Y\'and+rec_count+<>+0', 115, 'Search_Doc_id.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                </div>

                                <div class="col-md-4">
                                    <label class="columnlabel1">วันที่เอกสาร*&nbsp;</label>
                                    <input type='text' class="inputs" name='doc_date' size='10' value='' id="doc_date" readonly="readonly" />
                                    <a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                    <script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>
                                </div>
                                <div class="col-md-4">
                                    <label class="columnlabel1">เวลา*&nbsp;</label><input name='doc_time' type='text' class="inputs" id="doc_time" value='' size='10' />                                        
                                </div>
                            </div>           
                            
                            <div class="row">
                                <div class="col-md-4">
                                    <label class="control-label col-md-1 columnlabel1">เอกสารที่อนุมัติแล้ว&nbsp;:&nbsp;</label>
                                    <!--input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' readonly="readonly"/-->
                                    <a href='#' onClick="javascript:openBrWindow('vd_ticketbuy_doc_not_cgc&stadment=and+complete_flag+=+\'Y\'and+rec_count+<>+0', 115, 'Search_Doc_id.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                </div>                            
                            </div>
                            

                            <br>

                            <div class="table-responsive">
                                <table class="table table-condensed table-striped table-bordered table-hover no-margin">
                                    <thead>
                                        <tr>
                                            <th style="width:5%">
                                                <input type="checkbox" class="no-margin" name="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);">
                                            </th>
                                            <th style="width:10%">เลขที่ใบชั่ง</th>
                                            <th style="width:7%" class="hidden-phone">ทะเบียนรถ</th>
                                            <th style="width:15%" class="hidden-phone">ชื่อผู้ขาย</th>
                                            <th style="width:15%" class="hidden-phone">ประเภท</th>
                                            <th style="width:15%" class="hidden-phone">น้ำหนัก</th>
                                            <th style="width:10%" class="hidden-phone">ราคาต่อหน่วย</th>
                                            <th style="width:15%" class="hidden-phone">รวมราคา</th>
                                        </tr>
                                    </thead>                                   
                                    
                                    <tbody>
                                        <tr>
                                            <div style="width:100%; height: 300px; overflow: auto;" id="show"></div>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </body>
</html>