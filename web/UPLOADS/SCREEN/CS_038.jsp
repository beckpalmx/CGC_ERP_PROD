<%@page import="com.cgc.bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.cgc.bean.DataBean_Screen_Process"%>

<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<html>
    <head>
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
        <script type="text/javascript">
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
                    }
                    else{
                        SURL = "../JSP/CS_039.jsp?status_d=3&chk_all=1&username="+getId("username").value;
                        SURL = SURL+"&doc_id="+getId("doc_id").value;
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

                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    document.getElementsByName("ckbox")(i).checked = Value;
                }

            }
            function goDelChild()
            {
                
                var Deleteflag ="";
                var SURL;
                //alert(SURL);
                if(getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_039.jsp?status_d=3&chk_all=1&username="+getId("username").value;
                    SURL = SURL+"&doc_id="+getId("doc_id").value;
                    //alert(SURL);
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show039.jsp?doc_id=");
                    getId("chk_all").checked =false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_039.jsp?status_d=3&ckbox=";
                    for(var i=0;i<document.getElementsByName("ckBox").length;i++)
                    {
                        if(document.getElementsByName("ckBox")(i).checked ==true)
                            Deleteflag += (i+1).toString()+",";
                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length -1);
                    SURL = SURL+Deleteflag+"&doc_id="+getId("doc_id").value+"&username="+getId("username").value;
                    //alert(SURL);
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show039.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show039.jsp?doc_id=")', 500);
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
                    getSave(URLsend('chkNull,doc_id,doc_date,job_id,job_id_desc,weight,bag,carbon_pack,place_pack,i2,wh_in,wh_out,username','../JSP/CS_038.jsp'));
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                }
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if(r)
                {
                    getSave(URLsend('doc_id,doc_date,job_id,job_id_desc,weight,bag,carbon_pack,place_pack,i2,wh_in,wh_out,status_d,username','../JSP/CS_038.jsp'))
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                }
            }
            function Unload()
            {

                if(getId("doc_id").disabled == true && getId("status_cancle").value != "1" ){
                    var r = confirm("คุณได้ทำการเปลี่ยนหน้าคุณต้องการบันทึกข้อมูลทั้งหมดใช่หรือไม่");
                    if(r == true){
                        getSave(URLsend('chkNull,doc_id,doc_date,doc_time,work_type,wh_in,wh_out,prd_emp_id,prd_emp_id_desc,wh_emp_id,wh_emp_id_desc,wh_sup_id,wh_sup_id_desc','../JSP/CS_034.jsp'));
                    }

                    else{
                        var SURL = "../JSP/CS_035.jsp?status_d=3&chk_all=1";
                        SURL = SURL+"&doc_id="+getId("doc_id").value;
                        Delete_Line_no(SURL);
                    }
                }

            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <title>CGC ERP</title>
    </head>
    <body>
        <%
        UserBean userbean = (UserBean) session.getAttribute("user");
                    DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                    HeaderScreen_Process h_p = new HeaderScreen_Process();
                    objs_p = h_p.selectheaderscreen_process(objs_p, "CS_038");
        %>
        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
        <input type="hidden" id="chkNull" value="doc_id,doc_date,job_id,weight,bag,carbon_pack,place_pack,wh_in,wh_out">
        <input type="hidden" id="status_a" value="1"><!-- เป็นการเพิ่มข้อมูลเข้าไป-->
        <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
        <input type="hidden" id="status_cancle" value=""><!-- status_cancle = 1 คือค่าที่นำมา Edit แต่ถ้า ="" จะเป็นการ Insert -->
        <input type="hidden" id="child_ck" name="child_ck" value="">
        <table  cellpadding="0"  cellspacing="0">
            <tr>
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ใบแจ้งการบรรจุถ่าน(CS_038)&nbsp;</td>
                <td class="ftopright"></td>
            </tr>
            <tr >
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter">
                    <div align="left">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2" align="right"><b>หมายเลขเอกสาร : <%=objs_p.getIso_no()%></b></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%></b></td>
                            </tr>
                            <tr>
                                <td class="columnlabel"><b>เลขที่เอกสาร*</b>&nbsp;</td>
                                <td class="columnobject">
                                    <input name='doc_id' class='inputs' type='text' class="inputs" id="doc_id" value='' size='10' />
                                    &nbsp;<a href='#' onClick="openBrWindow('vd_packing_req_header&stadment=and+complete_flag+<>+\'Y\'', 38, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
	          		วันที่เอกสาร*&nbsp;
                                    <input name='doc_date' class='inputs' type='text' class="inputs" id="doc_date" value='' size='10' />
                                    &nbsp;<a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>&nbsp;&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ใบแจ้งการผลิต*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='job_id' class='inputs' type='text' class="inputs" id="job_id" value='' size='10' readonly="readonly"/>
                                    &nbsp;<a href='#' onClick="javascript:openBrWindow('Vd_job_order_header&stadment=and+complete_flag+<>+\'Y\'', 38, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='job_id_desc' class='inputs' type='text' class="inputs" id="job_id_desc" value='' size='30' readonly="readonly"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">น้ำหนักบรรจุ*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='weight' class='inputs' type='text' class="inputs" id="weight" value='' size='10' />
                                    &nbsp;(กิโลกรัม)
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ภาชนะที่บรรจุ*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='bag' class='inputs' type='text' class="inputs" id="bag" value='' size='30' />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ถ่านที่บรรจุ*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='carbon_pack' class='inputs' type='text' class="inputs" id="carbon_pack" value='' size='10' />
                                    &nbsp;&nbsp;
	          		I2&nbsp;
                                    <input name='i2' class='inputs' type='text' class="inputs" id="i2" value='' size='10' />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">สถานที่บรรจุ*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='place_pack' class='inputs' type='text' class="inputs" id="place_pack" value='' size='30' />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">คลังจ่าย&nbsp;</td>
                                <td class="columnobject">
                                    <select name='wh_in' id="wh_in">
                                        <option value='<%=objs_p.getWarehouse_begin_id()%>' selected><%=objs_p.getWarehouse_begin_name()%></option></select>&nbsp;&nbsp;
	          		คลังรับ&nbsp;
                                    <select name='wh_out' id="wh_out">
                                        <option value='<%=objs_p.getWarehouse_end_id()%>' selected><%=objs_p.getWarehouse_begin_name()%></option></select>&nbsp;&nbsp;
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
                                                <td colspan="4" class="h_multi">ข้อมูลการบรรจุ</td>
                                                <td colspan="4" class="btn_multi">
                                                    <input type='button' name='but1' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,doc_date,wh_in,wh_out,status_a,username','CS_039.jsp'));"/>
                                                    <input type='button' name='but2' value='  ลบ  ' onClick="goDelChild()"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="row3" width="3%"><input type="checkbox" name="chk_all" id="chk_all"  value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                <td class="row3" width="7%">ลำดับ&nbsp;</td>
                                                <td class="row3" width="15%">รหัสถ่าน&nbsp;</td>
                                                <td class="row3" width="20%">แหล่งผลิต&nbsp;</td>
                                                <td class="row3" width="10%">พาเลทที่&nbsp;</td>
                                                <td class="row3" width="15%">จำนวน(Kg)&nbsp;</td>
                                                <td class="row3" width="15%">คงเหลือ(Kg)&nbsp;</td>
                                                <td class="row3" width="15%">หมายเหตุ&nbsp;</td>
                                            </tr>

                                        </table>
                                    </div>
                                    <div style="width:100%; height: 150px; overflow: auto;" id="show">

                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace'>
                                    <br>
                                    <div align="center">
                                        <a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="AddHeader()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>                <img src="../IMAGES/BTN_PRINT_90.png" width="80" height="30"></div>
                                  <br>
                                </td>
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

    </body>
</html>