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
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script type="text/javascript">
            function Chknull(){
                if(document.getElementById('doc_id').value == ''){
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                }else document.report.submit();
            }
            function goAddChild(URLSend)
            {
                var arryChk = new Array;
                arryChk[0] = "chkNull"
                if(ChkParameter(arryChk))
                {
                    window.open(URLSend[0]);
                }

            }
            function cancle()
            {

                var SURL;
                var r = confirm("คุณต้องการยกเลิกข้อมูลทั้งหมดหรือไม่")
                if(r)
                {
                    if(getId("status_cancle").value == "1")
                    {
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                        setTimeout('getId("total_weight").value = "0";getId("total_weight_chk").value = "0";getId("lost_weight").value = "0";getId("lost_weight_chk").value = "0";',1000);
                        getId("document_confirm_flag").value = "N";getId("document_confirm_flag").checked = false;
                    }

                    else{
                        SURL = "../JSP/CS_030.jsp?status_d=3&chk_all=1&username="+getId("username").value;
                        SURL = SURL+"&doc_id="+getId("doc_id").value;
                        Delete_Line_no(SURL)
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                        setTimeout('getId("total_weight").value = "0";getId("total_weight_chk").value = "0";getId("lost_weight").value = "0";getId("lost_weight_chk").value = "0";',1000);
                        getId("document_confirm_flag").value = "N";getId("document_confirm_flag").checked = false;
                    }
                }

            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }
            function goDelChild()
            {
                var Deleteflag ="";
                var SURL;
                //alert(getId("chk_all").checked);
                if(getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_030.jsp?status_d=3&chk_all=1&username="+getId("username").value;
                    SURL = SURL+"&doc_id="+getId("doc_id").value;
                    //alert(SURL);
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show030.jsp?doc_id=");
                    getId("chk_all").checked =false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_301.jsp?status_d=3&ckbox=";
                    for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                    {
                        if(document.getElementsByName("ckbox")[i].checked ==true){
                            //alert(document.getElementsByName("ckbox")(i).value);
                            Deleteflag += document.getElementsByName("ckbox")[i].value+",";
                        }

                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length -1);
                    SURL = SURL+Deleteflag+"&doc_id="+getId("doc_id").value+"&username="+getId("username").value;
                    //alert(SURL);
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show301.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show301.jsp?doc_id=")', 500);
                }
            }
            function OpenEdit(URLSend)
            {
                window.open(URLSend[0]);
            }
            function AddHeader()
            {
                var r = confirm("คุณต้องการบันทึกหรือไม่")
                if(r)
                {
                    getSave(URLsend('chkNull,doc_id,doc_date,work_date,time_from,time_to,runner_id,shift,wh_in,wh_out,burn_no,product_id,ch_from,ch_to,weight_split,burn_out_date,lost_weight,total_weight,username,report_id,return_complete_flag,document_confirm_flag','../JSP/CS_300.jsp'));
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                    getId("return_complete_flag").disabled = false;
                    getId("return_complete_flag").value = "N";
                    setTimeout('getId("total_weight").value = "0";getId("total_weight_chk").value = "0";getId("lost_weight").value = "0";getId("lost_weight_chk").value = "0";',1000);
                    getId("document_confirm_flag").value = "N";getId("document_confirm_flag").checked = false;
                }
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if(r)
                {
                    getSave(URLsend('doc_id,doc_date,work_date,time_from,time_to,runner_id,shift,wh_in,wh_out,burn_no,product_id,ch_from,ch_to,weight_split,burn_out_date,lost_weight,total_weight,status_d,username,return_complete_flag','../JSP/CS_300.jsp'))
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                    setTimeout('getId("total_weight").value = "0";getId("total_weight_chk").value = "0";getId("lost_weight").value = "0";getId("lost_weight_chk").value = "0";',1000);
                }
            }
            function Unload()
            {

                if(getId("doc_id").disabled == true && getId("status_cancle").value != "1" && getId("total_weight_chk").value == "" ){
                    var r = confirm("คุณได้ทำการเปลี่ยนหน้าคุณต้องการบันทึกข้อมูลทั้งหมดใช่หรือไม่");
                    if(r == true){
                        getSave(URLsend('chkNull,doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,burn_no,wh_in,wh_out,total_weight','../JSP/CS_029.jsp'));
                    }

                    else{
                        var SURL = "../JSP/CS_030.jsp?status_d=3&chk_all=1";
                        SURL = SURL+"&doc_id="+getId("doc_id").value;
                        Delete_Line_no(SURL);
                    }
                }
                else if(getId("doc_id").disabled == true && getId("status_cancle").value == "1" && getId("total_weight_chk").value != getId("total_weight").value ){
                    getSave(URLsend('chkNull,doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,burn_no,wh_in,wh_out,total_weight','../JSP/CS_029.jsp'));
                }
            }
            function Checkvalue(thisvalue){
                if(thisvalue){
                    getId("return_complete_flag").value = "Y";
                    alert("ทำการส่งเอกสารกลับเพื่อทำการแก้ไขข้อมูล");
                }else{
                    getId("return_complete_flag").value = "N"
                    //alert("เอกสารนี้สมบูรณ์เรียบร้อยแล้ว");
                }
                //alert(getId("return_complete_flag").value);
            }
            function Checkvalue_document_confirm(objthis){
                if(objthis.checked){
                    alert("ยืนยันการแก้ไขเอกสาร");
                    objthis.value = "Y";
                }else{
                    objthis.value = "N";
                }
                //alert(objthis.value);
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
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
            <table  cellpadding="0"  cellspacing="0">
                <tr >
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รับถ่านออกจากเตาเขาคลังสินค้า(CS_300)&nbsp;</td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <div align="left">
                            <table   cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><b>หมายเลขเอกสาร : <%=objs_p.getIso_no()%> </b></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%> </b></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ส่งเอกสารกลับเพื่อแก้ไขข้อมูล</td>
                                    <td class="columnobject">
                                        <input id="return_complete_flag" type="checkbox" onclick="Checkvalue(this.checked)" value="N" name="return_complete_flag">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="150" class="columnlabel"><b>เลขที่เอกสารที่อนุมัติเรียบร้อยแล้ว</b>&nbsp;</td>
                                    <td width="607" class="columnobject">
                                        <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' readonly/> 
                                        &nbsp;
                                        <a href='#' onClick="openBrWindow('vd_carbon_burn_out_header_wh&stadment=and+complete_flag+=+\'Y\'', 300, 'Search_Doc_id.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        วันที่เอกสาร*&nbsp;
                                        <input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' readonly="readonly"/><!--
                                &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>-->&nbsp;&nbsp;	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">วันที่ทำงาน&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='work_date' type='text' class="inputs" id="work_date" value='' size='10' readonly="readonly"/><!--
                                      &nbsp;<a id='date_2' ><img name='IMAGE3' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'work_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_2',singleClick:true,step:1});</script>-->&nbsp;&nbsp;&nbsp;
                                        เวลา&nbsp;
                                        <input name='time_from' type='text' class="inputs" id="time_from" value='' size='10' maxlength="5" readonly />
                                        &nbsp;&nbsp;
                                        ถึง&nbsp;&nbsp;
                                        <input name='time_to' type='text' class="inputs" id="time_to" value='' size='10' maxlength="5" readonly/>	            </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ผู้บันทึก&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='runner_id' type='text' class="inputs" id="runner_id" value='' size='10' readonly="readonly" /><!--
                                        &nbsp;&nbsp;&nbsp;<a href='#' onClick="openBrWindow('Vemployee&stadment=and+dept_id+=+\'002\'', 29, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;--><input name='runner_id_desc' type='text' class="inputs" id="runner_id_desc" value='' size='30' readonly="readonly"/>	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ช่วงเวลาทำงาน(กะ)&nbsp;</td>
                                    <td class="columnobject"><select name='shift' id="shift" disabled>
                                            <option value='1'>เช้า</option><option value='2'>บ่าย</option><option value='3'>ดึก</option></select>&nbsp;&nbsp;	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">คลังจ่าย&nbsp;</td>
                                    <td class="columnobject">
                                        <input type="hidden" size="10" id="wh_in" name="wh_in" value="<%=objs_p.getWarehouse_begin_id()%>" ><input type='text' class="inputs" size="20"  id="wh_in_desc" name="wh_in_desc" value="<%=objs_p.getWarehouse_begin_name()%>">
                                        <!-- <a href='#' onClick="openBrWindow('Wh_bg', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>-->
                                        &nbsp;&nbsp;&nbsp;คลังรับ&nbsp;
                                        <input type="hidden" size="10"  id="wh_out" name="wh_out" value="<%=objs_p.getWarehouse_end_id()%>"><input type='text' class="inputs"  size="20"  id="wh_out_desc" name="wh_out_desc" value="<%=objs_p.getWarehouse_end_name()%>"><!--
                                        <a href='#' onClick="openBrWindow('Wh_en', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>-->
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ถ่านจากเตา&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='burn_no' type='text' class="inputs" id="burn_no" value='' size='10' readonly/>
                                        &nbsp;&nbsp;
                                        วัตถุดิบ&nbsp;<select name="product_id" id="product_id" disabled>
                                            <option value="C" selected>ถ่านกะลา</option>
                                            <option value="P">ถ่านปาล์ม</option>
                                            <option value="U">ถ่านไม้ยูคาฯ</option>
                                        </select> <!--
                                        <input name='product_id' type='text' class="inputs" id="product_id" value='' size='10'/>
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                        <a href='#' onClick="openBrWindow('Vproduct', 29, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE5' width='20' height='20' border='0' align='middle' ></a>
                                  <input name='product_id_desc' type='text' class="inputs" id="product_id_desc" value='' size='20' readonly="readonly"/>-->	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ช่องที่*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='ch_from' type='text' class="inputs" id="ch_from" value='' size='10' readonly />
                                        &nbsp;&nbsp;
                                        ถึง*&nbsp;&nbsp;&nbsp;&nbsp;
                                        <input name='ch_to' type='text' class="inputs" id="ch_to" value='' size='10' readonly/>	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">น้ำหนักก่อนร่อนแยก*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='weight_split' type='text' class="inputs" id="weight_split" value='' size='10' readonly/>
                                        &nbsp;&nbsp;
                                        วันที่*&nbsp;
                                        <input type='text' class="inputs" name='burn_out_date' id="burn_out_date" size='10' value='' readonly="readonly"/>
                                        &nbsp;<!--<a id='date_3' ><img name='IMAGE6' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField:'burn_out_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_3',singleClick:true,step:1});</script>-->	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ยืนยันเอกสาร*&nbsp;</td>
                                    <td class="columnobject"><input type="checkbox" id="document_confirm_flag" name="document_confirm_flag" value="N" onclick="Checkvalue_document_confirm(this)"></td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <div style="width:100%;">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <tr>
                                                    <td colspan="7" class="h_multi">ข้อมูลถ่านออกจากเตา</td>
                                                    <td colspan="8" class="btn_multi">
                                                        <input type='button' name='but1' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,wh_in,wh_out,doc_date,total_weight,lost_weight,status_a,username','CS_331.jsp'));"/>
                                                        <input type='button' name='but2' value='  ลบ  ' onclick='goDelChild()'/>		    			  		</td>
                                                </tr>
                                                <tr>
                                                    <td class="row3" width="3px"><input type="checkbox" name="chk_all"  id="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);" disabled/></td>
                                                    <td class="row3" width="4%">ลำดับ</td>
                                                    <td class="row3" width="10%">รหัส</td>
                                                    <td class="row3" width="8%">ขนาด</td>

                                                    <td class="row3" width="8%">ยอดยกมา</td>
                                                    <td class="row3" width="7%">CTC/I2</td>
                                                    <td class="row3" width="10%">หน่วยบรรจ</td>
                                                    <td class="row3" width="7%">น้ำหนัก</td>
                                                    <td class="row3" width="5%">ถุงที่</td>
                                                    <td class="row3" width="7%">น้ำหนัก<br>คลังรับ</td>
                                                    <td class="row3" width="8%">รหัสคลัง</td>
                                                    <td class="row3" width="15%">รหัสสินค้า</td>
                                                    <td class="row3" width="8%">ยอดผลต่าง<br>คลัง-ผลิต</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">                                    </div>                                </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right">
                                        ผู้รายงาน
                                        <input name="report_id" type='text' class="inputs" id="report_id" size="10" readonly>
                                        <!--<a href='#' onClick="openBrWindow('Vemployee1', 29, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>-->
                                        <input name="report_id_desc" type='text' class="inputs" id="report_id_desc" size="20" readonly>
                                        &nbsp;&nbsp;&nbsp;&nbsp;สูญเสีย*&nbsp;
                                        <input name='lost_weight' type='text' class="inputs" id="lost_weight" value='0' size='10' readonly="readonly" />
                                        <input name='lost_weight_chk' type='hidden' id="lost_weight_chk" value='0' size='10' readonly="readonly"/>
                                        &nbsp;(  Kg )&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        น้ำหนักรวม*&nbsp;
                                        <input name='total_weight' type='text' class="inputs" id="total_weight" value='0' size='10' readonly="readonly" />
                                        <input name="total_weight_chk" type="hidden" id="total_weight_chk" value="0" size="10" readonly="readonly"/>
                                        &nbsp;(  Kg)
                                        <!--
                                <input type='text' class="inputs" name='____total_weight' size='10' value='' />
                                        -->	          	</td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'>
                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                            <!--a href="javascript:;" onClick="AddHeader()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a-->
                                            <!--<a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>-->
                                            <a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a></div>
                                        <br>                                </td>
                                </tr>
                            </table>
                        </div></td>
                    <td class="fcenterright"></td>
                </tr>
                <tr bordercolor="0069B3">
                    <td class="ffootleft"></td>
                    <td  class="ffootcenter" colspan="2"></td>
                    <td class="ffootright"></td>
                </tr>
            </table>
        </form>
    </body>
</html>