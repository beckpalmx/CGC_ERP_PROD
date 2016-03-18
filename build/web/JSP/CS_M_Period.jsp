<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="com.cgc.DB.M_PeriodDAO"%>
<%@page import="com.cgc.bean.DataBeanM_Period"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>

<%@page isThreadSafe="false"%>
<%  
    ThaiUtil en = new ThaiUtil();
    DataBeanM_Period objdb = new DataBeanM_Period();
    M_PeriodDAO objex = new M_PeriodDAO();
    int statusck = 0;
    int statusnum = 0;

    for (int month = 1; month <= 12; month++) {
        String start_date = "A_start_month_" + month;
        String end_date = "A_end_month_" + month;

        //System.out.println("start_date = " + request.getParameter(start_date) + " : end_date = " + request.getParameter(end_date));

        objdb.setYear_period(request.getParameter("A_period_year") == null ? "" : en.EncodeTexttoTIS(request.getParameter("A_period_year")));
        objdb.setStart_date(request.getParameter(start_date) == null ? "" : en.EncodeTexttoTIS(request.getParameter(start_date)));
        objdb.setEnd_date(request.getParameter(end_date) == null ? "" : en.EncodeTexttoTIS(request.getParameter(end_date)));
        objdb.setRemark(request.getParameter("remark") == null ? "" : en.EncodeTexttoTIS(request.getParameter("remark")));
        objdb.setRunno(month);
        //System.out.println("statusck = " + statusck);
        objex.update(objdb);
        statusnum = 1;
    }
    
    if (statusnum == 1) {
        statusck = 2;
    }

    switch (statusck) {
        case 2:
            out.print("แก้ไขสำเร็จ");
            break;
        default:
            out.print("No Statment");
            break;
    }

%>
