/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBean_Return_Doc;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author com02
 */
public class Return_Doc_DAO {

    public void update(DataBean_Return_Doc Return_Doc_Bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql;
        String doc_id = Return_Doc_Bean.getDoc_id();

        //if (Return_Doc_Bean.getProcess_id().equalsIgnoreCase("PR_040") || Return_Doc_Bean.getProcess_id().equalsIgnoreCase("PR_057")) {
        if (Return_Doc_Bean.getProcess_id().equalsIgnoreCase("PR_040")) {
            sql = " UPDATE " + Return_Doc_Bean.getTable_header() + " SET complete_flag='N' where doc_id = '" + doc_id + "' ; "
                    + " UPDATE " + Return_Doc_Bean.getTable_detail1() + " SET complete_flag='N' where doc_id = '" + doc_id + "' ; "
                    + " UPDATE " + Return_Doc_Bean.getTable_detail2() + " SET complete_flag='N' where doc_id = '" + doc_id + "' ; ";
        } else if (Return_Doc_Bean.getProcess_id().equalsIgnoreCase("PR_025")) {
            sql = "UPDATE " + Return_Doc_Bean.getTable_header() + " SET complete_flag='N' where doc_id = '" + doc_id + "' ; "
                    + " UPDATE " + Return_Doc_Bean.getTable_detail1() + " SET complete_flag='N' where doc_id = '" + doc_id + "' ; "                    
                    + " UPDATE " + Return_Doc_Bean.getTable_detail2() + " SET complete_flag='N' where doc_id = '" + doc_id + "' ; "            
                    + " UPDATE " + Return_Doc_Bean.getTable_detail3() + " SET complete_flag='N' where doc_id = '" + doc_id + "' ; ";                        
        } else if (Return_Doc_Bean.getProcess_id().equalsIgnoreCase("PR_060")) {
            sql = "UPDATE " + Return_Doc_Bean.getTable_header() + " SET complete_flag='N' , wh_leader_confirm='N' where doc_id = '" + doc_id + "' ; "
                    + " UPDATE " + Return_Doc_Bean.getTable_detail1() + " SET complete_flag='N' where doc_id = '" + doc_id + "' ; ";
        } else {
            sql = "UPDATE " + Return_Doc_Bean.getTable_header() + " SET complete_flag='N' where doc_id = '" + doc_id + "' ; "
                    + " UPDATE " + Return_Doc_Bean.getTable_detail1() + " SET complete_flag='N' where doc_id = '" + doc_id + "' ; ";
        }

        System.out.println("getProcess_id = " + Return_Doc_Bean.getProcess_id());
        System.out.println("getTable_header = " + Return_Doc_Bean.getTable_header());
        System.out.println("getTable_detail1 = " + Return_Doc_Bean.getTable_detail1());
        System.out.println("getTable_detail2 = " + Return_Doc_Bean.getTable_detail2());
        System.out.println("getTable_detail3 = " + Return_Doc_Bean.getTable_detail3());

        System.out.println("sql = " + sql);

        PreparedStatement p;

        try {
            p = con.prepareStatement(sql);
            p.executeUpdate();
        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
    }
}
