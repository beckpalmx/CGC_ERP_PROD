<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.bean.DataBeanD_product_receive_detail"%>
<%@page import="com.cgc.DB.D_product_receive_detailDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
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
            function goAdd()
            {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,process_order,wh_in,wh_out,doc_date,c_type,size,job_edit_no,ctc_i2,qty,status_a,username,shift,unit_id,job_type_id,job_type_desc,remark', '../JSP/CS_037.jsp'));
                    //opener.getId("doc_id").disabled = true;
                    showTable("show", "doc_id", "../JSP/CS_Show037.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show037.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 800);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,process_order,wh_in,wh_out,doc_date,line_no,c_type,size,job_edit_no,ctc_i2,qty,status_u,username,shift,unit_id,job_type_id,job_type_desc,remark', '../JSP/CS_037.jsp'));
                    //opener.getId("doc_id").disabled = true;
                    showTable("show", "doc_id", "../JSP/CS_Show037.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show037.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 800);
                }
            }
            function goBack()
            {
                window.close();
            }
            function select() {
                select_value_c();
                if (getId("status_u").value != "") {
                    getId("shift").value = getId("selectshift").value;
                    getId("job_type_id").value = getId("job_type_id_sel").value;
                    getId("process_order").value = getId("process_order_sel").value;
                }

            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
    </head>
    <%!    ThaiUtil en = new ThaiUtil();
        D_product_receive_detailDAO objDAO = new D_product_receive_detailDAO();
        DataBeanD_product_receive_detail objBean = new DataBeanD_product_receive_detail();
        UtiDatabase objuti = new UtiDatabase();
        String doc_id, wh_in, wh_out, doc_date, line_no, status_a, status_u, burn_no, location_id, wh_id, size, job_edit_no, ctc_i2, qty, shift, palate_no, unit_id, c_type, job_type_id, job_type_desc, unit_id_desc, remark, process_order;
    %>
    <%
        doc_id = "";
        wh_in = "";
        wh_out = "";
        doc_date = "";
        line_no = "";
        status_a = "";
        status_u = "";
        burn_no = "";
        location_id = "";
        wh_id = "";
        size = "";
        job_edit_no = "";
        ctc_i2 = "0";
        qty = "";
        shift = "";
        palate_no = "";
        unit_id = "001";
        c_type = "CF";
        job_type_id = "";
        job_type_desc = "";
        unit_id_desc = "กิโลกรัม";
        remark = "";
        process_order = "";
        if (request.getQueryString().indexOf("line_no_") != -1) {
            line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
            doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
            objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
            wh_in = objBean.getWh_in();
            wh_out = objBean.getWh_out();
            doc_date = request.getParameter("doc_date");
            burn_no = objBean.getBurn_no();
            location_id = objBean.getLocation_id();
            wh_id = objBean.getWh_id();
            size = objBean.getSize();
            job_edit_no = objBean.getJob_edit_no();
            ctc_i2 = objBean.getCtc_i2();
            qty = objBean.getQty();
            shift = objBean.getShift();
            palate_no = objBean.getPalate_no();
            unit_id = objBean.getUnit_id();
            c_type = objBean.getC_type();
            job_type_id = objBean.getJob_type_id();
            job_type_desc = objBean.getJob_type_desc();
            unit_id_desc = objBean.getUnit_name();
            remark = objBean.getRemark();
            process_order = objBean.getProcess_order();
            status_u = "2";
        } else {
            doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
            wh_in = request.getParameter("wh_in");
            wh_out = request.getParameter("wh_out");
            doc_date = request.getParameter("doc_date");
            status_a = request.getParameter("status_a");
        }
    %>
    <body onLoad="select()" >
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="wh_in" value="<%=wh_in%>">
        <input type="hidden" id="wh_out" value="<%=wh_out%>">
        <input type="hidden" id="doc_date" value="<%=doc_date%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="job_type_id_sel" value="<%=job_type_id%>">
        <input type="hidden" id="process_order_sel" value="<%=process_order%>">
        <input type="hidden" id="chkNull" value="c_type,size,qty,job_type_id,job_type_desc">        
        <br>
        <div align="left">
            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                        <b>ถ่านเบิก</b>
                    </div>                        
                    <div class="panel-footer">           
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ชนิดถ่าน*&nbsp;:&nbsp;</td>
                                <td class="columnobject"><select class="select_cgc" name="c_type_select" id="c_type_select" onclick="click_value_c()">
                                        <option value="CF" selected>CF ถ่านกะลาที่สีแล้ว</option>
                                        <option value="UF">UF ถ่านยูคาฯที่สีแล้ว</option>
                                        <option value="KF">KF ถ่านไม้โกงกางที่สีแล้ว</option>
                                        <option value="PF">PF ถ่านปาล์มที่สีแล้ว</option>
                                        <option value="BF">BF ถ่านไม้ไผ่ที่สีแล้ว</option>
                                        <option value="C">C ถ่านกะลามะพร้าว</option>
                                        <option value="CB">CB ฝุ่นถ่านดิบ</option>
                                        <option value="CP">CP กะลา+ปาล์ม</option>
                                        <option value="CU">CU กะลา+ยูคา</option>
                                        <option value="K">K ถ่านไม้โกงกาง</option>
                                        <option value="P">P ถ่านกะลาปาล์ม</option>
                                        <option value="U">U ถ่านยูคา</option>
                                        <option value="B">B ถ่านไม้ไผ่</option>
                                    </select>
                                    <input name='c_type' type='hidden' id="c_type" value='<%=c_type%>' size='10' /></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">หน่วยนับ*&nbsp;:&nbsp;</td>
                                <td class="columnobject"><input class='inputs' type='text' class="inputs" name="unit_id" class='inputs' type='text' class="inputs" id="unit_id" size="10" value="<%=unit_id%>" readonly>
                                    <a href='#' onClick="javascript:openBrWindow('munit_code', 37, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                    <input class='inputs' type='text' class="inputs" name="unit_id_desc" id="unit_id_desc" value="<%=unit_id_desc%>" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ขนาด*&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input name='size' class='inputs' type='text' class="inputs" id="size" value='<%=size%>' size='10' readonly/>
                                    <a href='#' onClick="openBrWindow('m_carbon_size&textinput=size', 32, 'Search_Detail.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">รหัสแก้งาน&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input name='job_edit_no' class='inputs' type='text' class="inputs" id="job_edit_no" value='<%=job_edit_no%>' size='30' />                                
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">I2&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input name='ctc_i2' class='inputs' type='text' class="inputs" id="ctc_i2" value='<%=ctc_i2%>' size='10'  readonly/>
                                    <a href='#' onclick="openBrWindow('m_iodine&stadment=and+iod_ctype+=+\'' + getId('c_type_select').value + '\'&textinput=ctc_i2', 0, 'Search_Detail.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">จำนวน*&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <input name='qty' class='inputs' type='text' class="inputs" id="qty" value='<%=qty%>' size='10' onBlur="IsNuber(this.value, this)"/>                                
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ช่วงเวลาทำงาน(กะ)&nbsp;:&nbsp;</td>
                                <td class="columnobject"><%=objuti.ShowSelectBox("select shift_id,name_t from mshift where shift_grp = '2' order by runno", "shift_id", "name_t", "shift")%>
                                    <input type="hidden" id="selectshift" value="<%=shift%>">
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ประเภทงาน*&nbsp;:&nbsp;</td>
                                <td class="columnobject"><%=objuti.ShowSelectBox("select job_type_id,name_t from vmjob_type order by runno", "job_type_id", "name_t", "job_type_id")%>&nbsp;
                                    <input class='inputs' type='text' class="inputs" id="job_type_desc" name="job_type_desc" value="<%=job_type_desc%>" size="30">
                                    &nbsp;<b>ขั้นตอนที่&nbsp;:</b>&nbsp;<%=objuti.ShowSelectBox("select process_order,name_t from mprocess_order order by to_number(process_order,'99') asc", "process_order", "process_order", "process_order")%>                                        
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">หมายเหตุ&nbsp;:&nbsp;</td>
                                <td class="columnobject">
                                    <textarea class="text_inputs"id="remark" name="remark" cols="40" rows="5"><%=remark%></textarea>
                                </td>
                            </tr>

                            <tr>
                                <td colspan='2'  align="right">
                                    <%
                                        if (request.getParameter("status_a") != null) {
                                    %>
                                    <input type="button" class="cgcButton_5" name="button1" value="ตกลง" onClick="javascript:goAdd();"/>&nbsp;&nbsp;
                                    <%} else {
                                    %>
                                    <input type="button" class="cgcButton_5" name="button1" value="แก้ไข" onClick="javascript:goEdit();"/>&nbsp;&nbsp;
                                    <%}
                                    %>
                                    <input type="button" class="cgcButton_5" name="button2" value="ยกเลิก" onClick="javascript:goBack();"/>                                </td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>