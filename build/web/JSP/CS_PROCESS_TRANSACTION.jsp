<%@page import="com.cgc.engine.Process_transaction"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%Process_transaction objcom = new Process_transaction();%>
<%!    String date_from, date_to,username,process_for;
%>            
<%
    date_from = (String) request.getParameter("doc_date_from");
    date_to = (String) request.getParameter("doc_date_to");
    username = (String) request.getParameter("A_username");
    process_for = (String) request.getParameter("process_for");
    System.out.println(request.getParameter("doc_date_from"));
    System.out.println(request.getParameter("doc_date_to"));
%>
<%=
    objcom.main_check(date_from, date_to,username,process_for)
%>