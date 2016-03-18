
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>        
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">        

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>           

    </head>

    <script type="text/javascript">

        $(document).ready(function() {
            $('[data-toggle="tooltip"]').tooltip();
        });

    </script>      

    <script type="text/javascript">

        function validateForm() {
            if (document.getElementById('job_id').value == '') {
                alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                return false;
            } else {
                document.report.submit();
            }
        }
    </script>

    <body onunload="closepopup()">
        <form name="report" method="post" action="CS_Production_Receive_Trans.jsp" onsubmit="return validateForm()" target="_blank">                                
            <% UtiDatabase objuti = new UtiDatabase();%>           

            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;
                        <b>ประมวลผลสรุปข้อมูลผลิต (All New) (CS_Production_Receive_Trans_frm)</b>
                    </div>                

                    <div class="panel-footer">            
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnobject"><b>ใบแจ้งการผลิต*</b>&nbsp;</td>
                                <td class="columnobject"><input name='job_id' type='text' class="inputs" id="job_id" value='' size='10' />&nbsp;&nbsp;
                                    <a href='#' onClick="openBrWindow('Vd_job_order_header&stadment=and+(delete_flag<>\'Y\')', 361, 'Search_Config2.jsp');" data-toggle="tooltip" title="เลขที่ใบแจ้งการผลิต">
                                        <img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                    &nbsp;&nbsp;&nbsp;<input name='job_id_desc' type='text' class="inputs" id="job_id_desc" value='' size='30' readonly="readonly"/>                                
                                </td>
                            </tr>  
                            <!--tr>
                                <td colspan='2' class='blankspace' align="right">                                        
                            <!--input type ="submit" class="cgcButton" style="width:120px;height: 30px;"  value ="ประมวลผล" onclick="summit_data()"></td-->
                            <!--input type ="submit" class="cgcButton" style="width:120px;height: 30px;"  value ="ประมวลผล" onclick="validateForm()"></td-->
                            <!--/tr-->          

                            <tr>
                                <td colspan='2' class='blankspace' ></td>
                            </tr>
                        </table>
                        <button type="submit" class="btn btn-primary btn-block" data-toggle="tooltip" title="กดปุ่มเพื่อประมวลผล"  onclick="validateForm()" ><b>ประมวลผล</b></button>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
