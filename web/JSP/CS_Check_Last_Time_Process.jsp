<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="com.cgc.Util.Display_Document_Status"%>
<%@page import="com.cgc.bean.DataBean_Display_Document_Status"%>
<%@page isThreadSafe="false"%>
<%
    DataBean_Display_Document_Status obj_record = new DataBean_Display_Document_Status();
    Display_Document_Status r_c = new Display_Document_Status();
    int statusck = 0;
    String Sql_Str = "", Table_name = "";
    String runer_id = request.getParameter("runer_id");
    //System.out.println("runer_id = " + runer_id);
    if (runer_id != null) {

        if (runer_id.equals("1")) {
            Table_name = "tmp_stock_daily";
        } else if (runer_id.equals("2")) {
            Table_name = "tmp_stock_rawmat_friction_daily";
        }

        Sql_Str = "  select create_date as record_count From " + Table_name + " order by runno desc limit 1 ";

        statusck = 5;
        //System.out.println("runer_id <> null = " + runer_id);

        //System.out.println("Sql_Str  = " + Sql_Str);
        obj_record = r_c.Fn_Record_Count(obj_record, Sql_Str);
    }

    //System.out.println("statusck = " + statusck);
    switch (statusck) {

        case 5:
            out.print(obj_record.getRecord_count().equals(null) ? "กำลังประมวลผล ..." : obj_record.getRecord_count());
            //System.out.println("Record Count = " + obj_record.getRecord_count());
            break;
        default:
            out.print("No Statment");
            break;
    }

%>