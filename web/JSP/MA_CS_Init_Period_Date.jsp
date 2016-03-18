<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="com.cgc.Util.Display_Document_Status"%>
<%@page import="com.cgc.bean.DataBean_Display_Document_Status"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.cgc.Util.Last_Date"%>


<%@page isThreadSafe="false"%>
<%
    Last_Date lastdate = new Last_Date();
    int statusck = 0;

    String runer_id = request.getParameter("runer_id");
    System.out.println("Before runer_id = " + runer_id);

    int y = 9999;
    String end_month = "", start_month = "";

    if (runer_id.indexOf(':') != -1) {
        String[] parts = runer_id.split(":");
        String year = Integer.toString(Integer.parseInt(parts[0])-543);
        String month = parts[1];
        System.out.println("Split year = " + year);
        String smonth = (Integer.parseInt(month) >= 10 ? month : "0" + month);
        end_month = Integer.toString(lastdate.LastDate(Integer.parseInt(month), Integer.parseInt(year))) + "-" + smonth + "-" + parts[0];
        statusck = 2;
    } else {
        String[] parts = runer_id.split(";");
        String year = parts[0];
        String month = parts[1];
        String smonth = (Integer.parseInt(month) >= 10 ? month : "0" + month);
        start_month = "01" + "-" + smonth + "-" + year;
        statusck = 1;
    }

    switch (statusck) {
        case 1:
            out.print(start_month);
            break;
        case 2:
            out.print(end_month);
            break;
        default:
            out.print("No Statment");
            break;
    }

%>