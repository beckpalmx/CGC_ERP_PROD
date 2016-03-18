<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            function chk(){
                if(document.getElementById("chk_all").checked == true){
                    var formInputs = document.getElementsByTagName('input');
                    for (var i = 0; i < formInputs.length; i++) {
                        var theInput = formInputs[i];
                        if(theInput.type == 'checkbox'){
                            if (theInput.id != 'chk_all')
                                theInput.checked = true;
                        }
                    }
                }else{
                    var formInputs = document.getElementsByTagName('input');
                    for (var i = 0; i < formInputs.length; i++) {
                        var theInput = formInputs[i];
                        if(theInput.type == 'checkbox'){
                            if (theInput.id != 'chk_all')
                                theInput.checked = false;
                        }
                    }
                }
            }
            function cancal(){
                cancelAction();
                getId("show").innerHTML = "";
            }
            function showTablePage(){
                getId("show").innerHTML = "";
                showTableNonPopup('show', 'doc_id', '../JSP/CS_051_List.jsp?doc_id=');
            }

            function RunData(){
                var list = new Array();
                var cnt = 0;
                var chkList = 0;
                var URL = "";
                var formInputs = document.getElementsByTagName('input');
                for (var i = 0; i < formInputs.length; i++) {
                    var theInput = formInputs[i];
                    if(theInput.type == 'checkbox'){
                        if(theInput.name != 'chk_all'){
                            if(theInput.checked == true){
                                var s1 = theInput.value+":"+getId("product_id_"+cnt).value+":"+getId("wh_"+cnt).value+":"+getId("location_"+cnt).value+":"+getId("weigth_"+cnt).value+":"+getId("location_out_"+cnt).value+":";
                                list.push(s1);
                            }
                            cnt++;
                        }
                    }
                }
                var chkList = list.length;
                for(j=list.length;j > 0;j--){
                    if(j == chkList){
                        URL = "../JSP/CS_049.jsp?cntData="+chkList+"&param"+j+"="+list.pop();
                    }else {
                        URL = URL + "&param"+(j)+"="+list.pop();
                    }
                }
                var array = new Array;
                array[0] = URL;
                array[1] = "";
                //alert(URL);
                confirmDialogSave(array);
                getId("show").innerHTML = "";
            }
        </script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <title>CGC ERP</title>
    </head>
    <body>
            <div align="center">

                <table  cellpadding="0"  cellspacing="0">
                    <tr>
                        <td class="ftopleft"></td>
                        <td  class="ftopcenter" colspan="2">อนุมัติรับถ่านจากการผลิต (คลังสินค้า)&nbsp;</td>
                        <td class="ftopright"></td>
                    </tr>
                    <tr >
                        <td class="fcenterleft"></td>
                        <td  colspan="2" class="fcentercenter">
                            <div align="center">
                                <table  cellpadding="0" cellspacing="0" >
                                    <tr>
                                        <td colspan="2" align="right"><b>หมายเลขเอกสาร : </b></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : </b></td>
                                    </tr>
                                    <tr>
                                        <td width="30%" align="right">เลขที่เอกสารการผลิตถ่านกัมมันต์*&nbsp;</td>
                                        <td class="columnobject">

                                            <input type='text' class="inputs" name='doc_id' id="doc_id" size='10' value='' />&nbsp;<a href="javascript:openBrWindow('vd_product_receive_header',51,'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                            <input type='button' name='search' onClick="showTablePage();" value='ค้นหา'/>
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
                                                        <td class="headergrid" colspan="9">เอกสารการผลิตถ่านกัมมันต์</td>
                                                        <td class="headergrid" colspan="6">สำหรับเจ้าหน้าที่คลังสินค้า</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="row5" width="3%"><input type="checkbox" name="chk_all" value="chk_all" onClick="javascript:chk();"/></td>
                                                        <td class="row5" width="3%">No.&nbsp;</td>
                                                        <td class="row5" width="5%">ชนิด&nbsp;</td>
                                                        <td class="row5" width="5%">ขนาด&nbsp;</td>

                                                        <td class="row5" width="12%">รหัสครบพาเลท&nbsp;</td>
                                                        <td class="row5" width="5%">เลทที่&nbsp;</td>

                                                        <td class="row5" width="5%">หน่วยบรรจุ&nbsp;</td>
                                                        <td class="row5" width="5%">น้ำหนักนำส่ง&nbsp;</td>
                                                        <td class="row5" width="7%">CTC/I2&nbsp;</td>

                                                        <td class="row5" width="15%">Prod.code&nbsp;</td>
                                                        <td class="row5" width="10%">โกดัง&nbsp;</td>
                                                        <td class="row5" width="5%">แถวที่&nbsp;</td>
                                                        <td class="row5" width="10%">น้ำหนักรับเข้าคลัง&nbsp;</td>
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
                                            <input type='button' name='but1' value='  บันทึก  ' onclick='RunData();'/>
                                            <input type='button' name='but2' value='  ยกเลิก  ' onclick='javascript:;'/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
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
            </div>
            </form>

    </body>
</html>
