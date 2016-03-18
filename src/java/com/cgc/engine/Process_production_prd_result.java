/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.engine;

import com.cgc.DB.Process_production_result_DB;
import com.cgc.DB.Process_production_detail_track_process_DB;
import com.cgc.DB.Process_production_detail_withdraw_edit_track_process_DB;
import com.cgc.DB.Process_production_detail_product_edit_track_process_DB;
import com.cgc.DB.Process_production_detail_track_withdraw_all_process_DB;
import com.cgc.DB.Process_production_detail_all_track_process_DB;

//import java.util.Random;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Beckpalmx No7
 */
public class Process_production_prd_result {

    /**
     * @param args the command line arguments
     */
    public String main_check(String job_id, String user_login) throws Exception {
        StringBuffer String_return = new StringBuffer();
        // TODO code application logic here
        try {

            //Random r = new Random();
            //String r_create = Long.toString(Math.abs(r.nextLong()), 36);
            //java.util.Date date = new java.util.Date();
            //Timestamp ts = new Timestamp(date.getTime());
            
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy h:mm:ss");
            Timestamp cur_time = new Timestamp(new java.util.Date().getTime());
            String ts = sdf.format(cur_time);
            //String var = "100";            
            System.out.println("ts = " + ts);            
//***** Define Object For Process             

            Process_production_result_DB obj = new Process_production_result_DB();

            Process_production_detail_track_process_DB obj_track_product = new Process_production_detail_track_process_DB();
            Process_production_detail_withdraw_edit_track_process_DB obj_track_withdraw_edit_product = new Process_production_detail_withdraw_edit_track_process_DB();
            Process_production_detail_product_edit_track_process_DB obj_track_product_edit_product = new Process_production_detail_product_edit_track_process_DB();

            Process_production_detail_track_withdraw_all_process_DB obj_track_withdraw_all_process = new Process_production_detail_track_withdraw_all_process_DB();
            Process_production_detail_all_track_process_DB obj_track_product_all_process = new Process_production_detail_all_track_process_DB();

//      Define Object For Process *****//            
            
            
            
            //เรียกใช้งานให้ส่ง Parameter ตามนี้ obj.generater_transaction_process(job_id,user_login, cur_time);             
            //Process ใบสรุปการผลิต
            obj.generater_transaction_process(job_id, user_login, cur_time);
            System.out.println("End First Process");

            //Process งานได้ตามเครื่องจักรและกระบวนการ DocType = '1'
            obj_track_product.generater_transaction_process(job_id, user_login, cur_time);            
            System.out.println("End Second Process");
            
            //Process การเบิกแก้ไข ตามเครื่องจักรและกระบวนการ Doc_Type = '2'
            obj_track_withdraw_edit_product.generater_transaction_process(job_id, user_login, cur_time);
            System.out.println("End Third Process");
            
            //Process งานได้จากการแก้ไข ตามเครื่องจักรและกระบวนการ Doc_Type = '3'
            obj_track_product_edit_product.generater_transaction_process(job_id, user_login, cur_time);
            System.out.println("End Fourth Process");
            
            //Process สรุปการเบิก ตามเครื่องจักรและกระบวนการ Doc_Type = '1'
            obj_track_withdraw_all_process.generater_transaction_process(job_id, user_login, cur_time);
            System.out.println("End Fifth Process");
            
            //Process งานได้ ตามเครื่องจักรและกระบวนการ Doc_Type = '2'
            obj_track_product_all_process.generater_transaction_process(job_id, user_login, cur_time);
            System.out.println("End Sixth Process");
            System.out.println("**************************");
            System.out.println("End All Process");
            
            Timestamp cur_time2 = new Timestamp(new java.util.Date().getTime());
            String ts2 = sdf.format(cur_time2);

            String_return.append("ประมวลผลเสร็จสิ้น " + '\n');
            String_return.append("เริ่มประมวลผลเวลา : " + ts + '\n');
            String_return.append("เสร็จสิ้นเวลา :           " + ts2);

        } catch (Exception e) {
            e.printStackTrace(System.out);
        }
        //String_return.append(" ");
        //String_return.append("ประมวลผลเสร็จสิ้น");
        return String_return.toString();

    }
}
