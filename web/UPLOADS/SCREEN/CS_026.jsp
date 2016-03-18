<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_friction_receive_detail"%>
<%@page import="com.cgc.DB.D_carbon_friction_receive_detailDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<html>
    <head>
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
                    getSave(URLsend('doc_id,product_id,location_id,silo_no,weight_balance,status_a,username','../JSP/CS_026.jsp'));
                    //opener.getId("doc_id").disabled = true;
                    opener.getId("child_ck").value = "1";
                    showTable("show","doc_id","../JSP/CS_Show026.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show026.jsp?doc_id=")', 800);
                    
                    setTimeout('window.close()', 2000);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,product_id,location_id,silo_no,weight_balance,line_no,status_u,username','../JSP/CS_026.jsp'));
                    //showTable("show","doc_id","../JSP/CS_Show024.jsp?doc_id=");
                    showTable("show","doc_id","../JSP/CS_Show026.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show026.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 2000);
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
    </head>
    <body>
        <%!            ThaiUtil en = new ThaiUtil();
            D_carbon_friction_receive_detailDAO objDAO = new D_carbon_friction_receive_detailDAO();
            DataBeanD_carbon_friction_receive_detail objBean = new DataBeanD_carbon_friction_receive_detail();
            String runno, doc_id, line_no, status_a, status_u, location_id, product_id, silo_no, weight_balance;
        %>
        <%
                    doc_id = "";
                    line_no = "";
                    status_a = "";
                    status_u = "";
                    location_id = "";
                    product_id = "C";
                    //product_id_desc = "";
                    silo_no = "";
                    weight_balance = "";
                    if (request.getQueryString().indexOf("line_no_") != -1) {
                        line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                        doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                        objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
                        product_id = objBean.getProduct_id();
                        //product_id_desc = objBean.getProd_name();
                        silo_no = objBean.getSilo_no();
                        weight_balance = objBean.getWeight_balance();
                        location_id = objBean.getLocation_id();
                        silo_no = objBean.getSilo_no();
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
        <input type="hidden" id="chkNull" value="product_id,location_id,silo_no,weight_balance">
        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ข้อมูลการใช้ถ่าน&nbsp;</td>
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
                                <td class="columnlabel">ถ่าน*&nbsp;</td>
                                <td class="columnobject">
                                    <select name="product_id_select" id="product_id_select" onclick="click_value()">
                                      <option value="C" selected>ถ่านกะลา</option>
                                      <option value="P">ถ่านปาล์ม</option>
                                      <option value="U">ถ่านไม้ยูคาฯ</option>
                                    </select> 
                                    <input name='product_id' type='hidden' id="product_id" value='<%=product_id%>' size='10' /><!--
                                    &nbsp;<a href='javascript:;' onclick="openBrWindow('Vproduct', 26, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='product_id_desc' type='text' class="inputs" id="product_id_desc" value='' size='30' />-->
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">เลขกอง*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='location_id' type='text' class="inputs" id="location_id" value='<%=location_id%>' size='10' />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ไซโล*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='silo_no' type='text' class="inputs" id="silo_no" value='<%=silo_no%>' size='10' readonly/><a href='#' onClick="openBrWindow('Warehouse', 26, 'Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>
                                    <input name='silo_desc' type='hidden' id="silo_desc" value='' size='30' /></td>
                            </tr>
                            <!--
	          <tr>
	          	<td class="columnlabel"></td>
	          	<td class="columnobject">

	          	</td>
	          </tr>
	           -->

                            <tr>
                                <td class="columnlabel">คงเหลือ*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='weight_balance' type='text' class="inputs" id="weight_balance" value='<%=weight_balance%>' size='10'  onkeyup="IsNuber(this.value, this)"/>
                                </td>
                            </tr>

                            <tr>
                                <td colspan='2'  align="right">
                                    <%
                                                if (request.getParameter("status_a") != null) {
                                    %>
                                    <input type="button" name="button1" value="ตกลง" onClick="javascript:goAdd();"/>&nbsp;&nbsp;
                                    <%} else {
                                    %>
                                    <input type="button" name="button1" value="แก้ไข" onClick="javascript:goEdit();"/>&nbsp;&nbsp;
                                    <%}
                                    %>

                                    <input type="button" name="button2" value="ยกเลิก" onClick="javascript:goBack();"/>
                                </td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'>
                                </td>
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