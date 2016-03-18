/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.engine;

import com.cgc.DB.DBConnect;
import com.cgc.DB.IMP_Process_transactionDB;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Random;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Date;

/**
 *
 * @author Beckpalmx No7
 */
public class IMP_Process_transaction {

    /**
     * @param doc_date_from
     * @param doc_date_to
     * @param username
     * @param process_for
     * @return
     * @throws java.lang.Exception
     */
    public String main_check(String doc_date_from, String doc_date_to, String username, String process_for) throws Exception {
        StringBuilder String_return;
        try (Connection Conn = new DBConnect().openNewConnection()) {
            String_return = new StringBuilder();
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy h:mm:ss");
            Timestamp cur_time = new Timestamp(new java.util.Date().getTime());
            String start_time = sdf.format(cur_time);
            try {

                IMP_Process_transactionDB obj = new IMP_Process_transactionDB();
                Random r = new Random();
                String r_create = Long.toString(Math.abs(r.nextLong()), 36);

                //เรียกใช้งานให้ส่ง Parameter ตามนี้ obj.generater_transaction_process(date_from, date_to,process_id,table,doc_type);
                
                String Table = "";
                if (process_for.equals("CARBON")) {
                    Table = "d_ticketbuy_carbon_doc";
                } else {
                    Table = "d_ticketbuy_doc";
                }

                obj.generater_transaction_process(doc_date_from, doc_date_to, process_for, Table, "+", r_create, username);

                //}
                Timestamp cur_time2 = new Timestamp(new java.util.Date().getTime());
                String stop_time = sdf.format(cur_time2);

                Date d1 = sdf.parse(start_time);
                Date d2 = sdf.parse(stop_time);

                long diff = d2.getTime() - d1.getTime();
                long diffSeconds = diff / 1000 % 60;
                long diffMinutes = diff / (60 * 1000) % 60;
                long diffHours = diff / (60 * 60 * 1000) % 24;
                //long diffDays = diff / (24 * 60 * 60 * 1000);

                System.out.println("END Transaction Process ... " + '\n');
                String_return.append("ประมวลผลเสร็จสิ้น " + '\n');
                String_return.append("เริ่มประมวลผลเวลา : ").append(start_time).append('\n');
                String_return.append("เสร็จสิ้นเวลา :           ").append(stop_time).append('\n');
                String_return.append("ใช้เวลาทั้งสิ้น (ช.ม.:นาที:วินาที) : ").append((String.format("%02d", diffHours) + ":" + String.format("%02d", diffMinutes) + ":" + String.format("%02d", diffSeconds)));

                String Insert_Log = "insert into t_process_log (log_id,process_id,start_time,end_time,create_date,create_by,complete_flag) values (?,?,?,?,?,?,?) ";

                PreparedStatement p_log;
                p_log = Conn.prepareStatement(Insert_Log);
                p_log.setString(1, r_create);
                p_log.setString(2, "Import Weight : " + process_for);
                p_log.setTimestamp(3, cur_time);
                p_log.setTimestamp(4, cur_time2);
                p_log.setTimestamp(5, cur_time2);
                p_log.setString(6, username);
                p_log.setString(7, "Y");
                p_log.executeUpdate();

            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        //String_return.append(" ");
        //System.out.println("END Transaction Process ... ");
        //String_return.append("ประมวลผลเสร็จสิ้น");
        return String_return.toString();

    }
}
