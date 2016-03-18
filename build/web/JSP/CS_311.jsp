
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.DB.CS_311DAO"%>
<%@page import="com.cgc.bean.DataBeanCS_051"%>
<%@page import="com.cgc.Util.Chk_T_warehouse_item"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%    UtiDatabase uti = new UtiDatabase();
            //UserBean userbean;
            String[] strsprit = new String[]{};
            //userbean = (UserBean) session.getAttribute("user");
            strsprit = request.getParameter("line_no").split(",");
            CS_311DAO obj_311 = new CS_311DAO();
            obj_311.Cal_Approve(strsprit).trim();
            out.print(obj_311.Cal_Approve(strsprit).trim());
%>

