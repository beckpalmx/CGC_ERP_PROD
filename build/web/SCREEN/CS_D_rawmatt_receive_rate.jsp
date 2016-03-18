<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.Decimal_Place"%>
<%@page import="com.cgc.Util.UtiDatabase"%>

<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <head>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>

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
            function Chknull() {
                if (document.getElementById('doc_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else {
                    document.report.submit();
                }
            }

            function Cal_quality() {
                var r = confirm("คุณต้องการวิเคราะห์ข้อมูลใช่หรือไม่")
                if (r)
                {
                    getSave(URLsend('chkNull,supplier_id,quality_id,year_text,select_rate,select_product_id,report_id,runner_id,complete_flag', '../JSP/CS_D_rawmatt_receive_rate.jsp'))
                }
            }

            function cancle()
            {

                var r = confirm("คุณต้องการยกเลิกข้อมูลทั้งหมดหรือไม่")
                if (r)
                {
                    cancelAction();

                }

            }

            function Checkvalue(thisvalue) {
                if (thisvalue) {
                    getId("complete_flag").value = "Y";
                    alert("เอกสารนี้สมบูรณ์เรียบร้อยแล้ว");
                } else {
                    getId("complete_flag").value = "N"
                    //alert("เอกสารนี้สมบูรณ์เรียบร้อยแล้ว");
                }
            }


        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <title>CGC ERP</title>
    </head>
    <body onkeyup="chkEvent()">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UtiDatabase objuti = new UtiDatabase();
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_D_rawmatt_receive_rate");
                //objs_p = h_p.selectheaderscreen_process(objs_p, "RP_040_ ESTIMATE");                
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S339");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
%>
            <div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input name="emp_id" type="hidden" id="emp_id" value="<%=userbean.getEmp_id()%>">
            <input name="dept_id" type="hidden" id="dept_id" value="<%=userbean.getDept_id()%>">
            <input type="hidden" id="chkNull" value="year_text,supplier_id,report_id,runner_id">
            <input type="hidden" id="status_a" value="1"><!-- เป็นการเพิ่มข้อมูลเข้าไป-->
            <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" id="status_cancle" value=""><!-- status_cancle = 1 คือค่าที่นำมา Edit แต่ถ้า ="" จะเป็นการ Insert -->
            <input type="hidden" id="child_ck" name="child_ck" value="">
            <!---------------------------------------------------report----------------------------->
            <!--input type="hidden" id="report_code" name="report_code"  value="<%=path%>"-->            
            <input type="hidden" id="report_code" name="report_code" value="RP_040_ ESTIMATE">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">

            <div align="left">

                <div class="container">
                    <div class="panel panel-primary">
                        <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                            <b>บันทึกการประเมินคุณภาพถ่านวัตถุดิบของผู้ขาย(CS_D_rawmatt_receive_rate)</b>
                        </div>                        
                        <div class="panel-footer">   
                            <div align="center">
                                <table  cellpadding="0" cellspacing="0" >
                                    <tr>
                                        <td colspan="2" align="right"><b>หมายเลขเอกสาร : <%=doc_no%></b></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=doc_eff_date%></b></td>
                                    </tr>
                                    <!--tr>
                                        <td class="columnlabel1">ยืนยันข้อมูล</td>
                                        <td class="columnobject"><input id="complete_flag" type="checkbox" onclick="Checkvalue(this.checked)" value="N" name="complete_flag"/></td>
                                    </tr-->
                                    <input name='complete_flag' type='hidden' class="inputs" id="complete_flag" value='N' size='20' readonly/>

                                    <tr>
                                        <td width="150" class="columnlabel1"><b>เลขที่เอกสาร*&nbsp;:&nbsp;</b>&nbsp;</td>
                                        <td width="607" class="columnobject">
                                            <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='20' readonly/>
                                            &nbsp;<a href='javascript:;' onClick="openBrWindow('vd_quality_rawmatt_receive_rate_header&stadment=and+complete_flag+=+\'N\'', 312, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาข้อมูลที่ยังไม่ได้อนุมัติ' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a><!--&nbsp;<a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>&nbsp;&nbsp;-->	          	                                            
                                            <!--&nbsp;<a href='javascript:;' onClick="openBrWindow('vd_quality_rawmatt_receive_rate_header&stadment=and+complete_flag+=+\'Y\'', 312, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาข้อมูลที่ยังไม่ได้อนุมัติ' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a><!--&nbsp;<a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>&nbsp;&nbsp;-->	          	                                            
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="columnlabel1"><b>ปี พ.ศ.*&nbsp;:&nbsp;</b></td>                               
                                        <td colspan="3" class="columnobject">
                                            <%=objuti.ShowSelectBox("select price_year from vmproduct_price_year order by price_year desc", "price_year", "price_year", "year_text", "price_year", "-")%>

                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="columnlabel1">ช่วงเดือนการประเมิน&nbsp;:&nbsp;</td>
                                        <td class="columnobject"><select class='select_cgc' name="select_rate" id="select_rate">
                                                <option value="1">ม.ค.-เม.ย.</option>
                                                <option value="2">พ.ค.-ส.ค.</option>
                                                <option value="3">ก.ย.-ธ.ค.</option>
                                            </select>
                                            <!--&nbsp;ปี-->
                                            <input type='hidden' class="inputs" name="year_text" id="year_text_1" size="10"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;ชนิดถ่าน&nbsp;:&nbsp;
                                            <select class='select_cgc' name="select_product_id" id="select_product_id">
                                                <option value="C">ถ่านกะลา C</option>
                                                <option value="P">ถ่านปาล์ม P </option>
                                                <option value="PA">ถ่านปาล์ม PA </option>                                        
                                                <option value="U">ถ่านยูคา</option>
                                                <option value="K">ถ่านไม้โกงกาง</option>
                                            </select>                                    
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel1">ผู้ขาย*&nbsp;:&nbsp;</td>
                                        <td class="columnobject"><input name='supplier_id' type='text' class="inputs" id="supplier_id" value='' size='20'  />                                        
                                            &nbsp;<a href='javascript:;' onClick="openBrWindow('v_rawmatt_receive_supplier', 24, '_Config_rawmat_supplier.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหาข้อมูลที่ยังไม่ได้อนุมัติ' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                            <input name='supplier_id_desc' type='text' class="inputs" id="supplier_id_desc" value='' size='30' readonly/></td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel1">รหัสด้านคุณภาพ&nbsp;:&nbsp;</td>
                                        <td class="columnobject">
                                            <%= new UtiDatabase().ShowSelectBox("select quality_id,remark from m_quality_rawmatt_receive order by runno", "quality_id", "remark", "quality_id")%>

                                            &nbsp;&nbsp;&nbsp; </td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel1">ผู้ประเมิน&nbsp;:&nbsp;</td>
                                        <td class="columnobject"><input name='report_id' type='text' class="inputs" id="report_id" value='' size='10' readonly/>
                                            <a href='javascript:;'onclick="openBrWindow('Vemployee&stadment=and+(dept_id+=+\'09\')and+status+=+\'Y\'', 29, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE6' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                            <input name='report_id_desc' type='text' class="inputs" id="report_id_desc" value='' size='20' readonly/>
                                            <!--<input type="checkbox" name="prod_confirm" id="prod_confirm" value="N" onClick="Check_Confirm(this,'prod_dep')">
                                            ยืนยัน--></td>
                                    </tr>                               

                                    <tr>
                                        <td class="columnlabel1">ผู้อนุมัติ&nbsp;:&nbsp;</td>
                                        <td class="columnobject"><input name='runner_id' type='text' class="inputs" id="runner_id" value='' size='10' readonly/>
                                            <a href='javascript:;'onclick="openBrWindow('Vemployee1', 29, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE6' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                            <input name='runner_id_desc' type='text' class="inputs" id="runner_id_desc" value='' size='20' readonly/>
                                            <!--<input type="checkbox" name="wh_confirm" id="wh_confirm" value="N" onClick="Check_Confirm(this,'wh_dep')">
                                            ยืนยัน--></td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel1">&nbsp;</td>
                                        <td class="columnobject">&nbsp;

                                            &nbsp;&nbsp;&nbsp; </td>
                                    </tr>                                    
                                    <tr>
                                        <td class="columnlabel1">&nbsp;</td>
                                        <td class="columnobject">
                                            <input type="button" class="cgcButton_10" id="bt" value="ประมวลผล" onclick="Cal_quality()">
                                            <input type="button" class="cgcButton_10" id="bt" value="พิมพ์ผลประเมิน" onclick="Chknull()">
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td colspan='2' class='blankspace'><br>
                                            <div align="center"></div>                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'><br>
                                            <div align="center">
                                            </div>
                                            <br>                                  
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>

