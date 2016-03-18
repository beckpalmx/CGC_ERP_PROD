/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.PgroupBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class PGroupDAO {
    public boolean insert(PgroupBean pgBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mproduct_group(pgroup_id,name_t,remark,create_date) values(?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, pgBean.getPgroup_id());
            p.setString(2, pgBean.getName_t());
            p.setString(3, pgBean.getRemark());
            p.setTimestamp(4, pgBean.getCreate_date());
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
    public ArrayList<PgroupBean> selectDataAll() throws Exception {
        PgroupBean pgBean = null;
        ArrayList<PgroupBean> list = new ArrayList<PgroupBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from mproduct_group where delete_flag <> 'Y' order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            rs = p.executeQuery();

            while (rs.next()) {
                pgBean = new PgroupBean();
                pgBean.setPgroup_id(rs.getString("pgroup_id"));
                pgBean.setName_t(rs.getString("name_t"));
                pgBean.setRemark(rs.getString("remark"));
                list.add(pgBean);
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
    public ArrayList<PgroupBean> selectDataSerBy(String name, String id) throws Exception {
        PgroupBean pgBean = null;
        ArrayList<PgroupBean> list = new ArrayList<PgroupBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from mproduct_group where (name_t like ? or pgroup_id like ?) AND delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, name + "%");
            p.setString(2, id + "%");
            rs = p.executeQuery();

            while (rs.next()) {
                pgBean = new PgroupBean();
                pgBean.setPgroup_id(rs.getString("pgroup_id"));
                pgBean.setName_t(rs.getString("name_t"));
                pgBean.setRemark(rs.getString("remark"));
                list.add(pgBean);
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
    public void  update(PgroupBean pgBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mproduct_group SET name_t=?,remark=?,update_date=? where pgroup_id = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, pgBean.getName_t());
            p.setString(2, pgBean.getRemark());
            p.setTimestamp(3, pgBean.getUpdate_date());
            p.setString(4, pgBean.getPgroup_id());
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
    public void  updateDel(PgroupBean pgBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mproduct_group SET delete_flag = 'Y' where pgroup_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, pgBean.getPgroup_id());
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
    public PgroupBean selectData(String id) throws Exception {
        PgroupBean pgBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mproduct_group where pgroup_id = ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, id);
                rs = p.executeQuery();
                while (rs.next()) {
                    pgBean = new PgroupBean();
                    pgBean.setPgroup_id(rs.getString("pgroup_id"));
                    pgBean.setName_t(rs.getString("name_t"));
                    pgBean.setRemark(rs.getString("remark"));
                    pgBean.setDelete_flag(rs.getString("delete_flag"));
                }

        }finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
             return pgBean ;
        }
    }
}
