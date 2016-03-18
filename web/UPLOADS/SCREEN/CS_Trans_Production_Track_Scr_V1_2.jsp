
<!DOCTYPE HTML>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>

<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <script type="text/javascript">
            function CheckDate() {
                if (getId("date_f").value != "" && getId("date_t").value != "") {
                    document.report.date_from.value = format_Date(getId("date_f").value);
                    document.report.date_to.value = format_Date(getId("date_t").value);
                    document.report.submit();
                } else if (getId("date_f").value == "" && getId("date_t").value == "") {
                    document.report.submit();
                } else {
                    alert("กรุณาใส่วันที่ให้ครบ");
                }
            }

        </script>        
    </head>

    <body onunload="closepopup()">
        <form name ="report" action="CS_Trans_Production_Track_Prc_V1_2.jsp" target="_blank" method ="post">
            <input type="hidden" name="chkNull" id="chkNull" value="date_f,date_t">
            <input type="hidden" name="date_from" value="">
            <input type="hidden" name="date_to" value="">        
            <table  cellpadding="0"  cellspacing="0">
                <tr>
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รายงานติดตามการผลิต (CS_Trans_Production_Track_Scr_V1_2)&nbsp;</td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <div align="left">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2"  class="blankspace"></td>
                                </tr>                               

                                <tr>
                                    <td class="columnlabel">ใบแจ้งการผลิต*&nbsp;</td>
                                    <td class="columnobject"><input name='job_id' type='text' class="inputs" id="job_id" value='' size='10'/>                                            
                                        <a href='#' onClick="openBrWindow('Vd_job_order_header&stadment=and+(delete_flag<>\'Y\')', 361, 'Search_Config2.jsp');">
                                            <img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        <input name='job_id_desc' type='text' class="inputs" id="job_id_desc" value='' size='30' readonly="readonly"/>                                
                                    </td>
                                </tr>                             
                                
                                <input name="date_f" type='hidden' class="inputs" id="date_f" value="" readonly/>
                                <input name="date_f" type='hidden' class="inputs" id="date_f" value="" readonly/>
                                <!--
                                <tr>
                                    <td class='columnobject'><div align="right">วันที่เริ่มต้น&nbsp;:&nbsp;</div></td>
                                    <td class='columnobject'><input name="date_f" type='text' class="inputs" id="date_f" value="" readonly/>
                                        &nbsp;<a id='date_1' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'date_f', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});
                                        </script>                                    </td>
                                    <td class='columnobject'><div align="right">ถึงวันที่&nbsp;:&nbsp;</div></td>
                                    <td class='columnobject'><input name="date_t" type='text' class="inputs" id="date_t" value="" readonly/>
                                        &nbsp;<a id='date_2' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'date_t', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_2', singleClick: true, step: 1});</script>                                    
                                    </td>
                                </tr>      
                                -->

                                <tr>
                                    <td colspan='2' class='blankspace' ></td>
                                </tr>                                

                                <tr>
                                    <td colspan='2' class='blankspace' align="right">
                                        <!--input type ="submit" class="cgcButton_19" value ="ประมวลผล" onclick="CheckDate()"-->
                                        <input type ="submit" class="cgcButton_19" value ="ประมวลผล" onclick="CheckDate()">
                                    </td>
                                </tr>                                

                                <tr>
                                    <td colspan='2' class='blankspace' ></td>
                                </tr>
                            </table>
                        </div></td>
                    <td class="fcenterright"></td>
                </tr>
                <tr bordercolor="0069B3">
                    <td class="ffootleft"></td>
                    <td  class="ffootcenter" colspan="2"></td>
                    <td class="ffootright"></td>
                </tr>
            </table>
        </form>
    </body>
</html>
