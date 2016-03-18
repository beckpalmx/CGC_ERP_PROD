<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <head>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <!-- calendar stylesheet -->
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
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

        <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">           

        <script type="text/javascript">

            function add()
            {
                send_param = "chkNull,username,doc_id,h2o,butane,iod,psd_1,psd_2,psd_3,psd_4,psd_5,psd_6,psd_7,psd_8,psd_9,psd_10,psd_11,psd_12,psd_13,psd_14,psd_15,remark,pass,n_pass,grade";
                confirmDialogSave(URLsend(send_param, '../JSP/CS_060.jsp'));
            }

            function go_copy()
            {
                if (getId("doc_id_copy_to").value == null || getId("doc_id_copy_to").value == "") {
                    alert("กรุณาป้อนหมายเลขใบแจ้งผลิตฯที่ต้องการคัดลอกไป !!!");
                } else {
                    send_param = "username,status_copy,doc_id_copy_to,doc_id,h2o,butane,iod,psd_1,psd_2,psd_3,psd_4,psd_5,psd_6,psd_7,psd_8,psd_9,psd_10,psd_11,psd_12,psd_13,psd_14,psd_15,remark,pass,n_pass,grade";
                    confirmDialogSave(URLsend(send_param, '../JSP/CS_060.jsp'));
                }
            }

            function cancle()
            {
                cancelAction();
            }

            function OpenDoc_id(input)
            {
                switch (input) {
                    case 1:
                        openBrWindow('vd_header_analyze&stadment=and+doc_type+=+\'1\'', 60, 'Search_Config2.jsp');
                        break;
                    case 2:
                        openBrWindow('vd_header_analyze&stadment=and+doc_type+=+\'1\'', 600, 'Search_Config2.jsp');
                        break;
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
        <title>Header Analyze</title>
    </head>
    <body onUnload="closepopup();">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                UtiDatabase objuti = new UtiDatabase();
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_060");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
            %>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" id="status_cal" value="4" >
            <input type="hidden" id="status_copy" value="1" >
            <input type="hidden" id="doc_type" value="1" >
            <input type="hidden" id="chkNull" value="doc_id">            
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">
            <input type="hidden" id="chkstatus" value="1">


            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"><span class="glyphicon glyphicon-pencil" style="color:white"></span>&nbsp;<b>บันทึกพารามิเตอร์สำหรับวิเคราะห์ถ่านกัมมันต์ &nbsp;(CS_060)</b></div>       
                    <div class="panel-footer">            
                        <div align="left">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="4" align="right"><b>หมายเลขเอกสาร : - </b></td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="right"><b>วันที่มีผลบังคับใช้ : - </b></td>
                                </tr>
                                <tr>                                  
                                    <td class="columnlabel1"></b></td>                                    
                                </tr>                                 
                                <tr>
                                    <td class="columnlabel1"><b>เลขที่ใบแจ้งการผลิตฯ&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input type = "text" class="inputs" name='doc_id' id="doc_id" value='' size='18' readonly/>
                                        <input type = "hidden" name='job_id' id="job_id" value='' size='20' readonly/>
                                        &nbsp;<a href='#' onClick="OpenDoc_id(1)" data-toggle="tooltip" title="เลขที่ใบแจ้งฯที่ช่อง 1"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;                                        
                                        <b>คัดลอกไปเลขที่ใบแจ้งการผลิตฯ&nbsp;:&nbsp;</b>
                                        <input type = "text" class="inputs" name='doc_id_copy_to' id="doc_id_copy_to" value='' size='18' readonly/>
                                        <a href='#' onClick="OpenDoc_id(2)" data-toggle="tooltip" title="เลขที่ใบแจ้งฯที่ช่อง 2"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;                                                                                
                                </tr>

                                <tr>                                  
                                    <td class="columnlabel1"></b></td>                                    
                                </tr>                                

                                <tr>
                                    <!--td colspan="3" class="h_multi"></td-->
                                    <!--td colspan="4" class="btn_multi"--> 
                                    <td colspan="3" class="btn_multi">  
                                        <!--input type='button' align="left" class="cgcButton_12" name='bt_copy' id="bt_copy" value='  คัดลอก  ' onClick="go_copy();"/-->                                                
                                        <button type="button" class="btn btn-primary btn-block" data-toggle="tooltip" title="เลือกเลขที่ใบแจ้งฯที่ช่อง 1 และเลือกเลขที่ใบแจ้งฯที่ต้องการคัดลอกไปที่ช่อง 2" onClick="go_copy();"><b>คัดลอก</b></button>
                                    </td>
                                </tr>

                                <tr>                                  
                                    <td class="columnlabel1"></b></td>                                    
                                </tr>                                    
                                <tr>                                  
                                    <td class="columnlabel1"><b>ชื่อลูกค้า&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='cust_name' type='text' class="inputs" id="cust_name" value='' size='70'readonly="true"/>                                       	          	
                                    </td>
                                </tr>                                 
                                <tr>                                  
                                    <td class="columnlabel1"><b>ขนาดถ่าน&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='size_name' type='text' class="inputs" id="size_name" value='' size='70' readonly="true"/>                                       	          	
                                    </td>
                                </tr>                                 

                                <tr>                                  
                                    <td class="columnlabel1"><b>H2O(%)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='h2o' type='text' class="inputs" id="h2o" value='H2O (%)' size='15' readonly="true"/>                                       	          	
                                    </td>
                                </tr> 
                                <tr>                                  
                                    <td class="columnlabel1"><b>Butane(%)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='butane' type='text' class="inputs" id="butane" value='Butane (%)' size='15' readonly="true"/>                                       	          	
                                    </td>
                                </tr> 
                                <tr>                                  
                                    <td class="columnlabel1"><b>ไอโอดีน(%)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='iod' type='text' class="inputs" id="iod" value='ไอโอดีน (%)' size='15' readonly="true"/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (1)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_1' type='text' class="inputs" id="psd_1" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (2)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_2' type='text' class="inputs" id="psd_2" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (3)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_3' type='text' class="inputs" id="psd_3" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (4)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_4' type='text' class="inputs" id="psd_4" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (5)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_5' type='text' class="inputs" id="psd_5" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (6)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_6' type='text' class="inputs" id="psd_6" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (7)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_7' type='text' class="inputs" id="psd_7" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (8)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_8' type='text' class="inputs" id="psd_8" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (9)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_9' type='text' class="inputs" id="psd_9" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (10)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_10' type='text' class="inputs" id="psd_10" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (11)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_11' type='text' class="inputs" id="psd_11" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (12)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_12' type='text' class="inputs" id="psd_12" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (13)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_13' type='text' class="inputs" id="psd_13" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (14)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_14' type='text' class="inputs" id="psd_14" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>PSD (15)&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='psd_15' type='text' class="inputs" id="psd_15" value='' size='15'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel1"><b>ผ่าน&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='pass' type='text' class="inputs" id="pass" value='ผ่าน' size='15' readonly="true"/>                                       	          	
                                    </td>
                                </tr>                                     
                                <tr>                                  
                                    <td class="columnlabel1"><b>ไม่ผ่าน&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='n_pass' type='text' class="inputs" id="n_pass" value='ไม่ผ่าน' size='15' readonly="true"/>                                       	          	
                                    </td>
                                </tr>   
                                <tr>                                  
                                    <td class="columnlabel1"><b>เกรด&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='grade' type='text' class="inputs" id="grade" value='เกรด' size='15' readonly="true"/>                                       	          	
                                    </td>
                                </tr>       
                                <tr>                                  
                                    <td class="columnlabel1"><b>หมายเหตุ&nbsp;:&nbsp;</b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='remark' type='text' class="inputs" id="remark" value='หมายเหตุ' size='15' readonly="true"/>                                       	          	
                                    </td>
                                </tr>                                 


                                <tr>
                                    <td colspan='4' class='blankspace'>
                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle();"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="add();"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" class="imgtransparent" width="80" height="30" border="0"></a>                                            
                                            <!--a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a-->
                                            <!--a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a-->
                                        </div>
                                        <br>      		  	
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>