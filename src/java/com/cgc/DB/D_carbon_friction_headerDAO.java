/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanD_carbon_friction_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Administrator
 */
public class D_carbon_friction_headerDAO {

    public void insert(DataBeanD_carbon_friction_header DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        String SQL;
        int i = 1;
        try {
            SQL = "INSERT INTO d_carbon_friction_header(doc_id,doc_date,doc_time,shift,report_id,create_by,create_date,update_date,remark) "
                    + "VALUES(?,?,?,?,?,?,?,?,?)";
            p = con.prepareStatement(SQL);
            p.setString(i, DataBean.getDoc_id());
            i += 1;
            p.setString(i, DataBean.getDoc_date());
            i += 1;
            p.setString(i, DataBean.getDoc_time());
            i += 1;
            p.setString(i, DataBean.getShift());
            i += 1;
            p.setString(i, DataBean.getReport_id());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getRemark());
            i += 1;
            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
    }

    public void update(DataBeanD_carbon_friction_header DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        String SQL, SQL1;
        int i = 1;
        try {
            SQL = "UPDATE d_carbon_friction_header SET "
                    + "report_id = ?,update_by=?,update_date=?,complete_flag=?,remark=?"
                    + " WHERE doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
            p = con.prepareStatement(SQL);
            p.setString(i, DataBean.getReport_id());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getComplete_flag());
            i += 1;
            p.setString(i, DataBean.getRemark());
            i += 1;
            p.executeUpdate();
            p.clearParameters();

            System.out.println("Complete Flag = " + DataBean.getComplete_flag());

            if (DataBean.getComplete_flag().equals("Y")) {

                SQL1 = "UPDATE d_carbon_friction_withdraw_detail SET "
                        + "update_by=?,update_date=?,complete_flag=?"
                        + " WHERE doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                p = con.prepareStatement(SQL1);
                p.setString(1, DataBean.getBy());
                p.setTimestamp(2, DataBean.getDate());
                p.setString(3, DataBean.getComplete_flag());
                p.executeUpdate();
                p.clearParameters();
                SQL1 = "UPDATE d_carbon_friction_receive_detail_1 SET "
                        + "update_by=?,update_date=?,complete_flag=?"
                        + " WHERE doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                p = con.prepareStatement(SQL1);
                p.setString(1, DataBean.getBy());
                p.setTimestamp(2, DataBean.getDate());
                p.setString(3, DataBean.getComplete_flag());
                p.executeUpdate();
                p.clearParameters();
                SQL1 = "UPDATE d_carbon_friction_receive_detail_2 SET "
                        + "update_by=?,update_date=?,complete_flag=?"
                        + " WHERE doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                p = con.prepareStatement(SQL1);
                p.setString(1, DataBean.getBy());
                p.setTimestamp(2, DataBean.getDate());
                p.setString(3, DataBean.getComplete_flag());
                p.executeUpdate();
                p.clearParameters();

            }

            delete_from_db();

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
    }

    public void delete(DataBeanD_carbon_friction_header DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        try {
            p = con.prepareStatement("update d_carbon_friction_header set delete_flag = 'Y',delete_by=?,delete_date=? where doc_id=? and delete_flag ='N' and complete_flag = 'N' ");
            p.setString(1, DataBean.getBy());
            p.setTimestamp(2, DataBean.getDate());
            p.setString(3, DataBean.getDoc_id());
            p.executeUpdate();
            p.clearParameters();
            p = con.prepareStatement("update d_carbon_friction_withdraw_detail set delete_flag = 'Y',delete_by=?,delete_date=? where doc_id=? and delete_flag ='N' and complete_flag = 'N' ");
            p.setString(1, DataBean.getBy());
            p.setTimestamp(2, DataBean.getDate());
            p.setString(3, DataBean.getDoc_id());
            p.executeUpdate();
            p.clearParameters();
            p = con.prepareStatement("update d_carbon_friction_receive_detail_1 set delete_flag = 'Y',delete_by=?,delete_date=? where doc_id=? and delete_flag ='N' and complete_flag = 'N' ");
            p.setString(1, DataBean.getBy());
            p.setTimestamp(2, DataBean.getDate());
            p.setString(3, DataBean.getDoc_id());
            p.executeUpdate();
            p.clearParameters();
            p = con.prepareStatement("update d_carbon_friction_receive_detail_2 set delete_flag = 'Y',delete_by=?,delete_date=? where doc_id=? and delete_flag ='N' and complete_flag = 'N' ");
            p.setString(1, DataBean.getBy());
            p.setTimestamp(2, DataBean.getDate());
            p.setString(3, DataBean.getDoc_id());
            p.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
    }

    public void delete_from_db() throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p;
        String SQL_DELETE, Table = "";

        for (int i = 1; i <= 7; i++) {

            switch (i) {
                case 1:
                    Table = "d_carbon_friction_header";
                    break;
                case 2:
                    Table = "d_carbon_friction_burn_detail";
                    break;
                case 3:
                    Table = "d_carbon_friction_receive_detail";
                    break;
                case 4:
                    Table = "d_carbon_friction_receive_detail_1";
                    break;
                case 5:
                    Table = "d_carbon_friction_receive_detail_2";
                    break;
                case 6:
                    Table = "d_carbon_friction_receive_header";
                    break;
                case 7:
                    Table = "d_carbon_friction_withdraw_detail";
                    break;
            }

            SQL_DELETE = " delete from " + Table + " where delete_flag = 'Y' ; ";

            System.out.println(SQL_DELETE);
            p = con.prepareStatement(SQL_DELETE);
            p.executeUpdate();
        }
    }

}
