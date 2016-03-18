<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.Util.Last_Date"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <head>
        <%@ include file="PageHeader.jsp" %>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <!-- calendar stylesheet -->
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">     

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>          

        <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">           

        <script type="text/javascript">

            function AddHeader()
            {
                var r = confirm("คุณต้องการบันทึกหรือไม่");
                if (r)
                {
                    var strID = "";
                    strID += getIDElements('input', 'I_');
                    strID += getIDElements('input', 'A_');
                    strID += getIDElements('select', 'A_');
                    strID = strID.substr(0, strID.length - 1);
                    //alert(strID);
                    getSave(URLsend('chkNull,username,remark,runno,' + strID, '../JSP/CS_M_Period.jsp'));
                    //ResetValue();
                }

            }

            function cancle()
            {
                cancelAction();
            }

            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่");
                if (r)
                {
                    confirmDialogSave(URLsend('status_d,runno', '../JSP/CS_M_Period.jsp'));
                    ResetValue();
                }

            }

            function getCurrentPeriodYear() {

                AjaxRun_id("A_period_year", "../JSP/MA_CS_Period_Date.jsp?runer_id=99");


                for (month = 1; month <= 12; month++) {
                    id_name1 = "A_start_month_" + month;
                    AjaxRun_id(id_name1, "../JSP/MA_CS_Period_Date.jsp?runer_id=" + month);
                }

                for (month = 13; month <= 24; month++) {
                    id_name2 = "A_end_month_" + (month - 12);
                    AjaxRun_id(id_name2, "../JSP/MA_CS_Period_Date.jsp?runer_id=" + month);
                }
            }

            function InitPeriod() {
                if (getId("A_period_year").value === "") {
                    alert("กรุณาป้อนปี พ.ศ. !!!");
                } else {
                    for (month = 1; month <= 12; month++) {
                        id_name1 = "A_start_month_" + month;
                        id_name2 = "A_end_month_" + month;
                        var send_val1 = parseInt(getId("A_period_year").value) + ";" + month.toString();
                        AjaxRun_id(id_name1, "../JSP/MA_CS_Init_Period_Date.jsp?runer_id=" + send_val1);
                        var send_val2 = parseInt(getId("A_period_year").value) + ":" + month.toString();
                        AjaxRun_id(id_name2, "../JSP/MA_CS_Init_Period_Date.jsp?runer_id=" + send_val2);
                    }
                }
            }


        </script>

        <script type="text/javascript">

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>       

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <title>CGC CMMS</title>
    </head>
    <body onload="getCurrentPeriodYear();">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%                UserBean userbean = (UserBean) session.getAttribute("user");
                UtiDatabase objuti = new UtiDatabase();
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_059");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S501");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();

                //_______________________________________________________________report
            %>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" id="status_cal" value="4" >
            <input type="hidden" id="chkNull" value="A_period_year">
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">            
            <input type="hidden" id="chkstatus" value="1">
            <input type="hidden" id="runno" name="runno" value='1'>
            <input type="hidden" id="runid" name="runid" value='1'>
            <input type="hidden" id="start_year" name="start_year" value="<%=start_year%>">       
            <input type="hidden" id="current_date" name="current_date" value="<%=current_date%>">                  

            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-pencil" style="color:white"></span>&nbsp;
                        <b>กำหนดงวดบัญชีประจำปี (CS_M_Period)</b>
                    </div>                

                    <div class="panel-footer">           


                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td class="columnlabel1"><b>ปี พ.ศ.*&nbsp;:&nbsp;</b></td>                                    
                                <td colspan="3" class="columnobject">      
                                    <input type='text' class="inputs" name='A_period_year' id="A_period_year" size='10' value='' data-toggle="tooltip" title="ป้อนปี พ.ศ."/>   
                                    &nbsp;&nbsp;&nbsp;<input type="button" class="cgcButton_11" name="myBut" value=" กำหนดงวดบัญชี " data-toggle="tooltip" title="ป้อนปี พ.ศ. แล้วกดปุ่มนี้เพื่อกำหนดงวดบัญชี แล้วบันทึกข้อมูลกดที่ปุ่ม Save" onClick="InitPeriod()"/>
                                    &nbsp;&nbsp;&nbsp;<input type="button" class="cgcButton_11" name="myBut" value=" Reload " data-toggle="tooltip" title="กดปุ่มนี้เพื่อแสดงข้อมูล" onClick="getCurrentPeriodYear()"/>
                                </td>
                            </tr>                            
                            <tr>                                  
                                <td class="columnlabel1"><b>งวด เดือนที่ 1&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='A_start_month_1' type='text' class="inputs" id="A_start_month_1" value='' size='10' readonly/>                                       	          	
                                    &nbsp;:&nbsp;<input name='A_end_month_1' type='text' class="inputs" id="A_end_month_1" value='' size='10' readonly/>                                       	          	
                                </td>
                            </tr> 
                            <tr>                                  
                                <td class="columnlabel1"><b>งวด เดือนที่ 2&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='A_start_month_2' type='text' class="inputs" id="A_start_month_2" value='' size='10' readonly/>                                       	          	
                                    &nbsp;:&nbsp;<input name='A_end_month_2' type='text' class="inputs" id="A_end_month_2" value='' size='10' readonly/>                                       	          	                                    
                                </td>
                            </tr>          
                            <tr>                                  
                                <td class="columnlabel1"><b>งวด เดือนที่ 3&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='A_start_month_3' type='text' class="inputs" id="A_start_month_3" value='' size='10' readonly/>                                       	          	
                                    &nbsp;:&nbsp;<input name='A_end_month_3' type='text' class="inputs" id="A_end_month_3" value='' size='10' readonly/>                                       	          	                                    
                                </td>
                            </tr> 
                            <tr>                                  
                                <td class="columnlabel1"><b>งวด เดือนที่ 4&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='A_start_month_4' type='text' class="inputs" id="A_start_month_4" value='' size='10' readonly/>                                       	          	
                                    &nbsp;:&nbsp;<input name='A_end_month_4' type='text' class="inputs" id="A_end_month_4" value='' size='10' readonly/>                                       	          	                                                                        
                                </td>
                            </tr>
                            <tr>                                  
                                <td class="columnlabel1"><b>งวด เดือนที่ 5&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='A_start_month_5' type='text' class="inputs" id="A_start_month_5" value='' size='10' readonly/>                                       	          	
                                    &nbsp;:&nbsp;<input name='A_end_month_5' type='text' class="inputs" id="A_end_month_5" value='' size='10' readonly/>                                       	          	                                    
                                </td>
                            </tr>
                            <tr>                                  
                                <td class="columnlabel1"><b>งวด เดือนที่ 6&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='A_start_month_6' type='text' class="inputs" id="A_start_month_6" value='' size='10' readonly/>                                       	          	
                                    &nbsp;:&nbsp;<input name='A_end_month_6' type='text' class="inputs" id="A_end_month_6" value='' size='10' readonly/>                                       	          	                                                                        
                                </td>
                            </tr> 
                            <tr>                                  
                                <td class="columnlabel1"><b>งวด เดือนที่ 7&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='A_start_month_7' type='text' class="inputs" id="A_start_month_7" value='' size='10' readonly/>   
                                    &nbsp;:&nbsp;<input name='A_end_month_7' type='text' class="inputs" id="A_end_month_7" value='' size='10' readonly/>                                       	          	                                    
                                </td>
                            </tr>
                            <tr>                                  
                                <td class="columnlabel1"><b>งวด เดือนที่ 8&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='A_start_month_8' type='text' class="inputs" id="A_start_month_8" value='' size='10' readonly/>                                       	          	
                                    &nbsp;:&nbsp;<input name='A_end_month_8' type='text' class="inputs" id="A_end_month_8" value='' size='10' readonly/>                                       	          	                                    
                                </td>
                            </tr>         
                            <tr>                                 
                                <td class="columnlabel1"><b>งวด เดือนที่ 9&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='A_start_month_9' type='text' class="inputs" id="A_start_month_9" value='' size='10' readonly/>                                       	          	
                                    &nbsp;:&nbsp;<input name='A_end_month_9' type='text' class="inputs" id="A_end_month_9" value='' size='10' readonly/>                                       	          	                                    
                                </td>
                            </tr>
                            <tr>                                  
                                <td class="columnlabel1"><b>งวด เดือนที่ 10&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='A_start_month_10' type='text' class="inputs" id="A_start_month_10" value='' size='10' readonly/>                                       	          	
                                    &nbsp;:&nbsp;<input name='A_end_month_10' type='text' class="inputs" id="A_end_month_10" value='' size='10' readonly/>                                       	          	                                                                        
                                </td>
                            </tr>         
                            <tr>                                  
                                <td class="columnlabel1"><b>งวด เดือนที่ 11&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='A_start_month_11' type='text' class="inputs" id="A_start_month_11" value='' size='10' readonly/>    
                                    &nbsp;:&nbsp;<input name='A_end_month_11' type='text' class="inputs" id="A_end_month_11" value='' size='10' readonly/>                                       	          	                                                                        
                                </td>
                            </tr>
                            <tr>                                  
                                <td class="columnlabel1"><b>งวด เดือนที่ 12&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='A_start_month_12' type='text' class="inputs" id="A_start_month_12" value='' size='10' readonly/>         
                                    &nbsp;:&nbsp;<input name='A_end_month_12' type='text' class="inputs" id="A_end_month_12" value='' size='10' readonly/>                                       	          	                                                                        
                                </td>
                            </tr>                       

                            <tr>                                  
                                <td class="columnlabel1"><b>หมายเหตุ&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                        
                                    <input name='remark' type='text' class="inputs" id="remark" value='' size='70'/>                                       	          	
                                </td>
                            </tr>                                    


                            <tr>
                                <td colspan='4' class='blankspace'>
                                    <br>
                                    <div align="center">
                                        <a href="javascript:;" onClick="cancle();"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="AddHeader();"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" class="imgtransparent" width="80" height="30" border="0"></a>                                            
                                    </div>
                                    <br>      		  	
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>


        </form>
    </body>
</html>