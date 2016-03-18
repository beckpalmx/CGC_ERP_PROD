<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="javax.swing.*"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.DB.Login_Log_DAO"%>
<%@page import="com.cgc.bean.LoginlogBean"%>
<%
    Timestamp ts = new Timestamp(new java.util.Date().getTime());
    LoginlogBean logBean = new LoginlogBean();
    Login_Log_DAO logDAO = new Login_Log_DAO();
    
    String session_id = String.valueOf(session.getAttribute("session_id"));
    String logid = String.valueOf(session.getAttribute("logid"));
    logBean.setLogout_time(ts);
    logBean.setLogid(logid);
    logBean.setSession_id(session_id);    
    logDAO.update(logBean);
    
    System.out.println("Session Logout = " + session.getAttribute("session_id"));
    session.invalidate();
    System.out.println("Logout System");
    response.sendRedirect("../index.html");
%>