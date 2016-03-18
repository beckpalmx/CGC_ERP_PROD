/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.PcatBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author com02
 */
public class PCatDAO {
    public boolean insert(PcatBean pcBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mproduct_cat(pcat_id,name_t,remark,create_date) values(?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, pcBean.getPcat_id());
            p.setString(2, pcBean.getName_t());
            p.setString(3, pcBean.getRemark());
            p.setTimestamp(4, pcBean.getCreate_date());
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
    public ArrayList<PcatBean> selectDataAll() throws Exception {
        PcatBean pcBean = null;
        ArrayList<PcatBean> list = new ArrayList<PcatBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from mproduct_cat where delete_flag <> 'Y' order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            rs = p.executeQuery();

            while (rs.next()) {
                pcBean = new PcatBean();
                pcBean.setPcat_id(rs.getString("pcat_id"));
                pcBean.setName_t(rs.getString("name_t"));
                pcBean.setRemark(rs.getString("remark"));
                list.add(pcBean);
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
    public ArrayList<PcatBean> selectDataSerBy(String name, String id) throws Exception {
        PcatBean pcBean = null;
        ArrayList<PcatBean> list = new ArrayList<PcatBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from mproduct_cat where (name_t like ? or pcat_id like ?) AND delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, name + "%");
            p.setString(2, id + "%");
            rs = p.executeQuery();

            while (rs.next()) {
                pcBean = new PcatBean();
                pcBean.setPcat_id(rs.getString("pcat_id"));
                pcBean.setName_t(rs.getString("name_t"));
                pcBean.setRemark(rs.getString("remark"));
                list.add(pcBean);
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
    public void  updateDel(PcatBean pgBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mproduct_cat SET delete_flag = 'Y' where pcat_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, pgBean.getPcat_id());
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
    public void  update(PcatBean pgBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mproduct_cat SET name_t=?,remark=?,update_date=? where pcat_id = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, pgBean.getName_t());
            p.setString(2, pgBean.getRemark());
            p.setTimestamp(3, pgBean.getUpdate_date());
            p.setString(4, pgBean.getPcat_id());
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
    public PcatBean selectData(String id) throws Exception {
        PcatBean pcBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mproduct_cat where pcat_id = ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, id);
                rs = p.executeQuery();
                while (rs.next()) {
                    pcBean = new PcatBean();
                    pcBean.setPcat_id(rs.getString("pcat_id"));
                    pcBean.setName_t(rs.getString("name_t"));
                    pcBean.setRemark(rs.getString("remark"));
                    pcBean.setDelete_flag(rs.getString("delete_flag"));
                }

        }finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
             return pcBean ;
        }
    }
}
