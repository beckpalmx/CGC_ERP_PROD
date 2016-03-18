<%@page import="com.cgc.engine.Process_transaction_wh_summary"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%Process_transaction_wh_summary objcom = new Process_transaction_wh_summary();%>
<%!    String date_from, date_to,username,process_for,log_id;
%>            
<%
    date_from = (String) request.getParameter("doc_date_from");
    date_to = (String) request.getParameter("doc_date_to");
    username = (String) request.getParameter("A_username");
    process_for = (String) request.getParameter("process_for");
    log_id = (String) request.getParameter("r_create");
    System.out.println(request.getParameter("doc_date_from"));
    System.out.println(request.getParameter("r_create"));
%>
<%=
    objcom.main_check(date_from, date_to,username,process_for,log_id) 
%>

