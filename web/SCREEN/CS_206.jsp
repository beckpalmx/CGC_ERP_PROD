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

        <script src="../JS/angularjs/angular.min.js"></script>                

        <script src="../JS/alertify/alertify.min.js"></script>        
        <link rel="stylesheet" href="../CSS/alertify/alertify.core.css" />
        <link rel="stylesheet" href="../CSS/alertify/alertify.default.css" />   



    </head>
    <body onUnload="closepopup()">
        <%UserBean userbean = (UserBean) session.getAttribute("user");%>
        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
        <input type="hidden" id="chkNull" value="job_type_id,job_type_desc">
        <input type="hidden" id="status_u" value ="2">
        <input type = "hidden" id ="status_d" value ="3">

        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"><span class="glyphicon glyphicon-wrench" style="color:white"></span>&nbsp;<b>ประเภทงาน (เอกสารนำส่งสินค้าเข้าคลัง) (CS_206)</b></div>       
                <div class="panel-footer">
                    <div align="center">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1"><b>รหัสประเภทงาน*</b>&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='job_type_id' size='10' value='' id="job_type_id" />
                                    <a href='javascript:;' onClick="openBrWindow('mjob_type_detail', 204, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                    <input type='text' class="inputs" name='job_type_desc' size='30' value='' id="job_type_desc" />
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
                                        <a href="javascript:;" onClick="confirmDialogSave(URLsend('chkNull,job_type_id,job_type_desc,remark,username', '../JSP/CS_206.jsp'))"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogDelete(URLsend('job_type_id,job_type_desc,remark,status_d,username', '../JSP/CS_206.jsp'))"><img alt=""  src="../IMAGES/BTN_DEL_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
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
