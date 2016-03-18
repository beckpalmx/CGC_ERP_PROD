/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.DataBeanM_iodine;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Beck
 */
public class M_iodineDAO {
    private int returnvalue;
    public int insert(DataBeanM_iodine dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO m_iodine(iod_code,iod_ctype,iod_range,butane,ctc,name_t,remark,create_date,create_by) values(?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getIod_code());
            p.setString(2, dataBean.getIod_ctype());
            p.setString(3, dataBean.getIod_range());
            p.setString(4, dataBean.getButane());
            p.setString(5, dataBean.getCtc());
            p.setString(6, dataBean.getName_t());   
            p.setString(7, dataBean.getRemark());  
            p.setTimestamp(8, dataBean.getDate());
            p.setString(9, dataBean.getBy());
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
    public int  update(DataBeanM_iodine dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE m_iodine SET iod_ctype=?,iod_range=?,butane=?,ctc=?,name_t=?,remark=?,update_date=?,update_by=? where iod_code = ? and delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getIod_ctype());
            p.setString(2, dataBean.getIod_range());
            p.setString(3, dataBean.getButane());
            p.setString(4, dataBean.getCtc());
            p.setString(5, dataBean.getName_t());   
            p.setString(6, dataBean.getRemark()); 
            p.setTimestamp(7, dataBean.getDate());
            p.setString(8, dataBean.getBy());            
            p.setString(9, dataBean.getIod_code());
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
    public int  updateDel(DataBeanM_iodine dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE m_iodine SET delete_flag = 'Y',delete_by=?,delete_date=? where iod_code=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getBy());
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getIod_code());
            returnvalue =p.executeUpdate();
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
