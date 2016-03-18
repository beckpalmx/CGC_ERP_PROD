<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<!DOCTYPE HTML>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Screen</title>

        <script language="javascript" src="../JS/myAjaaxFramework.js"></script>
        <!--link href="../CSS/MENU.css" rel="stylesheet" type="text/css"-->
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 


        <!-- calendar stylesheet -->
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes adding a calendar a matter of 1 or 2 lines of code. -->

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
        

        <script language="javascript">
            function submitPage(cnt) {
                if (document.getElementById('chkbox_qc').checked) {
                    document.getElementById('qc_check').value = 'Y';
                } else {
                    document.getElementById('qc_check').value = 'N ';
                }
                ;
                if (cnt === 1) {
                    confirmDialogSave(URLsend('chkNull,screen_id,name_t_screen,name_t_dept,remark_screen,name_t_process,process_id,dept_id,iso_no,effective_date,qc_check,email_from,email_to,email_server,email_port', '../JSP/CS_001.jsp'));                    
                } else {
                    confirmDialogDelete(URLsend('screen_id,name_t_screen,remark_screen,process_id,dept_id,iso_no,effective_date,qc_check,chkstatus', '../JSP/CS_001.jsp'));
                }
            }

        </script>                

        <script type="text/javascript">

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>               

        <script>

            function Do_Action(param) {
                if (document.getElementById('chkbox_qc').checked) {
                    document.getElementById('qc_check').value = 'Y';
                } else {
                    document.getElementById('qc_check').value = 'N ';
                }
                ;
                //alert("param = " + param);
                if (param === 1) {
                    confirmSave_Data(this, "01", URLsend('chkNull,screen_id,name_t_screen,name_t_dept,remark_screen,name_t_process,process_id,dept_id,iso_no,effective_date,qc_check,email_from,email_to,email_server,email_port', '../JSP/CS_001.jsp'));
                    //return false;
                } else {
                    confirmDelete_Data(this, "02", URLsend('screen_id,name_t_screen,remark_screen,process_id,dept_id,iso_no,effective_date,qc_check,chkstatus', '../JSP/CS_001.jsp'));
                    //return false;
                }
            }

        </script>



    </head>    
    <body>
        <form id="userForm" class="form-horizontal">
            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-wrench" style="color:white"></span>&nbsp;<b>หน้าจอการทำงาน (CS_001)</b></div>
                    <input type="hidden" id="chkNull" value="screen_id,name_t_screen,process_id,dept_id">             
                    <input type="hidden" id="chkstatus" value="1">
                    <div class="panel-footer">
                        <div class="row">                            
                            <label class="control-label col-md-1 columnlabel1">รหัสหน้าจอ*&nbsp;:&nbsp;</label>
                            
                            <div class="col-md-6">                                
                                <input type='text' class="inputs" name='screen_id' id="screen_id" size='10' value='' />&nbsp;&nbsp;
                                <a href="javascript:openBrWindow('Vscreen',1,'Search_Config.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle'></a>&nbsp;&nbsp;
                                <input type='text' class="inputs" name='name_t_screen' id="name_t_screen" size='30' value='' />                                       
                            </div>
                        </div>       

                        <div class="row">
                            <label class="control-label col-md-1 columnlabel1">รหัส Process*&nbsp;:&nbsp;</label>
                            <div class="col-md-6">                                
                                <input type='text' class="inputs" name='process_id' id="process_id" size='10' value='' readonly/>&nbsp;&nbsp;
                                <a href=javascript:openBrWindow('Process',1,'Search_Config.jsp');><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                <input type='text' class="inputs" name='name_t_process' id="name_t_process" size='30' value='' />                                    
                            </div>
                        </div>   


                        <div class="row">
                            <label class="control-label col-md-1 columnlabel1">รหัสแผนก*&nbsp;:&nbsp;</label>
                            <div class="col-md-6">                                
                                <input type='text' class="inputs" name='dept_id' id="dept_id" size='10' value='' readonly/>&nbsp;&nbsp;
                                <a href=javascript:openBrWindow('Department',1,'Search_Config.jsp');><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' width='20' height='20' border='0' align='middle'></a>&nbsp;&nbsp;
                                <input type='text' class="inputs" name='name_t_dept' id="name_t_dept" size='30' value='' />                                  
                            </div>
                        </div>    

                        <div class="row">
                            <label class="control-label col-md-1 columnlabel1">หมายเลขเอกสาร&nbsp;:&nbsp;</label>
                            <div class="col-md-6">                                
                                <input type='text' class="inputs" name='iso_no' id="iso_no" size='30' value='' />                                    
                            </div>
                        </div>        

                        <div class="row">
                            <label class="control-label col-md-1 columnlabel1">วันที่บังคับใช้&nbsp;:&nbsp;</label>
                            <div class="col-md-6">                                
                                <input type='text' class="inputs" name='effective_date' id="effective_date" size='10' value='' readonly/>
                                <a id='date_1' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                <script type='text/javascript'>Calendar.setup({inputField: 'effective_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>

                            </div>
                        </div>                           

                        <div class="row">                            
                            <label class="control-label col-md-1 columnlabel1">QC Check&nbsp;:&nbsp;</label>
                            <div class="col-md-6">                                
                                <div class="checkbox checkbox-primary">
                                    <input type="hidden" name='qc_check' id="qc_check" value=''/>
                                    <input type='checkbox' name='chkbox_qc' id="chkbox_qc"/>
                                    <label for="qc_check"></label>                                     
                                </div>      
                            </div>      
                        </div>      

                        <div class="row">
                            <label class="control-label col-md-1 columnlabel1">หมายเหตุ&nbsp;:&nbsp;</label>
                            <div class="col-md-6">                                
                                <textarea class="text_inputs_3" name='remark_screen' id="remark_screen" rows='5' cols='40'></textarea>
                            </div>
                        </div>             

                        <div class="row">
                            <label class="control-label col-md-1 columnlabel1">Email From :&nbsp;</label>
                            <div class="col-md-6">                                
                                <input type='text' class="inputs" name='email_from' id="email_from" size='30' value='' />   
                            </div>
                        </div>    

                        <div class="row">
                            <label class="control-label col-md-1 columnlabel1">Email To :&nbsp;</label>
                            <div class="col-md-6">                                
                                <input type='text' class="inputs" name='email_to' id="email_to" size='100' value='' />                                    
                            </div>
                        </div>                            

                        <div class="row">
                            <label class="control-label col-md-1 columnlabel1">Email Server :&nbsp;</label>
                            <div class="col-md-6">                                
                                <input type='text' class="inputs" name='email_server' id="email_server" size='20' value='' />                                    
                            </div>
                        </div>     

                        <div class="row">
                            <label class="control-label col-md-1 columnlabel1">Email Port :&nbsp;</label>
                            <div class="col-md-6">                                
                                <input type='text' class="inputs" name='email_port' id="email_port" size='5' value='' />                                    
                            </div>
                        </div>                             



                        <!--div class="form-group form-group-sm">
                            <label class="control-label col-md-1 columnlabel1"></label>
                            <input type="hidden" id="chkNull" value="screen_id,name_t_screen,process_id,dept_id">
                            <input type="hidden" id="chkstatus" value="1">
                            <a href="javascript:;" onclick="cancelAction()" ><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                            <a href="javascript:;" onkeypress="if (event.keyCode == 113)" onClick="submitPage(1)"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                            <a href="javascript:;" onClick="submitPage(2)"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                        </div-->

                        <div class="form-group form-group-sm"></div>

                        <button type="button" class="btn btn-primary btn-block" data-toggle="tooltip" title="บันทึกข้อมูล" onClick="Do_Action(1);"><b>บันทึกข้อมูล</b></button>
                        
                        <div class="row">
                            <label class="control-label col-md-1 columnlabel1">&nbsp;</label>                            
                        </div>
                        
                        <button type="button" class="btn btn-danger btn-block" data-toggle="tooltip" title="ลบข้อมูล" onClick="Do_Action(2);"><b>ลบข้อมูล</b></button>

                        <!--button type="button" class="btn btn-primary btn-block" data-toggle="tooltip" title="บันทึกข้อมูล" onClick="submitPage(1)"><b>บันทึกข้อมูล</b></button>
                        <button type="button" class="btn btn-danger btn-block" data-toggle="tooltip" title="ลบข้อมูล" onClick="submitPage(2)"><b>ลบข้อมูล</b></button-->

                    </div>
                </div>
            </div>

        </form>
    </body>
</html>
