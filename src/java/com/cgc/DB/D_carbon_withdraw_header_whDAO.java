/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_carbon_withdraw_header;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Beck
 */
public class D_carbon_withdraw_header_whDAO {

    private int Returnvalue;

    public int insert(DataBeanD_carbon_withdraw_header dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_carbon_withdraw_header_wh (doc_id,wh_in,wh_out,doc_date,doc_time,work_type,prd_emp_id,wh_emp_id,wh_sup_id,create_date,update_date,create_by) values(?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getWh_in());
            p.setString(3, dataBean.getWh_out());
            p.setString(4, dataBean.getDoc_date());
            p.setString(5, dataBean.getDoc_time());
            p.setString(6, dataBean.getWork_type());
            p.setString(7, dataBean.getPrd_emp_id());
            p.setString(8, dataBean.getWh_emp_id());
            p.setString(9, dataBean.getWh_sup_id());
            p.setTimestamp(10, dataBean.getDate());
            p.setTimestamp(11, dataBean.getDate());
            p.setString(12, dataBean.getBy());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_carbon_withdraw_detail_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_carbon_withdraw_detail_wh set doc_date=?,create_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;

                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getBy());
                p.setString(3, dataBean.getDoc_id());
                p.executeUpdate();
            }
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_carbon_withdraw_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql =
                "update d_carbon_withdraw_header_wh set  wh_in=?,wh_out=?,doc_date=?,doc_time=?,work_type=?,prd_emp_id=?,wh_emp_id=?,wh_sup_id=?,update_date=?,update_by=?,doc_type=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            if (dataBean.getComplete_flag().equalsIgnoreCase("N")) {
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getWh_in());
                p.setString(2, dataBean.getWh_out());
                p.setString(3, dataBean.getDoc_date());
                p.setString(4, dataBean.getDoc_time());
                p.setString(5, dataBean.getWork_type());
                p.setString(6, dataBean.getPrd_emp_id());
                p.setString(7, dataBean.getWh_emp_id());
                p.setString(8, dataBean.getWh_sup_id());
                p.setTimestamp(9, dataBean.getDate());
                p.setString(10, dataBean.getBy());
                p.setString(11, dataBean.getDoc_type());
                p.setString(12, dataBean.getDoc_id());
                Returnvalue = p.executeUpdate();
                sql = "select count(doc_id) as num from d_carbon_withdraw_detail_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

                if (objuti.numRowdatabase(sql) != 0) {
                    sql = "update d_carbon_withdraw_detail_wh set doc_date=?,update_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    p = null;

                    p = con.prepareStatement(sql);
                    p.setString(1, dataBean.getDoc_date());
                    p.setString(2, dataBean.getBy());
                    p.setString(3, dataBean.getDoc_id());
                    p.executeUpdate();
                }
            } else {
                Returnvalue = Return_Document("d_carbon_withdraw", dataBean.getDoc_id(), con, p, objuti);
            }

        } finally {
            try {
                if(p != null){
                    p.close();
                }
                if(con != null){
                    con.close();
                }
                
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public void UpDel(DataBeanD_carbon_withdraw_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_carbon_withdraw_header_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? ";
        String sqldetail = "update d_carbon_withdraw_detail_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=?";
        PreparedStatement p = null;
        try {
            for (int i = 0; i < 2; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else {
                    p = con.prepareStatement(sqldetail);
                }
                p.setString(1, "Y");
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }

    }

    public int Return_Document(String Table_name, String doc_id, Connection con, PreparedStatement p, UtiDatabase Objuti) throws Exception {
        String SQLDetail = "";
        int status_return = 0;
        try {
            //SQLHeader = "Select count(doc_id) as num from "+Table_name+"_header_wh where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'Y'";
            SQLDetail = "Select count(doc_id) as num from " + Table_name + "_detail_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'";
            if (Objuti.numRowdatabase(SQLDetail) == 0) {
                //***************Delete Warehouse********************************
                p = con.prepareStatement("DELETE FROM " + Table_name + "_header_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'N'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("DELETE FROM " + Table_name + "_detail_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'N'");
                p.executeUpdate();
                p.clearParameters();
                //***************************************************************
                p.clearParameters();
                //**************return Complet_flag *****************************
                p = con.prepareStatement("UPDATE " + Table_name + "_header set complete_flag = 'N' WHERE doc_id ='" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("UPDATE " + Table_name + "_detail set complete_flag = 'N' WHERE doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                p.clearParameters();
                //***************************************************************
                status_return = 1;
            } else {
                status_return = -1;
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            return status_return;
        }
    }
}
