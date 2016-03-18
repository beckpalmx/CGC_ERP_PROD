/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.EmpBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


/**
 *
 * @author com02
 */
public class EmpDAO {

    public boolean insert(EmpBean empBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO memployee(emp_id, fname,lname,dept_id,status,remark,create_date,image_url) values(?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, empBean.getEmp_id());
            p.setString(2, empBean.getFname());
            p.setString(3, empBean.getLname());
            p.setString(4, empBean.getDept_id());
            p.setString(5, empBean.getStatus());
            p.setString(6, empBean.getRemark());
            p.setTimestamp(7, empBean.getCreate_date());
            p.setString(8, empBean.getImage_url());
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

    public boolean insert_MADB(EmpBean empBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnectionMA();
        String sql = "INSERT INTO memployee(emp_id, fname,lname,dept_id,status,remark,create_date) values(?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, empBean.getEmp_id());
            p.setString(2, empBean.getFname());
            p.setString(3, empBean.getLname());
            p.setString(4, empBean.getDept_id());
            p.setString(5, empBean.getStatus());
            p.setString(6, empBean.getRemark());
            p.setTimestamp(7, empBean.getCreate_date());
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
    
    public ArrayList<EmpBean> selectDataAll() throws Exception {
        EmpBean empBean = null;
        ArrayList<EmpBean> list = new ArrayList<EmpBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from vemployee_fullname where delete_flag <> 'Y' order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            rs = p.executeQuery();

            while (rs.next()) {
                empBean = new EmpBean();
                empBean.setEmp_id(rs.getString("emp_id"));
                empBean.setFullname(rs.getString("fullname"));
                empBean.setFname(rs.getString("fname"));
                empBean.setLname(rs.getString("lname"));
                empBean.setDept_id(rs.getString("dept_id"));
                empBean.setStatus(rs.getString("status"));
                empBean.setDept_name(rs.getString("depart_name"));
                list.add(empBean);
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

    public ArrayList<EmpBean> selectDataSerBy(String name, String id) throws Exception {
        EmpBean empBean = null;
        ArrayList<EmpBean> list = new ArrayList<EmpBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from vemployee_fullname where fname like ? or emp_id like ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, name + "%");
            p.setString(2, id + "%");
            rs = p.executeQuery();

            while (rs.next()) {
                empBean = new EmpBean();
                empBean.setEmp_id(rs.getString("emp_id"));
                empBean.setFullname(rs.getString("fullname"));
                empBean.setFname(rs.getString("fname"));
                empBean.setLname(rs.getString("lname"));
                empBean.setDept_id(rs.getString("dept_id"));
                empBean.setStatus(rs.getString("status"));
                list.add(empBean);
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
    public EmpBean selectData(String id) throws Exception {
        EmpBean empBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From vemployee_fullname where emp_id = ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, id);
                rs = p.executeQuery();
                while (rs.next()) {
                    empBean = new EmpBean();
                    empBean.setEmp_id(rs.getString("emp_id"));
                    empBean.setFullname(rs.getString("fullname"));
                    empBean.setFname(rs.getString("fname"));
                    empBean.setLname(rs.getString("lname"));
                    empBean.setDept_id(rs.getString("dept_id"));
                    empBean.setStatus(rs.getString("status"));
                    empBean.setDelete_flag(rs.getString("delete_flag"));
                }

        }finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
             return empBean ;
        }
    }
    public void  update(EmpBean empBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE memployee SET fname=?,lname=?,dept_id=?,status=?,remark=?,update_date=?,image_url=? where emp_id = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, empBean.getFname());
            p.setString(2, empBean.getLname());
            p.setString(3, empBean.getDept_id());
            p.setString(4, empBean.getStatus());
            p.setString(5, empBean.getRemark());
            p.setTimestamp(6, empBean.getUpdate_date());
            p.setString(7, empBean.getImage_url());
            p.setString(8, empBean.getEmp_id());
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

    public void  update_MADB(EmpBean empBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnectionMA();
        String sql = "UPDATE memployee SET fname=?,lname=?,dept_id=?,status=?,remark=?,update_date=? where emp_id = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, empBean.getFname());
            p.setString(2, empBean.getLname());
            p.setString(3, empBean.getDept_id());
            p.setString(4, empBean.getStatus());
            p.setString(5, empBean.getRemark());
            p.setTimestamp(6, empBean.getUpdate_date());
            p.setString(7, empBean.getEmp_id());


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
    
    public void  updateDel(EmpBean empBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE  memployee set delete_flag = 'Y' where emp_id = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, empBean.getEmp_id());
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
    
    public String Show_Detail_Img(String emp_id)throws Exception{
        String return_string = "";
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        try{
            rs = con.createStatement().executeQuery("select image_url from memployee where emp_id = '"+emp_id+"' and delete_flag = 'N'");
            System.out.println("emp_id = "+emp_id);
            while(rs.next()){
                if(rs.getString("image_url")==null){
                String pic_null = "human.png";
                return_string = "<a class=\"fancybox-effects-c\" href=\"http://www.cgc-carbon.com/cgc_image/"+ pic_null +"\" title=\"\"><img src=\"http://www.cgc-carbon.com/cgc_image/"+ pic_null +"\" alt=\"\" width=\"100px\" height=\"100px\"/></a>";
                System.out.println("return_string case 1 = "+ return_string);
                } else {
                String pic_display = rs.getString("image_url") ;    
                return_string = "<a class=\"fancybox-effects-c\" href=\"http://www.cgc-carbon.com/cgc_image/"+ pic_display +"\" title=\"\"><img src=\"http://www.cgc-carbon.com/cgc_image/"+ pic_display +"\" alt=\"\" width=\"100px\" height=\"100px\"/></a>";                
                System.out.println("return_string case 2 = "+ return_string);
                }
            }
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(rs != null){
                rs.close();
            }
            con.close();
            return_string = return_string + "<img id=\"myImg\" src=\"../IMAGES/default.png\"  width=\"100px\" height=\"100px\"/>" ;
            return return_string;
        }
    }    
    
}
