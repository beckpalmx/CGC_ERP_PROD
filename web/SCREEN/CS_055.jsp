<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
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
            function cancal() {
                cancelAction();
                getId("show").innerHTML = "";
            }
            function Send_to_Approve() {
                var value_ckbox = "";
                var value_doc_id = "";
                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                {
                    //alert(document.getElementsByName("ckbox")[i].checked);
                    if (document.getElementsByName("ckbox")[i].checked == true) {
                        value_ckbox += document.getElementsByName("ckbox")[i].value + ",";
                        value_doc_id += document.getElementsByName("line_doc_id")[i].value + ","
                    }
                }
                if (value_ckbox != "") {
                    getId("line_no").value = value_ckbox.substr(0, value_ckbox.length - 1);
                    getId("doc_id").value = value_doc_id.substr(0, value_doc_id.length - 1);
                    IDsend = "doc_id,line_no";
                    //alert(getId("line_no").value);
                    //alert(getId("doc_id").value);
                    getsaveApprove(URLsend(IDsend, "../JSP/CS_055.jsp"), "calreport");//(URLsend(IDsend, "../JSP/CS_048_2.jsp"));
                    getId("doc_id").value = "";
                    getId("line_no").value = "";
                    getId("show").innerHTML = "";
                    getId("chk_all").checked = false;
                }
                else {
                    alert("กรุณาเลือกข้อมูลที่จะบันทึก");
                }

            }

            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }
            function showTablePage() {
                if (getId("select_search").value == "1") {
                    showTableNonPopup('show', 'doc_id', '../JSP/CS_Show055.jsp?doc_id=');
                } else {
                    if (getId("doc_date").value == "") {
                        alert("กรุณาเลือกวันที่");
                    } else {
                        showTableNonPopup('show', 'doc_date', '../JSP/CS_Show055.jsp?doc_date=');
                    }
                }

            }
        </script>
    </head>
    <body onUnload="closepopup()">
        <input type="hidden" id="line_no" name="line_no" value="">

        <div align="left">

            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                        <b>อนุมัติปิดใบรับถ่านออกจากเตาเข้าคลังสินค้า</b>
                    </div>                        
                    <div class="panel-footer">     
                        <div align="center">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td width="30%" align="right">ค้นหาข้อมูลถ่านออกจากเตา*&nbsp;</td>
                                    <td class="columnobject">
                                        <input type='hidden' name='doc_id' id="doc_id" size='10' value='' /><!--&nbsp;<a href='javascript:;' onClick="javascript:openBrWindow('vd_carbon_burn_out_header_wh&stadment=and+complete_flag+<>+\'Y\'',49,'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                              <input type='text' class="inputs" name="doc_date" id="doc_date">-->
                                        <input type='button' class="cgcButton_6" name='search' onClick="showTablePage()" value='ค้นหา'/>
                                        <select class="select_cgc2" id="select_search" >
                                            <option value="1">ทั้งหมด</option>
                                            <option value="2">หาจากวันที่</option>
                                        </select>
                                        วันที่เอกสาร*&nbsp;
                                        <input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' readonly="readonly"/>
                                        &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>
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
                                                    <td class="headergrid" colspan="5">เอกสารที่จะส่งออก</td>
                                                    <td class="headergrid" colspan="8"></td>
                                                </tr>

                                                <tr>
                                                    <td class="row5" width="3%"><input type="checkbox" name="chk_all" id="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                    <td class="row5" width="7%">No.&nbsp;</td>
                                                    <td class="row5" width="15%">รหัสเอกสาร&nbsp;</td>
                                                    <td class="row5" width="15%">วันที่บันทึกเอกสาร&nbsp;</td>
                                                    <td class="row5" width="15%">รหัสสินค้า&nbsp;</td>
                                                    <td class="row5" width="15%">วันที่ทำงาน&nbsp;</td>
                                                    <td class="row5" width="15%">จากเวลา&nbsp;</td>
                                                    <td class="row5" width="15%">ถึงเวลา</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">

                                        </div>                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan='2' align="right">
                                        <input type="hidden" name="chkNull" id="chkNull" value="doc_id"/>
                                        <input type='button' class="cgcButton_4" name='but1' value='  บันทึก  ' onclick='Send_to_Approve();'/>
                                        <input type='button' class="cgcButton_3" name='but2' value='  ยกเลิก  ' onclick='javascript:cancal();'/>                                    </td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                            </table>
                            <textarea class="text_inputs" name="calreport" id="calreport" cols="90" rows="7"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
