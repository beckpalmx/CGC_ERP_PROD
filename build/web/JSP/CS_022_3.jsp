<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.D_rawmatt_receiveDAO"%>
<%@page import="com.cgc.bean.DataBean_D_rawmatt_receive"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%!    ThaiUtil en = new ThaiUtil();
    DataBean_D_rawmatt_receive objdb = new DataBean_D_rawmatt_receive();
    D_rawmatt_receiveDAO objex = new D_rawmatt_receiveDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;

%>
<%
objdb.setDoc_id(request.getParameter("doc_id"));
    objdb.setAshes_weight(request.getParameter("ashes_weight_acc"));
    objdb.setAshes_percent(request.getParameter("ashes_percent_acc"));
    objdb.setDust_weight(request.getParameter("dust_weight_acc"));
    objdb.setDust_percent(request.getParameter("dust_percent_acc"));
    objdb.setVolatile_weight(request.getParameter("volatile_weight_acc"));
    objdb.setVolatile_percent(request.getParameter("volatile_percent_acc"));
    objdb.setMoise_weight(request.getParameter("moise_weight_acc"));
    objdb.setMoise_percent(request.getParameter("moise_percent_acc"));
    objdb.setContamination_weight(request.getParameter("contamination_weight_acc"));
    objdb.setContamination_percent(request.getParameter("contamination_percent_acc"));
    objdb.setNet_weight(request.getParameter("net_weight_acc"));
    objex.Update_Acc(objdb);
    out.print("ทำการบันทึกสำเร็จ");
%>
