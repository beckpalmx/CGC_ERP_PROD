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
            }
            function showTable() {
                //getId("show").innerHTML = "";
                (getId("process_id").value == "") ? alert("กรุณาเลือกโปรเซสที่ต้องการ") :
                        (getId("doc_id").value == "") ? alert("กรุณาเลือกรหัสเอกสาร") :
                        showTableNonPopupApprove('show', 'process_id', 'table_s1', 'doc_id', '../JSP/CS_Show048.jsp');
            }
            function Send_to_Approve() {
                var IDsend = "";
                var Nochk = true;
                var overweight = false;
                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                {

                    if (document.getElementsByName("ckbox")[i].checked == true) {
                        var value_ckbox = document.getElementsByName("ckbox")[i].value;

                        if (getId("location_id_" + value_ckbox).value == "" || getId("location_id_" + value_ckbox).value == null) {
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
                            IDsend += (getId("process_id").value == "PR_022") ? "total_price_" + value_ckbox + "," : "warehouse_in_" + value_ckbox + "," + "location_doc_id_" + value_ckbox + ",";
                            IDsend += getId("process_id").value == "PR_115" ? "doc_type_" + value_ckbox + "," : "";
                            Nochk = false;
                        }
                    }
                }
                if (Nochk != true && IDsend != "") {
                    getId("line_no").value = getId("line_no").value.substr(0, getId("line_no").value.length - 1);
                    IDsend = IDsend.substr(0, IDsend.length - 1);
                    IDsend = "process_id,table_h,table_s1,table_s2,doc_id,doc_date,line_no," + IDsend;
                    //alert(IDsend);
                    if (getId("doc_date").value == "") {
                        alert("กรุณาระบุวันที่ของเอกสาร");
                    } else {
                        getsaveApprove(URLsend(IDsend, "../JSP/CS_048_2.jsp"), "calreport");//(URLsend(IDsend, "../JSP/CS_048_2.jsp"));
                        getId("doc_id").value = "";
                        getId("doc_date").value = "";
                        getId("line_no").value = "";
                        getId("show").innerHTML = "";
                        getId("chk_all").checked = false;
                    }
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
                    if (getId("table_h").value == "d_requisition_product_header_wh") {
                        openBrWindow(getId("table_h").value + '&stadment=and+complete_flag+<>+\'Y\'+and+net_weight+=+net_weight_wh', 482, 'Search_Config2.jsp');
                    } else if (getId("table_h").value == "d_rawmatt_receive") {
                        //openBrWindow(getId("table_h").value+'&stadment=and+complete_flag+<>+\'Y\'+and+price_flag+=+\'Y\'', 482, 'Search_Config2.jsp');
                        openBrWindow(getId("table_h").value + '&stadment=and+complete_flag+<>+\'Y\'+and+(doc_type+=+\'Y\'+or+lab_not_check+=+\'Y\')', 482, 'Search_Config2.jsp');
                    } else if (getId("table_h").value == "d_carbon_burn_in_header_wh") {
                        //openBrWindow(getId("table_h").value+'&stadment=and+complete_flag+<>+\'Y\'+and+price_flag+=+\'Y\'', 482, 'Search_Config2.jsp');
                        openBrWindow(getId("table_h").value + '&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+<>+\'N\'', 482, 'Search_Config2.jsp');

                    } else {
                        openBrWindow(getId("table_h").value + '&stadment=and+complete_flag+<>+\'Y\'', 482, 'Search_Config2.jsp');
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
            //-->
        </script>
    </head>

    <body onUnload="closepopup()">        
        <form name="btform" method="post" action="CS_048.jsp">
            <input type="hidden" name="table_h" id="table_h" >
            <input type="hidden" name="table_s1" id="table_s1" >
            <input type="hidden" name="table_s2" id="table_s2" >
            <input type="hidden" name="line_no" id="line_no">

            <div align="center">

                <div class="container">
                    <div class="panel panel-primary">
                        <div class="panel-heading"><div align="left"><span class="glyphicon glyphicon-tasks"></span>&nbsp;
                            <b>อนุมัติรับ-จ่าย (คลังสินค้า)&nbsp;(CS_048_2)</b></div>
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
                                    <td align="right"><span class="columnobject">รหัส process* :&nbsp;</span></td>
                                    <td class="columnobject"><input type='text' class="inputs" name='process_id' id="process_id" size='10' value='' />
                                        &nbsp;<a href='javascript:;' onClick="getId('doc_id').value = '';
                                                    getId('doc_date').value = '';
                                                    openBrWindow('vmprocess&stadment=and+doc_type+<>+\'N\'', 482, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;
                                        <input type='text' class="inputs" name='process_name' id="process_name" size='30' value='' /></td>
                                </tr>
                                <tr>
                                    <td width="30%" align="right"><span class="columnobject">เลขที่เอกสาร* :&nbsp;</span></td>
                                    <td class="columnobject"><input name="doc_id" type='text' class="inputs" id="doc_id" size="10">
                                        &nbsp;<a href='javascript:;' onClick="BrownDoc_id()"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;
                                        <input name="doc_date" type='text' class="inputs" id="doc_date" size="30">
                                        <input type='button' class="cgcButton_6" name='search' onClick="showTable()" value='ค้นหา'/></td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <div width="100%">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">

                                                <tr>
                                                    <td class="headergrid" colspan="7">เอกสาร</td>
                                                    <td class="headergrid" colspan="4">คลังสินค้า</td>
                                                </tr>

                                                <tr>
                                                    <td class="row3" width="3%"><input type="checkbox" name="chk_all" value="chk_all" onClick="ckall(this.checked);"/></td>
                                                    <td class="row3" width="3%">No.&nbsp;</td>
                                                    <td class="row3" width="10%">เลขที่เอกสาร&nbsp;</td>
                                                    <td class="row3" width="10%">วันที่เอกสาร&nbsp;</td>
                                                    <td class="row3" width="10%">ใบแจ้งผลิต&nbsp;</td>
                                                    <td class="row3" width="10%">ถ่าน&nbsp;</td>
                                                    <td class="row3" width="10%">น้ำหนัก (Kg)&nbsp;</td>
                                                    <td class="row3" width="13%">รหัสถ่าน&nbsp;</td>
                                                    <td class="row3" width="7%">เลขกอง/เลทที่&nbsp;</td>
                                                    <td class="row3" width="10%">คลัง&nbsp;</td>
                                                    <td class="row3" width="10%">น้ำหนัก (Kg)&nbsp;</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">                                            </div>                                        </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan='2' align="right">
                                        <input type='button' class="cgcButton_4" name='but1' value='  บันทึก  ' onclick='javascript:Send_to_Approve();'/>
                                        <input type='button' class="cgcButton_3" name='but2' value='  ยกเลิก  ' onclick='cancal()'/>  
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                            </table>
                            <textarea class="text_inputs_3" name="calreport" id="calreport" cols="100" rows="7"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
