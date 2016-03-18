<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_friction_receive_detail_1"%>
<%@page import="com.cgc.DB.D_carbon_friction_receive_detail_1DAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<html>
    <head>
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>                   
        <script type="text/javascript">
            function get_balance() {
                var URL = "../JSP/CS_Detail_025_2.jsp?get_balance=4&doc_date=" + getId('doc_date').value + "&shift=" + (getId("shift").value == 8 ? "9" : "8");
                //alert(URL);
                //AjaxRun_id('balance_weight', URL);
            }
            function goAdd()
            {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('chkNull,doc_id,doc_date,product_id,friction_house,silo_no,location_id,balance_weight,remain_weight,status_a', '../JSP/CS_Detail_025_2.jsp'));
                    showTable("show2", "doc_id", "../JSP/CS_DetailShow_025_2.jsp?doc_id=");
                    setTimeout('showTable("show2","doc_id","../JSP/CS_DetailShow_025_2.jsp?doc_id=")', 800);

                    setTimeout('window.close()', 2000);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('chkNull,doc_id,doc_date,line_no,product_id,friction_house,silo_no,location_id,balance_weight,remain_weight,status_u', '../JSP/CS_Detail_025_2.jsp'));
                    showTable("show2", "doc_id", "../JSP/CS_DetailShow_025_2.jsp?doc_id=");
                    setTimeout('showTable("show2","doc_id","../JSP/CS_DetailShow_025_2.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 2000);
                }
            }
            function goBack()
            {
                window.close();
            }

            function select() {
                select_value();
            }

        </script>
    </head>
    <body onLoad="select()" >
        <%!            ThaiUtil en = new ThaiUtil();
            D_carbon_friction_receive_detail_1DAO objDAO = new D_carbon_friction_receive_detail_1DAO();
            DataBeanD_carbon_friction_receive_detail_1 objBean = new DataBeanD_carbon_friction_receive_detail_1();
            String runno, doc_id, doc_date, line_no, product_id, friction_house, silo_no, location_id, balance_weight, remain_weight, status_a, status_u;
        %>
        <%
            doc_id = "";
            line_no = "";
            product_id = "";
            friction_house = "";
            silo_no = "";
            location_id = "";
            balance_weight = "0";
            remain_weight = "0";
            doc_date = request.getParameter("doc_date");
            if (request.getQueryString().indexOf("line_no_") != -1) {
                line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                objBean = objDAO.ReturnEdit(doc_id, line_no);
                product_id = objBean.getProduct_id();
                friction_house = objBean.getFriction_house();
                silo_no = objBean.getSilo_no();
                location_id = objBean.getLocation_id();
                balance_weight = objBean.getBalance_weight();
                remain_weight = objBean.getRemain_weight();
                doc_date = objBean.getDoc_date();
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
        <input type="hidden" id="chkNull" value="product_id,remain_weight">
        <input type="hidden" id="shift" value="<%=request.getParameter("shift")%>">
        <input type="hidden" id="doc_date" value="<%=doc_date%>">
        <br>
        <div align="left">
            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                        <b>ข้อมูลถ่านได้</b>
                    </div>                        
                    <div class="panel-footer">                      
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ถ่าน* :&nbsp;</td>
                                <td class="columnobject"><select name="product_id_select" class="select_cgc" id="product_id_select" onclick="click_value()">
                                        <option value="CF" selected>CF ถ่านกะลาที่สีแล้ว</option>
                                        <option value="UF">UF ถ่านยูคาฯที่สีแล้ว</option>
                                        <option value="KF">KF ถ่านไม้โกงกางที่สีแล้ว</option>
                                        <option value="PF">PF ถ่านปาล์มที่สีแล้ว</option>
                                        <option value="BF">BF ถ่านไม้ไผ่ที่สีแล้ว</option>
                                        <option value="PAF">PAF ปาล์มดิบที่สีแล้ว</option>                                        
                                        <option value="C">C ถ่านกะลามะพร้าว</option>
                                        <option value="CB">CB ฝุ่นถ่านดิบ</option>
                                        <option value="CP">CP กะลาปาล์มดิบ</option>
                                        <option value="CU">CU กะลา+ยูคา</option>
                                        <option value="K">K ถ่านไม้โกงกาง</option>
                                        <option value="P">P ถ่านกะลาปาล์ม</option>
                                        <option value="PA">PA ปาล์มดิบ</option>
                                        <option value="U">U ถ่านยูคา</option>
                                        <option value="B">B ถ่านไม้ไผ่</option>
                                    </select>
                                    <input name='product_id' type='hidden' id="product_id" value='<%=product_id%>' size='10' /></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">โรงสี* :&nbsp;</td>
                                <td class="columnobject">
                                    <input name='friction_house' type='text' class="inputs" id="friction_house" value='<%=friction_house%>' size='10' />                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ไซโล* :&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="silo_no" id="silo_no" value="<%=silo_no%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">เลขกอง :&nbsp;</td>
                                <td class="columnobject">
                                    <input name='location_id' type='text' class="inputs" id="location_id" value='<%=location_id%>' size='20' />
                                    &nbsp;<a href='javascript:;' onClick="openBrWindow('vmlocation', 289, 'Search_Config2.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                                        
                                    &nbsp;<input type="hidden" name="location_name" id="location_name" value="" size="20">                                    
                                </td>
                            </tr>  
                            <tr>
                                <td class="columnlabel1"><input type="button" class="cgcButton_2" value="ยอดยกมา" id="get_balance" onclick="get_balance()"> :&nbsp;</td>
                                <td class="columnobject"><input type='text' class="inputs" name="balance_weight" id="balance_weight" value="<%=balance_weight%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ยอดคงเหลือ* :&nbsp;</td>
                                <td class="columnobject">
                                    <input name='remain_weight' type='text' class="inputs" id="remain_weight" value='<%=remain_weight%>' size='10'  onkeyup="IsNuber(this.value, this)"/>                                </td>
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
                                <td colspan='2' class='blankspace'>                                
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>