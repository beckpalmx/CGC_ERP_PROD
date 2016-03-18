<%@page import="com.cgc.engine.Process_production_prd_result"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%Process_production_prd_result objcom = new Process_production_prd_result();%>
<%!    String job_id,user_login;
%>            
<%
    job_id = (String) request.getParameter("job_id");
    user_login = (String) request.getParameter("user_login");
    System.out.println(request.getParameter("job_id") + " user_login = " + user_login);
 
%>
<%= objcom.main_check(job_id,user_login) %>