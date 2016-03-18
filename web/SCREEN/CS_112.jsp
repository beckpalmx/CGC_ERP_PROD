<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
            function goAddChild(URLSend)
            {
                var arryChk = new Array;
                arryChk[0] = "chkNull";
                if(ChkParameter(arryChk))
                {
                    window.open(URLSend[0]);
                }

            }
            function cancle()
            {

                var SURL;
                var r = confirm("คุณต้องการยกเลิกข้อมูลทั้งหมดหรือไม่")
                if(r)
                {
                    if(getId("status_cancle").value == "1" && getId("child_ck").value == "")
                    {
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                    }
                    else  if(getId("status_cancle").value == "1" && getId("child_ck").value == "1")
                    {
                        alert("มีการเปลี่ยนแปลงข้อมูลกรุณาบันทึกข้อมูล");
                    }
                    else{
                        SURL = "../JSP/CS_113.jsp?status_d=3&chk_all=1";
                        SURL = SURL+"&doc_id="+getId("doc_id").value;
                        Delete_Line_no(SURL)
                        cancelAction();
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("show").innerHTML = "";
                        getId("doc_id").disabled = false;
                    }


                }

            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    document.getElementsByName("ckbox")(i).checked = Value;
                }

            }
            function goDelChild()
            {
                var Deleteflag ="";
                var SURL;
                if(getId("chk_all").checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/CS_113.jsp?status_d=3&chk_all=1&username="+getId("username").value;
                    SURL = SURL+"&doc_id="+getId("doc_id").value;
                    //alert(SURL);
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show113.jsp?doc_id=");
                    getId("chk_all").checked =false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/CS_113.jsp?status_d=3&ckbox=";

                    for(var i=0;i<document.getElementsByName("ckBox").length;i++)
                    {
                        if(document.getElementsByName("ckBox")(i).checked ==true){
                            Deleteflag += (i+1).toString()+",";
                        }

                    }
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length -1);
                    SURL = SURL+Deleteflag+"&doc_id="+getId("doc_id").value+"&username="+getId("username").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_Show113.jsp?doc_id=");
                    for(var i=0;i<=3;i++){
                        setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_Show113.jsp?doc_id=")', 100);
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
                if(r)
                {
                    getSave(URLsend('chkNull,doc_id,job_no,doc_date,cust_id,product_id,weight,hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10,hc11,hc12,hc13,hc14,hc15,username','../JSP/CS_112.jsp'));
                    getId("show").innerHTML = "";
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("doc_id").disabled = false;
                    for(var i = 1 ; i <= 15; i++){
                        getId("hc"+i.toString()).value = "";
                    }
                }
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if(r)
                {
                    getSave(URLsend('doc_id,job_no,doc_date,cust_id,product_id,weight,hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10,hc11,hc12,hc13,hc14,hc15,status_d,username','../JSP/CS_112.jsp'));
                    getId("show").innerHTML = "";
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    for(var i = 1 ; i <= 15; i++){
                        getId("hc"+i.toString()).value = "";
                    }
                    getId("doc_id").disabled = false;

                }
            }
            function Unload()
            {

                if(getId("doc_id").disabled == true && getId("status_cancle").value != "1" ){
                    var r = confirm("คุณได้ทำการเปลี่ยนหน้าคุณต้องการบันทึกข้อมูลทั้งหมดใช่หรือไม่");
                    if(r == true){
                        getSave(URLsend('chkNull,doc_id,doc_date,time_from,time_to,runner_id,runner_id_desc,shift,wh_in,wh_out,loc_total,loc_1,s_bag_loc1,q_bag_loc1,w_bag_loc1,loc_1_desc,loc_2,s_bag_loc2,q_bag_loc2,w_bag_loc2,loc_2_desc,loc_3,s_bag_loc3,q_bag_loc3,w_bag_loc3,loc_3_desc,c_weight1,c_weight2,c_weight3,c_weight4,c_weight5,p_weight1,p_weight2,p_weight3,p_weight4,p_weight5,u_weight1,u_weight2,u_weight3,u_weight4,u_weight5,remark,child_ck,status_cancle','../JSP/CS_025.jsp'));
                    }
                    else{
                        var SURL = "../JSP/CS_024.jsp?status_d=3&chk_all=1";
                        SURL = SURL+"&doc_id="+getId("doc_id").value;
                        Delete_Line_no(SURL);
                    }
                }
                closepopup();
            }
            function OpenDoc_id()
            {

                if(getId("child_ck").value == "1" && getId("doc_id").disabled == true && getId("status_cancle").value == "1"){
                    alert("มีการเปลี่ยนแปลงข้อมูลกรุณาบันทึกข้อมูล");
                }
                else if(getId("child_ck").value == "1" && getId("doc_id").disabled == true && getId("status_cancle").value == ""){
                    alert("ถ้าต้องการเลือกข้อมูลอื่นกรุณาบันทึกข้อมูลหรือยกเลิกข้อมูล");
                }
                else{
                    openBrWindow('vd_carbon_analyze_header&stadment=and+complete_flag+<>+\'Y\'', 105, 'Search_Doc_id.jsp');
                }
            }
        </script>
    </head>
    <body>
        <%
                    UserBean userbean = (UserBean) session.getAttribute("user");
                    DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                    HeaderScreen_Process h_p = new HeaderScreen_Process();
                    objs_p = h_p.selectheaderscreen_process(objs_p, "CS_112");
        %>
        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
        <input type="hidden" id="chkNull" value="doc_id,doc_date,job_no,cust_id,product_id,weight">
        <input type="hidden" id="status_a" value="1"><!-- เป็นการเพิ่มข้อมูลเข้าไป-->
        <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
        <input type="hidden" id="status_cancle" value=""><!-- status_cancle = 1 คือค่าที่นำมา Edit แต่ถ้า ="" จะเป็นการ Insert -->
        <input type="hidden" id="child_ck" name="child_ck" value="">
        <input name="hc7" type="hidden" id="hc7" size="5">
        <input name="hc8" type="hidden" id="hc8" size="5">
        <input name="hc9" type="hidden" id="hc9" size="5">
        <input name="hc10" type="hidden" id="hc10" size="5">
        <input name="hc11" type="hidden" id="hc11" size="5">
        <input name="hc12" type="hidden" id="hc12" size="5">
        <input name="hc13" type="hidden" id="hc13" size="5">
        <input name="hc14" type="hidden" id="hc14" size="5">
        <input name="hc15" type="hidden" id="hc15" size="5">
        <table  cellpadding="0"  cellspacing="0">
            <tr>
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2"><DIV id="u4_rtf4">
                        <DIV id="u4_rtf5">
                            <DIV id="u9_rtf2">
                                <DIV id="u4_rtf">QC Report(CS_112)</DIV>
                            </DIV>
                        </DIV>
                    </DIV></td>
                <td class="ftopright"></td>
            </tr>
            <tr >
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter"><div align="center">
                        <table width="94%"  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2" align="right"><b>หมายเลขเอกสาร :<%=objs_p.getIso_no()%></b></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : <%=objs_p.getEffective_date()%></b></td>
                            </tr>
                            <tr>
                                <td width="156" align="" class="columnlabel"><b>เลขที่เอกสาร*</b>&nbsp;</td>
                                <td width="600" class="columnobject"><input name='doc_id' type='text' class="inputs" id="doc_id" value='' size='10' />
                                    &nbsp;<a href='javascript:;' onClick="openBrWindow('vd_qc_report_header&stadment=and+complete_flag+<>+\'Y\'', 112, 'Search_Doc_id.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    Stuffing Date*&nbsp;
                                    <input name='doc_date' type='text' class="inputs" id="doc_date" value='' size='10' />
                                    &nbsp;<a href="javascript:;" id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.png' border='0' align='absmiddle'></a>
                                    <script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">P/O*&nbsp;</td>
                                <td class="columnobject"><input name='job_no' type='text' class="inputs" id="job_no" value='' size='15' />
                                    <a href='javascript:;' onClick="javascript:openBrWindow('Vd_job_order_header&stadment=and+complete_flag+<>+\'Y\'', 112, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>Customer&nbsp;&nbsp;&nbsp;<input name='cust_id' type='text' class="inputs" id="cust_id" value='' size='15' />
                                    &nbsp;&nbsp;<input type='text' class="inputs" name='cust_id_desc' id="cust_id_desc" value=""></td>
                            </tr>
                            <!--<tr>
                                <td class="columnlabel"></td>
                                <td class="columnobject"><input name='cust_id' type='text' class="inputs" id="cust_id" value='' size='15' />
                                    &nbsp;&nbsp;<input type='text' class="inputs" name='cust_id_desc' id="cust_id_desc" value=""></td>
                            </tr>-->
                            <tr>
                                <td class="columnlabel"><span class="columnobject">Product *&nbsp;</span></td>
                                <td class="columnobject">
                                    <input name='product_id' type='text' class="inputs" id="product_id" value='' size='15' />
                                    <a href='javascript:;' onClick="javascript:openBrWindow('Vproduct', 112, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a><input type='text' class="inputs" name='product_id_desc' id="product_id_desc" value=""></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">Weight*&nbsp;</td>
                                <td class="columnobject"><input name='weight' type='text' class="inputs" id="weight" value='' size='10' />
                                    &nbsp;&nbsp;&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace'></td>
                            </tr>
                            <tr>
                                <td colspan='2' class='btn_multi'>&nbsp;</td>
                            </tr>
                            <tr>
                                <td height="208" colspan="2" align="center"><div style="width:100%;">
                                        <table width="200" border="0" cellpadding="0" cellspacing="1">
                                            <tr>
                                                <td colspan="5" class="h_multi">ข้อมูล QC Report</td>
                                                <td colspan="14" class="btn_multi">
                                                    <input type='button' name='but1' value='  เพิ่ม  ' onClick="javascript:goAddChild(URLsend('doc_id,hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10,hc11,hc12,hc13,hc14,hc15,status_a,username','CS_113.jsp'));"/>
                                                    <input type='button' name='but2' value='   ลบ  ' onclick='javascript:goDelChild();'/>                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="3px" rowspan="2"  class="row3"><label>
                                                        <div align="center">
                                                            <input type="checkbox" name="chk_all" id="chk_all" onClick="ckall(this.checked);">
                                                        </div>
                                                    </label>                        </td>
                                                <td width="5%" rowspan="2"  class="row3"><div align="center">ลำดับ</div></td>
                                                <td width="10%" rowspan="2"  class="row3"><div align="center">Packing Shift</div></td>
                                                <td width="10%" rowspan="2"  class="row3"><div align="center">Packing Code</div></td>
                                                <td width="10%" rowspan="2"  class="row3"><div align="center">Weight</div>
                                                    <div align="center"></div>
                                                    <div align="center"></div>
                                                    <div align="center"></div>
                                                <td  width="70%" colspan="7" class="row3"><div align="center">Parameter</div></div>
                                                    <div align="center"></div>                                                  <div align="center"></div>                                                <div align="center"></div></td>
                                            </tr>
                                            <tr>
                                                <td width="10%" class="row3"><input name="hc1" type='text' class="inputs" id="hc1" size="8" readonly></td>
                                                <td width="10%" class="row3"><input name="hc2" type='text' class="inputs" id="hc2" size="8" readonly></td>
                                                <td width="10%" class="row3"><input name="hc3" type='text' class="inputs" id="hc3" size="8" readonly></td>
                                                <td width="10%" class="row3"><input name="hc4" type='text' class="inputs" id="hc4" size="8" readonly></td>
                                                <td width="10%" class="row3"><input name="hc5" type='text' class="inputs" id="hc5" size="8" readonly></td>
                                                <td width="10%" class="row3"><input name="hc6" type='text' class="inputs" id="hc6" size="8" readonly></td>
                                                <td width="10%" class="row3"><div align="center"><a href="#" onClick="javascript:goAddChild(URLsend('hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10,hc11,hc12,hc13,hc14,hc15','CS_Parameter.jsp'));">More...</a></div></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div style="width:100%; height: 150px; overflow: auto;" id="show"> </div></td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace'>                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center"><div align="right"></div></td>
                            </tr>
                            <tr>
                                <td colspan='2' class='blankspace'>
                                    <br>
                                    <div align="center">
                                        <a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="AddHeader()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>                <img src="../IMAGES/BTN_PRINT_90.png" width="80" height="30"></div>
                                    <br>                                </td>
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

    </body>
</html>
