/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.UserBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public UserBean selectData(UserBean data) throws Exception {
        UserBean userBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From vmuser_account where username = ? AND password = ? and use_status = 'Y' and delete_flag = 'N'";
        //System.out.println("sql vmuser_account = " + sql);
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, data.getUsername());
            p.setString(2, data.getPassword());
            rs = p.executeQuery();
            while (rs.next()) {
                userBean = new UserBean();
                userBean.setRunno(rs.getInt("runno"));
                userBean.setUsername(rs.getString("username"));
                userBean.setPassword(rs.getString("password"));
                userBean.setEmp_id(rs.getString("emp_id"));
                userBean.setPriviledge_id(rs.getString("priviledge_id"));
                userBean.setRemark(rs.getString("remark"));
                userBean.setUse_status(rs.getString("use_status"));
                userBean.setCompany_id(rs.getString("company_id"));
                userBean.setMenu_type(rs.getString("menu_type"));
                userBean.setDelete_flag(rs.getString("delete_flag"));
                userBean.setDept_id(rs.getString("dept_id"));
                userBean.setFullname(rs.getString("fullname"));
                userBean.setPrint_count(rs.getString("print_count"));
                //System.out.println("username  = " + rs.getString("username"));
                //System.out.println("username  = " + rs.getString("password"));
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return userBean;
        }
    }

    public UserBean selectChk(UserBean data) throws Exception {
        UserBean userBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From vmuser_account where username = ?";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, data.getUsername());
            rs = p.executeQuery();
            while (rs.next()) {
                userBean = new UserBean();
                userBean.setRunno(rs.getInt("runno"));
                userBean.setUse_status(rs.getString("username"));
                userBean.setPassword(rs.getString("password"));
                userBean.setEmp_id(rs.getString("emp_id"));
                userBean.setPriviledge_id(rs.getString("priviledge_id"));
                userBean.setRemark(rs.getString("remark"));
                userBean.setUse_status(rs.getString("use_status"));
                userBean.setCompany_id(rs.getString("company_id"));
                userBean.setMenu_type(rs.getString("menu_type"));
                userBean.setDelete_flag(rs.getString("delete_flag"));
                userBean.setPrint_count(rs.getString("print_count"));
                //System.out.println("Print Count = " + rs.getString("print_count"));
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return userBean;
        }
    }

    public boolean insert(UserBean data) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO muser_account(username,password,emp_id,priviledge_id,remark,use_status,create_date) values(?,?,?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, data.getUsername());
            p.setString(2, data.getPassword());
            p.setString(3, data.getEmp_id());
            p.setString(4, data.getPriviledge_id());
            p.setString(5, data.getRemark());
            p.setString(6, data.getUse_status());
            p.setTimestamp(7, data.getCreate_date());
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

    public void updateDel(UserBean data) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE muser_account SET delete_flag = 'Y' where username=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, data.getUsername());
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

    public void update(UserBean data) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE muser_account SET password=?,emp_id=?,priviledge_id=?,remark=?,use_status=?,update_date=? where username = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, data.getPassword());
            p.setString(2, data.getEmp_id());
            p.setString(3, data.getPriviledge_id());
            p.setString(4, data.getRemark());
            p.setString(5, data.getUse_status());
            p.setTimestamp(6, data.getUpdate_date());
            p.setString(7, data.getUsername());
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
}
