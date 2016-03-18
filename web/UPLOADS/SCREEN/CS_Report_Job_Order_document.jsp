<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>                         

        <script type="text/javascript">
            function cancal() {
                cancelAction();
                getId("show1").innerHTML = "";
                getId("show2").innerHTML = "";
            }
            function get_search() {
                showTableNonPopup2("show1", "cust_id,spec1", "../JSP/CS_Show_Job_order_document.jsp?cust_id=" + getId("cust_id").value + "&spec1=" + getId("spec1").value);
                //showTableNonPopup("show2", "search_date", "../JSP/CS_Show_Report_d_carbon_carbon_send_qc.jsp?select_case=2&search_date=");
            }
            function send_print(doc_id, report_code) {
                getId("doc_id").value = doc_id;
                getId("report_code").value = report_code;
                document.report.submit();
            }
        </script>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <title>CGC ERP</title>
    </head>
    <body>
        <form id="report" name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input type="hidden" id="doc_id" name="doc_id" value=""/>
            <input type="hidden" id="report_code" name="report_code" value=""/>
            <input type="hidden" id="type_report" name="type_report" value="2"/>


            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-search" style="color:white"></span>&nbsp;
                        <b>ค้นหาใบแจ้งการผลิต (CS_Report_Job_Order_document)</b>
                    </div>                
                    <div class="panel-footer">
                        <div align="center">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><b>หมายเลขเอกสาร : </b></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : </b></td>
                                </tr>

                                <!--tr>
                                    <td width="30%" align="right">วันที่&nbsp;</td>
                                    <td class="columnobject"><input type='text' class="inputs" id="search_date" name="search_date" value="" size="10" >&nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'search_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>
                                    </td>
                                </tr-->

                                <tr>
                                    <td class="columnlabel1">ลูกค้า&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='cust_id' type='text' class="inputs" id="cust_id" value='' size='15' readonly />
                                        &nbsp;<a href='javascript:;' onClick="openBrWindow('Vcustomer', 32, 'Search_Config5.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        &nbsp;<input name='cust_id_desc' type='text' class="inputs" id="cust_id_desc" value='' size='30' readonly/>	
                                        <input name='country_id' type='hidden' id="country_id" value='' size='10' readonly/>             
                                        <input name='country_id_desc' type='hidden' id="country_id_desc" value='' size='10' readonly/>                                             
                                    </td>
                                </tr>   

                                <tr>
                                    <td class="columnlabel1">ขนาด&nbsp;</td>
                                    <td class="columnobject"><input type='text' class="inputs" name="spec1" id="spec1" value="" onclick="openBrWindow('m_carbon_size&textinput=spec1', 32, 'Search_Detail.jsp')" readonly/>
                                        &nbsp;<a href='javascript:;' onClick="openBrWindow('m_carbon_size&textinput=spec1', 32, 'Search_Detail.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                    </td>

                                </tr>                                 

                                <tr>
                                    <td class="columnlabel1"></td>
                                    <td class="columnobject">
                                        <input type='button' class="cgcButton_6" name='search' onClick="get_search();" value='ค้นหา'/>
                                        <input type="button" class="cgcButton_3" id="cancel" name="cancel" value="ยกเลิก" onclick="cancal()">                                            
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
                                                    <td class="headergrid" colspan="14">ใบแจ้งการผลิต</td>
                                                </tr>
                                                <tr>
                                                    <td class="row5" width="3%">No</td>
                                                    <td class="row5" width="8%">เลขที่เอกสาร</td>
                                                    <td class="row5" width="5%">วันที่</td>
                                                    <td class="row5" width="5%">ลูกค้า</td>
                                                    <td class="row5" width="5%">ขนาดถ่าน</td>
                                                    <td class="row5" width="5%">ไอโอดีน</td>
                                                    <td class="row5" width="5%">จำนวน (ตัน)</td>                                           
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show1"></div>
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

                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
