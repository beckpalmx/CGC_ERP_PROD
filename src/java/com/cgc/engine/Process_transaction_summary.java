/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.engine;

import com.cgc.DB.Process_transactionDB;
import java.util.Random;

/**
 *
 * @author Beckpalmx No7
 */
public class Process_transaction_summary {

    /**
     * @param date_from
     * @param date_to
     * @param username
     * @param process_for
     * @return
     * @throws java.lang.Exception
     */
    public String main_check(String date_from, String date_to, String username, String process_for) throws Exception {
        StringBuilder String_return = new StringBuilder();
        // TODO code application logic here
        try {
            Random r = new Random();
            Process_transactionDB obj = new Process_transactionDB();
            String r_create = Long.toString(Math.abs(r.nextLong()), 36);
            //เรียกใช้งานให้ส่ง Parameter ตามนี้ obj.generater_transaction_process(date_from, date_to,process_id,table,doc_type); 
            switch (process_for) {
                case "RAWMAT":
                    System.out.println("Begin RAWMAT ");
                    obj.generater_transaction_process("24-12-2556", date_to, "PR_022", "vd_rawmatt_receive", "+", r_create, username);
                    obj.generater_transaction_process("24-12-2556", date_to, "PR_023", "vd_rawmatt_withdraw_detail", "-", r_create, username);
                    obj.generater_transaction_process("24-12-2556", date_to, "PR_025", "vd_carbon_friction_receive_detail_2", "+", r_create, username);
                    obj.generater_transaction_process("24-12-2556", date_to, "PR_057", "vd_rawmatt_bigbag_withdraw_detail", "-", r_create, username);
                    //obj.generater_transaction_process(date_from, date_to,"PR_115","vd_adjust_product_detail","*",r_create,username);
                    obj.generater_transaction_process(date_from, date_to, "PR_117", "vd_adjust_rawmat_detail", "*", r_create, username);
                    System.out.println("End RAWMAT ");
                    break;
                case "WAREHOUSE":
                    System.out.println("Begin WAREHOUSE ");
                    obj.generater_transaction_process("21-12-2556", date_to, "PR_029", "vd_carbon_burn_out_detail_wh_complete", "+", r_create, username);
                    obj.generater_transaction_process(date_from, date_to, "PR_034", "vd_carbon_withdraw_detail_wh", "-", r_create, username);
                    obj.generater_transaction_process(date_from, date_to, "PR_036", "vd_product_receive_detail_prod_wh_report", "+", r_create, username);
                    obj.generater_transaction_process(date_from, date_to, "PR_040", "vd_packing_product_detail_wh", "-", r_create, username);
                    obj.generater_transaction_process(date_from, date_to, "PR_041", "vd_packing_product_detail_prod_wh", "+", r_create, username);
                    obj.generater_transaction_process(date_from, date_to, "PR_042", "vd_requisition_product_detail_wh", "-", r_create, username);
                    obj.generater_transaction_process(date_from, date_to, "PR_114", "vd_carbon_return_detail_wh", "+", r_create, username);
                    obj.generater_transaction_process(date_from, date_to, "PR_115", "vd_adjust_product_detail", "*", r_create, username);
                    obj.generater_transaction_process(date_from, date_to, "PR_060", "vd_carbon_send_product_detail", "+", r_create, username);
                    System.out.println("End WAREHOUSE ");
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
        }
        //String_return.append(" ");
        System.out.println("END Transaction Process ... ");
        String_return.append("ประมวลผลเสร็จสิ้น");
        return String_return.toString();

    }
}
