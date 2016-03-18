<%@page import="com.cgc.bean.DataBeanD_requisition_product_detail"%>
<%@page import="com.cgc.DB.D_requisition_product_detail_whDAO"%>
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
            function goAdd() {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,wh_in,wh_out,doc_date,product_id,weight,bag,lot_no,remark,status_a,username,quantity,job_id', '../JSP/CS_310.jsp'));
                    //opener.getId("doc_id").disabled = false;
                    showTable("show", "doc_id", "../JSP/CS_Show310.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show310.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 1000);
                }
            }
            function goEdit()
            {

                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,wh_in,wh_out,doc_date,product_id,weight,bag,lot_no,remark,line_no,status_u,username,quantity,job_id', '../JSP/CS_310.jsp'));

                    //opener.getId("doc_id").disabled = false;
                    showTable("show", "doc_id", "../JSP/CS_Show310.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show310.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 1000);
                }
            }
            function goBack()
            {
                window.close();
            }
            function Cal_Weight(bag, quantity, weight) {
                getId(weight).value = parseInt(getId(bag).value) * parseInt(getId(quantity).value);
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <%!        ThaiUtil en = new ThaiUtil();
            D_requisition_product_detail_whDAO objDAO = new D_requisition_product_detail_whDAO();
            DataBeanD_requisition_product_detail objBean = new DataBeanD_requisition_product_detail();
            String doc_id, doc_date, line_no, status_a, status_u, product_id, weight, bag, lot_no, prod_name, remark, wh_in, wh_out, net_weight, quantity, job_id, job_id_desc;
        %>
        <%
            doc_id = "";
            product_id = "";
            weight = "";
            doc_date = "";
            line_no = "";
            status_a = "";
            status_u = "";
            bag = "";
            lot_no = "";
            remark = "";
            prod_name = "";
            net_weight = "";
            quantity = "";
            job_id = "";
            job_id_desc = "";
            if (request.getQueryString().indexOf("line_no_") != -1) {
                line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
                doc_date = objBean.getDoc_date();
                wh_in = objBean.getWh_in();
                wh_out = objBean.getWh_out();
                product_id = objBean.getProduct_id();
                prod_name = objBean.getProd_name();
                weight = objBean.getWeight();
                lot_no = objBean.getLot_no();
                bag = objBean.getBag();
                remark = objBean.getRemark().replace("<br>", " ");
                quantity = objBean.getQuantity();
                job_id = objBean.getJob_id();
                job_id_desc = objBean.getJob_id_desc();
                status_u = "2";
                if (request.getParameter("net_weight") != null) {
                    net_weight = request.getParameter("net_weight");
                }
            } else {
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                doc_date = request.getParameter("doc_date");
                wh_in = request.getParameter("wh_in");
                wh_out = request.getParameter("wh_out");
                status_a = request.getParameter("status_a");
                if (request.getParameter("net_weight") != null) {
                    net_weight = request.getParameter("net_weight");
                }
            }
        %>
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="wh_in" value="<%=wh_in%>">
        <input type="hidden" id="wh_out" value="<%=wh_out%>">
        <input type="hidden" id="doc_date" value="<%=doc_date%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type ="hidden" id="net_weightcal" value="<%=net_weight%>">
        <input type="hidden" id="bagedit" value="<%=bag%>">
        <input type="hidden" id="weightedit" value="<%=weight%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="chkNull" value="product_id,weight,bag,lot_no,job_id">
        <br>
        <div align="left">
            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                        <b>ข้อมูลการเบิก</b>
                    </div>                        
                    <div class="panel-footer">                      
                        <div align="center">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2"  class="blankspace"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">รหัสถ่าน*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='product_id' type='text' class="inputs" id="product_id" value='<%=product_id%>' size='10' readonly="readonly"/>
                                        <a href='#' onClick="javascript:openBrWindow('Vproduct', 43, 'Search_Config2_1.jsp')" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        <input name='product_id_desc' type='text' class="inputs" id="product_id_desc" value='<%=prod_name%>' size='50' readonly="readonly"/>                                
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ใบแจ้งการผลิต*&nbsp;</td>
                                    <td class="columnobject"><input name='job_id' type='text' class="inputs" id="job_id" value='<%=job_id%>' size='10' readonly="readonly" />
                                        <a href='#' onClick="openBrWindow('Vd_job_order_header&stadment=and+complete_flag+<>+\'Y\'', 43, 'Search_Config2.jsp');">
                                            <img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        <input name='job_id_desc' type='text' class="inputs" id="job_id_desc" value='<%=job_id_desc%>' size='50' readonly="readonly"/>
                                        <input type="hidden" name="cust_id" id="cust_id" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">น้ำหนักบรรจุ*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='quantity' type='text' class="inputs" id="quantity"  size='10' value="<%=quantity%>" onKeyUp="IsNuber(this.value, this)" onBlur="Cal_Weight('bag', 'quantity', 'weight')"/>
                                        &nbsp;(กิโลกรัม)                                </td>
                                </tr>

                                <tr>
                                    <td class="columnlabel1">จำนวนกระสอบ*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='bag' type='text' class="inputs" id="bag" value='<%=bag%>' size='10' onKeyUp="IsNuber(this.value, this)" onBlur="Cal_Weight('bag', 'quantity', 'weight')"/>                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">น้ำหนักสุทธิ&nbsp;</td>
                                    <td class="columnobject"><input name="weight" type='text' class="inputs" id="weight" size="10" value="<%=weight%>" readonly>
                                        &nbsp;(กิโลกรัม) </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">Lot No.*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='lot_no' type='text' class="inputs" id="lot_no" value='<%=lot_no%>' size='10' />                                </td>
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
        </div>
    </body>
</html>