<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!    String link_id = "";
%>
<%
    link_id = (String) request.getParameter("doc_id");
%>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>

        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
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
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                    getId("show_comfirm_" + document.getElementsByName("ckbox")[i].value).innerHTML = Value ? 'ยืนยัน' : 'รอการยืนยัน';
                }

            }
            function cancal() {
                cancelAction();
                getId("show").innerHTML = "";
            }
            function showTablePage() {
                showTableNonPopup('show', 'doc_id', '../JSP/CS_Show114.jsp?doc_id=');
            }


            function viewDetail() {
                window.open('CS_114_view.jsp?id=' + getId("doc_id").value, '', 'width=800,height=300');
            }
            function Send_to_Approve() {
                var IDsend = "";
                var Nochk = true;
                var overweight = false;
                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                {

                    if (document.getElementsByName("ckbox")[i].checked == true) {
                        var value_ckbox = document.getElementsByName("ckbox")[i].value;
                        if (getId("location_id_" + value_ckbox).value == "") {
                            getId("location_id_" + value_ckbox).value = "-";
                        }
                        if (parseInt(getId("weight_" + value_ckbox).value) > parseInt(getId("weight_doc_id_" + value_ckbox).value)) {
                            getId("line_no").value = "";
                            getId("weight_" + value_ckbox).select();
                            IDsend = "";
                            Nochk = false;
                            overweight = true;
                            break;
                        }
                        else if (getId("product_id_" + value_ckbox).value == "") {
                            getId("line_no").value = "";
                            getId("product_id_" + value_ckbox).focus();
                            IDsend = "";
                            Nochk = false;
                            break;
                        }
                        else if (getId("warehouse_id_" + value_ckbox).value == "") {
                            getId("line_no").value = "";
                            getId("warehouse_id_" + value_ckbox).focus();
                            IDsend = "";
                            Nochk = false;
                            break;
                        }
                        else if (getId("weight_" + value_ckbox).value == "") {
                            getId("line_no").value = "";
                            getId("weight_" + value_ckbox).focus();
                            IDsend = "";
                            Nochk = false;
                            break;
                        }
                        else {
                            getId("line_no").value += value_ckbox + ",";
                            IDsend += "product_id_" + value_ckbox + "," + "location_id_" + value_ckbox + "," + "warehouse_id_" + value_ckbox + "," + "weight_" + value_ckbox + "," + "job_id_" + value_ckbox + "," + "weight_doc_id_" + value_ckbox + ","
                            Nochk = false;
                        }
                    }
                }
                if (Nochk != true && IDsend != "") {
                    getId("line_no").value = getId("line_no").value.substr(0, getId("line_no").value.length - 1);
                    IDsend = IDsend.substr(0, IDsend.length - 1);
                    IDsend = "doc_id,doc_date,line_no," + IDsend;
                    //alert(IDsend);
                    getsaveApprove(URLsend(IDsend, "../JSP/CS_114.jsp"), "calreport");//(URLsend(IDsend, "../JSP/CS_048_2.jsp"));
                    getId("doc_id").value = "";
                    getId("doc_date").value = "";
                    getId("line_no").value = "";
                    getId("show").innerHTML = "";
                    getId("chk_all").checked = false;
                } else if (Nochk != true && IDsend == "") {
                    overweight ? alert("น้ำหนักที่รับเข้าคลังมีค่ามากกว่าน้ำหนักจริง กรุณากรอกน้ำหนักให้ถูกต้อง") : alert("กรุณากรอกข้อมูลให้ครบ");
                    overweight = false;
                }
                else {
                    alert("กรุณาเลือกข้อมูลที่จะบันทึก");
                }

            }

            function loadId() {
                if (getId("id_link").value == 'null') {
                    getId("doc_id").value = '';
                } else {
                    getId("doc_id").value = getId("id_link").value;
                    showTablePage();
                }
            }
        </script>
    </head>
    <body onload="loadId()" onUnload="closepopup()">
        <input type="hidden" id="line_no" name="line_no" value="">
        <div align="left">
            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                        <b>ยืนยันแจ้งคืนถ่านกัมมันต์ที่เหลือจากการผลิตเข้าคลังสินค้า (CS_114)</b>
                    </div>                        
                    <div class="panel-footer">                      

                        <div align="center">                

                            <table width="94%"  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><b>หมายเลขเอกสาร :</b></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : </b></td>
                                </tr>
                                <tr>
                                <input type="hidden" name="id_link" id="id_link" value="<%= link_id%>"/>
                                <input type="hidden" name="doc_date" id="doc_date" value=""/>
                                <input type="hidden" name="doc_time" id="doc_time" value=""/>
                                <input type="hidden" name="doc_time" id="doc_time" value=""/>
                                <input type="hidden" name="sending_id," id="sending_id," value=""/>
                                <input type="hidden" name="remark" id="remark" value=""/>
                                <td width="200" align=""
                                    class="columnlabel1">&nbsp;</td>
                                <td width="556" class="columnobject"><b>เลขที่เอกสาร*</b>
                                    <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' />
                                    &nbsp;<a href='javascript:;' onClick="openBrWindow('vd_carbon_return_header_wh&stadment=and+complete_flag+<>+\'Y\'', 114, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;
                                    <input type='button' class="cgcButton_6" name='search' onClick="showTablePage();" value='ค้นหา'/>
                                </td>
                                </tr>                            
                                <tr>
                                    <td colspan='2' class='btn_multi'>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="headergrid" colspan="17">ข้อมูลการคืนถ่านกัมมันต์</td>
                                </tr>                             
                                <tr>
                                    <td height="208" colspan="2" align="center">
                                        <div style="width:100%;">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">
                                                <tr>
                                                    <td width="3%" rowspan="2" valign="middle" class="row5"><div align="center">
                                                            <input type="checkbox" name="chk_all" id="chk_all" onClick="ckall(this.checked);">
                                                        </div></td>
                                                    <td width="3%" rowspan="2" valign="middle" class="row5"><div align="center">No.</div></td>
                                                    <td width="18%" rowspan="2" valign="middle" class="row5"><div align="center">รหัสสินค้า</div></td>
                                                    <td width="12%" rowspan="2" valign="middle" class="row5" ><div align="center">ขนาด</div></td>
                                                    <td colspan="3" valign="middle" class="row3"><div align="center">
                                                            <DIV align="center">จำนวนคืน</DIV>
                                                        </div>
                                                        <div align="center"></div>
                                                        <div align="center"></div></td>
                                                    <td width="15%" rowspan="2" valign="middle" class="row5"><div align="center">เก็บโกดัง</div></td>
                                                    <td width="12%" rowspan="2" valign="middle" class="row5"><div align="center">กองที่</div></td>
                                                    <td width="8%" rowspan="2" valign="middle" class="row5"><div align="center">ยืนยัน</div></td>
                                                </tr>
                                                <tr>
                                                    <td width="9%" valign="middle" class="row5"><DIV align="center">กส/ถุง</DIV></td>
                                                    <td width="10%" valign="middle" class="row5"><DIV align="center">น.น<BR>
                                                            ถุงเศษ</DIV></td>
                                                    <td width="10%" valign="middle" class="row5"><DIV align="center">น.น<BR>
                                                            สุทธิ</DIV></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">

                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'>
                                <tr>
                                    <td colspan='2' align="right">
                                        <input type='button' class="cgcButton_4" name='but1' value='  บันทึก  ' onclick='Send_to_Approve();'/>
                                        <input type='button' class="cgcButton_3" name='but2' value='  ยกเลิก  ' onclick='javascript:cancal();'/>
                                    </td>
                                </tr>
                                </td>
                                </tr>
                            </table>
                            <textarea class="text_inputs_3" name="calreport" id="calreport" cols="100" rows="7"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
