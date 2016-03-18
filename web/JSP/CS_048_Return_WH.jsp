<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.bean.DataBean_Return_Doc"%>
<%@page import="com.cgc.DB.Return_Doc_DAO"%>  

<%
    Return_Doc_DAO rdDAO = new Return_Doc_DAO();
    DataBean_Return_Doc rdBean;
    Timestamp ts;
    ThaiUtil tu;
%>
<%
    tu = new ThaiUtil();
    rdBean = new DataBean_Return_Doc();
    rdBean.setProcess_id(request.getParameter("process_id") != null ? request.getParameter("process_id") : "-");
    rdBean.setTable_header(request.getParameter("table_h") != null ? request.getParameter("table_h") : "-");
    rdBean.setTable_detail1(request.getParameter("table_s1") != null ? request.getParameter("table_s1") : "-");
    rdBean.setTable_detail2(request.getParameter("table_s2") != null ? request.getParameter("table_s2") : "-");    
    rdBean.setTable_detail3(request.getParameter("table_s3") != null ? request.getParameter("table_s3") : "-");    
    rdBean.setDoc_id(request.getParameter("doc_id") != null ? request.getParameter("doc_id") : "-");    
    
    System.out.println("process_id = " + request.getParameter("process_id"));
    System.out.println("table_h = " + request.getParameter("table_h"));
    System.out.println("table_s1 = " + request.getParameter("table_s1"));
    System.out.println("table_s2 = " + request.getParameter("table_s2"));
    System.out.println("table_s3 = " + request.getParameter("table_s3"));
    System.out.println("doc_id = " + request.getParameter("doc_id"));

    if (request.getParameter("process_id") != null && request.getParameter("doc_id") != null ) {        
        rdDAO.update(rdBean);
        out.println("บันทึกสำเร็จ");
    }
%>