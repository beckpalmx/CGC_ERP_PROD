<!DOCTYPE HTML>
<%@page import="com.cgc.DB.MenuDAO"%>
<%@page import="com.cgc.bean.MenuBean"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
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

        <script type="text/javascript">
            function clearckbox()
            {
                for (i = 0; i < document.getElementsByName("menu").length; i++)
                {
                    document.getElementsByName("menu")[i].checked = false;
                }
                openBrWindow('Priviledge', 4, 'Search_Config.jsp');
            }
            function RunBox() { //v2.0
                var list = new Array();
                var box = String();
                box = "";
                list = document.getElementsByName("menu");
                for (i = 0; i < list.length; i++) {
                    if (document.getElementsByName("menu")[i].checked === true) {
                        box = box + list[i].value + ",";
                    }
                }
                box = box.substr(0, box.length - 1);
                document.getElementById("box").value = box;
                confirmDialogSave(URLsend('chkNull,priviledge_id,name_t,remark,box', '../JSP/CS_004.jsp'));
            }
        </script>
        <title>CGC ERP</title>
    </head>
    <%!        MenuBean menuBean = new MenuBean();
        MenuDAO menuDAO = new MenuDAO();
        ArrayList<MenuBean> listMain, listSub;
        String text = "";
    %>
    <%
        text = "<div nowrap><ul>";
        listMain = new ArrayList<MenuBean>();
        listSub = new ArrayList<MenuBean>();        
        
        listMain = menuDAO.selectDataMainList();
        for (MenuBean mainBean : listMain) {
            text = text + "<li><font size='2'><input type='checkbox' value='" + mainBean.getMain_menu_id() + "' name='menu' id='" + mainBean.getMain_menu_id() + "'>" + " " + mainBean.getName_t() + " - " + mainBean.getMain_menu_id() + "</font></li><ul>\n";
            listSub = menuDAO.selectDataSubList(mainBean.getMain_menu_id());
            for (MenuBean subBean : listSub) {
                text = text + "<li><font size='2'><input type='checkbox' value='" + subBean.getSub_menu_id() + "' name='menu' id='" + subBean.getSub_menu_id() + "'>" + " " + subBean.getName_t() + " - " + subBean.getSub_menu_id() + "</font></li>\n";
            }
            text = text + "</ul>";
        }
        text = text + "</ul></div>";

        System.out.println("text = " + text);


    %>

    <script type="text/javascript">

        $(document).ready(function() {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>                   

    <body onunload="closepopup()">
        <form id="userForm" class="form-horizontal">        

            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"><span class="glyphicon glyphicon-wrench" style="color:white"></span>&nbsp;<b>สิทธิ์การใช้งาน (CS_004)</b></div>
                    <div class="panel-footer">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1"><b>รหัสสิทธิ์การใช้งาน*</b>&nbsp;</td>
                                <td class="columnobject">
                                    <input name='priviledge_id' type='text' class="inputs" id="priviledge_id" value='' size='10' />
                                    &nbsp;<a href='javascript:;' onclick="clearckbox()"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    <input name='name_t' type='text' class="inputs" id="name_t" value='' size='30' />                                
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1"><b>หมายเหตุ&nbsp;</b></td>
                                <td class="columnobject"><textarea class="text_inputs" name='remark' cols='40' rows='5' id="remark"></textarea></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1"><b>กำหนดสิทธิ์การเข้าใช้งานระบบ&nbsp;</b></td>
                                <td class="columnobject"></td>
                            </tr>
                            <tr>
                                <td valign="top"  class="columnlabel1">&nbsp;</td>
                                <td valign="top" >
                                    <div align="left">
                                        <table  class="large" border="0" cellpadding="0" cellspacing="0" >
                                            <tr>
                                                <td class="writeback"><%=text%></td>
                                            </tr>
                                        </table>
                                    </div></td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace'></td>
                            </tr>
                        </table>                                                                
                        <input type="hidden" id="chkNull" value="priviledge_id,name_t">
                        <input type="hidden" id="chkstatus" value="1">
                        <input type="hidden" id="box" value="">                
                        <div>
                            <button type="button" class="btn btn-primary btn-block" onclick="RunBox()" data-toggle="tooltip" title="กดปุ่มเพื่อบันทึกข้อมูล"><b>บันทึกข้อมูล</b></button>     
                        </div> 
                        <table>
                            <tr>
                                <td></td>
                            </tr>
                        </table>                
                        <div>                            
                            <button type="button" class="btn btn-warning btn-block" onclick="cancelAction()" data-toggle="tooltip" title="กดปุ่มเพื่อ Clear หน้าจอ"><b>ยกเลิก</b></button>
                        </div>         
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
