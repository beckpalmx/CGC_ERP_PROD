/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.engine;

import com.cgc.DB.Process_transaction_friction_summaryDB_New;
//import java.util.Random;
import java.text.SimpleDateFormat;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.cgc.Util.System_Log;

public class Process_transaction_rawmat_friction_summary {

    /**
     * @param date_from
     * @param date_to
     * @param username
     * @param process_for
     * @param log_id
     * @return
     * @throws java.lang.Exception
     */
    System_Log Log = new System_Log();

    public String main_check(String date_from, String date_to, String username, String process_for, String log_id) throws Exception {
        StringBuilder String_return = new StringBuilder();
        String Time_Loop;
        Calendar calendar1 = Calendar.getInstance();
        Calendar calendar2 = Calendar.getInstance();
        System.out.println("A date_from = " + date_from);
        System.out.println("A date_to = " + date_to);
        int day_f = Integer.parseInt(date_from.substring(0, 2));
        int month_f = Integer.parseInt(date_from.substring(3, 5));
        int year_f = Integer.parseInt(date_from.substring(6, 10)) - 543;

        int day_t = Integer.parseInt(date_to.substring(0, 2));
        int month_t = Integer.parseInt(date_to.substring(3, 5));
        int year_t = Integer.parseInt(date_to.substring(6, 10)) - 543;

        calendar1.set(year_f, month_f, day_f);
        calendar2.set(year_t, month_t, day_t);

        long milsecs1 = calendar1.getTimeInMillis();
        long milsecs2 = calendar2.getTimeInMillis();
        long diff_1 = milsecs2 - milsecs1;

        long dsecs = diff_1 / 1000;
        //long dminutes = diff_1 / (60 * 1000);
        //long dhours = diff_1 / (60 * 60 * 1000);
        long ddays = diff_1 / (24 * 60 * 60 * 1000);

        System.out.println("Your Day Difference=" + dsecs);

        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy h:mm:ss");

        Timestamp cur_time = new Timestamp(new java.util.Date().getTime());
        String Sql_Ins = "insert into t_process_log_stock (log_id,process_id,start_time,end_time,create_date,create_by) "
                + "values ('" + log_id + "','" + process_for + "','" + cur_time + "','" + cur_time + "','" + cur_time + "','" + username + "')";

        System.out.println("Sql_Ins = " + Sql_Ins);

        Log.WriteTimeStamp(Sql_Ins);
        String start_time = sdf.format(cur_time);

        try {
            //Random r = new Random();
            //String log_id = Long.toString(Math.abs(r.nextLong()), 36);
            //เรียกใช้งานให้ส่ง Parameter ตามนี้ obj.generater_transaction_process(Time_Loop,date_from, date_to,process_id,table,doc_type); 

            System.out.println("Begin WAREHOUSE ");

            if (ddays >= 17) {
                startProcess("1", date_from, "02-" + date_to.substring(3, 10), log_id, username);
                startProcess("2", "03-" + date_to.substring(3, 10), "04-" + date_to.substring(3, 10), log_id, username);
                startProcess("3", "05-" + date_to.substring(3, 10), "06-" + date_to.substring(3, 10), log_id, username);
                startProcess("4", "07-" + date_to.substring(3, 10), "08-" + date_to.substring(3, 10), log_id, username);
                startProcess("5", "09-" + date_to.substring(3, 10), "10-" + date_to.substring(3, 10), log_id, username);
                startProcess("6", "11-" + date_to.substring(3, 10), "12-" + date_to.substring(3, 10), log_id, username);
                startProcess("7", "13-" + date_to.substring(3, 10), "14-" + date_to.substring(3, 10), log_id, username);
                startProcess("8", "15-" + date_to.substring(3, 10), "16-" + date_to.substring(3, 10), log_id, username);
                startProcess("9", "17-" + date_to.substring(3, 10), "18-" + date_to.substring(3, 10), log_id, username);
                startProcess("10", "19-" + date_to.substring(3, 10), "20-" + date_to.substring(3, 10), log_id, username);
                startProcess("11", "21-" + date_to.substring(3, 10), "22-" + date_to.substring(3, 10), log_id, username);
                startProcess("12", "23-" + date_to.substring(3, 10), "24-" + date_to.substring(3, 10), log_id, username);
                startProcess("13", "25-" + date_to.substring(3, 10), "26-" + date_to.substring(3, 10), log_id, username);
                startProcess("14", "27-" + date_to.substring(3, 10), "27-" + date_to.substring(3, 10), log_id, username);
                startProcess("15", "28-" + date_to.substring(3, 10), date_to, log_id, username);

            } else {
                System.out.println("Loop ddays < 15 ");
                System.out.println("ddays < 15 date_from = " + date_from);
                System.out.println("ddays < 15 date_to = " + date_to);
                Time_Loop = "1";
                startProcess(Time_Loop, date_from, date_to, log_id, username);
            }
            System.out.println("End WAREHOUSE ");

        } catch (Exception e) {
            e.printStackTrace(System.out);
        }
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
        System.out.println("Start Transaction Process ... " + start_time + '\n');
        System.out.println("End Transaction Process ... " + stop_time + '\n');
        String_return.append("ระบบกำลังประมวลผล กรุณารอสักครู่ ... " + '\n');
        return String_return.toString();
    }

    public void startProcess(final String Time_Loop, final String date_from_send, final String date_to_send, final String log_id, final String username) throws Exception {

        Runnable runnable;
        runnable = new Runnable() {

            @Override
            public void run() {
                try {
                    try {
                        try {
                            Thread.sleep(0);
                        } catch (InterruptedException e) {
                            System.out.println("Info : " + e);
                        }
                        Process_transaction_friction_summaryDB_New obj = new Process_transaction_friction_summaryDB_New();
                        System.out.println("startProcess ... " + Time_Loop + " date_from_send = " + date_from_send + " date_to_send = " + date_to_send);
                        obj.generater_transaction_process(Time_Loop, date_from_send, date_to_send, "PR_RAWMAT_STOCK_VALUE", "vt_transaction_stock_process_report_raw_friction", "*", log_id, username);
                    } catch (Exception ex) {
                        Logger.getLogger(Process_transaction_wh_summary.class.getName()).log(Level.SEVERE, null, ex);
                    }

                    System.out.println("Final OK");
                    Timestamp cur_time2 = new Timestamp(new java.util.Date().getTime());
                    String Sql_Update = "Update t_process_log_stock set end_time = '" + cur_time2 + "',update_date = '" + cur_time2 + "',update_by = '" + username + "' where log_id = '" + log_id + "'";
                    Log.WriteTimeStamp(Sql_Update);

                } catch (Exception ex) {
                    Logger.getLogger(Process_transaction_rawmat_friction_summary.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        };
        new Thread(runnable).start();
    }

}
