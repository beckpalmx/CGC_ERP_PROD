/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.MenuBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;


public class MenuDAO {

    public MenuBean selectSubMenu(String data) throws Exception {
        MenuBean menuBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        //String sql = "SELECT * From mmenu_sub where sub_menu_id = ? and delete_flag = 'N' order by main_menu_id,sub_menu_id";
        String sql = "SELECT * From mmenu_sub where sub_menu_id = ? and delete_flag = 'N' order by runno,sub_menu_id";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, data);
            rs = p.executeQuery();
            while (rs.next()) {
                menuBean = new MenuBean();
                menuBean.setSub_menu_id(rs.getString("sub_menu_id"));
                menuBean.setMain_menu_id(rs.getString("main_menu_id"));
                menuBean.setScreen_id(rs.getString("screen_id"));
                menuBean.setName_t(rs.getString("name_t"));
                menuBean.setImg(rs.getString("img"));
                menuBean.setImg_swap(rs.getString("img_swap"));
                menuBean.setPage_type(rs.getString("page_type"));
                menuBean.setDelete_flag(rs.getString("delete_flag"));
                menuBean.setDoc_no(rs.getString("doc_no"));
                menuBean.setDoc_eff_date(rs.getString("doc_eff_date"));
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return menuBean;
        }
    }

    public MenuBean selectMainMenu(String data) throws Exception {
        MenuBean menuBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mmenu_main where main_menu_id = ? and delete_flag = 'N' order by runno ";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, data);
            rs = p.executeQuery();
            while (rs.next()) {
                menuBean = new MenuBean();
                menuBean.setMain_menu_id(rs.getString("main_menu_id"));
                menuBean.setName_t(rs.getString("name_t"));
                menuBean.setDelete_flag(rs.getString("delete_flag"));
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return menuBean;
        }
    }
    public MenuBean selectPriviledge(String id) throws Exception {
        MenuBean menuBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mpriviledge where priviledge_id = ?";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, id);
            rs = p.executeQuery();
            while (rs.next()) {
                menuBean = new MenuBean();
                menuBean.setMain_menu_id(rs.getString("main_menu_id"));
                menuBean.setSub_menu_id(rs.getString("sub_menu_id"));
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return menuBean;
        }
    }
    public boolean insertMain(MenuBean menuBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mmenu_main(main_menu_id, name_t,remark,create_date) values(?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, menuBean.getMain_menu_id());
            p.setString(2, menuBean.getName_t());
            p.setString(3, menuBean.getRemark());
            p.setTimestamp(4, menuBean.getCreate_date());
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
    public boolean insertSub(MenuBean menuBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mmenu_sub(sub_menu_id,main_menu_id,screen_id,name_t,remark,create_date,doc_no,doc_eff_date,img,img_swap,page_type) values(?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        
        try {
            p = con.prepareStatement(sql);
            p.setString(1, menuBean.getSub_menu_id());
            p.setString(2, menuBean.getMain_menu_id());
            p.setString(3, menuBean.getScreen_id());
            p.setString(4, menuBean.getName_t());
            p.setString(5, menuBean.getRemark());
            p.setTimestamp(6, menuBean.getCreate_date());
            p.setString(7, menuBean.getDoc_no());
            p.setString(8, menuBean.getDoc_eff_date());      
            p.setString(9, menuBean.getImg());
            p.setString(10, menuBean.getImg_swap());  
            
            //p.setString(9, "../IMAGES/ICON/file0.png");
            //p.setString(10, "../IMAGES/ICON/file1.png");    
            
            p.setString(11, menuBean.getPage_type());          
            
            p.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace(System.out);
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
    public void  updateMain(MenuBean menuBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mmenu_main SET name_t=?,remark=?,update_date=? where main_menu_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, menuBean.getName_t());
            p.setString(2, menuBean.getRemark());
            p.setTimestamp(3, menuBean.getUpdate_date());
            p.setString(4, menuBean.getMain_menu_id());

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
    public void  updateSub(MenuBean menuBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mmenu_sub SET main_menu_id=?,screen_id=?,name_t=?,remark=?,update_date=?,doc_no=?,doc_eff_date=?,page_type=? where sub_menu_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, menuBean.getMain_menu_id());
            p.setString(2, menuBean.getScreen_id());
            p.setString(3, menuBean.getName_t());
            p.setString(4, menuBean.getRemark());
            p.setTimestamp(5, menuBean.getUpdate_date());
            p.setString(6, menuBean.getDoc_no());
            p.setString(7, menuBean.getDoc_eff_date());
            p.setString(8, menuBean.getPage_type());
            p.setString(9, menuBean.getSub_menu_id());

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
    public void  updateDelMain(MenuBean menuBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mmenu_main SET delete_flag = 'Y' where main_menu_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, menuBean.getMain_menu_id());
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
    public void  updateDelSub(MenuBean menuBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mmenu_sub SET delete_flag = 'Y' where sub_menu_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, menuBean.getSub_menu_id());
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
    public ArrayList<MenuBean> selectDataSubList(String id) throws Exception {
        MenuBean menuBean = null;
        ArrayList<MenuBean> list = new ArrayList<MenuBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        //String sql = "SELECT * From mmenu_sub where main_menu_id = ? AND delete_flag <> 'Y' order by runno";
        //String sql = "SELECT * From mmenu_sub where main_menu_id = ? AND delete_flag <> 'Y' order by main_menu_id,sub_menu_id ";
        String sql = "SELECT * From mmenu_sub where main_menu_id = ? AND delete_flag <> 'Y' order by runno,sub_menu_id ";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, id);
            rs = p.executeQuery();

            while (rs.next()) {
                menuBean = new MenuBean();
                menuBean.setName_t(rs.getString("name_t"));
                menuBean.setScreen_id(rs.getString("screen_id"));
                menuBean.setSub_menu_id(rs.getString("sub_menu_id"));
                list.add(menuBean);
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
    public ArrayList<MenuBean> selectDataMainList() throws Exception {
        MenuBean menuBean = null;
        ArrayList<MenuBean> list = new ArrayList<MenuBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mmenu_main order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            rs = p.executeQuery();

            while (rs.next()) {
                menuBean = new MenuBean();
                menuBean.setMain_menu_id(rs.getString("main_menu_id"));
                menuBean.setName_t(rs.getString("name_t"));
                list.add(menuBean);
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
    public boolean InsertParam(String sreen,String lookup)throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mreport_param(report_id, lookup_name,create_date) values(?,?,?)";
        PreparedStatement p = null;
        Timestamp ts = new Timestamp( new java.util.Date().getTime());

        try {
            p = con.prepareStatement(sql);
            p.setString(1, sreen);
            p.setString(2, lookup);
            p.setTimestamp(3, ts);
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
    public void  updateParam(String sreen,String lookup) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mreport_param SET lookup_name=?,update_date=? where report_id=?";
        PreparedStatement p = null;
        Timestamp ts = new Timestamp( new java.util.Date().getTime());
        try {
            p = con.prepareStatement(sql);
            p.setString(1, lookup);
            p.setTimestamp(2, ts);
            p.setString(3, sreen);

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
