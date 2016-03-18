<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- calendar stylesheet -->
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
            function cancal() {
                cancelAction();
                getId("show1").innerHTML = "";
                getId("show2").innerHTML = "";
            }
            function get_search() {
                //getId("location_id").value = "K13B^/58";
                //alert(getId("month_id").value);
                if (getId("price_year").value == "price_year" || getId("month_id").value == "month_id") {
                    alert("กรุณาเลือก ปี และ เดือน");
                } else {
                    showTableNonPopup2("show1", "month_id,price_year,location_id", "../JSP/CS_Report_Rawmat_bigbag_balance_1.jsp?month_id=" + getId("month_id").value + "&price_year=" + getId("price_year").value + "&location_id=" + getId("location_id").value);
                }
                //showTableNonPopup("show2", "search_date", "../JSP/CS_Show_Report_d_carbon_carbon_send_qc.jsp?select_case=2&search_date=");
            }
            function send_print() {
                getId("doc_id").value = doc_id;
                getId("report_code").value = "RP_015_2";
                document.report.submit();
            }
        </script>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <title>CS_Report_Rawmat_bigbag_balance_1</title>
    </head>
    <body>
        <form id="report" name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <% UtiDatabase objuti = new UtiDatabase();%>           
            <input type="hidden" id="doc_id" name="doc_id" value=""/>
            <input type="hidden" id="report_code" name="report_code" value=""/>
            <input type="hidden" id="type_report" name="type_report" value="2"/>
            <div align="center">
                <table  cellpadding="0"  cellspacing="0">
                    <tr >
                        <td class="ftopleft"></td>
                        <td  class="ftopcenter" colspan="2">รายการสรุปการรับ-เบิก คงเหลือ วัตถุดิบถุงใหญ่ (CS_Report_Rawmat_bigbag_balance_1)&nbsp;</td>
                        <td class="ftopright"></td>
                    </tr>
                    <tr >
                        <td class="fcenterleft"></td>
                        <td  colspan="2" class="fcentercenter">
                            <div align="center">
                                <table  cellpadding="0" cellspacing="0" >
                                    <tr>
                                        <td colspan="2" align="right"><b>หมายเลขเอกสาร : </b></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : </b></td>
                                    </tr>   
                                    <tr>
                                        <td class="columnlabel"><b>กรุณาประมวลผลวัตถุดิบ!!! ก่อนดูข้อมูลนี้</b></td> 
                                    </tr>
                                    <tr>

                                        <td class="columnlabel"><b>ปี พ.ศ.*&nbsp;</b></td>                               
                                        <td colspan="3" class="columnobject">
                                            <%=objuti.ShowSelectBox("select price_year from vmproduct_price_year order by price_year desc", "price_year", "price_year", "price_year", "price_year", "-")%>
                                        </td>
                                    </tr>    
                                    <tr>
                                        <td class="columnlabel"><b>เดือน *&nbsp;</b></td>                               
                                        <td colspan="3" class="columnobject">
                                            <%=objuti.ShowSelectBox("select month_id from mmonth order by runno", "month_id", "month_id", "month_id", "month_id", "-")%>
                                            <!--%=objuti.ShowSelectBox("select month_id from mmonth where month_id <> '01' order by runno", "month_id", "month_id", "month_id", "month_id", "-")%-->
                                        </td>
                                    </tr>   

                                    <tr>
                                        <td class="columnlabel">กองที่(วัตถุดิบ)&nbsp;</td>
                                        <td class="columnobject">
                                            <input name='location_id' type='text' class="inputs" id="location_id" value='-' size='20' readonly />
                                            &nbsp;<a href='javascript:;' onClick="openBrWindow('vmlocation', 289, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                        
                                            &nbsp;<input type="hidden" name="location_name" id="location_name" value="" size="20">   
                                            กรณีไม่เลือกกองที่ ระบบจะแสดงข้อมูลถ่านทุกกอง
                                        </td>
                                    </tr>       
                                    
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>                                    

                                    <tr>
                                        <td class="columnlabel"></td>
                                        <td class="columnobject">
                                            <input type='button' class="cgcButton_6" name='search' onClick="get_search();" value='ค้นหา'/>
                                            <input type="button" class="cgcButton_3" id="cancel" name="cancel" value="ยกเลิก" onclick="cancal()">                                  
                                            <input type="button" class="cgcButton_11" name="myBut" value=" พิมพ์รายงาน  " onClick="send_print();"/>
                                        </td>
                                    </tr>    
                                    </td>
                                    </tr>                                           


                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>

                                    <tr>
                                        <td colspan="2" align="center">
                                            <div width="100%">
                                                <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">
                                                    <tr>
                                                        <td class="headergrid" colspan="14">รายการสรุป รับ - จ่าย - ยอดคงเหลือ วัตถุดิบถุงใหญ่</td>
                                                    </tr>
                                                    <!--tr>
                                                        <td class="row5" width="3%">No</td>
                                                        <td class="row5" width="8%">ประเภทวัตถุดิบ</td>
                                                        <td class="row5" width="5%">คลังวัตถุดิบ</td>
                                                        <td class="row5" width="5%">กองที่</td>
                                                        <td class="row5" width="5%">จำนวน</td>                                           
                                                    </tr-->
                                                </table>
                                            </div>
                                            <div style="width:100%; height: 550px; overflow: auto;" id="show1"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' align="right">

                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
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
            </div>
        </form>
    </body>
</html>
