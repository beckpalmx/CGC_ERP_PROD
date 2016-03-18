
<%@page import="com.cgc.bean.DataBeanD_ticketbuy"%>
<%@page import="com.cgc.DB.D_ticketbuyDAO"%>
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
                    getSave(URLsend('doc_id,ticket_text,net_wght,price_unit,price_total,line_no,status_u,username', '../JSP/CS_D_tickybuy_1.jsp'));
                    opener.getId("doc_id").disabled = true;
                    showTable("show", "doc_id", "../JSP/CS_Show_D_ticketbuy_doc.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show_D_ticketbuy_doc.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 1500);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,ticket_text,net_wght,price_unit,price_total,line_no,status_u,username', '../JSP/CS_D_tickybuy_1.jsp'));
                    opener.getId("doc_id").disabled = true;
                    showTable("show", "doc_id", "../JSP/CS_Show_D_ticketbuy_doc.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show_D_ticketbuy_doc.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 1500);
                }
            }

            function goBack()
            {
                window.close();
            }

            function cal_total_price() {

                if (isNaN((parseFloat(getId("net_wght").value) * parseFloat(getId("price_unit").value).toFixed(2)))) {
                    getId("price_total").value = 0;
                } else
                    var n = (parseFloat(getId("net_wght").value).toFixed(2) * parseFloat(getId("price_unit").value).toFixed(2));
                var result = Math.floor(n * 100) / 100;
                getId("price_total").value = result;
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
    </head>
    <body>
        <%!
            ThaiUtil en = new ThaiUtil();
            D_ticketbuyDAO objDAO = new D_ticketbuyDAO();
            DataBeanD_ticketbuy objBean = new DataBeanD_ticketbuy();
            String doc_id, ticket_text, status_a, status_u, truck_no, cred_name, prod_name, line_no, net_wght, price_unit, price_total, date_in, date_out, time_in, time_out, load_in, load_out;
        %>
        <%
            doc_id = "";
            ticket_text = "";
            truck_no = "";
            cred_name = "";
            prod_name = "";
            net_wght = "";
            line_no = "";
            price_unit = "";
            price_total = "";
            status_a = "";
            status_u = "";
            date_in = "";
            date_out = "";
            time_in = "";
            time_out = "";
            load_in = "";
            load_out = "";

            if (request.getQueryString().indexOf("ticket_text_") != -1) {
                ticket_text = request.getQueryString().substring(12, request.getQueryString().indexOf("="));
                //out.println(request.getQueryString());
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                objBean = objDAO.ReturnEdit(doc_id, ticket_text, objBean);
                truck_no = objBean.getTruck_no();
                cred_name = objBean.getCred_name();
                prod_name = objBean.getProd_name();
                net_wght = objBean.getNet_wght();
                line_no = objBean.getLine_no();
                price_unit = objBean.getPrice_unit();
                price_total = objBean.getPrice_total();
                date_in = objBean.getDate_in();
                date_out = objBean.getDate_out();
                time_in = objBean.getTime_in();
                time_out = objBean.getTime_out();
                load_in = objBean.getLoad_in();
                load_out = objBean.getLoad_out();
                status_u = "2";

                //out.println(ticket_text);
                //out.println(doc_id);
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
        <input type="hidden" id="chkNull" value="net_wght,price_unit,price_total">
        <input type="hidden" id="cred_code" name="cred_code" value="000380"> <!-- C.Gigantic Carbon -->
        <br>
        <div align="left">
            <div class="container">
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-tasks"></span>&nbsp;
                        <b>ข้อมูลการรับไม้ฟืน</b>
                    </div>                        
                    <div class="panel-footer">           
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">เลขที่ใบชั่ง*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='ticket_text' type='text' class="inputs" id="ticket_text" value='<%=ticket_text%>' size='20' readonly="readonly" />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ทะเบียนรถ&nbsp;</td>
                                <td class="columnobject">
                                    <input name='truck_no' type='text' class="inputs" id="truck_no" value='<%=truck_no%>' size='20' readonly/>                                </td>
                            </tr>
                            <tr>
                                <td height="21" class="columnlabel1">วันที่&nbsp;</td>
                                <td class="columnobject">
                                    <input name='date_in' type='text' class="inputs" id="date_in" value='<%=date_in%>' size='20' readonly/>                                </td>
                            </tr>                            
                            <tr>
                                <td height="21" class="columnlabel1">เวลาเข้า&nbsp;</td>
                                <td class="columnobject">
                                    <input name='time_in' type='text' class="inputs" id="time_in" value='<%=time_in%>' size='20' readonly/>                                </td>
                            </tr>                            
                            <tr>
                                <td height="21" class="columnlabel1">เวลาออก&nbsp;</td>
                                <td class="columnobject">
                                    <input name='time_out' type='text' class="inputs" id="time_out" value='<%=time_out%>' size='20' readonly/>                                </td>
                            </tr>                                   

                            <tr>
                                <td height="21" class="columnlabel1">ชื่อผู้ขาย&nbsp;</td>
                                <td class="columnobject">
                                    <input name='cred_name' type='text' class="inputs" id="cred_name" value='<%=cred_name%>' size='40' readonly/>                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">ประเภท</td>
                                <td class="columnobject"><input name="prod_name" type='text' class="inputs" id="prod_name" size="40" value="<%=prod_name%>" readonly></td>
                            </tr>
                            <tr>
                                <td class="columnlabel1">น้ำหนักรถเข้า&nbsp;</td>
                                <td class="columnobject"><input name='load_in' type='text' class="inputs" id="load_in" value='<%=load_in%>' onKeyUp="IsNuber(this.value, this)" size='15' readonly/>
                                    &nbsp;(กิโลกรัม) </td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel1">น้ำหนักรถออก&nbsp;</td>
                                <td class="columnobject"><input name='load_out' type='text' class="inputs" id="load_out" value='<%=load_out%>' onKeyUp="IsNuber(this.value, this)" size='15' readonly/>
                                    &nbsp;(กิโลกรัม) </td>
                            </tr>                            

                            <tr>
                                <td class="columnlabel1"><b>น้ำหนักไม้ฟืน</b>&nbsp;</td>
                                <td class="columnobject"><input name='net_wght' type='text' class="inputs" id="net_wght" value='<%=net_wght%>' onKeyUp="IsNuber(this.value, this)" size='15' readonly/>
                                    &nbsp;(กิโลกรัม) </td>
                            </tr>
                            <tr>
                                <td class="columnlabel1"><b>ราคาต่อหน่วย*</b>&nbsp;</td>
                                <td class="columnobject"><input name='price_unit' type='text' class="inputs" id="price_unit" value='<%=price_unit%>' onKeyUp="IsNuber(this.value, this)" size='15' />
                                    &nbsp;(บาท) </td>
                            </tr>

                            <tr>
                                <td class="columnlabel1"><b>รวมราคา*</b>&nbsp;</td>
                                <td class="columnobject"><input name='price_total' type='text' class="inputs" id="price_total" value='<%=price_total%>' onKeyUp="IsNuber(this.value, this)" size='15' readonly/>
                                    &nbsp;(บาท)&nbsp; 
                                    <input type="button" class="cgcButton_9" id="btnet_weight_payment" value="คำนวณราคารวม" onclick="cal_total_price()">                                        
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
                                <td colspan='2' class='blankspace'>                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>