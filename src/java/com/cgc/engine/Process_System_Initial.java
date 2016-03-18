/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.engine;

import com.cgc.DB.Process_System_Initial_DB;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Random;

/**
 *
 * @author beck
 */
public class Process_System_Initial {

    /**
     * @param date_from
     * @param date_to
     * @return
     * @throws java.lang.Exception
     */
    public String main_check(String date_from, String date_to) throws Exception {
        StringBuilder String_return = new StringBuilder();
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy h:mm:ss");
        Timestamp cur_time = new Timestamp(new java.util.Date().getTime());
        String start_time = sdf.format(cur_time);

        // TODO code application logic here
        try {
            Random r = new Random();
            Process_System_Initial_DB obj = new Process_System_Initial_DB();
            String r_create = Long.toString(Math.abs(r.nextLong()), 36);
            //เรียกใช้งานให้ส่ง Parameter ตามนี้ obj.generater_transaction_process(job_id);             
            obj.generater_transaction_process(date_from, date_to);

        } catch (Exception e) {
            e.printStackTrace(System.out);
        }

        Timestamp cur_time2 = new Timestamp(new java.util.Date().getTime());
        String stop_time = sdf.format(cur_time2);
        System.out.println("END Transaction Process ... " + '\n');
        String_return.append("ประมวลผลเสร็จสิ้น " + '\n');
        StringBuilder append = String_return.append("เริ่มประมวลผลเวลา : ").append(start_time).append('\n');
        StringBuilder append1 = String_return.append("เสร็จสิ้นเวลา :           ").append(stop_time);

        return String_return.toString();

    }
}
