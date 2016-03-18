<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_burn_out_detail"%>
<%@page import="com.cgc.DB.D_carbon_burn_out_detail_whDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js">

        </script>
        <script type="text/javascript">

            function goAdd() {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,wh_in,wh_out,doc_date,line_no,production_no,size,g_code,g_sum,ctc_i2,bag,weight,remark,status_a,username,bag_no,wh_weight,wh_id,product_id,weight_diff,location_id', '../JSP/CS_301.jsp'));
                    opener.getId("doc_id").disabled = true;
                    showTable("show", "doc_id", "../JSP/CS_Show301.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show301.jsp?doc_id=")', 800);

                    setTimeout('window.close()', 1500);
                }
            }
            function goEdit()
            {

                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,wh_in,wh_out,doc_date,line_no,production_no,size,g_code,g_sum,ctc_i2,bag,weight,remark,status_u,username,bag_no,wh_weight,wh_id,product_id,weight_diff,location_id', '../JSP/CS_301.jsp'));
                    opener.getId("doc_id").disabled = true;
                    showTable("show", "doc_id", "../JSP/CS_Show301.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show301.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 1500);
                }
            }
            function goBack()
            {
                window.close();
            }
            function  Weight_diff(g_sum, weight, wh_weight, weight_diff)
            {
                getId(weight_diff).value = !isNaN(parseInt(getId(g_sum).value, 10) + parseInt(getId(weight).value, 10) - parseInt(getId(wh_weight).value, 10)) ? (parseInt(getId(g_sum).value, 10) + parseInt(getId(weight).value, 10) - parseInt(getId(wh_weight).value, 10)).toString() : "0";
            }
            function EditValue(username, create_name) {
                if (getId(username).value != getId(create_name).value && getId(create_name).value != "") {
                    getId("production_no").disabled = true;
                    getId("size").disabled = true;
                    getId("g_code").disabled = true;
                    //getId("g_sum").disabled = true;
                    //getId("bag").disabled = true;
                    //getId("weight").disabled = true;
                    getId("remark").disabled = true;

                }

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

    </head>
    <%!    UtiDatabase objuti = new UtiDatabase();
        ThaiUtil en = new ThaiUtil();
        D_carbon_burn_out_detail_whDAO objDAO = new D_carbon_burn_out_detail_whDAO();
        DataBeanD_carbon_burn_out_detail objBean = new DataBeanD_carbon_burn_out_detail();
        String doc_id, wh_in, wh_out, doc_date, line_no,
                status_a, status_u, production_no, size,
                g_code, g_sum, ctc_i2, bag, weight, lost,
                remark, lost_weight, total_weight, bag_no,
                wh_weight, wh_id, product_id, create_by, weight_diff, location_id, product_name, warehouse_name;
    %>
    <%
        doc_id = "";
        wh_in = "";
        wh_out = "";
        doc_date = "";
        line_no = "";
        status_a = "";
        status_u = "";
        production_no = "";
        size = "";
        g_code = "";
        g_sum = "";
        ctc_i2 = "";
        bag = "";
        weight = "";
        lost = "";
        remark = "";
        lost_weight = "";
        total_weight = "";
        bag_no = "";
        wh_weight = "";
        wh_id = "-";
        product_id = "-";
        product_name = "-";
        create_by = "";
        weight_diff = "0";
        location_id = "-";
        warehouse_name = "-";
        if (request.getQueryString().indexOf("line_no_") != -1) {
            line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
            doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
            objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
            wh_in = objBean.getWh_in();
            wh_out = objBean.getWh_out();
            doc_date = objBean.getDoc_date();
            production_no = objBean.getProduction_no();
            size = objBean.getSize();
            g_code = objBean.getG_code();
            g_sum = objBean.getG_sum();
            weight = objBean.getWeight();
            ctc_i2 = objBean.getCtc_i2();
            bag = objBean.getBag();
            weight = objBean.getWeight();
            lost = objBean.getLost();
            remark = objBean.getRemark();
            bag_no = objuti.NotNull(objBean.getBag_no());
            wh_weight = objuti.NotNull(objBean.getWh_weight());
            wh_id = objuti.NotNull(objBean.getWh_id());
            product_id = objuti.NotNull(objBean.getProduct_id());
            product_name = objuti.NotNull(objBean.getProduct_name());
            warehouse_name = objuti.NotNull(objBean.getWarehouse_name());
            create_by = objBean.getBy();
            weight_diff = objuti.NotNull(objBean.getWeight_diff());
            location_id = objBean.getLocation_id();
            status_u = "2";
            if (request.getParameter("total_weight") != null) {
                total_weight = request.getParameter("total_weight");
            }
            if (request.getParameter("lost_weight") != null) {
                lost_weight = request.getParameter("lost_weight");
            }
        } else {
            doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
            wh_in = request.getParameter("wh_in");
            wh_out = request.getParameter("wh_out");
            doc_date = request.getParameter("doc_date");
            status_a = request.getParameter("status_a");
            if (request.getParameter("total_weight") != null) {
                total_weight = request.getParameter("total_weight");
            }
            if (request.getParameter("lost_weight") != null) {
                lost_weight = request.getParameter("lost_weight");
            }
        }
    %>
    <body onLoad="EditValue('username', 'by')">
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="wh_in" value="<%=wh_in%>">
        <input type="hidden" id="wh_out" value="<%=wh_out%>">
        <input type="hidden" id="doc_date" value="<%=doc_date%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="total_wightcal" value="<%=total_weight%>">
        <input type="hidden" id="lost_weightcal" value="<%=lost_weight%>">
        <input type="hidden" id="weightedit" value="<%=weight%>">
        <input type="hidden" id="lostedit" value="<%=lost%>">
        <input type="hidden" id="by" value="<%=create_by%>">
        <!--input type='text' class="inputs" id="chkNull" value="production_no,size,bag,weight"-->
        <input type="hidden" id="chkNull" value="production_no,size,bag,weight">
        <br>
        <div align="left">
            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                        <b>ข้อมูลถ่านออกจากเตา</b>
                    </div>                        
                    <div class="panel-footer">              
                        <div align="center">                
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2"  class="blankspace"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">รหัส*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='production_no' type='text' class="inputs" id="production_no" value='<%=production_no%>' size='30' />	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ขนาด*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='size' type='text' class="inputs" id="size" value='<%=size%>' size='10' readonly/>	
                                        <a href='#' onClick="openBrWindow('m_carbon_size', 30, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>        	
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">รหัสยอดยกมา&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='g_code' type='text' class="inputs" id="g_code" value='<%=g_code%>' size='30' />	          	
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ยอดยกมา&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='g_sum' type='text' class="inputs" id="g_sum" value='<%=g_sum%>' size='10' onblur="IsNuber(this.value, this)"/>	          	
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">I2&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='ctc_i2' type='text' class="inputs" id="ctc_i2" value='<%=ctc_i2%>' size='10'  readonly/><a href='#' onclick="openBrWindow('m_iodine&textinput=ctc_i2', 0, 'Search_Detail.jsp')">
                                            <img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">หน่วยบรรจุ*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='bag' type='text' class="inputs" id="bag" value='<%=bag%>' size='10' onkeyup="IsNumber2(this.value, this)"/>	          	
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">น้ำหนัก*&nbsp;</td>                                
                                    <td class="columnobject"><input name='weight' type='text' class="inputs" id="weight" value='<%=weight%>' size='10' onkeyup="IsNuber(this.value, this)"/></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">หมายเหตุ&nbsp;</td>
                                    <td class="columnobject"><input name='remark' type='text' class="inputs" id="remark" value='<%=remark%>' size='30' /></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">จำนวนถุง*&nbsp;</td>
                                    <td class="columnobject"><input name="bag_no" type='text' class="inputs" id="bag_no" size="10" value="<%=bag_no%>" onkeyup="IsNumber2(this.value, this)"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">น้ำหนักคลังรับ*&nbsp;</td>
                                    <td class="columnobject"><input name="wh_weight" type='text' class="inputs" id="wh_weight" value="<%=wh_weight%>" size="10" onBlur="Weight_diff('g_sum', 'weight', 'wh_weight', 'weight_diff')" onkeyup="IsNuber(this.value, this)">
                                        ยอดผลต่าง
                                        <input name="weight_diff" type='text' class="inputs" id="weight_diff" size="10" value="<%=weight_diff%>"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">รหัสคลัง*&nbsp;</td>
                                    <td class="columnobject"><input name="wh_id" type='text' class="inputs" id="wh_id" size="10" value ="<%=wh_id%>" readonly>&nbsp;&nbsp;&nbsp;
                                        <a href='#' onClick="openBrWindow('mwarehouse', 301, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                        <input type='text' class="inputs" name="wh_id_desc" id="wh_id_desc" value="<%=warehouse_name%>"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">กองที่&nbsp;</td>
                                    <td class="columnobject"><input name="location_id" type='text' class="inputs" id="location_id" value="<%=location_id%>" size="10">
                                    </td>
                                </tr>       


                                <tr>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">รหัสสินค้า*&nbsp;</td>
                                    <td class="columnobject"><input name="product_id" type='text' class="inputs" id="product_id" value="<%=product_id%>" size="20" readonly>&nbsp;&nbsp;&nbsp;<a href='#' onClick="openBrWindow('Vproduct', 302, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                        <input type='text' class="inputs" name="product_id_desc" id="product_id_desc" value="<%=product_name%>" size="70"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">&nbsp;</td>
                                    <td class="columnobject">&nbsp;</td>
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
                                        <input type="button" class="cgcButton_5" name="button2" value="ยกเลิก" onClick="javascript:goBack();"/>      		  	</td>
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