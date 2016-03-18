/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanMLocation;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Beckpalmx No7
 */

public class MLocationDAO {

    private int returnvalue;

    public int insert(DataBeanMLocation dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql = "INSERT INTO mlocation(location_id,name_t,location_id_ref,price_per_unit,remark,create_by,create_date) values(?,?,?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getLocation_id());
            p.setString(2, dataBean.getName_t());
            p.setString(3, dataBean.getLocation_id_ref());
            p.setString(4, dataBean.getPrice_per_unit());
            p.setString(5, dataBean.getRemark());
            p.setString(6, dataBean.getBy());
            p.setTimestamp(7, dataBean.getDate());

/*            
            System.out.println("dataBean.getLocation_id_ref() = " + dataBean.getLocation_id_ref());
            System.out.println("dataBean.getPrice_per_unit() = " + dataBean.getPrice_per_unit());
            System.out.println("dataBean.getBy() = " + dataBean.getBy());
            System.out.println("dataBean.getDate() = " + dataBean.getDate());
*/        
            

            returnvalue = p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }

        return returnvalue;
    }

    public int update(DataBeanMLocation dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mlocation SET name_t=?,location_id_ref=?,price_per_unit=?,remark=?,update_by=?,update_date=? where runno = ? and delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getName_t());
            p.setString(2, dataBean.getLocation_id_ref());
            p.setString(3, dataBean.getPrice_per_unit());
            p.setString(4, dataBean.getRemark());
            p.setString(5, dataBean.getBy());
            p.setTimestamp(6, dataBean.getDate());
            p.setInt(7, dataBean.getRunno());

            System.out.println("dataBean.getLocation_id_ref() = " + dataBean.getLocation_id_ref());
            System.out.println("dataBean.getPrice_per_unit() = " + dataBean.getPrice_per_unit());
            System.out.println("dataBean.getBy() = " + dataBean.getBy());
            System.out.println("dataBean.getDate() = " + dataBean.getDate());            
            System.out.println("dataBean.getRunno() = " + dataBean.getRunno());   
            
            returnvalue = p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return returnvalue;
    }

    public int updateDel(DataBeanMLocation dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "DELETE FROM mlocation where runno=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setInt(1, dataBean.getRunno());
            returnvalue = p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return returnvalue;
    }

}
