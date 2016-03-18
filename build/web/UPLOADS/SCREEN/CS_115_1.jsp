<%@page import="com.cgc.bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <!--link href="../CSS/BT.css" rel="stylesheet" type="text/css"-->
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>        
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />        
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>        
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        
        <script type="text/javascript">
            function goAddChild(URLSend)
            {
                if (getId("status_cancle").value == "1") {
                    var arryChk = new Array;
                    arryChk[0] = "chkNull"
                    if (ChkParameter(arryChk))
                    {
                        window.open(URLSend[0]);
                    }
                } else {
                    alert('กรุณาบันทึกข้อมูลก่อนเพิ่มรายละเอียด');
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
                        getId("runner").disabled = false;
                    }
                    else {
                        SURL = "../JSP/CS_116.jsp?status_d=3&chk_all=1";
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL)
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                        getId("runner").disabled = false;

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
                //alert("Del");
                var Deleteflag = "";
                var SURL;
                if (getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_116.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show116.jsp?doc_id=");
                    getId("chk_all").checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    //alert("test");
                    SURL = "../JSP/CS_116.jsp?status_d=3&ckbox=";

                    for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                    {
                        if (document.getElementsByName("ckbox")[i].checked == true)
                            Deleteflag += (i + 1).toString() + ",";
                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                    SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value + "&username=" + getId("username").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show116.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show116.jsp?doc_id=")', 500);
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
                    getSave(URLsend('chkNull,doc_id,doc_date,doc_type,doc_time,remark,username', '../JSP/CS_115.jsp'));
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
                    getSave(URLsend('doc_id,doc_date,doc_type,doc_time,remark,username,status_d', '../JSP/CS_115.jsp'));
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                }
            }
            function Unload()
            {/*
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
             */
            }
        </script>
        <script language="javascript">
            window.onload = function() {
                var mytext = document.report.elements;
                for (i = 0; i < mytext.length; i++) {
                    if (mytext[i].type != "" && mytext[i].type != "submit") {
                        mytext[i].onfocus = function() {
                            this.className = 'hi_light';
                        }
                        mytext[i].onblur = function() {
                            this.className = '';
                        }
                    }
                }
            }
        </script>        

        <title>CGC ERP</title>
    </head>
    <body>
        <%
            UserBean userbean = (UserBean) session.getAttribute("user");
            DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
            HeaderScreen_Process h_p = new HeaderScreen_Process();
            objs_p = h_p.selectheaderscreen_process(objs_p, "CS_034");
        %>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_id,doc_date,doc_time,doc_type">
            <input type="hidden" id="status_a" value="1"><!-- เป็นการเพิ่มข้อมูลเข้าไป-->
            <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" id="status_cancle" value=""><!-- status_cancle = 1 คือค่าที่นำมา Edit แต่ถ้า ="" จะเป็นการ Insert -->
            <input type="hidden" id="child_ck" name="child_ck" value="">
            <table  cellpadding="0"  cellspacing="0">
                <tr>
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">ใบปรับยอดสินค้า(CS_115)&nbsp;</td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <div align="left">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><b>หมายเลขเอกสาร : <%=objs_p.getIso_no()%> </b></td>
                                </tr>
                                <tr>
                                    <td height="25" colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%> </b></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">
                                        <input name="runner" id="runner" class="cgcButton_7" type="button" value="เลขที่เอกสาร" onclick="AjaxRun_id('doc_id', '../JSP/CS_115.jsp?runer_id=1');
                                                this.disabled = true;">&nbsp;
                                    <td class="columnobject">
                                        <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' />
                                        &nbsp;<a href='#' onClick="javascript:openBrWindow('d_adjust_product_header&stadment=and+complete_flag+<>+\'Y\'', 115, 'Search_Doc_id.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                        วันที่เอกสาร*&nbsp;
                                        <input type='text' class="inputs" name='doc_date' size='10' value='' id="doc_date" readonly="readonly" />&nbsp;<a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>&nbsp;&nbsp;
                                        เวลา*&nbsp;
                                        <input name='doc_time' type='text' class="inputs" id="doc_time" value='' size='10' />                                </td>
                                </tr>
                                <!--<tr>
                                    <td class="columnlabel">คลังสินค้า&nbsp;</td>
                                    <td class="columnobject"><input type='text' class="inputs" size="10" id="wh_in" name="wh_in" value="" ><a href='#' onClick="openBrWindow('Wh_bg', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a> 
                                      <input type='text' class="inputs" size="20"  id="wh_in_desc" name="wh_in_desc" value="">
                                      </td>
                              </tr>
                                <tr>
                                  <td class="columnlabel">เลขที่กอง</td>
                                  <td class="columnobject"><input name='work_type' type='text' class="inputs" id="work_type" value='' size='10' /></td>
                                </tr>-->
                                <tr>
                                    <td class="columnlabel">&nbsp;</td>
                                    <td class="columnobject"><select name="doc_type" id="doc_type">
                                            <option value="+">รับเข้า</option>
                                            <option value="-">จ่ายออก</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">&nbsp;</td>
                                    <td class="columnobject"><textarea class="text_inputs" name="remark" id="remark" cols="45" rows="5"></textarea></td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <div style="width:100%;">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <!--tr>
                                                    <td colspan="5" class="h_multi">ข้อมูลการปรับยอด</td>
                                                    <td colspan="6" class="btn_multi">
                                                        <input type='button' class="cgcButton_4" name='but1' id='but1' value='  เพิ่ม  ' onClick="goAddChild(URLsend('doc_id,doc_date,status_a,username', 'CS_116.jsp'))"/>
                                                        <input type='button' class="cgcButton_3" name='but2' id='but2' value='  ลบ  ' onclick='goDelChild()'/>                                                </td>
                                                </tr-->


                                                <tr>
                                                    <td colspan="5" class="h_multi"></td>
                                                    <td colspan="6" class="btn_multi">
                                                        <input type='button' align="left" class="cgcButton_4" name='but1' id="but1" value='  เพิ่ม  ' onClick="goAddChild(URLsend('doc_id,doc_date,status_a,username', 'CS_116.jsp'))"/>
                                                        <input type='button' align="left" class="cgcButton_3" name='but2' id="but2" value='  ลบ  ' onclick='goDelChild()'/>
                                                    </td>
                                                </tr>



                                                <tr>
                                                    <td class="row3" width="3%"><input type="checkbox" name="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                    <td class="row3" width="7%">ลำดับ&nbsp;</td>                                                    
                                                    <td class="row3" width="15%">รหัสสินค้า&nbsp;</td>
                                                    <td class="row3" width="15%">กลุ่มสินค้า&nbsp;</td>
                                                    <td class="row3" width="15%">ชนิดสินค้า</td>
                                                    <td class="row3" width="15%">คลังสินค้า&nbsp;</td>
                                                    <td class="row3" width="15%">เลขที่กอง&nbsp;</td>
                                                    <td class="row3" width="15%">ปรับยอด/kg.&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">                                    </div>                                </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'>
                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="AddHeader()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>                
                                            <img src="../IMAGES/BTN_PRINT_90.png" width="80" height="30"></div>
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
        </form>
    </body>
</html>