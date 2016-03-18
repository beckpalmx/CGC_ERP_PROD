<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.DB.D_quality_rawmatt_receive_rateDAO"%>
<%@page import="com.cgc.bean.DataBeanD_quality_rawmatt_receive_rate_header"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
            DataBeanD_quality_rawmatt_receive_rate_header bean = new DataBeanD_quality_rawmatt_receive_rate_header();
            UtiDatabase objuti = new UtiDatabase();
            D_quality_rawmatt_receive_rateDAO objDAO = new D_quality_rawmatt_receive_rateDAO();
            bean.setSupplier_id(request.getParameter("supplier_id"));
            bean.setProduct_id(request.getParameter("select_product_id"));
            bean.setRate_text(request.getParameter("select_rate"));
            bean.setYear(request.getParameter("year_text"));
            bean.setAssessor_id(request.getParameter("report_id"));
            bean.setApprove_id(request.getParameter("runner_id"));
            bean.setQuality_id(request.getParameter("quality_id"));
            bean.setComplete_flag(request.getParameter("complete_flag"));
            objDAO.main_summary_quality(bean);
%>
<%out.print("ทำการประมวณผลสำเร็จ");%>

