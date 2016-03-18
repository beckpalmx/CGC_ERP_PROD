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
        <input type="hidden" id="chkNull" value="iod_code,iod_range">
        <input type="hidden" id="status_u" value ="2">
        <input type = "hidden" id ="status_d" value ="3">
        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"><span class="glyphicon glyphicon-pencil" style="color:white"></span>&nbsp;<b>ทะเบียนค่า Iodine&nbsp;(CS_205)</b></div>       
                <div class="panel-footer">
                    <div align="center">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1"><b>รหัสค่า IODINE*</b>&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' class="inputs" name='iod_code' size='15' value='' id="iod_code" />
                                    &nbsp;<a href='javascript:;' onClick="openBrWindow('m_iodine', 205, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    <input type='text' class="inputs" name='name_t' size='30' value='' id="name_t" />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ประเภท&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <select class="select_cgc" name="iod_ctype" id="iod_ctype">
                                        <option value="C" selected>C ถ่านกะลา</option>
                                        <option value="P">P ถ่านปาล์ม</option>
                                        <option value="U">U ถ่านไม้ยูคาฯ</option>
                                        <option value="K">K ไม้โกงกาง</option>
                                        <option value="D">D ฝุ่น</option>
                                        <option value="CP">CP</option>
                                        <option value="CF">CF</option>
                                        <option value="PF">PF</option>
                                        <option value="UF">UF</option>
                                        <option value="KF">KF</option>
                                    </select></td>
                            </tr>                             
                            <tr>
                                <td class="columnlabel1">ช่วงค่า IODINE&nbsp;:&nbsp;</td>
                                <td class="columnobject"><input name="iod_range" type='text' class="inputs" id="iod_range" maxlength="20">
                                </td>
                            </tr>   
                            <tr>
                                <td class="columnlabel1">ช่วงค่า BUTANE&nbsp;:&nbsp;</td>
                                <td class="columnobject"><input name="butane" type='text' class="inputs" id="butane" maxlength="20">
                                </td>
                            </tr>  
                            <tr>
                                <td class="columnlabel1">ช่วงค่า CTC&nbsp;:&nbsp;</td>
                                <td class="columnobject"><input name="ctc" type='text' class="inputs" id="ctc" maxlength="20">
                                    <label>                                        </label></td>
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
                                        <a href="javascript:;" onClick="confirmDialogSave(URLsend('chkNull,iod_code,iod_ctype,iod_range,butane,ctc,name_t,remark,username', '../JSP/CS_205.jsp'))"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogDelete(URLsend('iod_code,iod_ctype,iod_range,butane,ctc,name_t,remark,status_d,username', '../JSP/CS_205.jsp'))"><img alt=""  src="../IMAGES/BTN_DEL_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
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
