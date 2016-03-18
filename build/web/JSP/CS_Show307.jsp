<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page import="com.cgc.DB.D_packing_product_detail_whDAO"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%
D_packing_product_detail_whDAO objdetail = new D_packing_product_detail_whDAO();
ThaiUtil objth = new ThaiUtil();
%>
<%=objdetail.showDetail(objth.EncodeTexttoTIS(request.getParameter("doc_id")))%>


