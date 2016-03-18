<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
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
        <script type="text/javascript">
            function Chknull(){
                if(document.getElementById('doc_id').value == ''){
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                }else document.report.submit();
            }
            function goAddChild()
            {
                var strId = "";
                var arryChk = new Array;
                var URL = new Array;
                arryChk[0] = "chkNull";
                if(ChkParameter(arryChk))
                {
                    strId = strId+"doc_id,status_a,username";
                    URL = URLsend(strId, "../SCREEN/CS_033.jsp")
                    window.open(URL[0]);
                }

            }
            function cancle()
            {

                var SURL;
                var r = confirm("คุณต้องการยกเลิกข้อมูลทั้งหมดหรือไม่")
                if(r)
                {
                    if(getId("status_cancle").value == "1")
                    {
                        cancelAction();
                        setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show032.jsp?doc_id=")',1000);
                        getId("show2").innerHTML = "";
                        getId("doc_id").disabled = false;
                        getId("base_plate_desc").disabled = true;
                        getId("status_cancle").value = "";
                        setTimeout('getId("chkbox_mark_sign").checked = false;getId("chkbox_base_plate").checked = false;getId("mark_sign").value = "N";getId("base_plate").value = "N";',1000);
                    }
                    else{
                        SURL = "../JSP/CS_033.jsp?status_d=3&chk_all=1&username="+getId("username").value;
                        SURL = SURL+"&doc_id="+getId("doc_id").value;
                        Delete_Line_no(SURL)
                        cancelAction();
                        setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show032.jsp?doc_id=")',1500);
                        getId("show2").innerHTML = "";
                        getId("doc_id").disabled = false;
                        getId("base_plate_desc").disabled = true;
                        setTimeout('getId("chkbox_mark_sign").checked = false;getId("chkbox_base_plate").checked = false;getId("mark_sign").value = "N";getId("base_plate").value = "N";',1000);
                        getId("status_cancle").value = "";
                    }
                }

            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }
            function goDelChild()
            {
                var Deleteflag ="";
                var SURL;
                if(getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_033.jsp?status_d=3&chk_all=1&username="+getId("username").value;
                    SURL = SURL+"&doc_id="+getId("doc_id").value;
                    Delete_Line_no(SURL);
                    getId("show2").innerHTML = "";
                    getId("chk_all").checked =false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_033.jsp?status_d=3&ckbox=";

                    for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                    {
                        if(document.getElementsByName("ckbox")[i].checked ==true)
                            Deleteflag += (document.getElementsByName("ckbox")[i].checked)?(14+i+1).toString()+",":"";
                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length -1);
                    SURL = SURL+Deleteflag+"&doc_id="+getId("doc_id").value+"&username="+getId("username").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show2", "doc_id", "../JSP/CS_Show033.jsp?doc_id=");
                    if(getId("status_cancle").value == "1"){
                        showTableNonPopup("show", "doc_id", "../JSP/CS_Show032.jsp?doc_id=");
                    }
                   
                }
            }
            function OpenEdit(URLSend)
            {
                window.open(URLSend[0]);
            }
            function AddHeader()
            {
                var strId ="";
                var r = confirm("คุณต้องการบันทึกหรือไม่")
                if(r)
                {
                    var formInputs = document.getElementsByTagName('input');
                    for (var i = 0; i < formInputs.length; i++) {

                        var theInput = formInputs[i];
                        if(theInput.type == 'text' && theInput.id.toString().indexOf("param") != -1 || theInput.id.toString().indexOf("method") != -1 || theInput.id.toString().indexOf("spec") != -1 || theInput.id.toString().indexOf("add_desc") != -1 ){
                            strId += theInput.id.toString()+",";
                        }
                        
                    }
                    strId = strId.substr(0, strId.length -1);
                    //alert(strId);
                    strId = "chkNull,complete_flag,doc_id,doc_date,cust_id,cust_id_desc,po_no,contain_date,iso_no,country_id,country_id_desc,lot_no,mark_sign,base_plate,base_plate_desc,base_plate_qty,remark,approve,mark_sign_desc,username,quality_dep,prod_dep,wh_dep,sale_confirm,quality_confirm,prod_confirm,wh_confirm,po_no_befor,iod2,screen_id,cust_id_desc,deadline,stock_prod,maxline,"+strId;
                    getSave(URLsend(strId,'../JSP/CS_032.jsp'));
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show032.jsp?doc_id=")',1500);
                    getId("sale_confirm").value = "N";getId("sale_confirm").checked = false;
                    getId("quality_confirm").value = "N";getId("quality_confirm").checked = false;
                    getId("prod_confirm").value = "N";getId("prod_confirm").checked = false;
                    getId("wh_confirm").value = "N";getId("wh_confirm").checked = false;
                    getId("show2").innerHTML = "<table width=\"100%\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\" class=\"inner\"  name = \"tbdetail\" id = \"tbdetail\"></table>";
                    getId("doc_id").disabled = false;
                    getId("base_plate_desc").disabled = true;
                    getId("status_cancle").value = "";
                    getId("wh_confirm").disabled = true;
                    getId("quality_confirm").disabled = true;
                    getId("sale_confirm").disabled = true;
                    getId("prod_confirm").disabled = true;
                    getId("maxline").value = "0";
                    setTimeout('getId("chkbox_mark_sign").checked = false;getId("chkbox_base_plate").checked = false;getId("mark_sign").value = "N";getId("base_plate").value = "N";',1000);
                }
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if(r)
                {
                    getSave(URLsend('doc_id,doc_date,cust_id,cust_id_desc,po_no,contain_date,iso_no,country_id,country_id_desc,lot_no,mark_sign,base_plate,base_plate_desc,base_plate_qty,remark,approve,wh_dep,sale_confirm,quality_confirm,prod_confirm,wh_confirm,po_no_befor,iod2,screen_id,cust_id_desc,deadline,stock_prod,status_d,username','../JSP/CS_032.jsp'))
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show032.jsp?doc_id=")',1500);
                    getId("sale_confirm").value = "N";getId("sale_confirm").checked = false;
                    getId("quality_confirm").value = "N";getId("quality_confirm").checked = false;
                    getId("prod_confirm").value = "N";getId("prod_confirm").checked = false;
                    getId("wh_confirm").value = "N";getId("wh_confirm").checked = false;
                    getId("show2").innerHTML = "";
                    getId("doc_id").disabled = false;
                    getId("base_plate_desc").disabled = true;
                    getId("status_cancle").value = "";
                    setTimeout('getId("chkbox_mark_sign").checked = false;getId("chkbox_base_plate").checked = false;getId("mark_sign").value = "N";getId("base_plate").value = "N";',1000);
                }
            }
            function Unload()
            {

                if(getId("doc_id").disabled == true && getId("status_cancle").value != "1" && getId("total_weight_chk").value == "" ){
                    var r = confirm("คุณได้ทำการเปลี่ยนหน้าคุณต้องการบันทึกข้อมูลทั้งหมดใช่หรือไม่");
                    if(r == true){
                        getSave(URLsend('chkNull,doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,burn_no,wh_in,wh_out,total_weight','../JSP/CS_029.jsp'));
                    }

                    else{
                        var SURL = "../JSP/CS_030.jsp?status_d=3&chk_all=1";
                        SURL = SURL+"&doc_id="+getId("doc_id").value;
                        Delete_Line_no(SURL);
                    }
                }
                else if(getId("doc_id").disabled == true && getId("status_cancle").value == "1" && getId("total_weight_chk").value != getId("total_weight").value ){
                    getSave(URLsend('chkNull,doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,burn_no,wh_in,wh_out,total_weight','../JSP/CS_029.jsp'));
                }
            }
            function chkValue(input,thisChk)
            {
                if(thisChk){
                    getId(input).value = "Y";
                    if(input == "base_plate"){
                        getId("base_plate_desc").disabled = false;
                        getId("base_plate_desc").value = "จำนวน";
                    }
                    else if(input == "mark_sign"){
                        getId("mark_sign_desc").disabled = false;
                    }
                }else{
                    getId(input).value = "N";
                    if(input == "base_plate"){
                        getId("base_plate_desc").value = "";
                        getId("base_plate_desc").disabled = true;
                    }
                    else if(input == "mark_sign"){
                        getId("mark_sign_desc").value = "";
                        getId("mark_sign_desc").disabled = true;
                    }
                }
            }
            //document.onkeydown = chkEvent
            function chkEvent(This) {
               
                //alert(window.event.keyCode);
            }
            function Check_Confirm(This){
                //alert(getId(This.id).checked);
                if(getId(This.id).checked){
                    if(confirm("คุณต้องการปิดใบแจ้งการผลิตหรือไม่(ถ้าปิดใบแจ้งการผลิตจะไม่สามารถนำใบแจ้งไปใช้ได้อีก)")){
                        getId(This.id).value = "Y"
                    }else{
                        getId(This.id).value = "N";
                    }
                    alert(getId(This.id).value);
                }else{
                    getId(This.id).value = "N"
                }
            }
            function CreateNewRow()
            {
                var intLine = parseInt(getId("maxline").value);
                intLine++;
                
                var theTable = document.getElementById("tbdetail");
                var newRow = theTable.insertRow(theTable.rows.length);
                newRow.id = newRow.uniqueID;

                var item1 = 1;
                var newCell;
                //*** Column 1 ***//
                newCell = newRow.insertCell(0)
                newCell.id = newCell.uniqueID
                newCell.setAttribute("width", "3px");
                newCell.setAttribute("class", "forborder");
                newCell.innerHTML = "<td ><input type = 'checkbox' id = 'ckbox_"+(intLine+14)+"' name = 'ckbox'></td>"
                newCell = newRow.insertCell(1)
                newCell.setAttribute("width", "7%");
                newCell.setAttribute("class", "forborder");
                newCell.innerHTML = "<td>"+(intLine+14)+"&nbsp;</td>"
                newCell = newRow.insertCell(2)
                newCell.setAttribute("width", "25%");
                newCell.setAttribute("class", "forborder");
                newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"20\" NAME=\"param"+(intLine+14)+"\" ID=\"param"+(intLine+14)+"\" VALUE=\"PSD\" ></td>"
                newCell = newRow.insertCell(3)
                newCell.setAttribute("width", "25%");
                newCell.setAttribute("class", "forborder");
                newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"20\" NAME=\"method"+(intLine+14)+"\" ID=\"method"+(intLine+14)+"\" VALUE=\"\" ></td>"
                newCell = newRow.insertCell(4)
                newCell.setAttribute("width", "20%");
                newCell.setAttribute("class", "forborder");
                newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"20\" NAME=\"spec"+(intLine+14)+"\" ID=\"spec"+(intLine+14)+"\" VALUE=\"\" ></td>"
                newCell = newRow.insertCell(5)
                newCell.setAttribute("width", "20%");
                newCell.setAttribute("class", "forborder");
                newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"20\" NAME=\"add_desc"+(intLine+14)+"\" ID=\"add_desc"+(intLine+14)+"\" VALUE=\"\" ></td>"
                getId("maxline").value = intLine;
            }
            function RemoveRow()
            {
                var intLine = parseInt(getId("maxline").value);
                if(parseInt(intLine) > 0)
                {
                    var theTable = (document.all) ? document.all.tbExp : document.getElementById("tbdetail");
                    var theTableBody = theTable.tBodies[0];
                    theTableBody.deleteRow(intLine-1);
                    intLine--;
                    getId("maxline").value = intLine;
                }
            }
            
            function Check_Confirm(This){
                if(getId(This.id).checked){
                    if(confirm("คุณต้องการปิดใบแจ้งการผลิตหรือไม่(ถ้าปิดใบแจ้งการผลิตจะไม่สามารถนำใบแจ้งไปใช้ได้อีก)")){
                        getId(This.id).value = "Y"
                    }else{
                        getId(This.id).value = "N";
                        getId(This.id).checked = false;
                    }
                    //alert(getId(This.id).value);
                }else{
                    getId(This.id).value = "N"
                }
            }            
            
            
        </script>
  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <title>CGC ERP</title>
    </head>
    <body onkeyup="chkEvent()">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%

                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_032");
                //System.out.println("--------------");
                //System.out.println(objs_p);
                //System.out.println("--------------");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S507");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
            %>
            <div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_id,doc_date,cust_id,cust_id_desc,po_no,contain_date,iso_no,country_id,country_id_desc,lot_no,iod2">
            <input type="hidden" id="status_a" value="1"><!-- เป็นการเพิ่มข้อมูลเข้าไป-->
            <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" id="status_cancle" value=""><!-- status_cancle = 1 คือค่าที่นำมา Edit แต่ถ้า ="" จะเป็นการ Insert -->
            <input type="hidden" id="child_ck" name="child_ck" value="">
            <input type="hidden" id="screen_id" name="screen_id" value="CS_032">
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">
            <input type="hidden" name="maxline" value="0" id="maxline">
            <div align="center">

                <table  cellpadding="0"  cellspacing="0">

                    <tr>
                        <td class="ftopleft"></td>
                        <td  class="ftopcenter" colspan="2">ใบแจ้งการผลิต(CS_032)&nbsp;</td>
                        <td class="ftopright"></td>
                    </tr>

                    <tr >
                        <td class="fcenterleft"></td>
                        <td  colspan="2" class="fcentercenter">
                            <div align="center">
                                <table  cellpadding="0" cellspacing="0" >
                                    <tr>
                                        <td colspan="2" align="right"><b>หมายเลขเอกสาร : <%=objs_p.getIso_no()%> </b></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%> </b></td>
                                    </tr>
                                    <!--<tr>
                                        <td class="columnlabel">ปิดใบแจ้งการผลิต*&nbsp;</td>
                                        <td class="columnobject">
                                            <input type="checkbox" value="N" id="complete_flag" name="complete_flag" onclick="Check_Confirm(this)">
                                        </td>
                                    </tr>-->

                                    <tr>
                                        <td class="columnlabel">ปิดใบแจ้งการผลิต*&nbsp;</td>
                                        <td class="columnobject">
                                            <input type="checkbox" value="N" id="complete_flag" name="complete_flag" onclick="Check_Confirm(this)"><!--&nbsp;สาเหตุการปิดใบแจ้ง&nbsp;<select id="close_job_type" name="close_job_type">
                                                <option value="1">ปิดใบแจ้งเนื้องจากทำการส่งออกสำเร็จ</option>
                                                <option value="2">อื่นๆ</option>
                                            </select><br>
                                            <input type='text' class="inputs" id="remark_close_job_order" name ="remark_close_job_order" value="" size="50">-->
                                        </td>
                                    </tr>                                    
                                    
                                    <tr>
                                        <td width="150" class="columnlabel"><b>เลขที่เอกสาร*</b>&nbsp;</td>
                                        <td width="607" class="columnobject">
                                            <input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='20' />
                                            &nbsp;<a href='javascript:;' onClick="openBrWindow('vd_job_order_header&stadment=and+complete_flag+<>+\'Y\'', 32, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                            วันที่เอกสาร*&nbsp;
                                            <input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' readonly />
                                            &nbsp;<a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>&nbsp;&nbsp;	          	</td>
                                    </tr>
                                    
                                    <tr>
                                        <td width="150" class="columnlabel"><b>เอกสารที่ปิดใบแจ้งฯแล้ว</b>&nbsp;</td>
                                        <td width="607" class="columnobject">
                                            <!--input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='20' /-->
                                            &nbsp;<a href='javascript:;' onClick="openBrWindow('vd_job_order_header&stadment=and+complete_flag+=+\'Y\'', 32, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                        </td>    
                                    </tr>                                    
                                    
                                    <tr>
                                        <td class="columnlabel">เลขที่ใบสั่งซื้อ*&nbsp;</td>
                                        <td class="columnobject">
                                            <input name='po_no' type='text' class="inputs" id="po_no" value='' size='20' />&nbsp;<a href='javascript:;' onClick="openBrWindow('vd_saleorderproduct_detail&stadment=and+(doc_type+<>+\'Y\'+or+doc_type+is+null)',32, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' >
                                            </a>&nbsp;&nbsp;
                                            <input name='po_no_befor' type='text' class="inputs" id="po_no_befor" value='' size='20' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">ผู้ซื้อ*&nbsp;</td>
                                        <td class="columnobject">
                                            <input name='cust_id' type='text' class="inputs" id="cust_id" value='' size='20' readonly />
                                            &nbsp;<a href='javascript:;' onClick="openBrWindow('Vcustomer',32, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='cust_id_desc' type='text' class="inputs" id="cust_id_desc" value='' size='30' readonly/>	          	</td>
                                    </tr>

                                    <tr>
                                        <td class="columnlabel">กำหนดเข้าตู้ / ขึ้นรถบรรทุก*&nbsp;</td>
                                        <td class="columnobject">
                                            <input name='contain_date' type='text' class="inputs" id="contain_date" value='' size='10' readonly/>
                                            &nbsp;<a id='date_2' ><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'contain_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_2',singleClick:true,step:1});</script>
                                            กำหนดส่งสินค้า<input name='deadline' type='text' class="inputs" id="deadline" value='' size='10' readonly/>&nbsp;<a id='date_3' ><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'deadline',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_3',singleClick:true,step:1});</script>	          	</td>
                                    </tr>
                                    <tr>
                                        <!--td class="columnlabel">F-A-019 เลขที่*&nbsp;</td-->
                                        <td class="columnlabel">ประเทศ*&nbsp;</td>
                                        <td class="columnobject">                                            
                                            <input name='country_id' type='text' class="inputs" id="country_id" value='' size='10' readonly/><!--
                                            &nbsp;<a href='javascript:;' onClick="openBrWindow('mcountry',32, 'Search_Config2.jsp')" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE5' width='20' height='20' border='0' align='middle' ></a>-->&nbsp;&nbsp;&nbsp;<input name='country_id_desc' type='text' class="inputs" id="country_id_desc" value='' size='30' readonly/>	          	</td>
                                            <input name='iso_no' type='hidden' id="iso_no" value='-' size='20' />                                        
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">กำหนดเป็น LOT NO*&nbsp;</td>
                                        <td class="columnobject">
                                            <input name='lot_no' type='text' class="inputs" id="lot_no" value='' size='20' />	          	</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">ค่า Iodine*&nbsp;</td>
                                        <td class="columnobject">
                                            <input name='iod2' type='text' class="inputs" id="iod2" value='' size='20' onclick="openBrWindow('m_iodine&textinput=iod2', 0, 'Search_Detail.jsp');"/>	          	</td>
                                    </tr>     
                                    <tr>
                                        <td class="columnlabel">มีสินค้าใน Stock จำนวน&nbsp;</td>
                                        <td class="columnobject">
                                            <input name='stock_prod' type='text' class="inputs" id="stock_prod" value='' size='20' />&nbsp;&nbsp;
                                            ตัน&nbsp;	          	
                                        </td>
                                    </tr>                                      
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <div style="width:100%;">
                                                <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                    <tr>
                                                        <td colspan="6" class="h_multi">ข้อมูลการผลิต</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="row3" width="3px"></td>
                                                        <td class="row3" width="7%">ลำดับที่&nbsp;</td>
                                                        <td class="row3" width="25%">Parameter&nbsp;</td>
                                                        <td class="row3" width="25%">Test Method&nbsp;</td>
                                                        <td class="row3" width="20%">Specification&nbsp;</td>
                                                        <td class="row3" width="20%">เพิ่มเติม&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div  id="show" style="width:100%;">
                                                <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">1</td>
                                                        <td class="forborder" width="25%"><input name='param1' type='text' class="inputs" id="param1" value='ชนิด/ขนาด' size=20 readonly='readonly' /></td>
                                                        <td class="forborder" width="25%"><input name='method1' type='text' class="inputs" id="method1" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec1' type='text' class="inputs" id="spec1" value='' size=20 onclick="openBrWindow('m_carbon_size&textinput=spec1', 32, 'Search_Detail.jsp');" readonly/></td>
                                                        <td class="forborder" width="20%"><input name='add_desc1' type='text' class="inputs" id="add_desc1" value='' size=20 /></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">2</td>
                                                        <td class="forborder" width="25%"><input name='param2' type='text' class="inputs" id="param2" value='จำนวน(ตัน)' size=20 readonly='readonly' /></td>
                                                        <td class="forborder" width="25%"><input name='method2' type='text' class="inputs" id="method2" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec2' type='text' class="inputs" id="spec2" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='add_desc2' type='text' class="inputs" id="add_desc2" value='' size=20 /></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">3</td>
                                                        <td class="forborder" width="25%"><input name='param3' type='text' class="inputs" id="param3" value='รหัสสินค้า(CGC)' size=20 readonly='readonly' /><!--&nbsp;<a href='javascript:;' onClick="openBrWindow('d_saleorderproduct_detail&stadment=and+doc_id+=+\''+getId('po_no').value+'\'',32, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>--></td>
                                                        <td class="forborder" width="25%"><input name='method3' type='text' class="inputs" id="method3" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec3' type='text' class="inputs" id="spec3" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='add_desc3' type='text' class="inputs" id="add_desc3" value='' size=20 /></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">4</td>
                                                        <td class="forborder" width="25%"><input name='param4' type='text' class="inputs" id="param4" value='การบรรจุ(กระสอบ)' size=20 readonly='readonly' /></td>
                                                        <td class="forborder" width="25%"><input name='method4' type='text' class="inputs" id="method4" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec4' type='text' class="inputs" id="spec4" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='add_desc4' type='text' class="inputs" id="add_desc4" value='' size=20 /></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">5</td>
                                                        <td class="forborder" width="25%"><input name='param5' type='text' class="inputs" id="param5" value='น้ำหนักบรรจุ' size=20 readonly='readonly' /></td>
                                                        <td class="forborder" width="25%"><input name='method5' type='text' class="inputs" id="method5" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec5' type='text' class="inputs" id="spec5" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='add_desc5' type='text' class="inputs" id="add_desc5" value='' size=20 /></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">6</td>
                                                        <td class="forborder" width="25%"><input name='param6' type='text' class="inputs" id="param6" value='Butane' size=20 readonly='readonly' /></td>
                                                        <td class="forborder" width="25%"><input name='method6' type='text' class="inputs" id="method6" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec6' type='text' class="inputs" id="spec6" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='add_desc6' type='text' class="inputs" id="add_desc6" value='' size=20 /></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">7</td>
                                                        <td class="forborder" width="25%"><input name='param7' type='text' class="inputs" id="param7" value='CTC' size=20 readonly='readonly' /></td>
                                                        <td class="forborder" width="25%"><input name='method7' type='text' class="inputs" id="method7" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec7' type='text' class="inputs" id="spec7" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='add_desc7' type='text' class="inputs" id="add_desc7" value='' size=20 /></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">8</td>
                                                        <td class="forborder" width="25%"><input name='param8' type='text' class="inputs" id="param8" value='I2' size=20 readonly='readonly' /></td>
                                                        <td class="forborder" width="25%"><input name='method8' type='text' class="inputs" id="method8" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec8' type='text' class="inputs" id="spec8" value='' size=20 onclick="openBrWindow('m_iodine&textinput=spec8', 0, 'Search_Detail.jsp');" /></td>
                                                        <td class="forborder" width="20%"><input name='add_desc8' type='text' class="inputs" id="add_desc8" value='' size=20 /></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">9</td>
                                                        <td class="forborder" width="25%"><input name='param9' type='text' class="inputs" id="param9" value='Methylene Blue' size=20 readonly='readonly' /></td>
                                                        <td class="forborder" width="25%"><input name='method9' type='text' class="inputs" id="method9" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec9' type='text' class="inputs" id="spec9" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='add_desc9' type='text' class="inputs" id="add_desc9" value='' size=20 /></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">10</td>
                                                        <td class="forborder" width="25%"><input name='param10' type='text' class="inputs" id="param10" value='Moisture Content' size=20 readonly='readonly' /></td>
                                                        <td class="forborder" width="25%"><input name='method10' type='text' class="inputs" id="method10" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec10' type='text' class="inputs" id="spec10" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='add_desc10' type='text' class="inputs" id="add_desc10" value='' size=20 /></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">11</td>
                                                        <td class="forborder" width="25%"><input name='param11' type='text' class="inputs" id="param11" value='Ash' size=20 readonly='readonly' /></td>
                                                        <td class="forborder" width="25%"><input name='method11' type='text' class="inputs" id="method11" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec11' type='text' class="inputs" id="spec11" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='add_desc11' type='text' class="inputs" id="add_desc11" value='' size=20 /></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">12</td>
                                                        <td class="forborder" width="25%"><input name='param12' type='text' class="inputs" id="param12" value='pH' size=20 readonly='readonly' /></td>
                                                        <td class="forborder" width="25%"><input name='method12' type='text' class="inputs" id="method12" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec12' type='text' class="inputs" id="spec12" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='add_desc12' type='text' class="inputs" id="add_desc12" value='' size=20 /></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">13</td>
                                                        <td class="forborder" width="25%"><input name='param13' type='text' class="inputs" id="param13" value='Bulk Density' size=20 readonly='readonly' /></td>
                                                        <td class="forborder" width="25%"><input name='method13' type='text' class="inputs" id="method13" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec13' type='text' class="inputs" id="spec13" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='add_desc13' type='text' class="inputs" id="add_desc13" value='' size=20 /></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="forborder" width="3px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                        <td class="forborder" width="7%">14</td>
                                                        <td class="forborder" width="25%"><input name='param14' type='text' class="inputs" id="param14" value='Hardness' size=20 readonly='readonly' /></td>
                                                        <td class="forborder" width="25%"><input name='method14' type='text' class="inputs" id="method14" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='spec14' type='text' class="inputs" id="spec14" value='' size=20 /></td>
                                                        <td class="forborder" width="20%"><input name='add_desc14' type='text' class="inputs" id="add_desc14" value='' size=20 /></td>
                                                    </tr>
                                                </table>
                                            </div>                                    </td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <div style="width:100%;">
                                                <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                    <tr>
                                                        <td colspan="3" class="h_multi">P.S.D & Other Detail</td>
                                                        <td colspan="3" class="btn_multi">
                                                            <input type='button' class="cgcButton_4" name='but1' value='  เพิ่ม  ' onclick='getId("status_cancle").value == "1"?goAddChild():CreateNewRow();'/>
                                                            <input type='button' class="cgcButton_3" name='but2' value='  ลบ  ' onclick='getId("status_cancle").value == "1"?goDelChild():RemoveRow();'/>		    			  		</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="row3" width="3px"><input type="checkbox" name="chk_all" id="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                        <td class="row3" width="7%">ลำดับที่&nbsp;</td>
                                                        <td class="row3" width="25%">Parameter&nbsp;</td>
                                                        <td class="row3" width="25%">Test Method&nbsp;</td>
                                                        <td class="row3" width="20%">Specification&nbsp;</td>
                                                        <td class="row3" width="20%">เพิ่มเติม&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div style="width:100%; height: 150px; overflow: auto;" id="show2">
                                                <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner"  name = "tbdetail" id = "tbdetail"></table>
                                            </div>                    </td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">&nbsp;</td>
                                        <td class="columnobject"><input name='mark_sign' type='hidden' id="mark_sign" value='N'/><input name='chkbox_mark_sign' type='checkbox' id="chkbox_mark_sign" value='' onClick="chkValue('mark_sign',this.checked);"/>
                                            ตีตรา<input type='text' class="inputs" id="mark_sign_desc" name="mark_sign_desc" value="" disabled></td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">หมายเหตุ&nbsp;</td>
                                        <td class="columnobject"><textarea class="text_inputs" name='remark' cols='75' rows='5' id="remark"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">&nbsp;</td>
                                        <td class="columnobject">
                                            <b>ไม้รอง</b><br>
                                            <input name='base_plate' type='hidden' id="base_plate" value='N'/><input name='chkbox_base_plate' type='checkbox' id="chkbox_base_plate" value='' onClick="chkValue('base_plate',this.checked);"/>
                                            ต้องการ
                                            <input name='base_plate_desc' type='text' class="inputs" id="base_plate_desc" value='' size='30' disabled />		          </td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">จำนวน&nbsp;</td>
                                        <td class="columnobject">
                                            <input name='base_plate_qty' type='text' class="inputs" id="base_plate_qty" value='' size='10' />
                                            ตัว		          </td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel"></td>
                                        <td class="columnobject"></td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">ฝ่ายขาย</td>
                                        <td class="columnobject"><input name='approve' type='text' class="inputs" id="approve" value='' size='10' readonly/>
                                            <!--<a href='javascript:;'onclick="openBrWindow('Vemployee',32, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE6' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;-->
                                            <input name='approve_desc' type='text' class="inputs" id="approve_desc" value='' size='20' readonly/>
                                            <input type="checkbox" name="sale_confirm" id="sale_confirm" value="N"  disabled>
                                            ยืนยัน</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel"> ฝ่ายวิเคราะห์คุณภาพ</td>
                                        <td class="columnobject"><input name='quality_dep' type='text' class="inputs" id="quality_dep" value='' size='10' readonly/>
                                            <!--&nbsp;<a href='javascript:;'onclick="openBrWindow('Vemployee1',32, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE6' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;-->
                                            <input name='quality_dep_desc' type='text' class="inputs" id="quality_dep_desc" value='' size='20' readonly/>

                                            <input type="checkbox" name="quality_confirm" id="quality_confirm" value="N"  disabled>
                                            ยืนยัน                                            </td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">ฝ่ายผลิต&nbsp;</td>
                                        <td class="columnobject"><input name='prod_dep' type='text' class="inputs" id="prod_dep" value='' size='10' readonly/>
                                            <!--<a href='javascript:;'onclick="openBrWindow('Vemployee2',32, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE6' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;-->
                                            <input name='prod_dep_desc' type='text' class="inputs" id="prod_dep_desc" value='' size='20' readonly/>
                                            <input type="checkbox" name="prod_confirm" id="prod_confirm" value="N"  disabled>
                                            ยืนยัน</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">ฝ่ายคลังสินค้า</td>
                                        <td class="columnobject"><input name='wh_dep' type='text' class="inputs" id="wh_dep" value='' size='10' readonly/>
                                            <!--<a href='javascript:;'onclick="openBrWindow('Vemployee3',32, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE6' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;-->
                                            <input name='wh_dep_desc' type='text' class="inputs" id="wh_dep_desc" value='' size='20' readonly/>
                                            <input type="checkbox" name="wh_confirm" id="wh_confirm" value="N"  disabled>
                                            ยืนยัน</td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'><br>
                                            <div align="center">
                                                <!-- <a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                                 <a href="javascript:;" onClick="AddHeader()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                                 <a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>                <img src="../IMAGES/BTN_PRINT_90.png" width="80" height="30">-->&nbsp;&nbsp;&nbsp;
                                            </div>                           </td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'><br>
                                            <div align="center">
                                                <a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;" onClick="AddHeader()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a>                                        </div>
                                            <br>                                  </td>
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

