<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.DB.D_rawmatt_analyze_detailDAO"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
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
        <script language="javascript">
            function cancal() {
                cancelAction();
                getId("show").innerHTML = "";
            }
            function showTable() {
                //getId("show").innerHTML = "";
                (getId("process_id").value === "") ? alert("กรุณาเลือกโปรเซสที่ต้องการ") :
                        (getId("doc_id").value === "") ? alert("กรุณาเลือกรหัสเอกสาร") :
                        showTableNonPopupApprove('show', 'process_id', 'table_s1', 'doc_id', '../JSP/CS_Show048.jsp');
            }

            function Save_Data() {
                if (getId("complete_flag").value === "Y") {
                    var r = confirm("คุณต้องการคืนเอกสารที่ผ่านการยืนยันแล้วใช่หรือไม่");
                    if (r)
                    {
                        confirmDialogSave(URLsend('process_id,table_h,table_s1,table_s2,table_s3,doc_id', '../JSP/CS_048_Return_WH.jsp'));
                    }
                } else {
                    alertify.alert("กรุณายืนยันการคืนเอกสาร");
                }
            }

            function BrownDoc_id() {
                if (getId("process_id").value === "") {
                    alert("กรุณาเลือกรหัส Process");
                } else {
                    openBrWindow(getId("table_h").value + '&stadment=and+complete_flag+=+\'Y\'', 482, 'Search_Config2.jsp');
                }
            }

            function Checkvalue(thisvalue) {
                if (thisvalue) {
                    getId("complete_flag").value = "Y";
                    alert("ยืนยันการคืนเอกสารแล้ว");
                } else {
                    getId("complete_flag").value = "N";
                    //alert("เอกสารนี้สมบูรณ์เรียบร้อยแล้ว");
                }
            }
            //-->
        </script>
    </head>

    <body onUnload="closepopup()">        
        <form name="btform" method="post" action="CS_048_Return_A.jsp">
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_046");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                DataBean_Screen_Report objscreen = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objscreen = r_p.Fn_Report(objscreen, request.getParameter("submenu_id"));
                objr_p = r_p.Fn_Report(objr_p, "S801");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                UtiDatabase objuti = new UtiDatabase();
                String inputSQL = " select count(doc_id) as num from vd_rawmatt_receive where complete_flag = 'N' and lab_not_check = 'N' and doc_type = 'N' and check_doc_transfer is null  ";
                //int record_count1 = objuti.numRowdatabase(inputSQL);
                inputSQL = " select count(doc_id) as num from vd_rawmatt_analyze_header where approve_status = 'N' ";
                //int record_count2 = objuti.numRowdatabase(inputSQL);

                //_______________________________________________________________report
            %>            

            <input type="hidden" name="table_h" id="table_h" value="-" >
            <input type="hidden" name="table_s1" id="table_s1" value="-" >
            <input type="hidden" name="table_s2" id="table_s2" value="-" >
            <input type="hidden" name="table_s3" id="table_s3" value="-" >
            <input type="hidden" name="line_no" id="line_no">

            <div align="left">

                <div class="container">
                    <div class="panel panel-primary">
                        <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                            <b><%=objscreen.getName_t() + " (" + objscreen.getPath() + ")"%></b>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>[ หมายเลขเอกสาร : <%=objscreen.getDoc_no()%></b>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>วันที่มีผลบังคับใช้ : <%=objscreen.getDoc_eff_date()%> ]</b>
                        </div>                              
                        <div class="panel-footer">                                
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td align="right"><span class="columnobject">รหัส Process* :&nbsp;</span></td>
                                    <td class="columnobject"><input type='text' class="inputs" name='process_id' id="process_id" size='15' value='-' />
                                        &nbsp;<a href='javascript:;' onClick="getId('doc_id').value = '';
                                                getId('doc_date').value = '';
                                                openBrWindow('vmprocess&stadment=and+process_for+=+\'WH\'', 482, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;
                                        <input type='text' class="inputs" name='process_name' id="process_name" size='30' value='' /></td>
                                </tr>
                                <tr>
                                    <td width="30%" align="right"><span class="columnobject">เลขที่เอกสาร* :&nbsp;</span></td>
                                    <td class="columnobject"><input name="doc_id" type='text' class="inputs" id="doc_id" size="15" value="-">
                                        &nbsp;<a href='javascript:;' onClick="BrownDoc_id()"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;
                                        <input name="doc_date" type='text' class="inputs" id="doc_date" size="30">                                     
                                </tr>

                                <tr>
                                    <td class="columnlabel1"><b>ยืนยันการคืนเอกสาร</b>&nbsp;:&nbsp;</td>
                                    <td class="columnobject">
                                        <div class="checkbox checkbox-primary">
                                            <input type="checkbox" id="complete_flag" name="complete_flag" value="N" onClick="Checkvalue(this.checked)">
                                            <label for="complete_flag"></label> 
                                        </div>
                                    </td>
                                </tr>                                              

                                <tr>
                                    <td colspan='2' align="right">
                                        <!--input type='button' class="cgcButton_4" name='but1' value='  บันทึก  ' onclick='javascript:Send_to_Approve();'/-->
                                        <input type='button' class="cgcButton_4" name='but1' value='  บันทึก  ' onclick='Save_Data();'/>
                                        <input type='button' class="cgcButton_3" name='but2' value='  ยกเลิก  ' onclick='cancal()'/>  
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                            </table>                            
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
