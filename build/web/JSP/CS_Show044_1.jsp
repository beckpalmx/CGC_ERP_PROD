<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page import="com.cgc.DB.D_packing_product_detail_prodDAO_40_1"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_packing_product_detail_prodDAO_40_1 objdetail = new D_packing_product_detail_prodDAO_40_1();
ThaiUtil objth = new ThaiUtil();
%>
<%=objdetail.showDetail(objth.EncodeTexttoTIS(request.getParameter("doc_id")))%>


