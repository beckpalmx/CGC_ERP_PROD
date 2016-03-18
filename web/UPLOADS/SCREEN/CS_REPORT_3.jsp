<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<!DOCTYPE HTML>
<%!    String path;
    String lookup;
%>
<%
    path = (String) request.getParameter("report_code");
    lookup = (String) request.getParameter("lookup");
    UtiDatabase objuti = new UtiDatabase();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CGC ERP</title>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script type="text/javascript" src="../JS/myAjaxFramework.js"></script>

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>          

        <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">              

        <script type="text/javascript">

            function openBrown(tableID) {
                //alert("../SEARCHSCREEN/Search_Report.jsp?table="+getId(tableID).value+"");
                window.open("../SEARCHSCREEN/Search_Report.jsp?table=" + tableID);
            }

            var my_window = null;
            function MM_openBrWindow(theURL, winName, features) { //v2.0
                if (my_window == null) {
                    my_window = window.open(theURL, winName, features);
                } else {
                    closepopup();
                    my_window = window.open(theURL, winName, features);
                }
            }


            function CheckDate() {
                // alert("ok : " + format_Date(getId("date_f").value));
                if (getId("date_f").value != "" && getId("date_t").value != "") {
                    //if(!ChkDate(getId("date_f").value, getId("date_t").value)){
                    //date_form = format_Date(getId("date_f").value);
                    //date_to = format_Date(getId("date_t").value);

                    document.report.date_form.value = format_Date(getId("date_f").value);//dateFormat(da1.format,'yyyy-mm-dd').tostring;
                    document.report.date_to.value = format_Date(getId("date_t").value);
                    document.report.submit();
                    //}else{
                    //    alert("กรุณาใส่วันที่ให้ถูกต้อง");
                    //}

                } else if (getId("date_f").value == "" && getId("date_t").value == "") {
                    document.report.submit();
                } else {
                    alert("กรุณาใส่วันที่ให้ครบ");
                }
            }
        </script>
    </head>
    <body onunload="closepopup()">

        <div class="container">        
            <div class="panel panel-primary">
                <div class="panel-heading"> <span class=" glyphicon glyphicon-print" style="color:white"></span>&nbsp;
                    <b>รายงาน 3</b>
                </div>                

                <div class="panel-footer">        

                    <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
                        <input type="hidden" name="report_code" value="<%=path%>">
                        <input type="hidden" name="type_report" value="4">
                        <input type="hidden" name="lookup" value="<%=lookup%>">
                        <input type="hidden" name="date_form" value="">
                        <input type="hidden" name="date_to" value="">      

                        <table  cellpadding="0" cellspacing="0" >
                            </tr>    
                            <tr>
                                <td class="columnlabel1">รหัสสินค้า/วัตถุดิบ :&nbsp;</td>
                                <td class="columnobject"><input name="product_id" type='text' class="inputs" id="product_id" value="" size="20" >&nbsp;&nbsp;<a href='#' onClick="openBrWindow('Vproduct', 301, 'Search_Config2_1.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                    <input type="hidden" name="product_id_desc" id="product_id_desc" value="" size="70"></td>
                            </tr>                                
                            <tr>
                                <td class='columnlabel1'>Product Group :&nbsp;</td><td class='columnobject'><input name='pgroup_id' type='text' class="inputs" id="pgroup_id" value='' />
                                    &nbsp;<a href='javascript:;' onclick="MM_openBrWindow('../SEARCHSCREEN/SearchProductGroup.jsp?chk=0', '', 'scrollbars=yes,width=560,height=500')" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='?????' name='IMAGE1' width='20' height='20' border='0' align='middle' /></a>
                                    <input type="hidden" id="name_t_pgroup"/><input type="hidden" id="remark_pgroup"/>
                                </td>
                            </tr>
                            <tr>
                                <td class='columnlabel1'>Warehouse ID :&nbsp;</td><td class='columnobject'><input name='warehouse_id' type='text' class="inputs" id="warehouse_id" value='' />
                                    &nbsp;<a href='javascript:;' onclick="MM_openBrWindow('../SEARCHSCREEN/SearchWareHouse.jsp?chk=0', '', 'scrollbars=yes,width=560,height=500')" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='?????' name='IMAGE1' width='20' height='20' border='0' align='middle' /></a>
                                    <input type="hidden" id="name_t_warehouse"/><input type="hidden" id="remark_wh"/>
                                </td>
                            </tr>
                            <tr></tr>
                            <tr>
                                <td class="columnlabel1">Branch :&nbsp;</td>
                                <td class="columnobject">
                                    <%=objuti.ShowSelectBox_Class3("select branch_id,name_t from mbranch order by runno", "branch_id", "name_t", "branch")%>
                                </td>
                            </tr>                                

                            <tr></tr>                           

                            <tr>
                                <td class="columnlabel1">โรงสี(สีถ่าน) :&nbsp;</td>
                                <td class="columnobject">
                                    <input name='friction_house' type='text' class="inputs" id="friction_house" value='-' size='20' readonly />
                                    &nbsp;<a href='javascript:;' onClick="openBrWindow('vm_friction_house', 289, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                                                                                                
                                </td>
                            </tr>                                

                            <tr>
                                <td class="columnlabel1">กองที่(วัตถุดิบ) :&nbsp;</td>
                                <td class="columnobject">
                                    <input name='location_id' type='text' class="inputs" id="location_id" value='-' size='20' readonly />
                                    &nbsp;<a href='javascript:;' onClick="openBrWindow('vmlocation', 289, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                        
                                    &nbsp;<input type="hidden" name="location_name" id="location_name" value="" size="20">                                    
                                </td>
                            </tr>

                            </tr>
                            <tr>
                                <td class='columnobject'><div align="right">วันที่เริ่มต้น&nbsp;:&nbsp;</div></td>
                                <td class='columnobject'><input name='date_f' type='text' class="inputs" id="date_f" value='' readonly/>
                                    <a id='date_1' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                    <script type='text/javascript'>Calendar.setup({inputField: 'date_f', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});
                                    </script>                                    </td>
                                <td class='columnobject'><div align="right">ถึงวันที่&nbsp;:&nbsp;</div></td>
                                <td class='columnobject'><input name='date_t' type='text' class="inputs" id="date_t" value='' readonly/>
                                    <a id='date_2' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                    <script type='text/javascript'>Calendar.setup({inputField: 'date_t', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_2', singleClick: true, step: 1});</script>                                    
                                </td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace' ></td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace' align="right">
                                    <input type="button" class="cgcButton_11" name="myBut" value=" พิมพ์รายงาน  " onclick="CheckDate()"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace' ></td>
                            </tr>      
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
