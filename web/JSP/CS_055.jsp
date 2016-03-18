<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.DB.D_carbon_burn_out_header_whDAO"%>
<%@page import="com.cgc.Util.Chk_T_warehouse_item"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!    UtiDatabase uti = new UtiDatabase();
    UserBean userbean;
    String[] strsprit_runno = new String[]{};
    String[] strsprit_doc_id = new String[]{};
    D_carbon_burn_out_header_whDAO obj_approve;
%>
<%
            userbean = (UserBean) session.getAttribute("user");
            obj_approve = new D_carbon_burn_out_header_whDAO();
            strsprit_runno = request.getParameter("line_no").split(",");
            strsprit_doc_id = request.getParameter("doc_id").split(",");
%>
<%=obj_approve.Cal_Approve(strsprit_runno, strsprit_doc_id)%>

