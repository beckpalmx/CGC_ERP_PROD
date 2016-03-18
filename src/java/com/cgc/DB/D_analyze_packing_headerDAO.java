/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_analyze_packing_header;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Beckpalmx No7
 */
public class D_analyze_packing_headerDAO {

    private int Returnvalue;

    public int insert(DataBeanD_analyze_packing_header dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_analyze_packing_header (doc_id,doc_date,doc_time,shift,prd_no,cust_id,size,quantity,hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10,hc11,hc12,hc13,hc14,hc15,create_date,update_date,create_by) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {

            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getDoc_time());
            p.setString(4, dataBean.getShift());
            p.setString(5, dataBean.getPrd_no());
            p.setString(6, dataBean.getCust_id());
            p.setString(7, dataBean.getSize());
            p.setString(8, dataBean.getQuantity());
            p.setString(9, dataBean.getHc1());
            p.setString(10, dataBean.getHc2());
            p.setString(11, dataBean.getHc3());
            p.setString(12, dataBean.getHc4());
            p.setString(13, dataBean.getHc5());
            p.setString(14, dataBean.getHc6());
            p.setString(15, dataBean.getHc7());
            p.setString(16, dataBean.getHc8());
            p.setString(17, dataBean.getHc9());
            p.setString(18, dataBean.getHc10());
            p.setString(19, dataBean.getHc11());
            p.setString(20, dataBean.getHc12());
            p.setString(21, dataBean.getHc13());
            p.setString(22, dataBean.getHc14());
            p.setString(23, dataBean.getHc15());
            p.setTimestamp(24, dataBean.getDate());
            p.setTimestamp(25, dataBean.getDate());
            p.setString(26, dataBean.getBy());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_carbon_analyze_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_analyze_packing_detail set doc_date=?,create_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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

    public int update(DataBeanD_analyze_packing_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql =
                "update d_analyze_packing_header set  doc_date=?,doc_time=?,shift=?,prd_no=?,cust_id=?,size=?,quantity=?,hc1=?,hc2=?,hc3=?,hc4=?,hc5=?,hc6=?,hc7=?,hc8=?,hc9=?,hc10=?,hc11=?,hc12=?,hc13=?,hc14=?,hc15=?,update_date=?,update_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getDoc_time());
            p.setString(3, dataBean.getShift());
            p.setString(4, dataBean.getPrd_no());
            p.setString(5, dataBean.getCust_id());
            p.setString(6, dataBean.getSize());
            p.setString(7, dataBean.getQuantity());
            p.setString(8, dataBean.getHc1());
            p.setString(9, dataBean.getHc2());
            p.setString(10, dataBean.getHc3());
            p.setString(11, dataBean.getHc4());
            p.setString(12, dataBean.getHc5());
            p.setString(13, dataBean.getHc6());
            p.setString(14, dataBean.getHc7());
            p.setString(15, dataBean.getHc8());
            p.setString(16, dataBean.getHc9());
            p.setString(17, dataBean.getHc10());
            p.setString(18, dataBean.getHc11());
            p.setString(19, dataBean.getHc12());
            p.setString(20, dataBean.getHc13());
            p.setString(21, dataBean.getHc14());
            p.setString(22, dataBean.getHc15());
            p.setTimestamp(23, dataBean.getDate());
            p.setString(24, dataBean.getBy());
            p.setString(25, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_analyze_packing_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_analyze_packing_detail set doc_date=?,update_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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

    public void UpDel(DataBeanD_analyze_packing_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_analyze_packing_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_analyze_packing_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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
