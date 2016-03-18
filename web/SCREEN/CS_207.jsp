<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <head>
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js">
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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



    </head>
    <body onUnload="closepopup()">
        <%UserBean userbean = (UserBean) session.getAttribute("user");%>
        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
        <input type="hidden" id="chkNull" value="name_t">
        <input type="hidden" id="status_u" value ="2">
        <input type="hidden" id ="status_d" value ="3">
        <input type="hidden" id="runno" value ="0">        
        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"><span class="glyphicon glyphicon-pencil" style="color:white"></span>&nbsp;<b>ทะเบียนกอง (วัตถุดิบ) (K) (CS_207)</b></div>       
                <div class="panel-footer">
                    <div align="center">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1"><b>รหัสกอง</b>&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='location_id' size='10' value='' id="location_id" />
                                    <a href='javascript:;' onClick="openBrWindow('mlocation&stadment=and+location_type+=+\'R\'', 207, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                    <input type='text' class="inputs" name='name_t' size='30' value='' id="name_t" />
                                </td>
                            </tr>

                            <tr>
                                <td class="columnlabel1">ราคาต่อหน่วย&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='price_per_unit' size='10' value='' id="price_per_unit" />
                                </td>
                            </tr>   

                            <tr>
                                <td class="columnlabel1">รหัสกองอ้างอิง&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='location_id_ref' size='10' value='' id="location_id_ref" />
                                </td>
                            </tr>                            

                            <tr>
                                <td class="columnlabel1">หมายเหตุ&nbsp;:&nbsp;</td>
                                <td class="columnobject"><textarea class="text_inputs" name='remark' rows='5' cols='40' id="remark"></textarea></td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'>
                                    <br>
                                    <div align="center">
                                        <a href="javascript:;" onClick="cancelAction()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogSave(URLsend('chkNull,runno,location_id,name_t,remark,username,location_id_ref,price_per_unit', '../JSP/CS_207.jsp'))"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogDelete(URLsend('runno,location_id,name_t,remark,status_d,username', '../JSP/CS_207.jsp'))"><img alt=""  src="../IMAGES/BTN_DEL_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                    </div>
                                    <br>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

