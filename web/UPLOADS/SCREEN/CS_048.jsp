<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
    </head>
    <script language="javascript">
        <!--
        function cancal(){
            cancelAction();
            getId("show").innerHTML = "";
        }
        function showTable(){
            var data = new String();
            data = getId("table_s1").value +","+getId("process_id").value+",";
            getId("table_s1").value = data;
            getId("show").innerHTML = "";
                
            showTableNonPopup('show', 'table_s1', '../JSP/CS_048_List.jsp?table=');
        }
            
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

        function RunData(){
            var data5 = new String();
            if(getId("process_id").value == 'PR_022')
                data5 = "total_price_";
            else 
                data5 = "location_out_";
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
                            var s1 = theInput.value+":"+document.getElementById("prod_code_"+cnt).value+":"+document.getElementById("location_"+cnt).value+":"+document.getElementById("wh_"+cnt).value+":"+document.getElementById("weight_"+cnt).value+":"+document.getElementById(data5+""+cnt).value+":";
                            list.push(s1);
                        }
                        cnt++;
                    }       
                }
            }
            var chkList = list.length;
            for(j=list.length;j > 0;j--){
                if(j == chkList){
                    URL = "../JSP/CS_048.jsp?cntData="+chkList+"&process_id="+getId("process_id").value+"&param"+j+"="+list.pop();
                }else {
                    URL = URL + "&param"+(j)+"="+list.pop();
                }
            }
            var array = new Array;
            array[0] = URL;
            array[1] = ""
            confirmDialogSave(array);
            getId("show").innerHTML = "";
        }
        //-->
    </script>
    <body onUnload="closepopup()">
        <div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
        <form name="btform" method="post" action="CS_048.jsp">
            <input type="hidden" name="table_h" id="table_h" >
            <input type="hidden" name="table_s1" id="table_s1" >
            <input type="hidden" name="table_s2" id="table_s2" >
            <div>

                <table  cellpadding="0"  cellspacing="0">
                    <tr >
                        <td class="ftopleft"></td>
                        <td  class="ftopcenter" colspan="2">อนุมัติรับ-จ่าย (คลังสินค้า)&nbsp;(CS_048)</td>
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
                                        <td width="30%" align="right"></td>
                                        <td class="columnobject">รหัส process* 
                                            <input type='text' class="inputs" name='process_id' id="process_id" size='10' value='' />&nbsp;<a href='javascript:;' onclick="openBrWindow('vmprocess&stadment=and+doc_type+<>+\'N\'', 48, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                            <input type='text' class="inputs" name='name_t' size='30' value='' />
                                            <input type='button' class="cgcButton_6" name='search' onClick="showTable()" value='ค้นหา'/>
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
                                                        <td class="headergrid" colspan="7">เอกสาร</td>
                                                        <td class="headergrid" colspan="4">คลังสินค้า</td>
                                                    </tr>

                                                    <tr>
                                                        <td class="row3" width="3%"><input type="checkbox" name="chk_all" value="chk_all" onClick="javascript:chk();"/></td>
                                                        <td class="row3" width="3%">No.&nbsp;</td>
                                                        <td class="row3" width="14%">เลขที่เอกสาร&nbsp;</td>
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
                                            <div style="width:100%; height: 150px; overflow: auto;" id="show">
                                                <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">

                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' align="right">
                                            <input type='button' name='but1' value='  บันทึก  ' onclick='javascript:RunData();'/>
                                            <input type='button' name='but2' value='  ยกเลิก  ' onclick='cancal()'/>
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
