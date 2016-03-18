/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.MessageBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class MessageDAO {
    
    
    public String selectData_MSG() throws Exception {
        
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From message where status = 'Y' and delete_flag = 'N' order by message_id desc",message_disp="";
        PreparedStatement p = null;
            try {
                p = con.prepareStatement(sql);
                //p.setString(1, data.getMessage_id());
                //p.setString(2, data.getMessage_detail());
                rs = p.executeQuery();
                while (rs.next()) {
                    //System.out.println(rs.getString("runno"));
                    //System.out.println(rs.getString("message_id"));
                    //System.out.println(rs.getString("message_detail"));        
                    message_disp = message_disp + "  " +rs.getString("message_detail");
                    System.out.println(message_disp); 
                }
                
                

        }finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
             return message_disp;
        }
    }
    public MessageBean selectChk(MessageBean data) throws Exception {
        MessageBean messageBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From message where message_id = ?";
        PreparedStatement p = null;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, data.getMessage_id());
                rs = p.executeQuery();
                while (rs.next()) {
                    messageBean = new MessageBean();
                    messageBean.setRunno(rs.getInt("runno"));
                    messageBean.setMessage_id(rs.getString("message_id"));
                    messageBean.setMessage_detail(rs.getString("message_detail"));
                    messageBean.setStatus(rs.getString("status"));
                    messageBean.setDelete_flag(rs.getString("delete_flag"));
                    //System.out.println(rs.getString("message_id"));
                    System.out.println(rs.getString("message_detail"));
                }

        }finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
             return messageBean ;
        }
    }
    public boolean insert(MessageBean data) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO message(message_id,message_detail,status,create_date,create_by) values(?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, data.getMessage_id());
            p.setString(2, data.getMessage_detail());
            p.setString(3, data.getStatus());
            p.setTimestamp(4, data.getCreate_date());
            p.setString(5, data.getCreate_by());
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
    public void  updateDel(MessageBean data) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE message SET delete_flag = 'Y',delete_date=?,delete_by=? where message_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setTimestamp(1, data.getDelete_date());            
            p.setString(2, data.getDelete_by());            
            p.setString(3, data.getMessage_id());
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
    public void  update(MessageBean data) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE message SET message_detail=?,status=?,update_date=?,update_by=? where message_id = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, data.getMessage_detail());
            p.setString(2, data.getStatus());
            p.setTimestamp(3, data.getUpdate_date());            
            p.setString(4, data.getUpdate_by());
            p.setString(5, data.getMessage_id());
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
