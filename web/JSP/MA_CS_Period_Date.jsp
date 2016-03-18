<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="com.cgc.Util.Display_Document_Status"%>
<%@page import="com.cgc.bean.DataBean_Display_Document_Status"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>


<%@page isThreadSafe="false"%>
<%
    DataBean_Display_Document_Status obj_record = new DataBean_Display_Document_Status();
    Display_Document_Status r_c = new Display_Document_Status();
    Connection con = new DBConnect().openNewConnection();
    int statusck = 0;
    String Sql_Str = "";
    String runer_id = request.getParameter("runer_id");
    //System.out.println("runer_id = " + runer_id);

    ResultSet rs = null;
    String year = "", start_month = "", end_month = "";

    if (runer_id.equals("99")) {
        String SQL_Period = "select year from mmonth where runno = 1";
        rs = con.createStatement().executeQuery(SQL_Period);
        while (rs.next()) {
            year = rs.getString("year");
        }
        statusck = 99;
    }

    if (Integer.parseInt(runer_id) > 0 && Integer.parseInt(runer_id) < 13) {
        String SQL_Start_Month = "select start_date from mmonth where runno = " + Integer.parseInt(runer_id);
        rs = con.createStatement().executeQuery(SQL_Start_Month);
        while (rs.next()) {
            start_month = rs.getString("start_date");
        }
        statusck = 1;
    }

    if (Integer.parseInt(runer_id) > 12 && Integer.parseInt(runer_id) < 25) {
        String SQL_End_Month = "select end_date from mmonth where runno = " + (Integer.parseInt(runer_id) - 12);
        //System.out.println("SQL_End_Month = " + SQL_End_Month);
        rs = con.createStatement().executeQuery(SQL_End_Month);
        while (rs.next()) {
            end_month = rs.getString("end_date");
            //System.out.println("end_month" + end_month);
        }
        statusck = 2;
    }

    if (con != null) {
        con.close();
    }

    //System.out.println("runer_id = " + runer_id);
    //System.out.println("statusck = " + statusck);
    switch (statusck) {
        case 99:
            out.print(year);
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