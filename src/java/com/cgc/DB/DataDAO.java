package com.cgc.DB;

///*
// * To change this template, choose Tools | Templates
// * and open the template in the editor.
// */
import com.cgc.DB.DBConnect;
import com.cgc.bean.DataBean;
import java.sql.PreparedStatement;
import java.sql.Connection;
public class DataDAO {

    public void insert(DataBean dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mdepartment(runno, dept_id, name_t) values(?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setInt(1, dataBean.getRunon());
            p.setString(2, dataBean.getId());
            p.setString(3, dataBean.getName());

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
//
    public void update(DataBean dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql =
                "UPDATE mdepartment SET dept_id=?,name_t=? where runno=?";

        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getId());
            p.setString(2, dataBean.getName());
            p.setInt(3, dataBean.getRunon());
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
//
//    public void delete(int id) throws Exception {
//        DBConnect dbConnect = new DBConnect();
//        Connection con = dbConnect.openNewConnection();
//
//        String sql = "delete from student where id = ?";
//
//        PreparedStatement p = null;
//
//        try {
//            p = con.prepareStatement(sql);
//            p.setInt(1, id);
//            p.executeUpdate();
//        } finally {
//            try {
//                p.close();
//                con.close();
//            } catch (Exception e) {
//                e.printStackTrace(System.out);
//            }
//        }
//    }
}
