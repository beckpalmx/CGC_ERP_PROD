<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
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
                getId("show2").innerHTML = "";
            }
            function showTable() {
                if (getId("doc_id").value == "") {
                    alert("กรุณาเลือกเลขที่เอกสาร");
                } else {
                    showTableNonPopupApprove('show', 'process_id', 'table_s1', 'doc_id', '../JSP/CS_Show052.jsp');
                    showTableNonPopupApprove('show2', 'process_id', 'table_s2', 'doc_id', '../JSP/CS_Show052.jsp');
                }
            }
            function Send_to_Approve() {
                var IDsend = "";
                var Nochk = true;
                var overweight = false;
                for (var i = 0; i < document.getElementsByName("ckbox_withdraw").length; i++)
                {

                    if (document.getElementsByName("ckbox_withdraw")[i].checked == true) {
                        var value_ckbox = document.getElementsByName("ckbox_withdraw")[i].value;
                        if (getId("location_withdraw_" + value_ckbox).value == "") {
                            getId("location_withdraw_" + value_ckbox).value = "-";
                        }
                        if (parseInt(getId("weight_withdraw_" + value_ckbox).value) > parseInt(getId("weight_doc_withdraw_" + value_ckbox).value)) {
                            getId("line_no").value = "";
                            getId("weight_withdraw_" + value_ckbox).select();
                            IDsend = "";
                            Nochk = false;
                            overweight = true;
                            break;
                        }
                        else if (getId("product_withdraw_" + value_ckbox).value == "") {
                            getId("line_no").value = "";
                            getId("product_withdraw_" + value_ckbox).focus();
                            IDsend = "";
                            Nochk = false;
                            break;
                        }
                        else if (getId("warehouse_withdraw_" + value_ckbox).value == "") {
                            getId("line_no").value = "";
                            getId("warehouse_withdraw_" + value_ckbox).focus();
                            IDsend = "";
                            Nochk = false;
                            break;
                        }
                        else if (getId("weight_withdraw_" + value_ckbox).value == "") {
                            getId("line_no").value = "";
                            getId("weight_" + value_ckbox).focus();
                            IDsend = "";
                            Nochk = false;
                            break;
                        }
                        else {
                            getId("line_no").value += value_ckbox + ",";
                            IDsend += "product_withdraw_" + value_ckbox + "," + "location_withdraw_" + value_ckbox + "," + "warehouse_withdraw_" + value_ckbox + ","
                                    + "weight_withdraw_" + value_ckbox + ",job_withdraw_" + value_ckbox + "," + "weight_doc_withdraw_" + value_ckbox + ",";
                            Nochk = false;
                        }
                    }
                }
                if (Nochk != true && IDsend != "") {
                    //document.btform.but1.disabled = true;
                    //document.btform.but3.disabled = true;
                    getId("line_no").value = getId("line_no").value.substr(0, getId("line_no").value.length - 1);
                    IDsend = IDsend.substr(0, IDsend.length - 1);
                    IDsend = "process_id,table_h,table_s1,doc_id,doc_date,line_no," + IDsend;
                    //alert(IDsend);
                    getsaveApprove(URLsend(IDsend, "../JSP/CS_052.jsp"), "calreport");//(URLsend(IDsend, "../JSP/CS_048_2.jsp"));
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
            function Send_to_Approve2() {
                var IDsend = "";
                var Nochk = true;
                var overweight = false;
                for (var i = 0; i < document.getElementsByName("ckbox_secure").length; i++)
                {

                    if (document.getElementsByName("ckbox_secure")[i].checked == true) {
                        var value_ckbox = document.getElementsByName("ckbox_secure")[i].value;
                        if (getId("location_secure_" + value_ckbox).value == "") {
                            getId("location_secure_" + value_ckbox).value = "-";
                        }
                        if (parseInt(getId("weight_secure_" + value_ckbox).value) > parseInt(getId("weight_doc_secure_" + value_ckbox).value)) {
                            getId("line_no").value = "";
                            getId("weight_secure_" + value_ckbox).select();
                            IDsend = "";
                            Nochk = false;
                            overweight = true;
                            break;
                        }
                        else if (getId("product_secure_" + value_ckbox).value == "") {
                            getId("line_no").value = "";
                            getId("product_secure_" + value_ckbox).focus();
                            IDsend = "";
                            Nochk = false;
                            break;
                        }
                        else if (getId("warehouse_secure_" + value_ckbox).value == "") {
                            getId("line_no").value = "";
                            getId("warehouse_secure_" + value_ckbox).focus();
                            IDsend = "";
                            Nochk = false;
                            break;
                        }
                        else if (getId("weight_secure_" + value_ckbox).value == "") {
                            getId("line_no").value = "";
                            getId("weight_secure_" + value_ckbox).focus();
                            IDsend = "";
                            Nochk = false;
                            break;
                        }
                        else {
                            getId("line_no").value += value_ckbox + ",";
                            IDsend += "product_secure_" + value_ckbox + "," + "location_secure_" + value_ckbox + "," + "warehouse_secure_" + value_ckbox + ","
                                    + "weight_secure_" + value_ckbox + ",job_secure_" + value_ckbox + "," + "weight_doc_secure_" + value_ckbox + ",";
                            Nochk = false;
                        }
                    }
                }
                if (Nochk != true && IDsend != "") {
                    //document.btform.but1.disabled = true;
                    //document.btform.but3.disabled = true;
                    getId("line_no").value = getId("line_no").value.substr(0, getId("line_no").value.length - 1);
                    IDsend = IDsend.substr(0, IDsend.length - 1);
                    IDsend = "process_id,table_h,table_s2,doc_id,doc_date,line_no," + IDsend;
                    //alert(IDsend);
                    getsaveApprove(URLsend(IDsend, "../JSP/CS_052.jsp"), "calreport");//(URLsend(IDsend, "../JSP/CS_048_2.jsp"));
                    getId("line_no").value = "";
                    getId("show2").innerHTML = "";
                    getId("chk_all2").checked = false;
                } else if (Nochk != true && IDsend == "") {
                    overweight ? alert("น้ำหนักที่รับเข้าคลังมีค่ามากกว่าน้ำหนักจริง กรุณากรอกน้ำหนักให้ถูกต้อง") : alert("กรุณากรอกข้อมูลให้ครบ");
                    overweight = false;
                }
                else {
                    alert("กรุณาเลือกข้อมูลที่จะบันทึก");
                }

            }
            function BrownDoc_id() {
                //opengetId("table_h").value
                if (getId("table_h").value != "") {
                    //openBrWindow(getId("table_h").value+'&stadment=and+complete_flag+<>+\'Y\'+and+total_weight_withdraw+=+total_weight_withdraw_wh+and+total_weight+=+total_weight_wh', 482, 'Search_Config2.jsp');
                    openBrWindow(getId("table_h").value + '&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'Y\'', 482, 'Search_Config2.jsp');
                }
            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for (var i = 0; i < document.getElementsByName("ckbox_withdraw").length; i++)
                {
                    document.getElementsByName("ckbox_withdraw")[i].checked = Value;
                }

            }
            function ckall2(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for (var i = 0; i < document.getElementsByName("ckbox_secure").length; i++)
                {
                    document.getElementsByName("ckbox_secure")[i].checked = Value;
                }

            }
            //-->
        </script>
    </head>

    <body onUnload="closepopup()">
        <div id="toolTipLayer" style="position:absolute; visibility: hidden" align="center"></div>
        <form name="btform" method="post" action="CS_048.jsp">
            <input type="hidden" name="table_h" id="table_h"  value="d_packing_product_header_wh">
            <input type="hidden" name="table_s1" id="table_s1" value="vd_packing_product_detail_wh">
            <input type="hidden" name="table_s2" id="table_s2" value="vd_packing_product_detail_prod_wh">
            <input type="hidden" name="line_no" id="line_no">
            <input type="hidden" name="process_id" id="process_id" value="PR_040">

            <div align="left">

                <div class="container">
                    <div class="panel panel-primary">
                        <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                            <b>อนุมัติการบรรจุถ่านกำมันต์ (CS_052)</b>
                        </div>                        
                        <div class="panel-footer">                               
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><b>หมายเลขเอกสาร : </b></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : </b></td>
                                </tr>
                                <tr>
                                    <td width="20%" align="right"><span class="columnobject">เลขที่เอกสาร*</span></td>                                    
                                    <td class="columnobject"><input name="doc_id" type='text' class="inputs" id="doc_id" size="10">
                                        <a href='javascript:;' onClick="BrownDoc_id()"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        <input name="doc_date" type='text' class="inputs" id="doc_date" size="30">
                                        <input type='button' class="cgcButton_6" name='search' onClick="showTable()" value='ค้นหา'/>
                                        <input type='button' class="cgcButton_3" name='but4' value='  ยกเลิก  ' onclick='cancal()'/></td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace'><strong>ถ่านเบิก</strong></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <div width="100%">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">

                                                <tr>
                                                    <td class="headergrid" colspan="8">เอกสาร</td>
                                                    <td class="headergrid" colspan="4">คลังสินค้า</td>
                                                </tr>

                                                <tr>
                                                    <td class="row3" width="1%"><input type="checkbox" name="chk_all" value="chk_all" onClick="ckall(this.checked);"/></td>
                                                    <td class="row3" width="7%">No.&nbsp;</td>
                                                    <td class="row3" width="10%">เลขที่เอกสาร&nbsp;</td>
                                                    <td class="row3" width="7%">วันที่เอกสาร&nbsp;</td>
                                                    <td class="row3" width="10%">ใบแจ้งผลิต&nbsp;</td>
                                                    <td class="row3" width="7%">ถ่าน&nbsp;</td>
                                                    <td class="row3" width="7%">ขนาด&nbsp;</td>
                                                    <td class="row3" width="7%">น้ำหนัก (Kg)&nbsp;</td>
                                                    <td class="row3" width="13%">รหัสถ่าน&nbsp;</td>
                                                    <td class="row3" width="7%">เลขกอง<br>/เลขที่&nbsp;</td>
                                                    <td class="row3" width="10%">คลัง&nbsp;</td>
                                                    <td class="row3" width="7%">น้ำหนัก (Kg)&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">                                            </div>                                        </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'><div align="right">
                                            <input type='button' class="cgcButton_8" name='but3' value='  อนุมัติถ่านเบิก  ' onclick='Send_to_Approve()'/>
                                        </div></td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'><strong>ถ่านได้</strong></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <div width="100%">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">

                                                <tr>
                                                    <td class="headergrid" colspan="8">เอกสาร</td>
                                                    <td class="headergrid" colspan="4">คลังสินค้า</td>
                                                </tr>

                                                <tr>
                                                    <td class="row3" width="1%"><input name="chk_all2" type="checkbox" id="chk_all2" onClick="ckall2(this.checked);" value="chk_all"/></td>
                                                    <td class="row3" width="7%">No.&nbsp;</td>
                                                    <td class="row3" width="10%">เลขที่เอกสาร&nbsp;</td>
                                                    <td class="row3" width="7%">วันที่เอกสาร&nbsp;</td>
                                                    <td class="row3" width="10%">ใบแจ้งผลิต&nbsp;</td>
                                                    <td class="row3" width="7%">ถ่าน&nbsp;</td>
                                                    <td class="row3" width="7%">ขนาด&nbsp;</td>
                                                    <td class="row3" width="7%">น้ำหนัก (Kg)&nbsp;</td>
                                                    <td class="row3" width="13%">รหัสถ่าน&nbsp;</td>
                                                    <td class="row3" width="7%">เลขกอง<br>/เลขที่&nbsp;</td>
                                                    <td class="row3" width="10%">คลัง&nbsp;</td>
                                                    <td class="row3" width="7%">น้ำหนัก (Kg)&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show2">                                            </div>                                        </td>
                                </tr>
                                <tr>
                                    <td colspan='2' align="right">
                                        <input type='button' class="cgcButton_8" name='but1' value='  อนุมัติถ่านได้  ' onclick='javascript:Send_to_Approve2();'/></td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                            </table>
                            <textarea class="text_inputs" name="calreport" id="calreport" cols="100" rows="7"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
