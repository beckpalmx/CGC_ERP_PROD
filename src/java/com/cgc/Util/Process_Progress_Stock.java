package com.cgc.Util;

import com.cgc.DB.DBConnect;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Process_Progress_Stock {

    public String Check_Process(String table_name, Double percent_complete, int record_complete, int count_day, String log_id) throws Exception {
        //String SQL = " select max(create_date) as end_date,min(create_date) as start_date from " + table_name;
        String SQL = " select end_time as end_date,start_time as start_date from " + table_name + " where log_id = " + log_id;
        //System.out.println("SQL = " + SQL) ;
        String Return_Value = "";
        DecimalFormat formatter = new DecimalFormat("#0");
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs;
        String process_wait;
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy h:mm:ss");
        Timestamp st_time;
        Timestamp en_time;
        //Timestamp cur_time2 = new Timestamp(new java.util.Date().getTime());
        String start_time, end_time, time_process = "";
        //String start_time = sdf.format(st_time);

        //System.out.println("percent_complete = " + percent_complete);
        try {
            if (percent_complete >= 100) {
                process_wait = "";
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    //System.out.println("Record Found = " + rs.getTimestamp("start_date"));
                    start_time = sdf.format(rs.getTimestamp("start_date"));
                    end_time = sdf.format(rs.getTimestamp("end_date"));

                    Date d1 = sdf.parse(start_time);
                    Date d2 = sdf.parse(end_time);

                    long diff = d2.getTime() - d1.getTime();
                    long diffSeconds = diff / 1000 % 60;
                    long diffMinutes = diff / (60 * 1000) % 60;
                    long diffHours = diff / (60 * 60 * 1000) % 24;

                    long add_minutes = (diff / (60 * 1000) % 60) + 1;

                    time_process = String.format("%02d", diffHours) + ":" + String.format("%02d", diffMinutes) + ":" + String.format("%02d", diffSeconds);
                    time_process = " \nเริ่มต้นประมวลผลเวลา " + start_time
                            + " \nเสร็จสิ้นเวลา " + end_time
                            + " \nใช้เวลาประมวลผล = " + time_process;
                }
            } else {
                process_wait = "ระบบกำลังประมวลผล กรุณารอสักครู่ ...";
            }
            String str_complete1 = " \nประมวลผลเสร็จสิ้นแล้วจำนวน " + record_complete + " วัน ";
            String str_complete2 = " จากทั้งหมด " + count_day + " วัน ";
            String str_complete3 = " \nคิดเป็นเปอร์เซ็นต์ = " + formatter.format(percent_complete) + " % ";
            Return_Value = process_wait + str_complete1 + str_complete2 + str_complete3 + time_process;

        } finally {
            try {
                //rs.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return Return_Value;

    }
}
