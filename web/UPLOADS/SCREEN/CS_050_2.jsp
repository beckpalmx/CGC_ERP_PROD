<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
            function cancal() {
                cancelAction();
                getId("show").innerHTML = "";
            }
            function Send_to_Approve() {
                var IDsend = "";
                var Nochk = true;
                var value_ckbox = "";
                var overweight = false;
                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                {
                    if (document.getElementsByName("ckbox")[i].checked == true) {
                        value_ckbox = document.getElementsByName("ckbox")[i].value;
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
                            IDsend += "product_id_" + value_ckbox + "," + "location_id_" + value_ckbox + "," + "warehouse_id_" + value_ckbox + "," + "weight_" + value_ckbox + "," + "product_id_" + value_ckbox + ",warehouse_in_" + value_ckbox + ",job_id_" + value_ckbox + ",weight_doc_id_" + value_ckbox + ",";
                            Nochk = false;
                        }
                        //alert(IDsend);
                    }
                }
                if (Nochk != true && IDsend != "") {
                    getId("line_no").value = getId("line_no").value.substr(0, getId("line_no").value.length - 1);
                    IDsend = IDsend.substr(0, IDsend.length - 1);
                    IDsend = "doc_id,doc_date,line_no," + IDsend;
                    //alert(IDsend);
                    getsaveApprove(URLsend(IDsend, "../JSP/CS_050_2.jsp"), "calreport");//(URLsend(IDsend, "../JSP/CS_048_2.jsp"));
                    getId("line_no").value = "";
                    getId("doc_id").value = "";
                    getId("doc_date").value = "";
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
            function BrownDoc_id() {
                //opengetId("table_h").value
                if (getId("table_h").value != "") {
                    openBrWindow(getId("table_h").value + '&stadment=and+complete_flag+<>+\'Y\'', 482, 'Search_Config2.jsp');
                }
            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }
            function showTablePage() {
                getId("doc_id").value == "" ? alert("กรุณาเลือกเลขที่เอกสารที่ต้องการอนุมัติ") :
                        showTableNonPopup('show', 'doc_id', '../JSP/CS_Show050.jsp?doc_id=');
            }
        </script>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
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

        <title>CGC ERP</title>
    </head>
    <body>
        <input type="hidden" id="line_no" name="line_no" value="">
        <div align="left">
            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                        <b>อนุมัติการเบิกถ่านกัมมันต์ไปใช้ในการผลิต (คลังสินค้า) (CS_050_2)</b>
                    </div>                        
                    <div class="panel-footer">                      

                        <div align="center">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><b>หมายเลขเอกสาร : </b></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : </b></td>
                                </tr>
                                <tr>
                                    <td width="30%" align="right">เลขที่เอกสารการเบิกถ่านกัมมันต์*&nbsp;</td>
                                    <td class="columnobject">

                                        <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' />
                                        &nbsp;<a href='javascript:;' onClick="javascript:openBrWindow('d_carbon_withdraw_header_wh&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'Y\'', 50, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;
                                        <input name='doc_date' type='text' class="inputs" id="doc_date" value=''  />
                                        <input type='button' class="cgcButton_6" name='search' onClick="showTablePage();" value='ค้นหา'/>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>

                                <tr>
                                    <td colspan="2" align="center">
                                        <div width="100%">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">
                                                <tr>
                                                    <td class="headergrid" colspan="8">เอกสารการเบิกถ่านกัมมันต์</td>
                                                    <td class="headergrid" colspan="6">สำหรับเจ้าหน้าที่คลังสินค้า</td>
                                                </tr>

                                                <tr>
                                                    <td class="row5" width="3%"><input type="checkbox" name="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                    <td class="row5" width="3%">No.&nbsp;</td>
                                                    <td class="row5" width="10%">เลขที่ใบสั่งผลิต&nbsp;</td>
                                                    <td class="row5" width="7%">ขนาด&nbsp;</td>
                                                    <td class="row5" width="5%">ชนิด&nbsp;</td>
                                                    <td class="row5" width="5%">ไอโอ&nbsp;</td>
                                                    <td class="row5" width="7%">เครื่องผลิต&nbsp;</td>
                                                    <td class="row5" width="10%">น้ำหนัก<br>แจ้งเบิก&nbsp;</td>
                                                    <td class="row5" width="15%">Prod.code&nbsp;</td>
                                                    <td class="row5" width="10%">โกดัง&nbsp;</td>
                                                    <td class="row5" width="5%">กองที่&nbsp;</td>
                                                    <td class="row5" width="10%">น้ำหนักจ่ายจริง(กก)&nbsp;</td>
                                                    <td class="row5" width="10%" colspan="2">
                                                        <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">
                                                            <tr>
                                                                <td colspan="2" class="row5" width="100%">จำนวน&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">
                                                                        <tr>
                                                                            <td  class="row5" width="50%">กส./ถุง&nbsp;</td>
                                                                            <td  class="row5" width="50%">เศษ&nbsp;</td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
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
                                    <td colspan='2' align="right">
                                        <input type='button' class="cgcButton_4" name='but1' value='  บันทึก  ' onclick='Send_to_Approve();'/>
                                        <input type='button' class="cgcButton_3" name='but2' value='  ยกเลิก  ' onclick='javascript:cancal();'/>
                                    </td>
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
        </div>
    </body>
</html>
