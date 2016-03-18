
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

            function add()
            {
                if (getId("price_year").value != "price_year") {
                    confirmDialogSave(URLsend('chkNull,username,pgroup_id,iodine,price_year,price_month_1,price_month_2,price_month_3,price_month_4,price_month_5,price_month_6,price_month_7,price_month_8,price_month_9,price_month_10,price_month_11,price_month_12,product_id,lot_no,runno,product_none_iodine,remark,start_year,current_date', '../JSP/CS_059.jsp'));
                } else {
                    alert("กรุณาเลือกปี พ.ศ.");
                }
            }

            function cancle()
            {
                cancelAction();
            }

            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if (r)
                {
                    confirmDialogSave(URLsend('status_d,runno', '../JSP/CS_059.jsp'));
                    ResetValue();
                }

            }

            function OpenProduct_id(input)
            {
                switch (input) {
                    case 1:
                        //alert(getId("price_year").value);
                        if (getId("price_year").value != "price_year") {
                            openBrWindow("vmproduct_price&stadment=and+pgroup_id<>'RAW'+and+price_year+=+\'" + getId("price_year").value + "\'", 59, 'Search_ConfigProductPrice.jsp');
                        } else {
                            alert("กรุณาเลือกปี พ.ศ.");
                        }
                        break;

                }

            }

            function getStatus() {
                if (document.getElementById("radio1").checked) {
                    document.getElementById("product_none_iodine").value = "Y";
                    // ไม่มีค่า Iodine product_none_iodine = Y
                } else if ((document.getElementById("radio2").checked)) {
                    document.getElementById("product_none_iodine").value = "N";
                    // มีค่า Iodine product_none_iodine = N
                }
            }


        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <title>CGC ERP</title>
    </head>
    <body onUnload="closepopup();">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
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
            <input type="hidden" id="chkNull" value="price_year,pgroup_id">
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">            
            <input type="hidden" id="chkstatus" value="1">
            <input type="hidden" id="runno" name="runno" value=''>
            <input type="hidden" id="start_year" name="start_year" value="<%=start_year%>">       
            <input type="hidden" id="current_date" name="current_date" value="<%=current_date%>">                  

            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-pencil" style="color:white"></span>&nbsp;
                        <b>บันทึกราคาต่อหน่วยสินค้า (CS_059)</b>
                    </div>                

                    <div class="panel-footer">           


                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="4" align="right"><b>หมายเลขเอกสาร : - </b></td>
                            </tr>
                            <tr>
                                <td colspan="4" align="right"><b>วันที่มีผลบังคับใช้ : - </b></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1"><b>ปี พ.ศ.*&nbsp;:&nbsp;</b></td>                               
                                <td colspan="3" class="columnobject">
                                    <%=objuti.ShowSelectBox_Class2("select price_year from vmproduct_price_year order by price_year desc", "price_year", "price_year", "price_year", "price_year", "-")%>

                                </td>
                            </tr>
                            <tr>
                                <td width="170" class="columnlabel1"><b>กลุ่มสินค้า</b>&nbsp;:&nbsp;</td>
                                <td colspan="3" class="columnobject">
                                    <input name='pgroup_id' type='pgroup_id' class="inputs" id="pgroup_id" value='' size='25' readonly/>
                                    &nbsp;<a href='#' onClick="OpenProduct_id(1)"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    <!--input type='text' class="inputs" name='prod_name' id="prod_name" size='70' value='' /-->                                       
                            </tr>
                            <tr>
                                <td class="columnlabel1"><b>รหัสสินค้า(ตามคลังสินค้า)&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                  
                                    <input type='text' class="inputs" name='product_id' id="product_id" value='' />
                                    <input type='text' class="inputs" name='name_t_product' id="name_t_product" size='50' value='' />                                    
                                </td>
                            </tr>                                

                            <tr>                                  
                                <td class="columnlabel1"><b>Lot No.&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                        
                                    <input name='lot_no' type='text' class="inputs" id="lot_no" value='' size='30'/>                                       	          	
                                </td>
                            </tr>                                   
                            <tr>                                  
                                <td class="columnlabel1"><b>ช่วงค่า Iodine&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='iodine' type='text' class="inputs" id="iodine" value='' size='15'/>                                       	          	
                                </td>
                            </tr> 
                            <tr>                                  
                                <td class="columnlabel1"><b>ราคา/หน่วย เดือนที่ 1&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='price_month_1' type='text' class="inputs" id="price_month_1" value='' size='10'/>                                       	          	
                                </td>
                            </tr> 
                            <tr>                                  
                                <td class="columnlabel1"><b>ราคา/หน่วย เดือนที่ 2&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='price_month_2' type='text' class="inputs" id="price_month_2" value='' size='10'/>                                       	          	
                                </td>
                            </tr>          
                            <tr>                                  
                                <td class="columnlabel1"><b>ราคา/หน่วย เดือนที่ 3&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='price_month_3' type='text' class="inputs" id="price_month_3" value='' size='10'/>                                       	          	
                                </td>
                            </tr> 
                            <tr>                                  
                                <td class="columnlabel1"><b>ราคา/หน่วย เดือนที่ 4&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='price_month_4' type='text' class="inputs" id="price_month_4" value='' size='10'/>                                       	          	
                                </td>
                            </tr>
                            <tr>                                  
                                <td class="columnlabel1"><b>ราคา/หน่วย เดือนที่ 5&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='price_month_5' type='text' class="inputs" id="price_month_5" value='' size='10'/>                                       	          	
                                </td>
                            </tr>
                            <tr>                                  
                                <td class="columnlabel1"><b>ราคา/หน่วย เดือนที่ 6&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='price_month_6' type='text' class="inputs" id="price_month_6" value='' size='10'/>                                       	          	
                                </td>
                            </tr> 
                            <tr>                                  
                                <td class="columnlabel1"><b>ราคา/หน่วย เดือนที่ 7&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='price_month_7' type='text' class="inputs" id="price_month_7" value='' size='10'/>                                       	          	
                                </td>
                            </tr>
                            <tr>                                  
                                <td class="columnlabel1"><b>ราคา/หน่วย เดือนที่ 8&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='price_month_8' type='text' class="inputs" id="price_month_8" value='' size='10'/>                                       	          	
                                </td>
                            </tr>         
                            <tr>                                 
                                <td class="columnlabel1"><b>ราคา/หน่วย เดือนที่ 9&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='price_month_9' type='text' class="inputs" id="price_month_9" value='' size='10'/>                                       	          	
                                </td>
                            </tr>
                            <tr>                                  
                                <td class="columnlabel1"><b>ราคา/หน่วย เดือนที่ 10&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='price_month_10' type='text' class="inputs" id="price_month_10" value='' size='10'/>                                       	          	
                                </td>
                            </tr>         
                            <tr>                                  
                                <td class="columnlabel1"><b>ราคา/หน่วย เดือนที่ 11&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='price_month_11' type='text' class="inputs" id="price_month_11" value='' size='10'/>                                       	          	
                                </td>
                            </tr>
                            <tr>                                  
                                <td class="columnlabel1"><b>ราคา/หน่วย เดือนที่ 12&nbsp;:&nbsp;</b></td>
                                <td colspan="3" class="columnobject">                                    
                                    <input name='price_month_12' type='text' class="inputs" id="price_month_12" value='' size='10'/>                                       	          	
                                </td>
                            </tr>    

                            <!--tr>
                                <td class="columnlabel1"><b>ค่า Iodine</b>&nbsp;</td>
                                <td class="columnobject"><input type="hidden" name="product_none_iodine" id="product_none_iodine">
                                    <input type="radio" name="radio" id="radio1" value="radio" onClick="getStatus()" checked>
                                    ไม่มีค่า Iodine 
                                    <input type="radio" name="radio" id="radio2" value="radio" onClick="getStatus()">
                                    มีค่า Iodine</td>
                            </tr-->

                            <input type="hidden" name="product_none_iodine" id="product_none_iodine">                                 

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
                                        <a href="javascript:;" onClick="add();"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" class="imgtransparent" width="80" height="30" border="0"></a>                                            
                                        <a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" class="imgtransparent" width="80" height="30" border="0"></a>
                                        <!--a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a-->
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