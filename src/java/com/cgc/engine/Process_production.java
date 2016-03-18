/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.engine;

import com.cgc.DB.Process_productionDB;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Random;

/**
 *
 * @author Beckpalmx No7
 */
public class Process_production {

    /**
     * @param args the command line arguments
     */
    public String main_check(String job_id) throws Exception {
        StringBuffer String_return = new StringBuffer();
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy h:mm:ss");
        Timestamp cur_time = new Timestamp(new java.util.Date().getTime());
        String start_time = sdf.format(cur_time);        
        
        // TODO code application logic here
        try {
            Random r = new Random();
            Process_productionDB obj = new Process_productionDB();
            String r_create = Long.toString(Math.abs(r.nextLong()), 36);
            //เรียกใช้งานให้ส่ง Parameter ตามนี้ obj.generater_transaction_process(job_id);             
            obj.generater_transaction_process(job_id);            
            
        } catch (Exception e) {
            e.printStackTrace(System.out);
        }
        
        Timestamp cur_time2 = new Timestamp(new java.util.Date().getTime());
        String stop_time = sdf.format(cur_time2);        
        System.out.println("END Transaction Process ... " + '\n');
        String_return.append("ประมวลผลเสร็จสิ้น " + '\n');
        String_return.append("เริ่มประมวลผลเวลา : " + start_time + '\n');
        String_return.append("เสร็จสิ้นเวลา :           " + stop_time);        

        return String_return.toString();

    }
}
