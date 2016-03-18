<%@page import="com.cgc.bean.DataBeanD_adjust_product_detail"%>
<%@page import="com.cgc.DB.D_adjust_rawmat_detailDAO"%>
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
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,product_id,location_id,weight,wh_in,status_a,username', '../JSP/CS_117_1.jsp'));
                    opener.getId("doc_id").disabled = true;
                    showTable("show", "doc_id", "../JSP/CS_Show117.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show117.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 1500);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,product_id,location_id,weight,wh_in,line_no,status_u,username', '../JSP/CS_117_1.jsp'));
                    opener.getId("doc_id").disabled = true;
                    showTable("show", "doc_id", "../JSP/CS_Show117.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show117.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 1500);
                }
            }
            function goBack()
            {
                window.close();
            }

            function goDelete()
            {
                if (confirm("ต้องการลบข้อมูล ?")) {
                    getSave(URLsend('doc_id,product_id,location_id,weight,wh_in,line_no,status_d,username', '../JSP/CS_117_1.jsp'));

                    showTable("show", "doc_id", "../JSP/CS_Show117.jsp?doc_id=");

                    setTimeout('showTable("show","doc_id","../JSP/CS_Show117.jsp?doc_id=")', 800);

                    setTimeout('window.close()', 1500);
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
            D_adjust_rawmat_detailDAO objDAO = new D_adjust_rawmat_detailDAO();
            DataBeanD_adjust_product_detail objBean = new DataBeanD_adjust_product_detail();
            String doc_id, line_no, status_a, status_u, product_id, product_id_desc, pgroup_name, pcat_name, location_id, weight, wh_in, wh_in_desc;
        %>
        <%
            doc_id = "";
            product_id = "";
            product_id_desc = "";
            pgroup_name = "";
            pcat_name = "";
            location_id = "";
            weight = "";
            line_no = "";
            status_a = "";
            status_u = "";
            weight = "";
            wh_in = "";
            wh_in_desc = "";
            if (request.getQueryString().indexOf("line_no_") != -1) {
                line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
                product_id = objBean.getProduct_id();
                product_id_desc = objBean.getProd_name();
                pgroup_name = objBean.getPgroup_name();
                pcat_name = objBean.getPcat_name();
                location_id = objBean.getLocation_id();
                weight = objBean.getWeight();
                wh_in = objBean.getWh_in();
                wh_in_desc = objBean.getWh_out();
                status_u = "2";
            } else {
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                status_a = request.getParameter("status_a");
            }
        %>
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="status_d" value="3">
        <input type="hidden" id="chkNull" value="product_id,weight,wh_in">
        <br>
        <div align="left">

            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                        <b>ข้อมูลการปรับยอด</b>
                    </div>                        
                    <div class="panel-footer">    
                        <div align="center">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2"  class="blankspace"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">รหัสสินค้า*&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='product_id' type='text' class="inputs" id="product_id" value='<%=product_id%>' size='20' readonly="readonly" />
                                        &nbsp;<a href='#' onClick="javascript:openBrWindow('vproduct&stadment=and+pgroup_id+=+\'RAW\'', 116, 'Search_Config2_1.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='product_id_desc' type='text' class="inputs" id="product_id_desc" value='<%=product_id_desc%>' size='30' readonly="readonly" />                                
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">กลุ่มสินค้า&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='pgroup_name' type='text' class="inputs" id="pgroup_name" value='<%=pgroup_name%>' size='20' readonly/>                                </td>
                                </tr>
                                <tr>
                                    <td height="21" class="columnlabel1">ชนิดสินค้า&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='pcat_name' type='text' class="inputs" id="pcat_name" value='<%=pcat_name%>' size='20' readonly/>                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">เลขที่กอง</td>
                                    <td class="columnobject"><input name="location_id" type='text' class="inputs" id="location_id" size="20" value="<%=location_id%>"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">ปรับยอด*&nbsp;</td>
                                    <td class="columnobject"><input name='weight' type='text' class="inputs" id="weight" value='<%=weight%>' onKeyUp="IsNuber(this.value, this)" size='10' />
                                        &nbsp;(กิโลกรัม) </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel1">คลังสินค้า*</td>
                                    <td class="columnobject"><input type='text' class="inputs" size="10" id="wh_in" name="wh_in" value="<%=wh_in%>" >
                                        <a href='#' onClick="openBrWindow('Wh_bg', 23, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                        <input type='text' class="inputs" size="30"  id="wh_in_desc" name="wh_in_desc" value="<%=wh_in_desc%>"></td>
                                </tr>

                                <tr>
                                    <td colspan='2'  align="right">
                                        <%
                                            if (request.getParameter("status_a") != null) {
                                        %>
                                        <input type="button" class="cgcButton_4" name="button1" value="ตกลง" onClick="javascript:goAdd();"/>&nbsp;&nbsp;
                                        <%} else {
                                        %>
                                        <input type="button" class="cgcButton_4" name="button1" value="แก้ไข" onClick="javascript:goEdit();"/>&nbsp;&nbsp;
                                        <input type="button" class="cgcButton_3" name="buttondel" value="ลบ" onClick="javascript:goDelete();"/>    
                                        <%}
                                        %>                                                                    
                                        <input type="button" class="cgcButton_5" name="button2" value="ยกเลิก" onClick="javascript:goBack();"/>                                
                                    </td>
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