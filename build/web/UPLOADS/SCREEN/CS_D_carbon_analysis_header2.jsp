<!DOCTYPE html>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <link rel="stylesheet" media="all" type="text/css" href="../CSS/ui-lightness/jquery-ui-1.8.17.custom.css" />
        <link rel="stylesheet" media="all" type="text/css" href="../CSS/timepicker.css" />
        <!---->        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link href="../CSS/tooltipster.css" rel="stylesheet" type="text/css"/>        
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script><!-- calendar stylesheet -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script><!-- language for the calendar -->
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script type="text/javascript" src="../JS/jquery/jquery-1.7.1.min.js"></script>
        <script type="text/javascript" src="../JS/jquery/jquery-ui-1.8.17.custom.min.js"></script>            
        <script type="text/javascript" src="../JS/jquery/jquery-ui-timepicker-addon.js"></script>
        <script type="text/javascript" src="../JS/jquery/jquery-ui-sliderAccess.js"></script>
        <script type="text/javascript" src="../JS/TimeFramwork.js"></script>
        <script type="text/javascript" src="js/jquery.tooltipster.min.js"></script>   

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>     

        <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">             

        <script src="../JS/angularjs/angular.min.js"></script>                

        <script src="../JS/alertify/alertify.min.js"></script>        
        <link rel="stylesheet" href="../CSS/alertify/alertify.core.css" />
        <link rel="stylesheet" href="../CSS/alertify/alertify.default.css" />          

        <link rel="stylesheet" href="../CSS/checkbox/awesome-bootstrap-checkbox.css"/> 
        <link rel="stylesheet" href="../FONTS/css/font-awesome.css" />                

        <script type="text/javascript">
            function ResetValue() {
                getId("quality_confirm").value = "N";
                getId("quality_confirm").checked = false;
                getId("maxline").value = "0";
                getId("complete_flag").value = "N";
                getId("complete_flag").checked = false;
                getId("complete_flag").disabled = true;
                getId("status_cancle").value = "";
                getId("show").innerHTML = "<table width=\"100%\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\" class=\"inner\"  name = \"tbExp\" id = \"tbExp\"></table>";
            }
            function Chknull() {
                if (document.getElementById('A_doc_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else {
                    getId("doc_id").value = document.getElementById('A_doc_id').value;
                    getId("report_code").value = "RP_098";
                    document.report.submit();
                }
            }

            function goAddChild(URLSend)
            {
                if (getId("status_cancle").value == "1") {
                    var arryChk = new Array;
                    arryChk[0] = "chkNull";
                    if (ChkParameter(arryChk))
                    {
                        window.open(URLSend[0]);
                    }
                } else {
                    alert("กรุณาบันทึกหัวเอกสาร");
                }

            }
            function cancle()
            {
                location.replace("CS_D_carbon_analysis_header2.jsp");
            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }

            function ___goDelChildBAK()
            {
                var Deleteflag = "";
                var SURL;

                SURL = "../JSP/CS_Detail_D_carbon_analysis_detail.jsp?status_d=3&ckbox=";
                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                {
                    Deleteflag += (document.getElementsByName("ckbox")[i].checked) ? (i + 1).toString() + "," : "";
                }

                Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);

                //alert("Delete Deleteflag = " + Deleteflag );

                SURL = SURL + Deleteflag + "&A_doc_id=" + getId("A_doc_id").value + "&username=" + getId("A_username").value;
                //alert("Delete SURL = " + SURL );
                Delete_Line_no(SURL);
                showTableNonPopup("show", "A_doc_id", "../JSP/CS_ShowD_carbon_analysis_detail.jsp?doc_id=");
                setTimeout('showTableNonPopup("show", "A_doc_id", "../JSP/CS_ShowD_carbon_analysis_detail.jsp?doc_id=")', 100);

            }

            function goDelChild()
            {
                var Deleteflag = "";
                var SURL;

                var r = confirm("คุณต้องการลบข้อมูลหรือไม่")
                if (r) {

                    //alert("Delete DATA");
                    if (getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                    {
                        SURL = "../JSP/CS_Detail_D_carbon_analysis_detail.jsp?status_d=3&chk_all=1&username=" + getId("A_username").value;
                        SURL = SURL + "&A_doc_id=" + getId("A_doc_id").value;
                        Delete_Line_no(SURL);
                        getId("show").innerHTML = "";
                        getId("chk_all").checked = false;
                        //location.replace("CS_D_carbon_analysis_header2.jsp");                        
                        showTableNonPopup("show", "A_doc_id", "../JSP/CS_ShowD_carbon_analysis_detail.jsp?doc_id=");
                        setTimeout('showTableNonPopup("show", "A_doc_id", "../JSP/CS_ShowD_carbon_analysis_detail.jsp?doc_id=")', 100);
                    }
                    else//จะทำการลบข้อมูลเฉพาะ Detail ที่ทำการเลือกไว้
                    {
                        SURL = "../JSP/CS_Detail_D_carbon_analysis_detail.jsp?status_d=3&ckbox=";
                        for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                        {
                            Deleteflag += (document.getElementsByName("ckbox")[i].checked) ? (i + 1).toString() + "," : "";
                        }
                        Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                        SURL = SURL + Deleteflag + "&A_doc_id=" + getId("A_doc_id").value + "&username=" + getId("A_username").value;
                        Delete_Line_no(SURL);
                        showTableNonPopup("show", "A_doc_id", "../JSP/CS_ShowD_carbon_analysis_detail.jsp?doc_id=");
                        setTimeout('showTableNonPopup("show", "A_doc_id", "../JSP/CS_ShowD_carbon_analysis_detail.jsp?doc_id=")', 100);
                    }
                }
            }



            function OpenEdit(URLSend)
            {
                window.open(URLSend[0]);
            }
            function AddHeader()
            {
                var r = confirm("คุณต้องการบันทึกหรือไม่")
                if (r)
                {
                    var arryChk = new Array;
                    arryChk[0] = "chkNull";
                    //if (ChkParameter(arryChk) && check_detail_null()) {                        
                    if (ChkParameter(arryChk)) {
                        var strID = "";
                        var select_id = "";

                        if (parseInt(getId("maxline").value, 10) != 0) {
                            for (var i = 1; i <= parseInt(getId("maxline").value, 10); i++) {
                                select_id += "P_bag_qty_" + (i) + ",P_machine_" + (i) + ",P_job_id_" + (i) + ",P_product_id_" + (i) + ",P_size_id_" + (i) + ",P_prod_no_" + (i) + ",P_h2o_" + (i) + ",P_butane_" + (i) + ",P_iod_" + (i) + ",P_remark_" + (i) + ",";
                            }

                        }
                        var str_Confirm = "quality_confirm,emp_id,";
                        var strID = select_id + str_Confirm + "A_screen_id,A_dept_doc_id,I_status,A_doc_id,A_doc_date,A_job_type,A_doc_type,A_lab_leader_id,A_send_doc_time,lab_emp_id";
                        getSave(URLsend('chkNull,maxline,' + strID, '../JSP/CS_D_carbon_analysis_header.jsp'));
                        ResetValue();
                    }
                }

            }

            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if (r)
                {
                    getSave(URLsend('D_status,A_doc_id', '../JSP/CS_D_carbon_analysis_header.jsp'));
                    ResetValue();
                }

            }

            function Unload()
            {
            }

            function OpenDoc_id(input)
            {
                switch (input) {
                    case 0:
                        openBrWindow('vd_carbon_analysis_all_header&stadment=and+doc_type+=+\'PM\'and+quality_confirm+=+\'N\'', 28, 'Search_Doc_id.jsp');
                        break;
                    case 1:
                        openBrWindow('vd_carbon_analysis_all_header&stadment=and+doc_type+=+\'PM\'and+quality_confirm+=+\'Y\'', 28, 'Search_Doc_id.jsp');
                        break;
                }
            }


            function Click_Complete_flag(value) {
                if (value) {
                    alert("เอกสารนี้สมบูรณ์");
                    getId("A_complete_flag").checked = value;
                    getId("A_complete_flag").value = "Y";
                } else {
                    getId("A_complete_flag").checked = value;
                    getId("A_complete_flag").value = "N";
                }
            }
            function Click_Company_id() {
                for (var i = 0; i < document.getElementsByName("company_id").length; i++)
                {
                    if (document.getElementsByName("company_id")[i].checked) {
                        getId("A_company_id").value = document.getElementsByName("company_id")[i].value;
                    }
                }
            }
            /*            
             function getuint(line) {
             openBrWindow("vm_part_unit&textinput=P_unit_id_" + line + "|unit_name_" + line + "&stadment=and+part_id=\'" + getId('P_part_id_' + line).value + "\'", 0, "Search_Detail.jsp");
             }
             */

            function CreateNewRow()
            {
                var theTable = document.getElementById("tbExp");

                var intLine = parseInt(getId("maxline").value);
                if (intLine == 0) {
                    for (var i = 1; i <= 15; i++) {
                        intLine++;
                        var theTable = document.getElementById("tbExp");
                        var newRow = theTable.insertRow(theTable.rows.length);
                        newRow.id = newRow.uniqueID;
                        var item1 = 1;
                        var newCell;
                        newCell = newRow.insertCell(0)
                        newCell.id = newCell.uniqueID
                        newCell.setAttribute("width", "10");
                        newCell.setAttribute("class", "forborder");
                        newCell.setAttribute("align", "center");
                        newCell.innerHTML = "<td><input type = 'checkbox' id = '" + intLine + "' name = 'ckbox'></td>"
                        newCell = newRow.insertCell(1)
                        newCell.setAttribute("width", "10");
                        newCell.setAttribute("class", "forborder");
                        newCell.setAttribute("align", "center");
                        newCell.innerHTML = "<td style=\"width: 10px;\">" + intLine + "&nbsp;</td>"
                        newCell = newRow.insertCell(2)
                        newCell.setAttribute("width", "5%");
                        newCell.setAttribute("class", "forborder");
                        newCell.setAttribute("align", "center");
                        newCell.innerHTML = "<td><INPUT    TYPE=\"text\" SIZE=\"5\" name=\"P_bag_qty\" ID=\"P_bag_qty_" + intLine + "\" VALUE=\"\" ></td>"
                        newCell = newRow.insertCell(3)
                        newCell.setAttribute("width", "5%");
                        newCell.setAttribute("class", "forborder");
                        newCell.setAttribute("align", "center");
                        //newCell.innerHTML = "<td ><INPUT   TYPE=\"text\" SIZE=\"15\" name=\"P_machine\" ID=\"P_machine_" + intLine + "\" VALUE=\"\" onclick=\"openBrWindow(\'mmachine&textinput=P_machine_" + intLine + "\', 0, \'Search_Detail_Desc.jsp\')\" readonly></td>"
                        newCell.innerHTML = "<td ><INPUT   TYPE=\"text\" SIZE=\"15\" name=\"P_machine\" ID=\"P_machine_" + intLine + "\" VALUE=\"\" ></td>"
                        newCell = newRow.insertCell(4)
                        newCell.setAttribute("width", "10%");
                        newCell.setAttribute("class", "forborder");
                        newCell.setAttribute("align", "center");
                        newCell.innerHTML = "<td><INPUT    TYPE=\"text\" SIZE=\"8\" name=\"P_job_id\" ID=\"P_job_id_" + intLine + "\" VALUE=\"\" onclick=\"openBrWindow(\'vd_job_order_header&textinput=P_job_id_" + intLine + "\', 0, \'Search_Detail_Desc.jsp\')\"></td>"
                        newCell = newRow.insertCell(5)
                        newCell.setAttribute("width", "5%");
                        newCell.setAttribute("class", "forborder");
                        newCell.setAttribute("align", "center");
                        newCell.innerHTML = "<td><INPUT   TYPE=\"text\" SIZE=\"5\" name=\"P_product_id\" ID=\"P_product_id_" + intLine + "\" VALUE=\"\"  onclick=\"openBrWindow(\'mproduct_cat&textinput=P_product_id_" + intLine + "\', 0, \'Search_Detail_Desc.jsp\')\" readonly></td>"
                        newCell = newRow.insertCell(6)
                        newCell.setAttribute("width", "10%");
                        newCell.setAttribute("class", "forborder");
                        newCell.setAttribute("align", "center");
                        newCell.innerHTML = "<td><INPUT   TYPE=\"text\" SIZE=\"8\" name=\"P_size\" ID=\"P_size_id_" + intLine + "\" VALUE=\"\"  onclick=\"openBrWindow(\'m_carbon_size&textinput=P_size_id_" + intLine + "\', 0, \'Search_Detail_Desc.jsp\')\" readonly></td>"
                        newCell = newRow.insertCell(7)
                        newCell.setAttribute("width", "10%");
                        newCell.setAttribute("class", "forborder");
                        newCell.setAttribute("align", "center");
                        newCell.innerHTML = "<td><INPUT    TYPE=\"text\" SIZE=\"10\" name=\"P_prod_no\" ID=\"P_prod_no_" + intLine + "\" VALUE=\"\"   ></td>"
                        newCell = newRow.insertCell(8)
                        newCell.setAttribute("width", "10%");
                        newCell.setAttribute("class", "forborder");
                        newCell.setAttribute("align", "center");
                        newCell.innerHTML = "<td><INPUT   TYPE=\"text\" SIZE=\"5\" name=\"P_h2o\" ID=\"P_h2o_" + intLine + "\" VALUE=\"\"></td>"
                        newCell = newRow.insertCell(9)
                        newCell.setAttribute("width", "10%");
                        newCell.setAttribute("class", "forborder");
                        newCell.setAttribute("align", "center");
                        newCell.innerHTML = "<td><INPUT  TYPE=\"text\" SIZE=\"5\" name=\"P_butane\" ID=\"P_butane_" + intLine + "\" VALUE=\"\" ></td>"
                        newCell = newRow.insertCell(10)
                        newCell.setAttribute("width", "10%");
                        newCell.setAttribute("class", "forborder");
                        newCell.setAttribute("align", "center");
                        newCell.innerHTML = "<td><INPUT    TYPE=\"text\" SIZE=\"5\" name=\"P_iod\" ID=\"P_iod_" + intLine + "\" VALUE=\"\" ></td>"
                        newCell = newRow.insertCell(11)
                        newCell.setAttribute("width", "10%");
                        newCell.setAttribute("class", "forborder");
                        newCell.setAttribute("align", "center");
                        newCell.innerHTML = "<td><INPUT    TYPE=\"text\" SIZE=\"10\" name=\"P_remark\" ID=\"P_remark_" + intLine + "\" VALUE=\"\" ></td>"
                        //newCell = newRow.insertCell(12)
                        //newCell.setAttribute("width", "10%");
                        //newCell.setAttribute("class", "forborder");
                        //newCell.setAttribute("align", "center");
                        //newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"7\" ID=\"P_total_weight_" + intLine + "\" VALUE=\"\" onblur=\"IsNuber(this.value, this)\"></td>"
                    }
                } else {
                    intLine++;
                    var theTable = document.getElementById("tbExp");
                    var newRow = theTable.insertRow(theTable.rows.length);
                    newRow.id = newRow.uniqueID;
                    var item1 = 1;
                    var newCell;
                    //*** Column 1 ***//
                    newCell = newRow.insertCell(0)
                    newCell.id = newCell.uniqueID
                    newCell.setAttribute("width", "2%");
                    newCell.setAttribute("class", "forborder");
                    newCell.setAttribute("align", "center");
                    newCell.innerHTML = "<td  style=\"width: 10px;\"><input type = 'checkbox' id = '" + intLine + "' name = 'ckbox'></td>"
                    newCell = newRow.insertCell(1)
                    newCell.setAttribute("width", "10");
                    newCell.setAttribute("class", "forborder");
                    newCell.setAttribute("align", "center");
                    newCell.innerHTML = "<td style=\"width: 10px;\" >" + intLine + "&nbsp;</td>"
                    newCell = newRow.insertCell(2)
                    newCell.setAttribute("width", "5%");
                    newCell.setAttribute("class", "forborder");
                    newCell.setAttribute("align", "center");
                    newCell.innerHTML = "<td><INPUT    TYPE=\"text\" SIZE=\"5\" name=\"P_bag_qty\" ID=\"P_bag_qty_" + intLine + "\" VALUE=\"\" ></td>"
                    newCell = newRow.insertCell(3)
                    newCell.setAttribute("width", "5%");
                    newCell.setAttribute("class", "forborder");
                    newCell.setAttribute("align", "center");
                    //newCell.innerHTML = "<td ><INPUT   TYPE=\"text\" SIZE=\"15\" name=\"P_machine\" ID=\"P_machine_" + intLine + "\" VALUE=\"\" onclick=\"openBrWindow(\'mmachine&textinput=P_machine_" + intLine + "\', 0, \'Search_Detail_Desc.jsp\')\" readonly></td>"
                    newCell.innerHTML = "<td ><INPUT   TYPE=\"text\" SIZE=\"15\" name=\"P_machine\" ID=\"P_machine_" + intLine + "\" VALUE=\"\" ></td>"
                    newCell = newRow.insertCell(4)
                    newCell.setAttribute("width", "10%");
                    newCell.setAttribute("class", "forborder");
                    newCell.setAttribute("align", "center");
                    newCell.innerHTML = "<td><INPUT    TYPE=\"text\" SIZE=\"8\" name=\"P_job_id\" ID=\"P_job_id_" + intLine + "\" VALUE=\"\" onclick=\"openBrWindow(\'vd_job_order_header&textinput=P_job_id_" + intLine + "\', 0, \'Search_Detail_Desc.jsp\')\"></td>"
                    newCell = newRow.insertCell(5)
                    newCell.setAttribute("width", "5%");
                    newCell.setAttribute("class", "forborder");
                    newCell.setAttribute("align", "center");
                    newCell.innerHTML = "<td><INPUT   TYPE=\"text\" SIZE=\"5\" name=\"P_product_id\" ID=\"P_product_id_" + intLine + "\" VALUE=\"\"  onclick=\"openBrWindow(\'mproduct_cat&textinput=P_product_id_" + intLine + "\', 0, \'Search_Detail_Desc.jsp\')\" readonly></td>"
                    newCell = newRow.insertCell(6)
                    newCell.setAttribute("width", "10%");
                    newCell.setAttribute("class", "forborder");
                    newCell.setAttribute("align", "center");
                    newCell.innerHTML = "<td><INPUT   TYPE=\"text\" SIZE=\"8\" name=\"P_size\" ID=\"P_size_id_" + intLine + "\" VALUE=\"\"  onclick=\"openBrWindow(\'m_carbon_size&textinput=P_size_id_" + intLine + "\', 0, \'Search_Detail_Desc.jsp\')\" readonly></td>"
                    newCell = newRow.insertCell(7)
                    newCell.setAttribute("width", "10%");
                    newCell.setAttribute("class", "forborder");
                    newCell.setAttribute("align", "center");
                    newCell.innerHTML = "<td><INPUT    TYPE=\"text\" SIZE=\"10\" name=\"P_prod_no\" ID=\"P_prod_no_" + intLine + "\" VALUE=\"\"   ></td>"
                    newCell = newRow.insertCell(8)
                    newCell.setAttribute("width", "10%");
                    newCell.setAttribute("class", "forborder");
                    newCell.setAttribute("align", "center");
                    newCell.innerHTML = "<td><INPUT   TYPE=\"text\" SIZE=\"5\" name=\"P_h2o\" ID=\"P_h2o_" + intLine + "\" VALUE=\"\"></td>"
                    newCell = newRow.insertCell(9)
                    newCell.setAttribute("width", "10%");
                    newCell.setAttribute("class", "forborder");
                    newCell.setAttribute("align", "center");
                    newCell.innerHTML = "<td><INPUT  TYPE=\"text\" SIZE=\"5\" name=\"P_butane\" ID=\"P_butane_" + intLine + "\" VALUE=\"\" ></td>"
                    newCell = newRow.insertCell(10)
                    newCell.setAttribute("width", "10%");
                    newCell.setAttribute("class", "forborder");
                    newCell.setAttribute("align", "center");
                    newCell.innerHTML = "<td><INPUT    TYPE=\"text\" SIZE=\"5\" name=\"P_iod\" ID=\"P_iod_" + intLine + "\" VALUE=\"\" ></td>"
                    newCell = newRow.insertCell(11)
                    newCell.setAttribute("width", "10%");
                    newCell.setAttribute("class", "forborder");
                    newCell.setAttribute("align", "center");
                    newCell.innerHTML = "<td><INPUT    TYPE=\"text\" SIZE=\"10\" name=\"P_remark\" ID=\"P_remark_" + intLine + "\" VALUE=\"\" ></td>"
                    //newCell = newRow.insertCell(12)
                    //newCell.setAttribute("width", "10%");
                    //newCell.setAttribute("class", "forborder");
                    //newCell.setAttribute("align", "center");
                    //newCell.innerHTML = "<td><INPUT    TYPE=\"text\" SIZE=\"7\" ID=\"P_total_weight_" + intLine + "\" VALUE=\"\" onblur=\"IsNuber(this.value, this)\"></td>"
                }

                getId("maxline").value = intLine;

            }
            function RemoveRow()
            {
                var intLine = parseInt(getId("maxline").value);
                if (parseInt(intLine) > 0)
                {
                    var theTable = (document.all) ? document.all.tbExp : document.getElementById("tbExp");
                    var theTableBody = theTable.tBodies[0];
                    //theTableBody.deleteRow(intLine - 1);
                    theTableBody.deleteRow((intLine + 1) - 1);
                    intLine--;
                    getId("maxline").value = intLine;
                    //alert("maxline = " + getId("maxline").value);
                }
            }
            function check_detail_null() {
                var status = true; //ไม่มีคำว่าง false = มีคำว่าง
                for (var i = 1; i <= parseInt(getId("maxline").value, 10); i++) {
                    if (getId("P_part_id_" + i).value == "" || getId("P_qty_" + i).value == "" || getId("P_remark_" + i).value == "") {
                        status = false;
                        alert("กรุณาตรวจสอบข้อมูลส่วนของ รายการ จำนวน ใช้งาน เนื่องจากมี่ช่องว่าง")
                        break;
                    }
                }
                return status;
            }
            /*            
             function getShowDetailstore()
             {
             showTableNonPopup("show1", "A_doc_id", "../SHOWDETAILSCREEN/MA_CS_Show028_Stroe.jsp?doc_id=");
             }
             */
            function Check_Confirm(This, Id_texbox) {
                var old_check = getId(This.id).checked;
                var old_value = getId(This.id).value;
                //alert(getId(This.id).checked);
                if (getId("emp_id").value == getId(Id_texbox).value) {
                    if (getId(This.id).checked) {
                        alert("ทำการยืนยันเรียบร้อยแล้ว");
                        getId(This.id).value = "Y";
                        //alert(getId(This.id).value);
                    } else {
                        getId(This.id).value = "N";
                    }
                } else {
                    alert("กรุณายืนยันช่องหน้าที่ของตัวเอง");
                    getId(This.id).checked = old_value == "Y" ? true : false;
                    getId(This.id).value = old_value;
                }
            }

            /*
             function OpenConfirm(table, URL, dept_id) {
             table += "&stadment=and+emp_id+=+\'" + getId("emp_id").value + "\'+and+dept_id+=+\'" + dept_id + "\'"
             openBrWindow(table, 314, URL);
             }*/

            function OpenConfirm(table, URL, dept_id) {
                table += "&stadment=and+dept_id+=+\'" + dept_id + "\'"
                openBrWindow(table, 314, URL);
            }

            function OpenConfirm2(table, URL, dept_id) {
                var dept_id1, dept_id2, status;
                dept_id1 = '06';
                status = 'Y';
                //table += "&stadment=and+(dept_id+=+\'" + dept_id1 + "\'+or+dept_id+=+\'" + dept_id2 + ")\'+and+status+=+\'" + status + "\'"            
                table += "&stadment=and+dept_id+=+\'" + dept_id1 + "\'+and+status+=+\'" + status + "\'"
                openBrWindow(table, 315, URL);
            }
            function OpenBrownNoConfirm(table, URL, dept_id) {
                table += "&stadment=and+" + (dept_id == '05' ?
                        "wh_emp_confirm" :
                        dept_id == '003' ?
                        "quality_confirm" :
                        dept_id == '002' ?
                        "product_confirm" :
                        dept_id == '006' ?
                        "wh_leader_confirm" :
                        ""
                        ) + "+=+'N'+and+complete_flag=+'N'";
                openBrWindow(table, 322, URL);

            }

            function OpenBrownConfirm(table, URL, dept_id) {
                table += "&stadment=and+" + (dept_id == '05' ?
                        "wh_emp_confirm" :
                        dept_id == '003' ?
                        "quality_confirm" :
                        dept_id == '002' ?
                        "product_confirm" :
                        dept_id == '006' ?
                        "wh_leader_confirm" :
                        ""
                        ) + "+=+'Y'+and+complete_flag=+'N'";
                openBrWindow(table, 322, URL);
            }

            function Display_Table()
            {
                showTableNonPopup("show", "A_doc_id", "../JSP/CS_ShowD_carbon_analysis_detail.jsp?doc_id=");
                setTimeout('showTableNonPopup("show", "A_doc_id", "../JSP/CS_ShowD_carbon_analysis_detail.jsp?doc_id=")', 100);
            }


            $(function() {
                $('#tabs').tabs();
            });

        </script>
        <title>Carbon Send Product</title>
    </head>
    <body >
        <style type="text/css">
            <!--
            bt {
                width: 1000px;
            }
            .block100{
                width:1500px;
                background-color: #CC0000  ;
            }
            .block50{

                width:50px;
            }

            -->
        </style>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_D_carbon_analysis_header2");
                UtiDatabase objuti = new UtiDatabase();
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S358");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
%>
            <input type="hidden" name="A_username" id="A_username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <!--input type="hidden" name="A_dept_doc_id" id="A_dept_doc_id" value="<%=userbean.getDept_doc_id()%>"-->
            <input type="hidden" name="A_dept_doc_id" id="A_dept_doc_id" value="PM">
            <input type="hidden" name="A_doc_type" id="A_doc_type" value="PM">
            <input type="hidden" name="complete_flag" id="complete_flag" value="N">
            <input type="hidden" name="A_deptID" id="A_deptID" value="<%=userbean.getDept_id()%>">
            <input type="hidden" name="emp_id" id="emp_id" value="<%=userbean.getEmp_id()%>">
            <input type="hidden" name="emp_fullname" id="emp_fullname" value="<%=userbean.getFullname()%>">    
            <input type="hidden" name="dept_id" id="dept_id" value="<%=userbean.getDept_id()%>">         
            <input type="hidden" id="A_screen_id" name="A_screen_id" value="CS_D_carbon_analysis_header2">
            <input type="hidden" name="chkNull" id="chkNull" value="A_doc_date">
            <input type="hidden" name="I_status" id="I_status" value="1"><!-- เป็นการเพิ่มข้อมูลเข้าไป-->
            <input type="hidden" name="D_status" id="D_status" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" name="status_cancle" id="status_cancle" value=""><!-- status_cancle = 1 คือค่าที่นำมา Edit แต่ถ้า ="" จะเป็นการ Insert -->
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">
            <input type="hidden" name="dept_id" value="<%=userbean.getDept_id()%>" id="dept_id" >
            <input type="hidden" id="maxline" name="maxline" value="0">

            <div align="left">
                <div class="container">
                    <div class="panel panel-primary">
                        <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                            <b>บันทึกรายการวิเคราะห์คุณภาพถ่าน(CS_D_carbon_analysis_header2)</b>
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


                                    <tr>
                                        <td width="150" class="columnlabel1">วันที่เอกสาร *&nbsp;</td>
                                        <td width="607" class="columnobject">
                                            <input name='A_doc_date' type='text' class="inputs" id="A_doc_date" value='' size='10' readonly="readonly"/>
                                            &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'A_doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="150" class="columnlabel1">ประเภทงาน&nbsp;</td>
                                        <td width="607" class="columnobject">                                    
                                            <input name='A_job_type' type='text' class="inputs" id="A_job_type" value='บด-ร่อน' size='10' maxlength="10" readonly/>                                                                                 
                                            &nbsp;&nbsp;กะ - เวลา&nbsp;
                                            <input name='A_send_doc_time' type='text' class="inputs" id="A_send_doc_time" value='' size='20' maxlength="20" />                                                                                
                                        </td>
                                    </tr>                                
                                    <tr>
                                        <td width="150" class="columnlabel1">เลขที่เอกสาร&nbsp;</td>
                                        <td width="607" class="columnobject">
                                            <input name='A_doc_id' type='text' class="inputs" id="A_doc_id" value='' size='20' readonly/>
                                            &nbsp;<a href='#' onClick="OpenDoc_id(0)"  ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='25' height='25' border='0' align='middle' ></a>                                       
                                            Approve ผลวิเคราะห์แล้ว&nbsp;<a href='#' onClick="OpenDoc_id(1)"  ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='25' height='25' border='0' align='middle' ></a>                                                                               
                                            <!--&nbsp;เอกสาร คลังยืนยันการรับแล้ว&nbsp;<a href='#' onClick="OpenDoc_id(2)"  ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='25' height='25' border='0' align='middle' ></a-->
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td height="200" colspan="2" align="center">
                                            <!--div id="tabs-1"-->
                                            <table width="200%" align="left" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                <tr>
                                                    <td colspan="3" class="h_multi"></td>
                                                    <td colspan="4" class="btn_multi">
                                                        <input type='button' align="left" class="cgcButton_4" name='bt_insert' id="bt_insert" value='  เพิ่ม  ' onClick="getId('status_cancle').value == '1' ? goAddChild(URLsend('A_doc_id,A_doc_date,dept_id,I_status,A_username,A_doc_type,A_job_type', 'CS_Detail_D_carbon_analysis_detail.jsp')) : CreateNewRow();"/>
                                                        <input type='button' align="left" class="cgcButton_3" name='bt_delete' id="bt_delete" value='  ลบ  ' onClick="getId('status_cancle').value == '1' ? goDelChild() : RemoveRow();"/>                                                
                                                        <input type="button" align="left" class="cgcButton_8" id="bt" value=" ผลวิเคราะห์ " onclick="Chknull()">
                                                        <input type="button" align="left" class="cgcButton_9" id="bt" value=" แสดงข้อมูล " onclick="Display_Table()">
                                                    </td>

                                                </tr>
                                            </table>

                                            <div style="width:100%; height: 450px; overflow: auto;" id="show">
                                                <table style="width:100%;"  align="left" border="0" cellpadding="0" cellspacing="1" class="inner"  name = "tbExp" id = "tbExp">
                                                    <tr align='center'>
                                                        <td  class="row3" width="10"><input type="checkbox" name="chk_all" id="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                        <!--td  class="row3" width="10"><input type="checkbox" name="chk_all" id="chk_all" value="chk_all"/></td-->
                                                        <td class="row3" >ลำดับ</td>
                                                        <td class="row3">จำนวน (ถุง)</td>
                                                        <td class="row3">แหล่งผลิต</td>
                                                        <td class="row3" >ใบแจ้งผลิต</td>
                                                        <td class="row3" >ชนิดถ่าน</td>
                                                        <td class="row3" >ขนาด</td>                                                                                                        
                                                        <td class="row3">รหัสผลิต</td>
                                                        <td class="row3" >H2O</td>                                                    
                                                        <td class="row3">Butane</td>
                                                        <td class="row3">ไอโอดีน</td>
                                                        <td class="row3"">หมายเหตุ</td>
                                                    </tr>
                                                </table> 
                                            </div>
                                        </td>
                                    </tr> 

                                    <tr>
                                        <td class="columnlabel1">ผู้บันทึกผลวิเคราะห์&nbsp;</td>            
                                        <td class="columnobject"><input name="lab_emp_id" type='text' class="inputs" id="lab_emp_id" value ="" size="15" readonly="true">
                                            <a href='javascript:;'onclick="OpenConfirm2('Vemployee', 'Search_Config2.jsp', '06')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE6' width='20' height='20' border='0' align='middle' ></a>                                        
                                            <input name="lab_emp_name" type='text' class="inputs" id="lab_emp_name" value="" size="30" readonly="true">
                                        </td>
                                    </tr>                                              


                                    <tr>
                                        <td class="columnlabel1">ผู้ตรวจสอบ&nbsp;</td>
                                        <td class="columnobject"><input name="A_lab_leader_id" type='text' class="inputs" id="A_lab_leader_id" value ="-" size="15" readonly="true">
                                            <!--a href='#' onClick="openBrWindow('Vemployee1', 314, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a-->
                                            <a href='javascript:;'onclick="OpenConfirm('Vemployee1', 'Search_Config2.jsp', '003')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE6' width='20' height='20' border='0' align='middle' ></a>                                                                                
                                            <input name="A_lab_leader_name" type='text' class="inputs" id="A_lab_leader_name" size="30" readonly="true">
                                            &nbsp;ยืนยันผลการวิเคราะห์ฯ&nbsp;
                                            <input type="checkbox" name="quality_confirm" id="quality_confirm" value="N" onclick="Check_Confirm(this, 'A_lab_leader_id')">
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan='2' class='blankspace'>
                                            <br>
                                            <div align="center">
                                                <a href="javascript:;" onClick="cancle()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;" onClick="AddHeader()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;" onClick="Delete()"><img alt="" class="imgtransparent" src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" class="imgtransparent" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a></div>
                                            <!--a href="javascript:;"  onclick="UpdateHeader()"><img alt="พิมพ์เอกสาร" class="imgtransparent" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a></div-->
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