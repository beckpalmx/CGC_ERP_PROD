
<%@page import="com.cgc.bean.UserBean"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
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
            function CheckDate(){
                if(getId("date_f").value != "" && getId("date_t").value != ""){
                    document.report.date_from.value = format_Date(getId("date_f").value);
                    document.report.date_to.value =  format_Date(getId("date_t").value);  
                    //alert(document.report.date_from.value);
                    //alert(document.report.date_to.value);
                    document.report.submit();                     
                }else if(getId("date_f").value == "" && getId("date_t").value == ""){
                    document.report.submit();
                }else{
                    alert("กรุณาใส่วันที่ให้ครบ");
                }
            }
        </script>        
    </head>

    <body onunload="closepopup()">
        <form name ="report" action="CS_Trans_RAWMAT_01.jsp" target="_blank" method ="post">
            <input type="hidden" name="date_from" value="">
            <input type="hidden" name="date_to" value="">        
            <table  cellpadding="0"  cellspacing="0">
                <tr>
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รายงานความเคลื่อนไหวถ่านวัตถุดิบ (ถ่านสี)&nbsp;</td>
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
                                    <td class="columnlabel">กลุ่มสินค้า</td>
                                    <td class="columnobject"><input name="pgroup_id" type='text' class="inputs" id="pgroup_id" value="RAW" size="20" readonly>&nbsp;&nbsp;<a href='#' onClick="openBrWindow('mproduct_group', 21, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                        <input type="hidden" name="name_t_pgroup" id="name_t_pgroup" value="" size="40"></td>
                                </tr>                                  
                                <tr>
                                    <td class="columnlabel">รหัสสินค้า</td>
                                    <td class="columnobject"><input name="product_id" type='text' class="inputs" id="product_id" value="" size="20" readonly>&nbsp;&nbsp;<a href='#' onClick="openBrWindow('Vproduct', 301, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                        <input type="hidden" name="product_id_desc" id="product_id_desc" value="" size="40"></td>
                                </tr>                                                                         
                                <tr>
                                    <td class='columnobject'><div align="right">วันที่เริ่มต้น&nbsp;:&nbsp;</div></td>
                                    <td class='columnobject'><input name="date_f" type='text' class="inputs" id="date_f" value="" readonly/>
                                        &nbsp;<a id='date_1' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField:'date_f',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});
                                        </script>                                    </td>
                                    <td class='columnobject'><div align="right">ถึงวันที่&nbsp;:&nbsp;</div></td>
                                    <td class='columnobject'><input name="date_t" type='text' class="inputs" id="date_t" value="" readonly/>
                                        &nbsp;<a id='date_2' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField:'date_t',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_2',singleClick:true,step:1});</script>                                    
                                    </td>
                                </tr>      

                                <tr>
                                    <td colspan='2' class='blankspace' ></td>
                                </tr>                                

                                <tr>
                                    <td colspan='2' class='blankspace' align="right">
                                        <input type ="submit" class="cgcButton" style="width:120px;height: 30px;"  value ="ประมวลผล" onclick="CheckDate()">
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
