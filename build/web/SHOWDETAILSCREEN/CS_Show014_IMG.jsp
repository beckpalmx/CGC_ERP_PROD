<%@page import="com.cgc.DB.EmpDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
            EmpDAO objdetail = new EmpDAO();
            System.out.println("emp_id = " + request.getParameter("emp_id") );        
%>    

<%=objdetail.Show_Detail_Img(request.getParameter("emp_id"))%>
