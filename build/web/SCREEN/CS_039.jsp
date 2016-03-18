<%@page import="com.cgc.bean.DataBeanD_packing_req_detail"%>
<%@page import="com.cgc.DB.D_packing_req_detailDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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
                    getSave(URLsend('doc_id,doc_date,wh_in,wh_out,product_id,place_prd,palate_no,qty_use,qty_balance,remark,status_a,username','../JSP/CS_039.jsp'));
                    opener.getId("doc_id").disabled = true;
                    showTable("show","doc_id","../JSP/CS_Show039.jsp?doc_id=");
                    for(var i=0;i<=3;i++){
                        setTimeout('showTable("show","doc_id","../JSP/CS_Show039.jsp?doc_id=")',300);
                    }
                    setTimeout('window.close()', 1000);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,doc_date,wh_in,wh_out,product_id,place_prd,palate_no,qty_use,qty_balance,remark,line_no,status_u,username','../JSP/CS_039.jsp'));
                    opener.getId("doc_id").disabled = true;
                    showTable("show","doc_id","../JSP/CS_Show039.jsp?doc_id=");
                    for(var i=0;i<=3;i++){
                        setTimeout('showTable("show","doc_id","../JSP/CS_Show039.jsp?doc_id=")',300);
                    }
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
    </head>
    <body>
        <%!        ThaiUtil en = new ThaiUtil();
            D_packing_req_detailDAO objDAO = new D_packing_req_detailDAO();
            DataBeanD_packing_req_detail objBean = new DataBeanD_packing_req_detail();
            String doc_id, doc_date, line_no, status_a, status_u, product_id,place_prd,palate_no,qty_use,qty_balance, prod_name,remark, wh_in, wh_out;
        %>
        <%
                    doc_id = "";
                    product_id = "";
                    place_prd = "";
                    doc_date = "";
                    line_no = "";
                    status_a = "";
                    status_u = "";
                    palate_no = "";
                    qty_use = "";
                    qty_balance = "";
                    remark = "";
                    prod_name = "";
                    if (request.getQueryString().indexOf("line_no_") != -1) {
                        line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                        doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                        objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
                        doc_date = objBean.getDoc_date();
                        wh_in = objBean.getWh_in();
                        wh_out = objBean.getWh_out();
                        product_id = objBean.getProduct_id();
                        prod_name = objBean.getProd_name();
                        place_prd = objBean.getPlace_prd();
                        palate_no = objBean.getPalate_no();
                        qty_use = objBean.getQty_use();
                        qty_balance = objBean.getQty_balance();
                        remark = objBean.getRemark();
                        status_u = "2";
                    } else {
                        doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                        doc_date = request.getParameter("doc_date");
                        wh_in = request.getParameter("wh_in");
                        wh_out = request.getParameter("wh_out");
                        status_a = request.getParameter("status_a");
                    }
        %>
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="wh_in" value="<%=wh_in%>">
        <input type="hidden" id="wh_out" value="<%=wh_out%>">
        <input type="hidden" id="doc_date" value="<%=doc_date%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="chkNull" value="product_id,place_prd,palate_no,qty_use,qty_balance">

        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ข้อมูลการบรรจุ&nbsp;</td>
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
                                <td class="columnlabel">รหัสถ่าน*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='product_id' type='text' class="inputs" id="product_id" value='<%=product_id%>' size='10' readonly="readonly"/>
                                    &nbsp;<a href='#' onclick="javascript:openBrWindow('Vproduct', 39, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='product_id_desc' type='text' class="inputs" id="product_id_desc" value='<%=prod_name%>' size='30' readonly="readonly"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">แหล่งผลิต*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='place_prd' type='text' class="inputs" id="place_prd" value='<%=place_prd%>' size='30' />
                                </td>
                            </tr>

                            <tr>
                                <td class="columnlabel">พาเลท*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='palate_no' type='text' class="inputs" id="palate_no" value='<%=palate_no%>' size='10' />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">จำนวนที่ใช้*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='qty_use' type='text' class="inputs" id="qty_use" value='<%=qty_use%>' size='10' />
                                    &nbsp;(กิโลกรัม)
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">คงเหลือ*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='qty_balance' type='text' class="inputs" id="qty_balance" value='<%=qty_balance%>' size='10' />
                                    &nbsp;(กิโลกรัม)
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">หมายเหตุ&nbsp;</td>
                                <td class="columnobject">
                                    <textarea class="text_inputs" name='remark' cols='40' rows='5' id="remark"><%=remark%></textarea>
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