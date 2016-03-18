<%@page import="com.cgc.bean.DataBeanD_carbon_withdraw_detail"%>
<%@page import="com.cgc.DB.D_carbon_withdraw_detailDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js">

        </script>
        <script type="text/javascript">
            function goAdd()
            {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,pcat_id,size_use,grd_io_ctc,weight,machine,job_id,remark,doc_date,status_a,username,bag,palate_no,product_id', '../JSP/CS_035.jsp'));
                    opener.getId("doc_id").disabled = false;
                    showTable("show", "doc_id", "../JSP/CS_Show035.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show035.jsp?doc_id=")', 300);
                    setTimeout('window.close()', 1500);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,pcat_id,size_use,grd_io_ctc,weight,machine,job_id,remark,doc_date,line_no,status_u,username,bag,palate_no,product_id', '../JSP/CS_035.jsp'));
                    opener.getId("doc_id").disabled = true;
                    showTable("show", "doc_id", "../JSP/CS_Show035.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show035.jsp?doc_id=")', 300);
                    setTimeout('window.close()', 1000);
                }
            }
            function goBack()
            {
                window.close();
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
    </head>
    <body>
        <%!        ThaiUtil en = new ThaiUtil();
            D_carbon_withdraw_detailDAO objDAO = new D_carbon_withdraw_detailDAO();
            DataBeanD_carbon_withdraw_detail objBean = new DataBeanD_carbon_withdraw_detail();
            String doc_id, product_id, work_type_id, work_type, doc_date, line_no, status_a, status_u, pcat_id, size_use, grd_io_ctc, weight, machine, job_id, remark, pcat_id_desc, bag, job_id_desc, palate_no;
        %>
        <%
            doc_id = "";
            work_type_id = "";
            work_type = "";
            product_id = "";
            pcat_id = "";
            size_use = "";
            doc_date = "";
            line_no = "";
            status_a = "";
            status_u = "";
            grd_io_ctc = "";
            weight = "0";
            machine = "";
            job_id = "";
            remark = "";
            bag = "";
            pcat_id_desc = "";
            job_id_desc = "";
            palate_no = "";
            if (request.getQueryString().indexOf("line_no_") != -1) {
                line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
                product_id = objBean.getProduct_id();
                pcat_id = objBean.getPcat_id();
                size_use = objBean.getSize_use();
                doc_date = objBean.getDoc_date();
                grd_io_ctc = objBean.getGrd_io_ctc();
                weight = objBean.getWeight();
                machine = objBean.getMachine();
                job_id = objBean.getJob_id();
                remark = objBean.getRemark();
                pcat_id_desc = objBean.getCat_name();
                bag = objBean.getBag();
                job_id_desc = objBean.getCust_name();
                palate_no = objBean.getPalate_no();
                status_u = "2";
            } else {
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                doc_date = request.getParameter("doc_date");
                work_type_id = request.getParameter("work_type_id");
                work_type = request.getParameter("work_type");
                status_a = request.getParameter("status_a");
            }
        %>
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="work_type" value="<%=work_type%>">
        <input type="hidden" id="doc_date" value="<%=doc_date%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="chkNull" value="pcat_id,size_use,grd_io_ctc,weight,machine,job_id">
        <br>
        <div align="left">

            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                        <b>ข้อมูลการเบิก</b>
                    </div>                        
                    <div class="panel-footer">           
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">รหัสถ่าน&nbsp;</td>
                                <td class="columnobject">
                                    <input name='product_id' type='text' class="inputs" id="product_id" value='<%=product_id%>' size='10' />                                </td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel1">ชนิดถ่าน*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='pcat_id' type='text' class="inputs" id="pcat_id" value='<%=pcat_id%>' size='10' readonly="readonly" />
                                    <a href='#' onClick="javascript:openBrWindow('Mproduct_cat', 35, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                    <input name='pcat_id_desc' type='text' class="inputs" id="pcat_id_desc" value='<%=pcat_id_desc%>' size='30' readonly="readonly" />                                
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">พาเลทที่&nbsp;</td>
                                <td class="columnobject">
                                    <input name='palate_no' type='text' class="inputs" id="palate_no" value='<%=palate_no%>' size='10' />                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ขนาดถ่าน*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='size_use' type='text' class="inputs" id="size_use" value='<%=size_use%>' size='10' readonly/>&nbsp;<a href='#' onclick="openBrWindow('m_carbon_size&textinput=size_use', 32, 'Search_Detail.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                               </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">เกรดไอโอดีน*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='grd_io_ctc' type='text' class="inputs" id="grd_io_ctc" value='<%=grd_io_ctc%>' size='10'  readonly/>&nbsp;<a href='#' onclick="openBrWindow('m_iodine&stadment=and+iod_ctype+=+\'' + getId('pcat_id').value + '\'&textinput=grd_io_ctc', 0, 'Search_Detail.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>                                
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">กระสอบ</td>
                                <td class="columnobject"><input name='bag' type='text' class="inputs" id="bag" value='<%=bag%>' size='10' onkeyup="IsNumber2(this.value, this)"/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">น้ำหนัก*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='weight' type='text' class="inputs" id="weight" value='<%=weight%>' size='10' onkeyup="IsNuber(this.value, this)"/>
                                    &nbsp;(กิโลกรัม)                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">เครื่องผลิต*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='machine' type='text' class="inputs" id="machine" value='<%=machine%>' size='30' readonly/>&nbsp;<a href='#' onClick="openBrWindow('mproduction_place', 35, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                 
                                </td>
                            </tr>

                            <tr>
                                <td class="columnlabel1">ใบแจ้งการผลิต*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='job_id' type='text' class="inputs" id="job_id" value='<%=job_id%>' size='10' readonly="readonly"/>                                    
                                    <a href='#' onClick="javascript:openBrWindow('Vd_job_order_header', 35, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE2' width='20' height='20' border='0' align='middle' ></a>&nbsp;<input name='job_id_desc' type='text' class="inputs" id="job_id_desc" value='<%=job_id_desc%>' size='30' readonly="readonly" />                                
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">หมายเหตุ&nbsp;</td>
                                <td class="columnobject">
                                    <textarea class="text_inputs" name='remark' cols='40' rows='5' id="remark"><%=remark%></textarea>                                </td>
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