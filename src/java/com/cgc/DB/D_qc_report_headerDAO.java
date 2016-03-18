/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_qc_report_header;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Beckpalmx No7
 */
public class D_qc_report_headerDAO {
private int Returnvalue;

    public int insert(DataBeanD_qc_report_header dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_qc_report_header (doc_id,stuffing_date,job_no,cust_id,product_id,weight,hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10,hc11,hc12,hc13,hc14,hc15,create_date,update_date,create_by) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {

            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getStuffing_date());
            p.setString(3, dataBean.getJob_no());
            p.setString(4, dataBean.getCust_id());
            p.setString(5, dataBean.getProduct_id());
            p.setString(6, dataBean.getWeight());
            p.setString(7, dataBean.getHc1());
            p.setString(8, dataBean.getHc2());
            p.setString(9, dataBean.getHc3());
            p.setString(10, dataBean.getHc4());
            p.setString(11, dataBean.getHc5());
            p.setString(12, dataBean.getHc6());
            p.setString(13, dataBean.getHc7());
            p.setString(14, dataBean.getHc8());
            p.setString(15, dataBean.getHc9());
            p.setString(16, dataBean.getHc10());
            p.setString(17, dataBean.getHc11());
            p.setString(18, dataBean.getHc12());
            p.setString(19, dataBean.getHc13());
            p.setString(20, dataBean.getHc14());
            p.setString(21, dataBean.getHc15());
            p.setTimestamp(22, dataBean.getDate());
            p.setTimestamp(23, dataBean.getDate());
            p.setString(24, dataBean.getBy());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_qc_report_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_qc_report_detail set doc_date=?,create_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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

    public int update(DataBeanD_qc_report_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql =
                "update d_qc_report_header set  stuffing_date=?,job_no=?,cust_id=?,product_id=?,weight=?,hc1=?,hc2=?,hc3=?,hc4=?,hc5=?,hc6=?,hc7=?,hc8=?,hc9=?,hc10=?,hc11=?,hc12=?,hc13=?,hc14=?,hc15=?,update_date=?,update_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getStuffing_date());
            p.setString(2, dataBean.getJob_no());
            p.setString(3, dataBean.getCust_id());
            p.setString(4, dataBean.getProduct_id());
            p.setString(5, dataBean.getWeight());
            p.setString(6, dataBean.getHc1());
            p.setString(7, dataBean.getHc2());
            p.setString(8, dataBean.getHc3());
            p.setString(9, dataBean.getHc4());
            p.setString(10, dataBean.getHc5());
            p.setString(11, dataBean.getHc6());
            p.setString(12, dataBean.getHc7());
            p.setString(13, dataBean.getHc8());
            p.setString(14, dataBean.getHc9());
            p.setString(15, dataBean.getHc10());
            p.setString(16, dataBean.getHc11());
            p.setString(17, dataBean.getHc12());
            p.setString(18, dataBean.getHc13());
            p.setString(19, dataBean.getHc14());
            p.setString(20, dataBean.getHc15());
            p.setTimestamp(21, dataBean.getDate());
            p.setString(22, dataBean.getBy());
            p.setString(23, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_qc_report_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_qc_report_detail set doc_date=?,update_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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

    public void UpDel(DataBeanD_qc_report_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_qc_report_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_qc_report_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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
}
