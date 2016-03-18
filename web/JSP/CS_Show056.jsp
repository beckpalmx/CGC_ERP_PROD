<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<%@page import="com.cgc.DB.D_product_receive_header_whDAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<% D_product_receive_header_whDAO objdetail = new D_product_receive_header_whDAO();
%>
<%=request.getParameter("doc_date") == null?
    objdetail.Show_Approve(request.getParameter("screen") == null ? null: request.getParameter("screen"))
        :
            objdetail.Show_Approve_Date(request.getParameter("doc_date"))
        %>

