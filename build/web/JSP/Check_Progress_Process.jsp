<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.cgc.Util.Display_Document_Status"%>
<%@page import="com.cgc.Util.Process_Progress_Stock"%>
<%@page import="com.cgc.bean.DataBean_Display_Document_Status"%>
<%@page isThreadSafe="false"%>
<%

    String runer_id = request.getParameter("runer_id");
    int statusck = 0;
    String Sql_Str;
    String chk_cond;
    String Return_Value = "";

    String table_name = "t_process_log_transaction";
    String start_time, end_time, time_process = "";
    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy h:mm:ss");

    if (runer_id != null) {

        String[] parts = runer_id.split("-");
        runer_id = parts[0];
        String process_for = parts[1];

        Sql_Str = " select * from " + table_name + " where log_id = " + runer_id;

        //System.out.println("Sql_Str = " + Sql_Str);

        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs;

        try {
            rs = con.createStatement().executeQuery(Sql_Str);
            while (rs.next()) {

                chk_cond = rs.getString("remark");
                start_time = sdf.format(rs.getTimestamp("start_time"));
                end_time = sdf.format(rs.getTimestamp("end_time"));
                //System.out.println("chk_cond = " + chk_cond);
                //System.out.println("start_time = " + start_time);
                //System.out.println("end_time = " + end_time);

                //System.out.println("start_time = " + rs.getTimestamp("start_time"));
                //System.out.println("end_time = " + rs.getTimestamp("end_time"));
                Date d1 = sdf.parse(start_time);
                Date d2 = sdf.parse(end_time);
                long diff = d2.getTime() - d1.getTime();
                long diffSeconds = diff / 1000 % 60;
                long diffMinutes = diff / (60 * 1000) % 60;
                long diffHours = diff / (60 * 60 * 1000) % 24;
                long add_minutes = (diff / (60 * 1000) % 60) + 1;

                if (chk_cond.equalsIgnoreCase("FINISH")) {
                    time_process = String.format("%02d", diffHours) + ":" + String.format("%02d", diffMinutes) + ":" + String.format("%02d", diffSeconds);
                    Return_Value = " \nเริ่มต้นประมวลผลเวลา " + start_time
                            + " \nเสร็จสิ้นเวลา " + end_time
                            + " \nใช้เวลาประมวลผล = " + time_process;
                } else {
                    Return_Value = "ระบบกำลังประมวลผล กรุณารอสักครู่ ...";
                }

                //System.out.println("Return_Value = " + Return_Value);
                
                statusck = 5;

            }
        } finally {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }       

    }

    switch (statusck) {

        case 5:

            out.print(Return_Value);

            break;
        default:
            out.print("No Statment");
            break;
    }

%>