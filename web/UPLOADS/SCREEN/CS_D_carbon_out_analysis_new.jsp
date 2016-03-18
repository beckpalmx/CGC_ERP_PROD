<!DOCTYPE HTML>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>

<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <head>
        <title>CARBON OUT ANALYSIS</title>
        <meta Http-Equiv="Cache-Control" Content="no-cache">
        <meta Http-Equiv="Pragma" Content="no-cache">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>

        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <link rel="stylesheet" media="all" type="text/css" href="../CSS/ui-lightness/jquery-ui-1.8.17.custom.css" />
        <link rel="stylesheet" media="all" type="text/css" href="../CSS/timepicker.css" />
        <script type="text/javascript" src="../JS/jquery/jquery-1.7.1.min.js"></script>        
        <script type="text/javascript" src="../JS/jquery/jquery-ui-1.8.17.custom.min.js"></script>
        <script type="text/javascript" src="../JS/jquery/jquery-ui-timepicker-addon.js"></script>
        <script type="text/javascript" src="../JS/jquery/jquery-ui-sliderAccess.js"></script>
        <script type="text/javascript" src="../JS/TimeFramwork.js"></script>                

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

        <script language="javascript" src="../JS/Form/input_form_carbon_out_analysis.js"></script>        
        
        <script src="../react/react.js"></script>
        <script src="../react/JSXTransformer.js"></script>
        <script src="../react/react-with-addons-0.13.3.js"></script>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--link href="../CSS/MENU.css" rel="stylesheet" type="text/css"-->
        <!--link href="../CSS/BT.css" rel="stylesheet" type="text/css"-->
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_table.css" rel="stylesheet" type="text/css">                     
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">                      

        <script language="javascript">

            function getStatus() {
                if (document.getElementById("radio1").checked) {
                    document.getElementById("approve_status").value = "N";
                    alert("กรุณาตรวจสอบเอกสาร ให้เรียบร้อย " + document.getElementById("approve_status").value);
                } else if ((document.getElementById("radio2").checked)) {
                    document.getElementById("approve_status").value = "Y";
                    alert("ตรวจสอบเอกสารเรียบร้อยแล้ว " + document.getElementById("approve_status").value);
                }
            }
            function Chknull() {
                if (document.getElementById('doc_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else
                    document.report.submit();
            }

            function OpenDoc_id()
            {
                openBrWindow('vd_carbon_out_analysis_header&stadment=and+approve_status+<>+\'Y\'', 314, 'Search_Doc_id.jsp');
            }
            function OpenDoc_id_approve()
            {
                openBrWindow('vd_carbon_out_analysis_header&stadment=and+approve_status+=+\'Y\'', 314, 'Search_Doc_id.jsp');
            }

            function unload() {
                alert("ไม่สามารถดำเนินการได้");
            }

            function cancle()
            {
                location.replace("CS_D_carbon_out_analysis_new.jsp");
            }


            function AddHeader()
            {
                var select_id = "";
                var r = confirm("คุณต้องการบันทึกหรือไม่")
                if (approve_status == '') {
                    approve_status = "N";
                }
                if (r) {
                    //alert(getId("maxline").value);
                    if (parseInt(getId("maxline").value, 10) != 0) {
                        for (var i = 1; i <= parseInt(getId("maxline").value, 10); i++) {
                            select_id += "c_type1_" + (i) + ",bu1_" + (i) + ",avg1_" + (i) + ",c_type2_" + (i) + ",bu2_" + (i) + ",avg2_" + (i) + ",c_type3_" + (i) + ",bu3_" + (i) + ",avg3_" + (i) + ",";
                        }
                        select_id += select_id.substr(0, select_id.length - 1);
                        //alert("select_id = " + select_id);
                        //getId("for_test").value = select_id;                        
                        getSave(URLsend('chkNull,doc_id,doc_date,c_type,tdate1,tname1,ttime1,tdate2,tname2,ttime2,tdate3,tname3,ttime3,reporter_id,approve_id,approve_status,username,maxline,' + select_id, '../JSP/CS_D_carbon_out_analysis_new.jsp'));
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        //getId("child_ck").value = "";
                        //getId("maxline").value = "0";
                        //getId("show").innerHTML = "<table width=\"100%\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\" class=\"inner3\"  name = \"tbdetail\" id = \"tbdetail\"></table>";
                    } else {
                        getSave(URLsend('chkNull,doc_id,doc_date,c_type,tdate1,tname1,ttime1,tdate2,tname2,ttime2,tdate3,tname3,ttime3,reporter_id,approve_id,approve_status,username,maxline', '../JSP/CS_D_carbon_out_analysis_new.jsp'));
                        getId("status_cancle").value = "";
                        //getId("child_ck").value = "";
                        //getId("child_ck").value = "";
                        //getId("maxline").value = "0";
                        //getId("show").innerHTML = "<table width=\"100%\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\" class=\"inner3\"  name = \"tbdetail\" id = \"tbdetail\"></table>";
                    }
                }
            }

            function Change_Type() {
                for (burn = 1; burn <= 3; burn++) {
                    for (channel = 1; channel <= 24; channel++) {
                        id_name = "c_type" + burn + "_" + channel;
                        //alert(id_name);
                        getId(id_name).value = getId("c_type").value;
                    }
                }
            }


        </script>                

        <script type="text/javascript">

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });</script>               

    </head>        
    <body onload="addHeader('dynamicHeader');
            addInput('show');">
        <form id="report" class="form-horizontal" name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">

            <%
                UtiDatabase objuti = new UtiDatabase();
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_D_carbon_out_analysis");

                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S808");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
            %>

            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_date">
            <input type="hidden" id="date_ck" name="date_ck" value="">
            <input type="hidden" id="status_a" value="1"><!-- เป็นการเพิ่มข้อมูลเข้าไป-->
            <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" id="status_cancle" value=""><!-- status_cancle = 1 คือค่าที่นำมา Edit แต่ถ้า ="" จะเป็นการ Insert -->
            <input type="hidden" id="child_ck" name="child_ck" value="">
            <input type="hidden" name="maxline" value="24" id="maxline">
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">        

            <input name="for_test" type='hidden' class="inputs" id="for_test" size="100">

            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks" style="color:white"></span>&nbsp;
                        <b>ผลวิเคราะห์คุณภาพถ่านออกจากเตา (CS_D_carbon_out_analysis_new)</b></div>                       
                    <div class="panel-footer">

                        <div class="row">                                                        
                            <div class="col-md-8"></div>                            
                            <label class="control-label col-md-1 columnlabel1">หมายเลขเอกสาร&nbsp;:&nbsp;<%=objs_p.getIso_no()%> </label>
                        </div>                             

                        <div class="row">                                                        
                            <div class="col-md-8"></div>
                            <label class="control-label col-md-2 columnlabel1">วันที่มีผลบังคับใช้&nbsp;:&nbsp;<%=objs_p.getEffective_date()%></label>                        
                        </div>                                                     

                        <table  cellpadding="0" cellspacing="0" >
                            <div class="row">                            
                                <label class="control-label col-md-1 columnlabel1">สถานะการตรวจสอบ : </label>                            
                                <div class="col-md-6">
                                    <font color="blue">
                                    <input type="hidden" id="approve_status" >
                                    <input type="radio" name="radio" id="radio1" onClick="getStatus()" checked>&nbsp;ยังไม่ได้ตรวจสอบ 
                                    <input type="radio" name="radio" id="radio2" onClick="getStatus()">&nbsp;ตรวจสอบแล้ว
                                    </font>
                                </div>
                            </div>       

                            <div class="row">
                                <label class="control-label col-md-1 columnlabel1">เลขที่เอกสาร&nbsp;:&nbsp;</label>
                                <div class="col-md-4" data-toggle="tooltip" title="เลือกเอกสารที่ยังไม่ได้ตรวจสอบ">
                                    <font color = '#3366CC'><input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='12' readonly="true"/></font>
                                    <a href='#' onClick="OpenDoc_id()" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                </div>
                                <div class="col-md-6" data-toggle="tooltip" title="เลือกวันที่เอกสาร">                                        
                                    <label class="control-label col-md-1 columnlabel1">วันที่เอกสาร*&nbsp;:&nbsp;</label>
                                    <font color = '#3366CC'><input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' readonly="true" /></font>
                                    <a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>
                                </div>
                            </div>   

                            <div class="row">
                                <label class="control-label col-md-1 columnlabel1">(ตรวจสอบแล้ว)&nbsp;:&nbsp;</label>
                                <div class="col-md-6" data-toggle="tooltip" title="ดูเอกสารที่ผ่านการตรวจสอบแล้ว">
                                    <a href='#' onClick="OpenDoc_id_approve()" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>                               
                                </div>
                            </div>    

                            <div class="row">
                                <label class="control-label col-md-1 columnlabel1">ประเภท&nbsp;:&nbsp;</label>
                                <div class="col-md-6" data-toggle="tooltip" title="เลือกประเภทถ่านและกดปุ่มเพื่อเปลี่ยนประเภทถ่านทั้งหมดในตาราง" >  
                                    <%=objuti.ShowSelectBox("select product_id,name_t from mproduct where pgroup_id = 'RAW' order by runno", "product_id", "name_t", "c_type")%>                                                                
                                    <input type='button' class="cgcButton_10" id="ChangeTypeBtn" name='ChangeTypeBtn' value='  เปลี่ยนประเภท (ทั้งหมด)  ' onClick="Change_Type();"/>
                                </div>
                            </div>

                            <div class="row">
                                <label class="control-label col-md-1 columnlabel1"> </label>
                            </div>                                
                            <div class="tab-content">
                                <div id="home" class="tab-pane fade in active">
                                    <label class="control-label col-md-1 columnlabel1"></label>
                                    <span class="label label-success"><font color="white">ข้อมูลการวิเคราะห์</font></span>
                                </div>               

                                <div class="row">
                                    <label class="control-label col-md-9"></label>
                                    <div class="col-md-2">                                                                                   
                                        <input type='hidden' class="cgcButton_4" id="InsertBtn" name='InsertBtn' value='  เพิ่ม  ' onClick="javascript:getId('status_cancle').value == '1' ? unload() : addInput('show');" disabled/>
                                    </div>
                                </div>

                                <div class="row">
                                    <label class="control-label col-md-1 columnlabel1"> </label>
                                </div>                                               

                                <div id="dynamicHeader"></div>
                                <div id="show"></div>

                            </div>

                            <div class="row">
                                <label class="control-label col-md-1 columnlabel1"> </label>
                            </div>                                

                            <div class="row">
                                <label class="control-label col-md-1 columnlabel1">ผู้รายงาน&nbsp;:&nbsp;</label>
                                <div class="col-md-6">                                
                                    <font color = '#3366CC'><input name="reporter_id" type='text' class="inputs" id="reporter_id" size="15" readonly='true' >
                                    <a href='#' onClick="openBrWindow('Vemployee&stadment=and+status+=+\'Y\'and+(dept_id+=+\'06\'or+dept_id+=+\'003\')', 313, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                    <input name="reporter_id_desc" type='text' class="inputs" id="reporter_id_desc" size="30" readonly='true' ></font>
                                </div>
                            </div>                                                          
                            <div class="row">
                                <label class="control-label col-md-1 columnlabel1">ผู้ตรวจสอบ&nbsp;:&nbsp;</label>
                                <div class="col-md-6">                                
                                    <font color = '#3366CC'><input name="approve_id" type='text' class="inputs" id="approve_id" size="15" readonly='true' >
                                    <a href='#' onClick="openBrWindow('Vemployee1&stadment=and+status+=+\'Y\'and+(dept_id+=+\'06\'or+dept_id+=+\'003\')', 313, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                    <input name="approve_id_desc" type='text' class="inputs" id="approve_id_desc" size="30" readonly='true' ></font>
                                </div>
                            </div>                                     

                            <!--br>
                            <button type="button" class="btn btn-warning" data-toggle="tooltip" title="ยกเลิก" onClick="Do_Action(2);"><b>ยกเลิก</b></button>                            

                            <button type="button" class="btn btn-primary" data-toggle="tooltip" title="บันทึกข้อมูล" onClick="Do_Action(1);"><b>บันทึกข้อมูล</b></button>                                                        

                            <button type="button" class="btn btn-danger" data-toggle="tooltip" title="ลบข้อมูล" onClick="Do_Action(2);"><b>ลบข้อมูล</b></button>

                            <button type="button" class="btn btn-success" data-toggle="tooltip" title="พิมพ์รายงาน" onClick="Do_Action(2);"><b>พิมพ์รายงาน</b></button-->
                            
                            <br>
                            <div class="row">
                                <!--label class="control-label col-md-1 columnlabel1"></label-->
                                <div class="col-md-12" align="center">
                                    <a href="javascript:;" onClick="cancle()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                    <a href="javascript:;" onClick="AddHeader()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                    <a href="javascript:;" onClick="Delete()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                                    <a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" class="imgtransparent" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a>
                                </div>
                            </div>
                            <br>
                        </table>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
