<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <head>
        <title></title>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">        
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>                          

        <script language="javascript">
            <!--
            var my_window = null;
            var t;
            function MM_openBrWindow(theURL, winName, features) { //v2.0
                if (my_window == null) {
                    my_window = window.open(theURL, winName, features);
                } else {
                    closepopup();
                    my_window = window.open(theURL, winName, features);
                }
            }

            function AddHeader()
            {
                if (getId('product_id').value == '') {
                    alert('กรุณาใส่รหัสสินค้า');
                } else {
                    var r = confirm("คุณต้องการบันทึกหรือไม่")
                    if (r)
                    {
                        //getSave(URLsend('complete_flag,chkNull,doc_id,doc_date,doc_type,doc_time,remark,username', '../JSP/CS_117.jsp'));
                        getSave(URLsend('chkNull,screen_id,lot_no,product_id,name_t_product,pgroup_id,pcat_id,ptype_id,price,min,max,safety,warehouse_id,location_id,value,remark_product,size_id,butane,ctc,iodine,unit_id,weight,username', '../JSP/CS_021.jsp'))
                    }
                }
            }
//-->

            function Delete_Data() {
                if (getId('product_id').value == '') {
                    alert('กรุณาเลือกรหัสสินค้าที่ต้องการลบ !!!');
                } else {
                    confirmDialogDelete(URLsend('screen_id,product_id,name_t_product,pgroup_id,pcat_id,ptype_id,price,min,max,safety,warehouse_id,location_id,value,remark_product,chkstatus,size_id,butane,ctc,iodine,unit_id,weight', '../JSP/CS_021.jsp'))
                }
            }

        </script>        
    </head>
    <body onUnload="closepopup()">

        <div class="container">
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-pencil" style="color:white"></span>&nbsp;
                    <b>ทะเบียนสินค้า(CS_021)</b>
                </div>                        
                <div class="panel-footer">                  

                    <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
                        <%
                            UserBean userbean = (UserBean) session.getAttribute("user");
                        %>
                        <input type="hidden" id="screen_id" name="screen_id" value="CS_021">
                        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1"><b>รหัสสินค้า*&nbsp;:&nbsp;</b></td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='product_id' id="product_id" value='' />&nbsp;<a href='javascript:;' onClick="openBrWindow('vproduct', 21, 'Search_Config2_1.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    <input type='text' class="inputs" name='name_t_product' id="name_t_product" size='70' value='' />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">Lot No.&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='lot_no' id="lot_no" size='30' value='' />
                                </td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel1">กลุ่มสินค้า*&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='pgroup_id' id="pgroup_id"  size='10' value='' readonly/>&nbsp;<a href='javascript:;' onClick="openBrWindow('mproduct_group', 21, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                    <input type='text' class="inputs" name='name_t_pgroup' id="name_t_pgroup" size='30' value='' readonly/>
                                    <input type="hidden" name="remark_pgroup" id="remark_pgroup">
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ชนิดสินค้า*&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='pcat_id' id="pcat_id" size='10' value='' readonly/>&nbsp;<a href='javascript:;' onClick="openBrWindow('mproduct_cat', 21, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='à¸à¹à¸à¸«à¸²' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                    <input type='text' class="inputs" name='name_t_pcat' id="name_t_pcat" size='30' value='' readonly/>
                                    <input type="hidden" name="remark_pcat" id="remark_pcat">
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ประเภทสินค้า*&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='ptype_id' id="ptype_id" size='10' value='' readonly/>&nbsp;<a href='javascript:;' onClick="openBrWindow('mproduct_type', 21, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='à¸à¹à¸à¸«à¸²' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                    <input type='text' class="inputs" name='name_t_ptype' id="name_t_ptype" size='30' value='' readonly/>
                                    <input type="hidden" name="remark_ptype" id="remark_ptype">
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ราคาสินค้า²&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='price' id="price" size='30' value='' onKeyUp="IsNumeric(this.value, this)"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">จุดต่ำสุด&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='min' id="min" size='30' value='' onKeyUp="IsNumeric(this.value, this)"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">จุดสูงสุด&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='max' id="max" size='30' value='' onKeyUp="IsNumeric(this.value, this)"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">จุด Safety&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='safety' id="safety" size='30' value='' onKeyUp="IsNumeric(this.value, this)"/>                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">หน่วยนับ*&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='unit_id' id="unit_id"  size='10' value='' readonly/>&nbsp;<a href='javascript:;' onClick="openBrWindow('munit_code', 21, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                    <input type='text' class="inputs" name='unit_name' id="unit_name" size='30' value='' readonly/>
                                </td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel1">น้ำหนักต่อหน่วย*&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='weight' id="weight" size='10' value='' />&nbsp;
                                    <input type='hidden' class="inputs" name='warehouse_id' id="warehouse_id" size='10' value='' />&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">เลขกอง&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='location_id' id="location_id" size='30' value='' />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">มูลค่า&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='value' id="value" size='30' value='' />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ขนาดถ่าน*&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='size_id' id="size_id"  size='10' value='' readonly/>&nbsp;<a href='javascript:;' onClick="openBrWindow('m_carbon_size', 21, 'Search_Config_Integer.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                    <input type='text' class="inputs" name='size_name' id="size_name" size='30' value='' readonly/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">Butane&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='butane' id="butane" size='30' value='' />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">CTC&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='ctc' id="ctc" size='30' value='' />
                                </td>
                            </tr>

                            <tr>
                                <td class="columnlabel1">ไอโอดีน (Iodine) *&nbsp;:&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="iodine" id="iodine" value="" onclick="openBrWindow('m_iodine_product&textinput=iodine', 0, 'Search_Detail_Desc.jsp')" readonly/></td>
                            </tr>                                        

                            <tr>
                                <td class="columnlabel1">ความเคลื่อนไหวล่าสุด &nbsp;:&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name='last_movement' id="last_movement" readonly='true'>
                                    &nbsp;(ตรวจสอบจากการทำรายการ)
                                </td>
                            </tr>                                

                            <tr>
                                <td class="columnlabel1">หมายเหตุ&nbsp;:&nbsp;</td>
                                <td class="columnobject"><textarea class="text_inputs" name='remark_product' id="remark_product" rows='5' cols='40'></textarea></td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'></td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace'><div align="center">
                                        <input type="hidden" id="chkstatus" value="1">
                                        <input type="hidden" id="chkNull" value="product_id,name_t_product,pgroup_id,pcat_id,ptype_id,weight,iodine">
                                        <a href="javascript:;" onClick="cancelAction()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="AddHeader()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="Delete_Data()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" class="imgtransparent"  width="80" height="30" border="0"></a></div></td>
                            </tr>
                        </table>
                </div>
                </body>
                </form>
            </div>
        </div>
</html>
