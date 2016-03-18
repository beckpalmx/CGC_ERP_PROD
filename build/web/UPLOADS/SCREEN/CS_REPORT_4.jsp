<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <%!        UtiDatabase objuti = new UtiDatabase();
        String path, lookup;
    %>
    <%
        lookup = (String) request.getParameter("lookup");
        path = (String) request.getParameter("report_code");
    %>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>        

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>          

        <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">              

        <script type="text/javascript">
            var my_window = null;
            function openBrown(tableID, SentToShow) {
                if (my_window == null) {
                    my_window = window.open("../SEARCHSCREEN/Search_Report.jsp?table=" + tableID + "&sentdataToshow=" + SentToShow, '', 'status=1,width=560,height=500');
                } else {
                    closepopup();
                    my_window = window.open("../SEARCHSCREEN/Search_Report.jsp?table=" + tableID + "&sentdataToshow=" + SentToShow, '', 'status=1,width=560,height=500');
                }
            }

            function CheckDate() {

                var da1 = new Date(document.report.date_f.value);
                var da2 = new Date(document.report.date_t.value);


                var d1 = document.report.date_f.value;
                var d2 = document.report.date_t.value;
                //var p1 = document.report.param_f.value;
                //var p2 = document.report.param_t.value;         


                if (da1 <= da2 || d1 == '' || d2 == '') {
                    if (d1 != '' || d2 != '') {
                        if (d1 != '') {
                            if (d2 == '') {
                                alert('กรุณาใส่ข้อมูลวันที่สิ้นสุดการออกรายงาน');
                            } else {
                                document.report.date_form.value = format_Date(d1);//dateFormat(da1.format,'yyyy-mm-dd').tostring;
                                document.report.date_to.value = format_Date(d2);//dateFormat(da2,'yyyy-mm-dd').tostring;
                                document.report.submit();
                            }
                        } else if (d2 != '') {
                            if (d1 == '')
                            {
                                alert('กรุณาใส่ข้อมูลวันที่เริ่มต้นการออกรายงาน');
                            } else {
                                document.report.date_form.value = format_Date(d1);
                                document.report.date_to.value = format_Date(d2);
                                document.report.submit();
                            }
                        }
                    }
                } else
                {
                    document.report.date_form.value = format_Date(d1);
                    document.report.date_to.value = format_Date(d2);
                    document.report.submit();
                }
            }

            function getStatus() {
                if (document.getElementById("radio1").checked) {
                    document.getElementById("status").value = 0;
                } else if ((document.getElementById("radio2").checked)) {
                    document.getElementById("status").value = 1;
                }
            }

            function getStatus1() {
                if (document.getElementById("radio11").checked) {
                    document.getElementById("status1").value = 0;
                } else if ((document.getElementById("radio12").checked)) {
                    document.getElementById("status1").value = 1;
                }
            }

            function getStatus2() {
                if (document.getElementById("radio13").checked) {
                    document.getElementById("status2").value = 0;
                } else if ((document.getElementById("radio14").checked)) {
                    document.getElementById("status2").value = 1;
                }
            }

            function CheckPrint() {
                document.report.submit();
            }


        </script>
    </head>

    <body onUnload="closepopup()">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input type="hidden" name="report_code" value="<%=path%>">
            <input type="hidden" name="lookup" value="<%=lookup%>">
            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class=" glyphicon glyphicon-print" style="color:white"></span>&nbsp;
                        <b>รายงาน 4</b>
                    </div>                

                    <div class="panel-footer">        

                        <div align="center">
                            <input type="hidden" name="type_report" value="5">
                            <input type="hidden" name="date_form" value="">
                            <input type="hidden" name="date_to" value="">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="5"  class="blankspace"></td>
                                </tr>

                                <tr><td colspan='5'><b>กำหนดเงื่อนไข การออกรายงาน</b></td>
                                </tr>

                                <%if ((path.charAt(6) != '8') && (path.charAt(6) != '9')) {%>

                                <tr>
                                    <td width="153" class='columnobject'><div align="right">วันที่เริ่มต้น&nbsp;:&nbsp;</div></td>
                                    <td width="193" class='columnobject'><input name='date_f' type='text' class="inputs" id="date_f" value='' size="15" readonly="true"/>
                                        &nbsp;<a id='date_1' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'date_f', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>                                    
                                    </td>
                                    <td width="71" class='columnobject'><div align="right">สิ้นสุด&nbsp;:&nbsp;</div></td>
                                    <td width="338" class='columnobject'><input name='date_t' type='text' class="inputs" id="date_t" value=''  size="15"  readonly="true"/>
                                        &nbsp;<a id='date_2' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'date_t', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_2', singleClick: true, step: 1});</script>                                    
                                    </td>
                                </tr>                                
                                <tr>
                                    <td class="columnlabel1">เงื่อนไขเพิ่มเติม รับเชื้อเพลิง </td>
                                    <td class="columnobject">&nbsp;&nbsp;
                                        <input type="hidden" id="status1" name="status1">
                                        <input type="radio" name="radio1" id="radio11" onClick="getStatus1()" checked>
                                        ไม่ใช้ 
                                        <input type="radio" name="radio1" id="radio12" onClick="getStatus1()">
                                        ใช้                                 
                                </tr>         
                                <tr>
                                    <td class="columnlabel1">ประเภทเชื้อเพลิง*&nbsp;</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select product_id,name_t from m_fuel order by runno", "product_id", "name_t", "product_id")%>
                                        <!--input type="hidden" id="product_id" value=""-->
                                    </td>
                                </tr>           
                                <tr>
                                    <td class="columnlabel1">เงื่อนไขเพิ่มเติม รับเชื้อเพลิง </td>
                                    <td class="columnobject">&nbsp;&nbsp;
                                        <input type="hidden" id="status2" name="status2">
                                        <input type="radio" name="radio2" id="radio13" onClick="getStatus2()" checked>
                                        ไม่ใช้ 
                                        <input type="radio" name="radio2" id="radio14" onClick="getStatus2()">
                                        ใช้                                 
                                </tr>         
                                <tr>
                                    <td class="columnlabel1">ผู้ขาย/Supplier*&nbsp;</td>
                                    <td class="columnobject">
                                        <%=objuti.ShowSelectBox("select supplier_id,name_t from msupplier order by runno", "supplier_id", "name_t", "supplier_id")%>
                                        <input type="hidden" id="supplier_id" value="">
                                    </td>
                                </tr>                                  
                                <tr>
                                    <td class="columnlabel1">เงื่อนไขเพิ่มเติม ฝ่ายผลิต (ด้านล่าง)</td>
                                    <td class="columnobject">&nbsp;&nbsp;
                                        <input type="hidden" id="status" name="status">
                                        <input type="radio" name="radio" id="radio1" onClick="getStatus()" checked>
                                        ไม่ใช้ 
                                        <input type="radio" name="radio" id="radio2" onClick="getStatus()">
                                        ใช้                                 
                                </tr>

                                <tr>
                                    <td class="columnlabel1">ประเภทงาน*</td>
                                    <td class="columnobject"><%=objuti.ShowSelectBox("select job_type_id,name_t from vmjob_type order by runno", "job_type_id", "name_t", "job_type_id")%>&nbsp;</td>
                                </tr>   

                                <tr>
                                    <td class="columnlabel1">ชนิดถ่าน (วัตถุดิบ)</td>
                                    <td class="columnobject"><input name="product_id2" type='text' class="inputs" id="product_id2" value="" size="20" readonly>
                                        &nbsp;&nbsp;<a href='#' onClick="openBrWindow('vproduct&stadment=and+pgroup_id+=+\'RAW\'', 301, 'Search_Config2_1.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                        <input type="hidden" name="product_id_desc2" id="product_id_desc2" value="" size="70"></td>
                                </tr>                                             

                                <tr>
                                    <td class="columnlabel1">กองที่(วัตถุดิบ)&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='location_id' type='text' class="inputs" id="location_id" value='-' size='20' readonly />
                                        &nbsp;<a href='javascript:;' onClick="openBrWindow('vmlocation', 289, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                        
                                        &nbsp;<input type="hidden" name="location_name" id="location_name" value="" size="20">                                    
                                    </td>
                                </tr>                 

                                <tr>
                                    <td class="columnlabel1">โกดัง/โรงสี*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='wh_id' type='text' class="inputs" id="wh_id" value='' size='10' readonly="readonly"/>                                        
                                        <!--a href='#' onClick="openBrWindow('Mwarehouse&stadment=and+wh_type+=+\'F\'', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='wh_name' type='text' class="inputs" id="wh_name" value='' size='30' readonly="readonly" />                                </td-->
                                        &nbsp;<a href='#' onClick="openBrWindow('vmwarehouse', 22, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                        <input name='wh_name' type='text' class="inputs" id='wh_name' value='' size='30' readonly="readonly" />                                
                                    </td>                                        
                                </tr>                                 


                                <tr>
                                    <td colspan='5' class='blankspace' ></td>
                                </tr>

                                <tr>
                                    <td colspan='5' class='blankspace' align="right">
                                        <input type="button" class="cgcButton_11" name="myBut" value=" พิมพ์รายงาน  " onClick="CheckDate();"/>
                                    </td>
                                </tr>               

                                <input name='year_document' type='hidden' id="year_document" value='' />

                                <%} else {%>
                                <input name='job_type_id' type='hidden' id="job_type_id" value='' />
                                <input name='date_form' type='hidden' id="date_form" value='2556-11-01' />
                                <input name='date_to' type='hidden' id="date_to" value='2556-11-01' />
                                <input name='status' type='hidden' id="status" value='' />
                                <input name='status1' type='hidden' id="status" value='' />
                                <input name='status2' type='hidden' id="status" value='' />
                                <input name='location_id' type='hidden' id="location_id" value='' />
                                <input name="product_id2" type="hidden" id="product_id2" value="" size="20" readonly>
                                <input name="wh_id" type="hidden" id="wh_id" value="" size="20" readonly>
                                <tr>
                                    <td class="columnlabel1">ปี พ.ศ.</td>
                                    <td class="columnobject"><%=objuti.ShowSelectBox("select year_document from vm_year_carbon_burn_out", "year_document", "year_document", "year_document")%>&nbsp;</td>
                                </tr>                                                                 

                                <tr>
                                    <td colspan='5' class='blankspace' ></td>
                                </tr>

                                <tr>
                                    <td colspan='5' class='blankspace' align="right">
                                        <input type="button" class="cgcButton_11" name="myBut" value=" พิมพ์รายงาน  " onClick="CheckPrint();"/>
                                    </td>
                                </tr>

                                <%}%>


                                <tr>
                                    <td colspan='5' class='blankspace' ></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>