package com.cgc.DB;

import com.cgc.bean.LookupBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LookupDAO {
    public boolean insert(LookupBean lookupBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mlookup(lookup_name,remark,create_date) values(?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, lookupBean.getLookup_name());
            p.setString(2, lookupBean.getRemark());
            p.setTimestamp(3, lookupBean.getCreate_date());
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
    public void update(LookupBean lookupBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mlookup SET remark=? where lookup_name=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, lookupBean.getRemark());
            p.setString(2, lookupBean.getLookup_name());

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
    public void updateDel(LookupBean lookupBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mlookup SET delete_flag = 'Y',update_date = ? where lookup_name=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setTimestamp(1, lookupBean.getUpdate_date());
            p.setString(2, lookupBean.getLookup_name());
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
    public LookupBean selectData(String id) throws Exception {
        LookupBean lookupBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mlookup where lookup_name = ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, id);
            rs = p.executeQuery();

            while (rs.next()) {
                lookupBean = new LookupBean();
                lookupBean.setLookup_name(rs.getString("lookup_name"));
                lookupBean.setRemark(rs.getString("remark"));
                lookupBean.setDelete_flag(rs.getString("delete_flag"));
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return lookupBean;
        }
    }
}
