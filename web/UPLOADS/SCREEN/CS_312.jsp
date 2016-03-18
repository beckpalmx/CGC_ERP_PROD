<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--meta http-equiv="Content-Type" content="text/html; charset=UTF-8"-->
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">     
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
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
            function getStatus() {
                if (document.getElementById("radio1").checked) {
                    document.getElementById("status").value = 0;
                } else if ((document.getElementById("radio2").checked)) {
                    document.getElementById("status").value = 1;
                }
            }
        </script>

    </head>

    <body onUnload="closepopup()">

        <% UserBean userbean = (UserBean) session.getAttribute("user");%>
        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>

        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-wrench" style="color:white"></span>&nbsp;<b>ข้อความ&nbsp;(CS_312)</b></div>
                <div class="panel-footer">              
                    <div align="center">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1"><b>รหัสข้อความ*</b>&nbsp;</td>
                                <td class="columnobject">
                                    <input name='message_id' type='text' class="inputs" id="message_id" value='' size='10' />
                                    &nbsp;<a href='javascript:;' onClick="openBrWindow('vmessage', 312, 'Search_Config_Display.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ข้อความ*&nbsp;</td>
                                <td class="columnobject">
                                    <!--input name='message_detail' type='text' class="inputs" id="message_detail" value='' size='50' /-->
                                    <textarea class="text_inputs_3" id="message_detail" name='message_detail' cols='100' rows='5'></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">แสดงข้อความ*&nbsp;</td>
                                <td class="columnobject"><input type="hidden" name="status" id="status">
                                    <input type="radio" name="radio" id="radio1" value="radio" onClick="getStatus()" checked>
                                    แสดง
                                    <input type="radio" name="radio" id="radio2" value="radio" onClick="getStatus()">
                                    ไม่แสดง</td>
                            </tr>


                            <tr>
                                <td colspan='2' class='blankspace'></td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace'><div align="center">
                                        <input type="hidden" id="chkstatus" value="1"/>
                                        <input type="hidden" id="chkNull" value="message_id,message_detail">
                                        <a href="javascript:;" onClick="cancelAction()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogSave(URLsend('chkNull,message_id,message_detail,status,username', '../JSP/CS_312.jsp'))">&nbsp;<img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0">&nbsp;</a>
                                        <a href="javascript:;" onClick="confirmDialogDelete(URLsend('message_id,message_detail,status,chkstatus,username', '../JSP/CS_312.jsp'))"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a></div></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
