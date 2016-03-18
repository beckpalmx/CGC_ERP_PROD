/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_product_receive_header;
import com.cgc.bean.DataBeanD_transaction_product_receive;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Beckpalmx No7
 */
public class Process_productionDB {

    public void generater_transaction_process(String job_id) throws Exception {

        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ArrayList<DataBeanD_transaction_product_receive> obj_AL = new ArrayList<DataBeanD_transaction_product_receive>();
        D_transaction_product_receiveDAO obj_tran = new D_transaction_product_receiveDAO();
        PreparedStatement p = null;
        try {
            // 01-09-2014 Check // 
            obj_AL = obj_tran.Select_Mem_AL(obj_AL, con, "d_product_receive_detail", job_id);
            obj_AL = obj_tran.Select_Mem_AL(obj_AL, con, "d_product_receive_detail_prod", job_id);
            obj_tran.main(obj_AL, con, p);

        } finally {
            try {
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

    }
}
