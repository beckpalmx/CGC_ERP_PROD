/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanD_packing_req_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.cgc.Util.UtiDatabase;
/**
 *
 * @author Beckpalmx No7
 */
public class D_packing_req_headerDAO {

    private int Returnvalue;
    public int insert(DataBeanD_packing_req_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_packing_req_header (doc_id,doc_date,wh_in,wh_out,job_id,weight,bag,carbon_pack,i2,place_pack,create_date,update_date,create_by) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getWh_in());
            p.setString(4, dataBean.getWh_out());
            p.setString(5, dataBean.getJob_id());
            p.setString(6, dataBean.getWeight());
            p.setString(7, dataBean.getBag());
            p.setString(8, dataBean.getCarbon_pack());
            p.setString(9, dataBean.getI2());
            p.setString(10, dataBean.getPlace_pack());
            p.setTimestamp(11, dataBean.getDate());
            p.setTimestamp(12, dataBean.getDate());
            p.setString(13, dataBean.getBy());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_packing_req_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

            if(objuti.numRowdatabase(sql) != 0){
                sql = "update d_packing_req_detail set doc_date=?,wh_in=?,wh_out=?,create_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getWh_in());
                p.setString(3, dataBean.getWh_out());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getDoc_id());
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

    public int update(DataBeanD_packing_req_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql =
                "update d_packing_req_header set  doc_date=?,wh_in=?,wh_out=?,job_id=?,weight=?,bag=?,carbon_pack=?,i2=?,place_pack=?,update_date=?,update_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getWh_in());
            p.setString(3, dataBean.getWh_out());
            p.setString(4, dataBean.getJob_id());
            p.setString(5, dataBean.getWeight());
            p.setString(6, dataBean.getBag());
            p.setString(7, dataBean.getCarbon_pack());
            p.setString(8, dataBean.getI2());
            p.setString(9, dataBean.getPlace_pack());
            p.setTimestamp(10, dataBean.getDate());
            p.setString(11, dataBean.getBy());
            p.setString(12, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_packing_req_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if(objuti.numRowdatabase(sql) != 0){
                sql = "update d_packing_req_detail set doc_date=?,wh_in=?,wh_out=?,update_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;

                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getWh_in());
                p.setString(3, dataBean.getWh_out());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getDoc_id());
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

    public void UpDel(DataBeanD_packing_req_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_packing_req_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_packing_req_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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
