/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.ScreenBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author com02
 */
public class ScreenDAO {
    public boolean insert(ScreenBean scBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mscreen(screen_id,process_id,name_t,dept_id,qc_check,iso_no,effective_date,remark,create_date,email_from,email_to,email_server,email_port) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, scBean.getScreen_id());
            p.setString(2, scBean.getProcess_id());
            p.setString(3, scBean.getName_t());
            p.setString(4, scBean.getDept_id());
            p.setString(5, scBean.getQc_check());
            p.setString(6, scBean.getIso_no());
            p.setString(7, scBean.getEffective_date());
            p.setString(8, scBean.getRemark());
            p.setTimestamp(9, scBean.getCreate_date());
            p.setString(10, scBean.getEmail_from());
            p.setString(11, scBean.getEmail_to());
            p.setString(12, scBean.getEmail_server());
            p.setString(13, scBean.getEmail_port());
            p.executeUpdate();

            return true;

        } catch (Exception e) {
            return false;
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }
    public void  updateDel(ScreenBean scBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mscreen SET delete_flag = 'Y' where screen_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, scBean.getScreen_id());
            p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }
    public void  update(ScreenBean scBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mscreen SET process_id=?,name_t=?,dept_id=?,qc_check=?,iso_no=?,effective_date=?,remark=?,update_date=?,email_from=?,email_to=?,email_server=?,email_port=? where screen_id = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, scBean.getProcess_id());
            p.setString(2, scBean.getName_t());
            p.setString(3, scBean.getDept_id());
            p.setString(4, scBean.getQc_check());
            p.setString(5, scBean.getIso_no());
            p.setString(6, scBean.getEffective_date());
            p.setString(7, scBean.getRemark());
            p.setTimestamp(8, scBean.getUpdate_date());
            p.setString(9, scBean.getEmail_from());
            p.setString(10, scBean.getEmail_to());
            p.setString(11, scBean.getEmail_server());
            p.setString(12, scBean.getEmail_port());            
            p.setString(13, scBean.getScreen_id());
            
            //System.out.println(scBean.getEmail_from());
            //System.out.println(scBean.getEmail_to());
            //System.out.println(scBean.getEmail_server());
            //System.out.println(scBean.getEmail_port());
            
            p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }
    public ScreenBean selectData(String id) throws Exception {
        ScreenBean scBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mscreen where screen_id = ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, id);
                rs = p.executeQuery();
                while (rs.next()) {
                    scBean = new ScreenBean();
                    scBean.setScreen_id(rs.getString("screen_id"));
                    scBean.setName_t(rs.getString("name_t"));
                    scBean.setRemark(rs.getString("remark"));
                    scBean.setDelete_flag(rs.getString("delete_flag"));
                }

        }finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
             return scBean ;
        }
    }
}
