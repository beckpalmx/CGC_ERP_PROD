/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.PtypeBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author com02
 */
public class PTypeDAO {

    public boolean insert(PtypeBean ptBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mproduct_type(ptype_id,name_t,remark,create_date) values(?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, ptBean.getPtype_id());
            p.setString(2, ptBean.getName_t());
            p.setString(3, ptBean.getRemark());
            p.setTimestamp(4, ptBean.getCreate_date());
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
    public ArrayList<PtypeBean> selectDataAll() throws Exception {
        PtypeBean ptBean = null;
        ArrayList<PtypeBean> list = new ArrayList<PtypeBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from mproduct_type where delete_flag <> 'Y' order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            rs = p.executeQuery();

            while (rs.next()) {
                ptBean = new PtypeBean();
                ptBean.setPtype_id(rs.getString("ptype_id"));
                ptBean.setName_t(rs.getString("name_t"));
                ptBean.setRemark(rs.getString("remark"));
                list.add(ptBean);
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return list;
        }
    }
    public ArrayList<PtypeBean> selectDataSerBy(String name, String id) throws Exception {
        PtypeBean ptBean = null;
        ArrayList<PtypeBean> list = new ArrayList<PtypeBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from mproduct_type where name_t like ? or ptype_id like ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, name + "%");
            p.setString(2, id + "%");
            rs = p.executeQuery();

            while (rs.next()) {
                ptBean = new PtypeBean();
                ptBean.setPtype_id(rs.getString("ptype_id"));
                ptBean.setName_t(rs.getString("name_t"));
                ptBean.setRemark(rs.getString("remark"));
                list.add(ptBean);
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return list;
        }
    }
    public void  updateDel(PtypeBean ptBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mproduct_type SET delete_flag = 'Y' where ptype_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, ptBean.getPtype_id());
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
    public void  update(PtypeBean ptBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mproduct_type SET name_t=?,remark=?,update_date=? where ptype_id = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, ptBean.getName_t());
            p.setString(2, ptBean.getRemark());
            p.setTimestamp(3, ptBean.getUpdate_date());
            p.setString(4, ptBean.getPtype_id());
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
    public PtypeBean selectData(String id) throws Exception {
        PtypeBean ptBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mproduct_type where ptype_id = ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, id);
                rs = p.executeQuery();
                while (rs.next()) {
                    ptBean = new PtypeBean();
                    ptBean.setPtype_id(rs.getString("ptype_id"));
                    ptBean.setName_t(rs.getString("name_t"));
                    ptBean.setRemark(rs.getString("remark"));
                    ptBean.setDelete_flag(rs.getString("delete_flag"));
                }

        }finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
             return ptBean ;
        }
    }
}
