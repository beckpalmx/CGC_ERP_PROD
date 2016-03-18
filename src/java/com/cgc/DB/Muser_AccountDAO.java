package com.cgc.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.cgc.bean.DataBeanMuser_Account;

public class Muser_AccountDAO {

    public int insert(DataBeanMuser_Account dataBean) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into  muser_account (username,password,create_date) values(?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getUser());
            p.setString(2, dataBean.getPassword());
            p.setTimestamp(3, dataBean.getDate());
            return p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public int update(DataBeanMuser_Account dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql
                = "update  muser_account set  password=?,update_date=? where username=?";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getPassword());
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getUser());
            return p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public int UpDel(DataBeanMuser_Account dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update  muser_account set delete_flag = ?,delete_date=? where username=? ";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getUser());
            return p.executeUpdate();

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
