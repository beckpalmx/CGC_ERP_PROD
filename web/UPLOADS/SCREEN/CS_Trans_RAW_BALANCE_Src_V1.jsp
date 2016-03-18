<!DOCTYPE HTML>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <head>
        <%@ include file="PageHeader.jsp" %>
        <title></title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>         

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>                   

        <script type="text/javascript">

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });

        </script>        

        <script>
            $(document).ready(function() {
                $("button").click(function() {
                    if (getId("date_f").value != "" && getId("date_t").value != "") {
                        document.report.date_from.value = format_Date(getId("date_f").value);
                        document.report.date_to.value = format_Date(getId("date_t").value);
                        document.report.submit();
                    } else if (getId("date_f").value == "" && getId("date_t").value == "") {
                        document.report.submit();
                    } else {
                        alert("กรุณาใส่วันที่ให้ครบ");
                    }
                });
            });
        </script>


    </head>

    <body onunload="closepopup()"> 

        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;
                    <b>รายงานยอดคงเหลือวัตถุดิบ (CS_Trans_RAW_BALANCE_Src_V1)</b>
                </div>                

                <div class="panel-footer">

                    <form name ="report" action="CS_Trans_RAW_BALANCE_Prc_V1.jsp" target="_blank" method ="post">
                        <input type="hidden" name="chkNull" id="chkNull" value="date_f,date_t">
                        <input type="hidden" name="date_from" value="">
                        <input type="hidden" name="date_to" value="">          
                        <table  cellpadding="0"  cellspacing="0">                        
                            <tr>                                
                                <td class='columnobject'><div align="right"><b>กลุ่มวัตถุดิบ&nbsp;:</b>&nbsp;</div></td>      
                                <td class="columnobject"><input name="pgroup_id" type='text' class="inputs" id="pgroup_id" value="RAW" size="10" readonly data-toggle="tooltip" title="กลุ่มวัตถุดิบ">                                        
                            </tr>                                  

                            <tr>                                
                                <td class='columnobject'><div align="right"><b>ประเภทวัตถุดิบ&nbsp;:</b>&nbsp;</div></td>                                
                                <td class="columnobject"><input name="ptype_id" type='text' class="inputs" id="ptype_id" value="RAW" size="10" readonly data-toggle="tooltip" title="ประเภทวัตถุดิบ">                                                                            
                                &nbsp;<a href='#' onClick="" data-toggle="tooltip" title="ประเภทวัตถุดิบ"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;
                                    <input type="text" class="inputs" name="name_t_pgroup" id="name_t_pgroup" value="วัตถุดิบ" size="30"></td>
                            </tr>   
                            
                            <tr>                                
                                <td class='columnobject'><div align="right"><b>รหัสวัตถุดิบ&nbsp;:</b>&nbsp;</div></td>                                
                                <td class="columnobject"><input name="product_id" type='text' class="inputs" id="product_id" value="" size="10" readonly data-toggle="tooltip" title="รหัสถ่านวัตถุดิบ">                                        
                                    &nbsp;<a href='#' onClick="openBrWindow('Vproduct&stadment=and+pgroup_id+=+\'RAW\'', 301, 'Search_Config2.jsp')" data-toggle="tooltip" title="รหัสถ่านวัตถุดิบ"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;
                                    <input type="text" class="inputs" name="product_id_desc" id="product_id_desc" value="" size="30"></td>
                            </tr>                                                                                              

                            <tr>
                                <td class='columnobject'><div align="right"><b>วันที่เริ่มต้น&nbsp;:</b>&nbsp;</div></td>
                                <td class='columnobject'><input name="date_f" type='text' class="inputs" id="date_f" value="<%=start_year%>" readonly/>
                                    &nbsp;<a id='date_1' href="javascript:;" data-toggle="tooltip" title="เริ่มวันที่"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                    <script type='text/javascript'>Calendar.setup({inputField: 'date_f', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});
                                    </script>                                    </td>
                                <td class='columnobject'><div align="right"><b>ถึงวันที่&nbsp;:</b>&nbsp;</div></td>
                                <td class='columnobject'><input name="date_t" type='text' class="inputs" id="date_t" value="<%=end_current_month%>" readonly/>
                                    &nbsp;<a id='date_2' href="javascript:;" data-toggle="tooltip" title="ถึงวันที่"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                    <script type='text/javascript'>Calendar.setup({inputField: 'date_t', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_2', singleClick: true, step: 1});</script>                                    
                                </td>
                            </tr>      

                            <td>
                            <td colspan='2' class='blankspace' ></td>
                            </tr> 
                        </table>     

                        <button type="button" class="btn btn-primary btn-block" data-toggle="tooltip" title="กดปุ่มเพื่อประมวลผล" ><b>ประมวลผล</b></button>

                    </form>
                    <!--/div-->
                </div>
            </div>
        </div>
    </body>
</html>
