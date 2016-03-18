package com.cgc.DB;

import com.cgc.bean.PriviledgeBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class PriviledgeDAO {
    public boolean insert(PriviledgeBean pvBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mpriviledge(priviledge_id,sub_menu_id,main_menu_id,name_t,remark,create_date) values(?,?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, pvBean.getPriviledge_id());
            p.setString(2, pvBean.getSub_menu_id());
            p.setString(3, pvBean.getMain_menu_id());
            p.setString(4, pvBean.getName_t());
            p.setString(5, pvBean.getRemark());
            p.setTimestamp(6, pvBean.getCreate_date());
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
    public void  update(PriviledgeBean pvBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mpriviledge SET sub_menu_id=?,main_menu_id=?,name_t=?,remark=?,update_date=? where priviledge_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, pvBean.getSub_menu_id());
            p.setString(2, pvBean.getMain_menu_id());
            p.setString(3, pvBean.getName_t());
            p.setString(4, pvBean.getRemark());
            p.setTimestamp(5, pvBean.getUpdate_date());
            p.setString(6, pvBean.getPriviledge_id());
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
    public void  updateDel(PriviledgeBean pvBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE  mpriviledge set delete_flag = 'Y' where priviledge_id = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, pvBean.getPriviledge_id());
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
    public PriviledgeBean selectData(String id) throws Exception {
        PriviledgeBean pvBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mpriviledge where priviledge_id = ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, id);
                rs = p.executeQuery();
                while (rs.next()) {
                    pvBean = new PriviledgeBean();
                    pvBean.setPriviledge_id(rs.getString("priviledge_id"));
                    pvBean.setName_t(rs.getString("name_t"));
                    pvBean.setRemark(rs.getString("remark"));
                    pvBean.setMain_menu_id(rs.getString("main_menu_id"));
                    pvBean.setSub_menu_id(rs.getString("sub_menu_id"));
                    pvBean.setDelete_flag(rs.getString("delete_flag"));
                }

        }finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
             return pvBean ;
        }
    }
}
