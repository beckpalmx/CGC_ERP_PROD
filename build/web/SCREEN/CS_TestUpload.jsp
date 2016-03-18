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
        <style>
            
        </style>
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
        <title>CGC ERP</title>
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
                if(getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_024.jsp?status_d=3&chk_all=1&username="+getId("username").value;
                    SURL = SURL+"&doc_id="+getId("doc_id").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show024.jsp?doc_id=");
                    getId("chk_all").checked =false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_024.jsp?status_d=3&ckbox=";
                    for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                    {
                        Deleteflag += (document.getElementsByName("ckbox")[i].checked)?(i+1).toString()+",":"";
                    }

                    Deleteflag = Deleteflag.substring(0, Deleteflag.length -1);
                    SURL = SURL+Deleteflag+"&doc_id="+getId("doc_id").value+"&username="+getId("username").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show024.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show024.jsp?doc_id=")', 100);
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
                    getSave(URLsend('chkNull,doc_id,doc_date,date_ck,status_cancle,child_ck,doc_time,wh_in,wh_out,runner_id,p_type,remark,username','../JSP/CS_023.jsp'));
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                    setTimeout('getId("child_ck").value = "";getId("date_ck").value= ""',1000);
                }
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if(r)
                {
                    getSave(URLsend('doc_id,doc_date,status_cancle,date_ck,child_ck,doc_time,wh_in,wh_out,runner_id,runner_id_desc,p_type,remark,status_d,username','../JSP/CS_023.jsp'))
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("show").innerHTML = "";
                    getId("doc_id").disabled = false;
                    setTimeout('getId("child_ck").value = "";getId("date_ck").value= ""',1000);
                }
            }
            function Unload()
            {

            }
            function OpenDoc_id()
            {
            }
            function CreateNewRow()
            {
                var intLine = parseInt(getId("maxline").value);
                intLine++;
                //var Test_array = getId("shift").value.split(",");
                //var Test_array1 = getId("shift_value").value.split(",");
                var theTable = document.getElementById("tbExp");
                var newRow = theTable.insertRow(theTable.rows.length);
                newRow.id = newRow.uniqueID;

                var item1 = 1;
                var newCell;
                //*** Column 1 ***//
                newCell = newRow.insertCell(0)
                newCell.id = newCell.uniqueID
                newCell.setAttribute("width", "3px");
                newCell.setAttribute("class", "forborder");
                newCell.innerHTML = "<td ><input type = 'checkbox' id = '"+intLine+"' name = 'ckbox'></td>"
                newCell = newRow.insertCell(1)
                newCell.setAttribute("width", "7%");
                newCell.setAttribute("class", "forborder");
                newCell.innerHTML = "<td>"+intLine+"&nbsp;</td>"
                newCell = newRow.insertCell(2)
                newCell.setAttribute("width", "30%");
                newCell.setAttribute("class", "forborder");
                newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"12\" ID=\"P_product_id_"+intLine+"\" VALUE=\"\" ></td>"
                newCell = newRow.insertCell(3)
                newCell.setAttribute("width", "60%");
                newCell.setAttribute("class", "forborder");
                newCell.innerHTML = "<td><INPUT TYPE=\"file\" SIZE=\"20\" ID=\"files_"+intLine+"\" VALUE=\"\" NAME=\"files[]\"><div id=\"list\"></div></td>"
                getId("maxline").value = intLine;
            }

            function RemoveRow()
            {
                var intLine = parseInt(getId("maxline").value);
                if(parseInt(intLine) > 0)
                {
                    var theTable = (document.all) ? document.all.tbExp : document.getElementById("tbExp");
                    var theTableBody = theTable.tBodies[0];
                    theTableBody.deleteRow(intLine-1);
                    intLine--;
                    getId("maxline").value = intLine;
                }
            }
        </script>
    </head>

    <body onUnload="Unload()" >
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">

            <%
                        UserBean userbean = (UserBean) session.getAttribute("user");
                        DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                        HeaderScreen_Process h_p = new HeaderScreen_Process();
                        objs_p = h_p.selectheaderscreen_process(objs_p, "CS_023");
                        // _______________________________________________________________report
                        DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                        HeaderScreen_Report r_p = new HeaderScreen_Report();
                        objr_p = r_p.Fn_Report(objr_p, "S502");
                        path = objr_p.getPath();
                        lookup = objr_p.getLookup();
                        doc_eff_date = objr_p.getDoc_eff_date();
                        doc_no = objr_p.getDoc_no();
                        //_______________________________________________________________report
%>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="A_doc_id">
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
            <input type="hidden" name="maxline" value="0" id="maxline">
            <table  cellpadding="0"  cellspacing="0">
                <tr >
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">ทะเบียนเครื่องจักร(CS_TestUpload)&nbsp;</td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <div align="left">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><strong>หมายเลขเอกสาร :<%=objs_p.getIso_no()%> </strong></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><strong>วันที่มีผลบังคับใช้ :<%=objs_p.getEffective_date()%></strong></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel"><strong>รหัสทะเบียนเครื่องจักร*</strong>&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='A_doc_id' type='text' class="inputs" id="A_doc_id" value='' size='10'  />
                                        &nbsp;<a href='#' onClick="OpenDoc_id()" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ผู้เบิก </td>
                                    <td class="columnobject">
                                        <input type='text' class="inputs" id="runner_id" name='runner_id' size='10' value='' readonly="readonly"/>&nbsp;&nbsp;<a href='#' onClick="javascript:openBrWindow('Vemployee&stadment=and+emp_id+between+\'0001\'+and+\'0008\'', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class="inputs" name='runner_id_desc' id="runner_id_desc" size='30' value='' readonly="readonly"/>                                </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <div style="width:100%;">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <tr>
                                                    <td colspan="3" class="h_multi">ข้อมูล</td>
                                                    <td colspan="4" class="btn_multi">
                                                        <input type="button" name="bt_show" id="bt_show" onclick="showTableNonPopup('show', 'A_doc_id', '../JSP/CS_ShowUpload.jsp?test=1');" value="Show">
                                                        <input type='button' name='bt_insert' id="bt_insert" value='  เพิ่ม  ' onClick="goAddChild(URLsend('A_doc_id','CS_TestUpload_Detail.jsp'));"/>
                                                        <input type='button' name='bt_delete' id="bt_delete" value='  ลบ  ' onClick="goDelChild()"/>                                                </td>
                                                </tr>
                                                <tr>
                                                    <td class="row3" width="3px"><input type="checkbox" id="chk_all" name="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                    <td class="row3" width="7%">ลำดับที่  </td>
                                                    <td class="row3" width="30%">ชื่อรูปภาพ</td>
                                                    <td class="row3" width="60%">รูปภาพ</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner"  name = "tbExp" id = "tbExp">
                                            </table>
                                        </div>                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">หมายเหตุ </td>
                                    <td class="columnobject"><textarea class="text_inputs" name='remark' cols='40' rows='5' id="remark"></textarea></td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'>
                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="AddHeader()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
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
    <script type="text/javascript" >
        
    </script>
</html>
