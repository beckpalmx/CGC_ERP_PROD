<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <script type="text/javascript">
            function cancal(){
                cancelAction();
                getId("show").innerHTML = "";
            }
            function Send_to_Approve(){
                var IDsend = "";
                var Nochk = true;
                var value_ckbox = "";
                var overweight = false;
                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    if(document.getElementsByName("ckbox")[i].checked ==true){
                        value_ckbox = document.getElementsByName("ckbox")[i].value;
                        if(getId("location_id_"+value_ckbox).value == ""){
                            getId("location_id_"+value_ckbox).value = "-";
                        }
                        //alert(parseInt(getId("weight_"+value_ckbox).value));
                        //alert(parseInt(getId("weight_doc_id_"+value_ckbox).value));
                        
                        if(parseInt(getId("weight_"+value_ckbox).value) > parseInt(getId("weight_doc_id_"+value_ckbox).value)){
                            getId("line_no").value = "";
                            getId("weight_"+value_ckbox).select();
                            IDsend ="";
                            Nochk = false;
                            overweight = true;
                            //alert("VALUE Not OK ");
                            break;
                        }
                        else if(getId("product_id_"+value_ckbox).value == ""){
                            getId("line_no").value = "";
                            getId("product_id_"+value_ckbox).focus();
                            IDsend ="";
                            Nochk = false;
                            break;
                        }
                        else if(getId("warehouse_id_"+value_ckbox).value == ""){
                            getId("line_no").value = "";
                            getId("warehouse_id_"+value_ckbox).focus();
                            IDsend ="";
                            Nochk = false;
                            break;
                        }
                        else if(getId("weight_"+value_ckbox).value == ""){
                            getId("line_no").value = "";
                            getId("weight_"+value_ckbox).focus();
                            IDsend ="";
                            Nochk = false;
                            break;
                        }
                        else{
                            getId("line_no").value += value_ckbox+",";
                            IDsend += "product_id_"+value_ckbox+","+"location_id_"+value_ckbox+","+"warehouse_id_"+value_ckbox+","+"weight_"+value_ckbox+","+"product_doc_id_"+value_ckbox+",warehouse_in_"+value_ckbox+","+"weight_doc_id_"+value_ckbox+",";
                            Nochk = false;
                        }
                    }
                }
                if(Nochk != true && IDsend != ""){
                    getId("line_no").value = getId("line_no").value.substr(0, getId("line_no").value.length-1);
                    IDsend = IDsend.substr(0, IDsend.length-1);
                    IDsend = "doc_id,doc_date,line_no,"+IDsend;
                    if(getId("doc_date").value == ""){
                        alert("กรุณาระบุวันที่ของเอกสาร");
                    }else{
                    getsaveApprove(URLsend(IDsend, "../JSP/CS_049_2_QRY.jsp"), "calreport");//(URLsend(IDsend, "../JSP/CS_048_2.jsp"));
                    getId("doc_id").value = "";
                    getId("doc_date").value = "";
                    getId("line_no").value = "";
                    getId("show").innerHTML = "";
                    getId("chk_all").checked = false;
                    }
                }else if(Nochk != true && IDsend == ""){
                    overweight?alert("น้ำหนักที่รับเข้าคลังมีค่ามากกว่าน้ำหนักจริง กรุณากรอกน้ำหนักให้ถูกต้อง"):alert("กรุณากรอกข้อมูลให้ครบ");
                    overweight = false;
                }
                else{
                    alert("กรุณาเลือกข้อมูลที่จะบันทึก");
                }

            }
            function BrownDoc_id(){
                //opengetId("table_h").value
                if(getId("table_h").value != ""){
                    openBrWindow(getId("table_h").value+'&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=\'N\'', 482, 'Search_Config2.jsp');
                }
            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }
            function showTablePage(){
                getId("doc_id").value == ""?alert("กรุณาเลือกเลขที่เอกสารที่ต้องการอนุมัติ"):
                    showTableNonPopup('show', 'doc_id', '../JSP/CS_Show049_QRY.jsp?doc_id=');
            }
        </script>
    </head>
    <body onUnload="closepopup()">
        <input type="hidden" id="line_no" name="line_no" value="">
        <div align="center">
            <table  cellpadding="0"  cellspacing="0">
                <tr >
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">ตรวจสอบการอนุมัติรับถ่านออกจากเตาเข้าคลังสินค้า (คลังสินค้า)&nbsp;(CS_049_2_QRY)</td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <div align="center">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td width="30%" align="right">เลขที่เอกสารออกจากเตา*&nbsp;</td>
                                    <td class="columnobject">
                                        <input type='text' class="inputs" name='doc_id' id="doc_id" size='20' value='' />&nbsp;
                                        <a href='javascript:;' onClick="javascript:openBrWindow('vd_carbon_burn_out_header_wh&stadment=and+complete_flag+=+\'Y\'+and+doc_type+=+\'Y\'',49,'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                        <input type='text' class="inputs" name="doc_date" id="doc_date" readonly> 
                                        <input type='button' name='search' onClick="showTablePage()" value='ค้นหา'/>                                  </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>

                                <tr>
                                    <td colspan="2" align="center">
                                        <div width="100%">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">

                                                <tr>
                                                    <td class="headergrid" colspan="6">เอกสารออกจากเตา</td>
                                                    <td class="headergrid" colspan="8">สำหรับเจ้าหน้าที่คลังสินค้า</td>
                                                </tr>

                                                <tr>
                                                    <td class="row5" width="3%"><input type="checkbox" name="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                    <td class="row5" width="3%">No.&nbsp;</td>
                                                    <td class="row5" width="10%">รหัส&nbsp;</td>
                                                    <td class="row5" width="5%">ชนิด&nbsp;</td>
                                                    <td class="row5" width="5%">ขนาด&nbsp;</td>
                                                    <td class="row5" width="5%">หน่วยบรรจุ&nbsp;</td>
                                                    <td class="row5" width="10%">น้ำหนักนำส่ง&nbsp;</td>
                                                    <td class="row5" width="8%">CTC/I2&nbsp;</td>
                                                    <td class="row5" width="12%">Prod.code&nbsp;</td>
                                                    <td class="row5" width="12%">เก็บโกดัง&nbsp;</td>
                                                    <td class="row5" width="7%">เลขกอง&nbsp;</td>
                                                    <td class="row5" width="10%">น้ำหนัก<br>รับเข้าคลัง&nbsp;</td>
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
                                                                    </table>                                                                    </td>
                                                            </tr>
                                                        </table>                                                        </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">                                        </div>                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan='2' align="right">
                                        <input type="hidden" name="chkNull" id="chkNull" value="doc_id"/>
                                        <!--input type='button' name='but1' value='  บันทึก  ' onclick='Send_to_Approve();'/>
                                        <input type='button' name='but2' value='  ยกเลิก  ' onclick='javascript:cancal();'/-->                                    
                                        </td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                            </table>
                            <!--textarea name="calreport" id="calreport" cols="90" rows="7"></textarea-->

                        </div></td>
                    <td class="fcenterright"></td>
                </tr>
                <tr bordercolor="0069B3">
                    <td class="ffootleft"></td>
                    <td  class="ffootcenter" colspan="2"></td>
                    <td class="ffootright"></td>
                </tr>
            </table>
        </div>
    </body>
</html>
