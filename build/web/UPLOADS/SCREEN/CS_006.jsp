<%@page import="com.cgc.bean.UserBean"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <%
        UserBean userbean = (UserBean) session.getAttribute("user");
    %>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
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
        <script type="text/javascript">
            function ckvalue()
            {
                if (getId("passwordnew_1").value === getId("passwordnew_2").value && getId("passwordnew_1").value !== getId("password").value && getId("passwordnew_2").value !== getId("password").value)
                {
                    //alert("test2");
                    confirmDialogSave(URLsend('chkNull,username,password,passwordnew_1,passwordnew_2', '../JSP/CS_006.jsp'))
                }
                else if (getId("passwordnew_1").value === getId("password").value && getId("passwordnew_2").value === getId("password").value)
                {
                    alert("คุณกรอกรหัสผ่านเหมือนเดิม กรุณากรอกรหัสผ่านใหม่ถ้าต้องการเปลี่ยนรหัสผ่าน");
                }
                else
                {
                    alert("คุณกรอก Password ไม่เหมือนกัน กรุณากรอกใหม่");
                }
            }
        </script>
    </head>

    <body>
        <input type="hidden" id="chkNull" value="passwordnew_1,passwordnew_2">
        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"><span class="glyphicon glyphicon-pencil" style="color:white"></span>&nbsp;<b>เปลี่ยนรหัสผ่าน&nbsp;(CS_006)</b></div>       
                <div class="panel-footer">
                    <div align="center">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1"><b>ผู้ใช้งาน*</b>&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input name="username" type='text' class="inputs" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">รหัสผ่านเดิม&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input name="password" type="password" class="inputs" id="password" value="" size="30"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">รหัสผ่านใหม่&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input name="passwordnew_1" class="inputs" type="password" id="passwordnew_1" value="" size="30"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">รหัสผ่านใหม่(อีกครั้ง)&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input name="passwordnew_2" class="inputs" type="password" id="passwordnew_2" value="" size="30"/>
                                </td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'>
                                    <br>
                                    <div align="center">
                                        <a href="javascript:;" onclick="cancelAction()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="ckvalue()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
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