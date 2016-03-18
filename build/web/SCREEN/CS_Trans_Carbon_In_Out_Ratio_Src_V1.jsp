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
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
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
                    document.report.submit();
                });
            });
        </script>

        <script type="text/javascript">
            function minmax(value, min, max)
            {
                if (parseInt(value) < min || isNaN(value))
                    return min;
                else if (parseInt(value) > max)
                    return max;
                else
                    return value;
            }
        </script>        

    </head>

    <body onunload="closepopup()"> 

        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;
                    <b>รายงานอัตราส่วนถ่านเติมเตา - ถ่านออกจากเตา (CS_Trans_Carbon_In_Out_Ratio_Src_V1)</b>
                </div>                

                <div class="panel-footer">

                    <form name ="report" action="CS_Trans_Carbon_In_Out_Ratio_Prc_V1.jsp" target="_blank" method ="post">
                        <input type="hidden" name="chkNull" id="chkNull" value="">
                        <table  cellpadding="0"  cellspacing="0">                        
                            <tr>                                
                                <td class='columnobject'><div align="right"><b>ปี พ.ศ.&nbsp;:</b>&nbsp;</div></td>      
                                <td class="columnobject"><input name="doc_year" type='text' class="inputs" id="doc_year" value="<%=current_year%>" size="10" data-toggle="tooltip" title="ปี พ.ศ.">                                        
                            </tr>                                  
                            <tr>                                
                                <td class='columnobject'><div align="right"><b>เริ่มจากเดือนที่&nbsp;:</b>&nbsp;</div></td>
                                <td class="columnobject"><input name="month_from" type='text' class="inputs" id="month_from" value="1" size="10" data-toggle="tooltip" title="เดือนที่"  onkeyup="this.value = minmax(this.value, 1, 12)">
                                <td class='columnobject'><div align="right"><b>ถึงเดือนที่&nbsp;:</b>&nbsp;</div></td>    
                                <td class="columnobject"><input name="month_to" type='text' class="inputs" id="month_to" value="12" size="10" data-toggle="tooltip" title="เดือนที่"  onkeyup="this.value = minmax(this.value, 1, 12)">                                    
                            </tr>                                 
                            <tr>                                
                                <td class='columnobject'><div align="right"><b>เริ่มจากเตาที่&nbsp;:</b>&nbsp;</div></td>
                                <td class="columnobject"><input name="burn_from" type='text' class="inputs" id="burn_from" value="1" size="10" data-toggle="tooltip" title="เตาที่" onkeyup="this.value = minmax(this.value, 1, 8)">
                                <td class='columnobject'><div align="right"><b>ถึงเตาที่&nbsp;:</b>&nbsp;</div></td>    
                                <td class="columnobject"><input name="burn_to" type='text' class="inputs" id="burn_to" value="8" size="10" data-toggle="tooltip" title="เตาที่" onkeyup="this.value = minmax(this.value, 1, 8)">                                    
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
