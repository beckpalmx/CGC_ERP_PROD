///*
// * To change this template, choose Tools | Templates
// * and open the template in the editor.
// */
package com.cgc.DB;

import com.cgc.bean.DeptBean;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

public class DeptDAO {

    public boolean insert(DeptBean deptBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mdepartment(dept_id, name_t,remark,create_date) values(?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, deptBean.getDept_id());
            p.setString(2, deptBean.getName_t());
            p.setString(3, deptBean.getRemark());
            p.setTimestamp(4, deptBean.getCreate_date());
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
    
    public boolean insert_MADB(DeptBean deptBean) throws Exception {
        DBConnect dbConnect = new DBConnect();        
        Connection con = dbConnect.openNewConnectionMA();
        String sql = "INSERT INTO mdepartment(dept_id, name_t,remark,create_date) values(?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, deptBean.getDept_id());
            p.setString(2, deptBean.getName_t());
            p.setString(3, deptBean.getRemark());
            p.setTimestamp(4, deptBean.getCreate_date());
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
    
//

    public void update(DeptBean deptBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mdepartment SET name_t=?,remark=?,update_date=? where dept_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, deptBean.getName_t());
            p.setString(2, deptBean.getRemark());
            p.setTimestamp(3, deptBean.getUpdate_date());
            p.setString(4, deptBean.getDept_id());

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
    
    public void update_MADB(DeptBean deptBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnectionMA();
        String sql = "UPDATE mdepartment SET name_t=?,remark=?,update_date=? where dept_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, deptBean.getName_t());
            p.setString(2, deptBean.getRemark());
            p.setTimestamp(3, deptBean.getUpdate_date());
            p.setString(4, deptBean.getDept_id());

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
    

    public void updateDel(DeptBean deptBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mdepartment SET delete_flag = 'Y' where dept_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, deptBean.getDept_id());
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
    
    public void updateDel_MADB(DeptBean deptBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnectionMA();
        String sql = "UPDATE mdepartment SET delete_flag = 'Y' where dept_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, deptBean.getDept_id());
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

    public DeptBean selectData(String id) throws Exception {
        DeptBean deptBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mdepartment where dept_id = ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, id);
            rs = p.executeQuery();

            while (rs.next()) {
                deptBean = new DeptBean();
                deptBean.setDept_id(rs.getString("dept_id"));
                deptBean.setName_t(rs.getString("name_t"));
                deptBean.setRemark(rs.getString("remark"));
                deptBean.setDelete_flag(rs.getString("delete_flag"));
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return deptBean;
        }
    }

    public ArrayList<DeptBean> selectDataAll() throws Exception {
        DeptBean deptBean = null;
        ArrayList<DeptBean> list = new ArrayList<DeptBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mdepartment where delete_flag <> 'Y' order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            rs = p.executeQuery();

            while (rs.next()) {
                deptBean = new DeptBean();
                deptBean.setDept_id(rs.getString("dept_id"));
                deptBean.setName_t(rs.getString("name_t"));
                deptBean.setRemark(rs.getString("remark"));
                list.add(deptBean);
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

    public ArrayList<DeptBean> selectDataSerBy(String name, String id) throws Exception {
        DeptBean deptBean = null;
        ArrayList<DeptBean> list = new ArrayList<DeptBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mdepartment where name_t like ? or dept_id like ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, name + "%");
            p.setString(2, id + "%");
            rs = p.executeQuery();

            while (rs.next()) {
                deptBean = new DeptBean();
                deptBean.setDept_id(rs.getString("dept_id"));
                deptBean.setName_t(rs.getString("name_t"));
                deptBean.setRemark(rs.getString("remark"));
                list.add(deptBean);
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
