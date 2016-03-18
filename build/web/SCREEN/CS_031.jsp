<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <head>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
            function goProcess(){
                var IDsend = "";
                var Nochk = true;
                for(var i=0;i<document.getElementsByName("ckBox").length;i++)
                {
                    if(document.getElementsByName("ckBox")(i).checked ==true){

                        if(getId("location_id_"+(i+1).toString()).value == ""){
                            getId("line_no").value = "";
                            getId("location_id_"+(i+1).toString()).focus();
                            IDsend ="";
                            Nochk = false;
                            break;
                        }
                        else if(getId("product_id_"+(i+1).toString()).value == ""){
                            getId("line_no").value = "";
                            getId("product_id_"+(i+1).toString()).focus();
                            IDsend ="";
                            Nochk = false;
                            break;
                        }
                        else if(getId("wh_id_"+(i+1).toString()).value == ""){
                            getId("line_no").value = "";
                            getId("wh_id_"+(i+1).toString()).focus();
                            IDsend ="";
                            Nochk = false;
                            break;
                        }
                        else{
                            getId("line_no").value += (i+1).toString()+",";
                            IDsend += "product_id_"+(i+1).toString()+","+"location_id_"+(i+1).toString()+","+"wh_id_"+(i+1).toString()+",";
                            Nochk = false;
                        }
                    }
                }
                if(Nochk != true && IDsend != ""){
                    getId("line_no").value = getId("line_no").value.substr(0, getId("line_no").value.length-1);
                    IDsend = IDsend.substr(0, IDsend.length-1);
                    IDsend = "doc_id,line_no,"+IDsend;
                    //alert(IDsend);
                    getSave(URLsend(IDsend, "../JSP/CS_031.jsp"));
                    getId("doc_id").value = "";
                    getId("line_no").value = "";
                    getId("show").innerHTML = "";
                    document.getElementsByName("chk_all").checked = false;
                }else if(Nochk != true && IDsend == ""){
                    alert("กรุณากรอกข้อมูลให้ครบ");
                }
                else{
                    alert("กรุณาเลือกข้อมูลที่จะบันทึก");
                }
                
            }
            function goCancel(){
                cancelAction();
                getId("show").innerHTML = "";
                getId("line_no").value = "";
                document.getElementsByName("chk_all").checked = false;

            }
            
            function search(){
                showTableNonPopup("show", "doc_id", "../JSP/CS_Show031.jsp?doc_id=");
            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    document.getElementsByName("ckbox")(i).checked = Value;
                }

            }
        </script>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CGC ERP</title>
    </head>
    <body>
        <%
                    DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                    HeaderScreen_Process h_p = new HeaderScreen_Process();
                    objs_p = h_p.selectheaderscreen_process(objs_p, "CS_029");
                    UserBean userbean = (UserBean) session.getAttribute("user");
        %>
        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
        <input type="hidden" id="status_cancle" value="">
        <input type="hidden" id="line_no" value="">
        <div align="center">
            <table  cellpadding="0"  cellspacing="0">
                <tr >
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รับถ่านออกจากเตาเข้าคลังสินค้า(CS_031)&nbsp;</td>
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
                                    <td width="30%" align="right">เลขที่เอกสารออกจากเตา*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' />
                                        &nbsp;<a href='#' onClick="openBrWindow('vd_carbon_burn_out_header&stadment=and+complete_flag+<>+\'Y\'', 31, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                        <input name='doc_date' type='hidden' id="doc_date" value='' size='10' readonly="readonly"/>
                                        <input type="button" name="search" id="search" value="ค้นหา" onClick="search();">
                                        
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <div style="width:100%;">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">

                                                <tr>
                                                    <td class="row3" width="3px"><input type="checkbox" name="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                    <td class="row3" width="7%">ลำดับที่&nbsp;</td>
                                                    <td class="row3" width="10%">รหัสถ่าน&nbsp;</td>
                                                    <td class="row3" width="10%">ขนาด&nbsp;</td>
                                                    <td class="row3" width="10%">ยอดยกมา&nbsp;</td>
                                                    <td class="row3" width="5%">CTC/I2&nbsp;</td>
                                                    <td class="row3" width="10%">ถุง(Kg)&nbsp;</td>
                                                    <td class="row3" width="10%">น้ำหนัก&nbsp;</td>
                                                    <td class="row3" width="10%">เก็บโกดัง&nbsp;</td>
                                                    <td class="row3" width="10%">เลขกอง&nbsp;</td>
                                                    <td class="row3" width="15%">Product_code&nbsp;</td>
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
                                        <input type='button' name='but1' value='  บันทึก  ' onclick='javascript:goProcess();'/>
                                        <input type='button' name='but2' value='  ยกเลิก  ' onclick='javascript:goCancel();'/>
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

    </body>

</html>
