<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.bean.DataBeanD_product_receive_detail"%>
<%@page import="com.cgc.DB.D_product_receive_detail_whDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js">
        </script>
        <script type="text/javascript">
            function goAdd()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,wh_in,wh_out,doc_date,product_id,size,job_edit_no,ctc_i2,qty,status_a,username,shift,unit_id,job_type_id,job_type_desc,remark','../JSP/CS_037.jsp'));
                    //opener.getId("doc_id").disabled = true;
                    showTable("show","doc_id","../JSP/CS_Show037.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show037.jsp?doc_id=")',800);
                    setTimeout('window.close()', 800);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,wh_in,wh_out,doc_date,line_no,product_id,size,job_edit_no,ctc_i2,qty,status_u,username,shift,unit_id,job_type_id,job_type_desc,remark','../JSP/CS_037.jsp'));
                    //opener.getId("doc_id").disabled = true;
                    showTable("show","doc_id","../JSP/CS_Show037.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show037.jsp?doc_id=")',800);
                    setTimeout('window.close()',800);
                }
            }
            function goBack()
            {
                window.close();
            }
            function select(){
                select_value();
                if(getId("status_u").value != ""){
                    getId("shift").value = getId("selectshift").value;
                    getId("job_type_id").value = getId("job_type_id_sel").value;
                }

            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
    </head>
    <%!    ThaiUtil en = new ThaiUtil();
        D_product_receive_detail_whDAO objDAO = new D_product_receive_detail_whDAO();
        DataBeanD_product_receive_detail objBean = new DataBeanD_product_receive_detail();
        UtiDatabase objuti = new UtiDatabase();
        String doc_id, wh_in, wh_out, doc_date, line_no, status_a, status_u, burn_no, location_id, wh_id, size, job_edit_no, ctc_i2, qty, shift, palate_no, unit_id, product_id, job_type_id, job_type_desc, unit_id_desc, remark;
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
        ctc_i2 = "";
        qty = "";
        shift = "";
        palate_no = "";
        unit_id = "";
        product_id = "CF";
        job_type_id = "";
        job_type_desc = "";
        unit_id_desc = "";
        remark = "";
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
            product_id = objBean.getProduct_id();
            job_type_id = objBean.getJob_type_id();
            job_type_desc = objBean.getJob_type_desc();
            unit_id_desc = objBean.getUnit_name();
            remark = objBean.getRemark();
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
        <input type="hidden" id="chkNull" value="product_id,size,qty,job_type_id,job_type_desc">
        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ถ่านเบิก&nbsp;</td>
                <td class="ftopright"></td>
            </tr>
            <tr >
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter">
                    <div align="center">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ชนิดถ่าน*</td>
                                <td class="columnobject"><select name="product_id_select" id="product_id_select" onclick="click_value()">
                                        <option value="CF" selected>CF ถ่านกะลาที่สีแล้ว</option>
                                        <option value="UF">UF ถ่านยูคาฯที่สีแล้ว</option>
                                        <option value="KF">KF ถ่านไม้โกงกางที่สีแล้ว</option>
                                        <option value="PF">PF ถ่านปาล์มที่สีแล้ว</option>
                                        <option value="BF">BF ถ่านไม้ไผ่ที่สีแล้ว</option>
                                        <option value="C">C ถ่านกะลามะพร้าว</option>
                                        <option value="CB">CB ฝุ่นถ่านดิบ</option>
                                        <option value="CP">CP กะลาปาล์มดิบ</option>
                                        <option value="CU">CU กะลา+ยูคา</option>
                                        <option value="K">K ถ่านไม้โกงกาง</option>
                                        <option value="P">P ถ่านกะลาปาล์ม</option>
                                        <option value="U">U ถ่านยูคา</option>
                                        <option value="B">B ถ่านไม้ไผ่</opt
                                    </select>
                                    <input name='product_id' type='hidden' id="product_id" value='<%=product_id%>' size='10' /></td>
                            </tr>                        
                            <tr>
                                <td class="columnlabel">หน่วยนับ*</td>
                                <td class="columnobject"><input name="unit_id" type='text' class="inputs" id="unit_id" size="10" value="<%=unit_id%>" readonly>&nbsp;<a href='#' onClick="javascript:openBrWindow('munit_code', 37, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a><input type='text' class="inputs" name="unit_id_desc" id="unit_id_desc" value="<%=unit_id_desc%>" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ขนาด*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='size' type='text' class="inputs" id="size" value='<%=size%>' size='10' readonly/><a href='#' onClick="openBrWindow('m_carbon_size&textinput=size', 32, 'Search_Detail.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">รหัสแก้งาน&nbsp;</td>
                                <td class="columnobject">
                                    <input name='job_edit_no' type='text' class="inputs" id="job_edit_no" value='<%=job_edit_no%>' size='30' />                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">I2&nbsp;</td>
                                <td class="columnobject">
                                    <input name='ctc_i2' type='text' class="inputs" id="ctc_i2" value='<%=ctc_i2%>' size='10'  readonly/><a href='#' onclick="openBrWindow('m_iodine&stadment=and+iod_ctype+=+\''+getId('product_id_select').value+'\'&textinput=ctc_i2', 0, 'Search_Detail.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">จำนวน*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='qty' type='text' class="inputs" id="qty" value='<%=qty%>' size='10' onBlur="IsNuber(this.value, this)"/>                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ช่วงเวลาทำงาน(กะ)&nbsp;</td>
                                <td class="columnobject"><%=objuti.ShowSelectBox("select shift_id,name_t from mshift where shift_grp = '2' order by runno", "shift_id", "name_t", "shift")%>
                                    <input type="hidden" id="selectshift" value="<%=shift%>">
                                    <!--<select name='shift' id="shift">
                                          <option value='1'>เช้า</option><option value='2'>บ่าย</option><option value='3'>ดึก</option></select>-->
                                    &nbsp;&nbsp; </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ประเภทงาน*</td>
                                <td class="columnobject"><%=objuti.ShowSelectBox("select job_type_id,name_t from vmjob_type order by runno", "job_type_id", "name_t", "job_type_id")%>&nbsp;<input id="job_type_desc" name="job_type_desc" value="<%=job_type_desc%>" size="30"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">หมายเหตุ&nbsp;</td>
                                <td class="columnobject">
                                    <textarea class="text_inputs" id="remark" name="remark" cols="40" rows="5"><%=remark%></textarea>
                                </td>
                            </tr>
                            <!--<tr>
                                 <td class="columnlabel">พนักงานคุมเครื่อง*&nbsp;</td>
                                 <td class="columnobject">
                                     <input name='emp_id' type='text' class="inputs" id="emp_id" value='' size='10' readonly="readonly"/>
                                     &nbsp;<a href='#' onClick="openBrWindow('Vemployee', 37, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE2' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='emp_id_desc' type='text' class="inputs" id="emp_id_desc" value='' size='30' readonly="readonly"/>                                </td>
                             </tr>-->
                            <tr>
                                <td colspan='2'  align="right">

                                    <input type="button" name="button2" value="ยกเลิก" onClick="javascript:goBack();"/>                                </td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'>                                </td>
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