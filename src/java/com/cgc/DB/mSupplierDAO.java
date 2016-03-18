package com.cgc.DB;

import java.sql.*;
import com.cgc.bean.*;

public class mSupplierDAO {

    public int insert(DataBeanCus_Sup dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "insert into msupplier (supplier_id,name_t,address1_t,tambol_code,amp_code,prov_code,zipcode,tel,fax,contact_name,remark,create_date,price_unit,location_id2) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getSupplier_id());
            p.setString(2, dataBean.getName_t());
            p.setString(3, dataBean.getAddress1_t());
            p.setString(4, dataBean.getTambol_code());
            p.setString(5, dataBean.getAmp_code());
            p.setString(6, dataBean.getProv_code());
            p.setString(7, dataBean.getZipcode());
            p.setString(8, dataBean.getTel());
            p.setString(9, dataBean.getFax());
            p.setString(10, dataBean.getContact_name());
            p.setString(11, dataBean.getRemark());
            p.setTimestamp(12, dataBean.getDate());
            p.setString(13, dataBean.getPrice_unit());
            p.setString(14, dataBean.getBranch_id());
            int a = p.executeUpdate();
            return a;

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public int Update(DataBeanCus_Sup dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql
                = "update msupplier set  name_t=?,address1_t=?,tambol_code=?,amp_code=?,prov_code=?,zipcode=?,tel=?,fax=?,contact_name=?,remark=?,update_date=?,price_unit=?,location_id2=? where supplier_id=? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);

            p.setString(1, dataBean.getName_t());
            p.setString(2, dataBean.getAddress1_t());
            p.setString(3, dataBean.getTambol_code());
            p.setString(4, dataBean.getAmp_code());
            p.setString(5, dataBean.getProv_code());
            p.setString(6, dataBean.getZipcode());
            p.setString(7, dataBean.getTel());
            p.setString(8, dataBean.getFax());
            p.setString(9, dataBean.getContact_name());
            p.setString(10, dataBean.getRemark());
            p.setTimestamp(11, dataBean.getDate());
            p.setString(12, dataBean.getPrice_unit());
            p.setString(13, dataBean.getBranch_id());
            p.setString(14, dataBean.getSupplier_id());
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

    public int UpDel(DataBeanCus_Sup dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update msupplier set delete_flag = ?,delete_date=? where supplier_id=? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getSupplier_id());
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

    public int UpDel_Real(DataBeanCus_Sup dataBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "delete from msupplier where supplier_id=? AND delete_flag = 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getSupplier_id());
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

    public static String selectData(String id) throws Exception {
        String str_return = "";
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From msupplier where supplier_id = ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, id);
            rs = p.executeQuery();
            while (rs.next()) {
                str_return = rs.getString("name_t");
                System.out.println("str_return = " + str_return);
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return str_return;
        }
    }

}
