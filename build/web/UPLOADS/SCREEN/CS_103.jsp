<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>

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
            <%!    String path, lookup, doc_eff_date, doc_no;
            %>
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
                        SURL = "../JSP/CS_108.jsp?status_d=3&chk_all=1";
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
                    SURL = "../JSP/CS_108.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    //alert(SURL);
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show108.jsp?doc_id=");
                    getId("chk_all").checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_108.jsp?status_d=3&ckbox=";

                    for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                    {
                        if (document.getElementsByName("ckbox")[i].checked === true) {
                            Deleteflag += (i + 1).toString() + ",";
                        }

                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&username=" + getId("username").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show108.jsp?doc_id=");
                    for (var i = 0; i <= 3; i++) {
                        setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show108.jsp?doc_id=")', 100);
                    }
                }
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
                    getSave(URLsend('chkNull,doc_id,doc_date,doc_time,prd_emp_id,sending_id,remark,username,complete_flag', '../JSP/CS_103.jsp'));
                    getId("complete_flag").value = "N";
                    getId("complete_flag").checked = false;
                    getId("show").innerHTML = "";
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("doc_id").disabled = false;
                }
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่");
                if (r)
                {
                    getSave(URLsend('doc_id,doc_date,doc_time,prd_emp_id,sending_id,remark,status_d,username,complete_flag', '../JSP/CS_103.jsp'));
                    getId("show").innerHTML = "";
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("doc_id").disabled = false;
                }
            }
            function Unload()
            {

                if (getId("doc_id").disabled === true && getId("status_cancle").value !== "1") {
                    var r = confirm("คุณได้ทำการเปลี่ยนหน้าคุณต้องการบันทึกข้อมูลทั้งหมดใช่หรือไม่");
                    if (r === true) {
                        getSave(URLsend('chkNull,doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,wh_in,wh_out,loc_total,loc_1,s_bag_loc1,q_bag_loc1,w_bag_loc1,loc_1_desc,loc_2,s_bag_loc2,q_bag_loc2,w_bag_loc2,loc_2_desc,loc_3,s_bag_loc3,q_bag_loc3,w_bag_loc3,loc_3_desc,c_weight1,c_weight2,c_weight3,c_weight4,c_weight5,p_weight1,p_weight2,p_weight3,p_weight4,p_weight5,u_weight1,u_weight2,u_weight3,u_weight4,u_weight5,remark,child_ck,status_cancle', '../JSP/CS_025.jsp'));
                    }
                    else {
                        var SURL = "../JSP/CS_024.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL);
                    }
                }
                closepopup();
            }
            function OpenDoc_id()
            {

                if (getId("child_ck").value === "1" && getId("doc_id").disabled === true && getId("status_cancle").value === "1") {
                    alert("มีการเปลี่ยนแปลงข้อมูลกรุณาบันทึกข้อมูล");
                }
                else if (getId("child_ck").value === "1" && getId("doc_id").disabled === true && getId("status_cancle").value === "") {
                    alert("ถ้าต้องการเลือกข้อมูลอื่นกรุณาบันทึกข้อมูลหรือยกเลิกข้อมูล");
                }
                else {
                    openBrWindow('vd_carbon_friction_receive_header&stadment=and+complete_flag+<>+\'Y\'', 25, 'Search_Doc_id.jsp');
                }
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
            function Chknull()
            {
                if (document.getElementById('doc_id').value === '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else
                    document.report.submit();
            }
        </script>
    </head>
    <body onUnload="closepopup()">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">   
            <%
                UtiDatabase objuti = new UtiDatabase();
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_103");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S513");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report                    
            %>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_id,doc_date,doc_time,prd_emp_id,sending_id">
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
                            <b>ใบแจ้งคืนถ่านกัมมันต์ที่เหลือจากการผลิตเข้าคลังสินค้า(CS_103)</b>
                        </div>                        
                        <div class="panel-footer">                      

                            <div align="center">            
                                <table width="94%"  cellpadding="0" cellspacing="0" >
                                    <tr>
                                        <td colspan="2" align="right"><b>หมายเลขเอกสาร :<%=objs_p.getIso_no()%></b></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%></b></td>
                                    </tr>
                                    <!--tr>
                                        <td class="columnlabel1">เอกสารสมบูรณ์&nbsp;</td>
                                        <td class="columnobject"><input name="complete_flag" type="checkbox" id="complete_flag" value="N" onClick="Checkvalue(this.checked)">
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
                                        <td width="156" align=""
                                            class="columnlabel1"><b>เลขที่เอกสาร*</b>&nbsp;</td>
                                        <td width="600" class="columnobject"><input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' />
                                            &nbsp;<a href='javascript:;' onClick="openBrWindow('vd_carbon_return_header&stadment=and+complete_flag+<>+\'Y\'+and+count_send_complete+=+\'0\'', 103, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                            <a href='#' title="ค้นหาข้อมูลที่ทำเบิกที่กลับมาแก้ไข"  onClick="openBrWindow('vd_carbon_return_header&stadment=and+complete_flag+<>+\'Y\'+and+count_send_complete+<>+\'0\'', 103, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาข้อมูลที่ทำเบิกที่กลับมาแก้ไข' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                            วันที่เอกสาร*&nbsp;
                                            <input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' readonly/>
                                            &nbsp;<a href="javascript:;" id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                            <script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>
                                            &nbsp;&nbsp;
                                            เวลา*&nbsp;
                                            <input name='doc_time' type='text' class="inputs" id="doc_time" value='' size='10' />                                </td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel1">แผนก*&nbsp;</td>
                                        <td class="columnobject"><input name='prd_emp_id' type='text' class="inputs" id="prd_emp_id" value='' size='10' readonly/>
                                            &nbsp;<a href='javascript:;' onClick="openBrWindow('mdepartment', 103, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                            <input name='prd_emp_id_desc' type='text' class="inputs" id="prd_emp_id_desc" value='' size='30' readonly/>
                                            &nbsp;&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel1">หมายเหตุ&nbsp;</td>
                                        <td class="columnobject"><label>
                                                <textarea class="text_inputs" name="remark" id="remark" cols="45" rows="5"></textarea>
                                            </label></td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='btn_multi'>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td height="208" colspan="2" align="center"><div style="width:100%;">
                                                <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                    <tr>
                                                        <td colspan="6" class="h_multi"></td>
                                                        <td colspan="9" class="btn_multi">
                                                            <input type='button' class="cgcButton_4" name='but1' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,status_a,username', 'CS_108.jsp'));"/>
                                                            <input type='button' class="cgcButton_3" name='but2' value='   ลบ  ' onclick='javascript:goDelChild();'/>                                                </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="headergrid" colspan="17">ข้อมูลการคืนถ่านกัมมันต์</td>
                                                    </tr>                                                  

                                                    <tr>
                                                        <td width="3%" rowspan="2" valign="middle" class="row3"><div align="center">
                                                                <input type="checkbox" name="chk_all" id="chk_all" onClick="ckall(this.checked);">
                                                            </div></td>
                                                        <td width="7%" rowspan="2" valign="middle" class="row3"><div align="center">No.</div></td>
                                                        <td width="7%" rowspan="2" valign="middle" class="row3"><div align="center">ขนาด</div></td>
                                                        <td valign="middle" class="row3"><div align="center">
                                                                <DIV align="center">ชนิดของถ่าน</DIV>
                                                            </div></td>
                                                        <td width="7%" rowspan="2" valign="middle" class="row3"><div align="center">
                                                                <DIV align="center">ไอโอดีน</DIV>
                                                            </div></td>
                                                        <td width="13%" rowspan="2" valign="middle" class="row3"><div align="center">
                                                                <DIV align="center">รหัสครบพาเลท<BR>
                                                                    / ครบถุง</DIV>
                                                            </div></td>
                                                        <td width="5%" rowspan="2" valign="middle" class="row3"><div align="center">
                                                                <DIV align="center">เลขที่</DIV>
                                                            </div></td>
                                                        <td width="5%" rowspan="2" valign="middle" class="row3"><div align="center">
                                                                <DIV align="center">เครื่อง<BR>
                                                                    ผลิต</DIV>
                                                            </div></td>
                                                        <td width="6%" rowspan="2" valign="middle" class="row3"><div align="center">
                                                                <DIV align="center">ขนาด<BR>
                                                                    บรรจุ</DIV>
                                                            </div></td>
                                                        <td colspan="3" valign="middle" class="row3"><div align="center">
                                                                <DIV align="center">จำนวนคืน</DIV>
                                                            </div>
                                                            <div align="center"></div>
                                                            <div align="center"></div></td>
                                                        <td width="11%" rowspan="2" valign="middle" class="row3"><div align="center">
                                                                <DIV align="center">สาเหตุการคืน</DIV>
                                                            </div></td>
                                                        <td width="8%" rowspan="2" valign="middle" class="row3"><div align="center">
                                                                <DIV align="center">หมายเหตุ</DIV>
                                                            </div></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="11%" valign="middle" class="row3"><DIV align="center">CF/PF/UF/ อื่นๆ</DIV></td>
                                                        <td width="5%" valign="middle" class="row3"><DIV align="center">กส/ถุง</DIV></td>
                                                        <td width="6%" valign="middle" class="row3"><DIV align="center">น.น<BR>
                                                                ถุงเศษ</DIV></td>
                                                        <td width="6%" valign="middle" class="row3"><DIV align="center">น.น<BR>
                                                                สุทธิ</DIV></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div style="width:100%; height: 150px; overflow: auto;" id="show"> </div></td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center"><div align="right"><span class="columnobject">ผู้นำส่ง*
                                                    <input name='sending_id' type='text' class="inputs" id="sending_id" value='' size='10' readonly/>
                                                    &nbsp;<a href='javascript:;' onClick="openBrWindow('Vemployee1', 103, 'Search_Config2.jsp')" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                                    <input name='sending_id_desc' type='text' class="inputs" id="sending_id_desc" value='' size='30' readonly/>
                                                    &nbsp;&nbsp;</span></div></td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'>
                                            <br>
                                            <div align="center">
                                                <a href="javascript:;" onClick="cancle()"><img alt="ล้างหน้าจอ" class="imgtransparent" src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;" onClick="AddHeader()"><img alt="บันทึก/แก้ไข" class="imgtransparent" src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;" onClick="Delete()"><img alt="ลบ" class="imgtransparent" src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>                                                       
                                                <a href="javascript:;" onclick="Chknull()"><img alt="พิมพ์เอกสาร" class="imgtransparent" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a>
                                            </div>
                                            <br>                                
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
