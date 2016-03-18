/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.ProductBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.TimeZone;
import com.cgc.Util.SendMail;
import com.cgc.bean.DataBeanSendMail;
import java.sql.SQLException;

/**
 *
 * @author com02
 */
public class ProductDAO {

    private int Returnvalue;
    private final UtiDatabase objuti = new UtiDatabase();

    Calendar localCalendar = Calendar.getInstance(TimeZone.getDefault());
    int currentYear = localCalendar.get(Calendar.YEAR);
    String ScurrentYear = Integer.toString(currentYear);

    public boolean insert(ProductBean proBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();


        /*      Function For Date 
         * 
         Date currentTime = localCalendar.getTime();
         int currentDay = localCalendar.get(Calendar.DATE);
         int currentMonth = localCalendar.get(Calendar.MONTH) + 1;
         int currentYear = localCalendar.get(Calendar.YEAR);
         int currentDayOfWeek = localCalendar.get(Calendar.DAY_OF_WEEK);
         int currentDayOfMonth = localCalendar.get(Calendar.DAY_OF_MONTH);
         int CurrentDayOfYear = localCalendar.get(Calendar.DAY_OF_YEAR);

         */
        String sql = "INSERT INTO mproduct"
                + "(product_id,pgroup_id,ptype_id,pcat_id,name_t,price,min,max,safety,quantity,weight,location_id,value,remark,create_date,size_id,butane,ctc,iodine,unit_id,lot_no,create_by) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, proBean.getProduct_id());
            p.setString(2, proBean.getPgroup_id());
            p.setString(3, proBean.getPtype_id());
            p.setString(4, proBean.getPcat_id());
            p.setString(5, proBean.getName_t());
            p.setString(6, proBean.getPrice());
            p.setString(7, proBean.getMin());
            p.setString(8, proBean.getMax());
            p.setString(9, proBean.getSafety());
            p.setString(10, proBean.getQuantity());
            p.setString(11, proBean.getWeight());
            p.setString(12, proBean.getLocation_id());
            p.setString(13, proBean.getValue());
            p.setString(14, proBean.getRemark());
            p.setTimestamp(15, proBean.getCreate_date());
            p.setString(16, proBean.getSize_id());
            p.setString(17, proBean.getButane());
            p.setString(18, proBean.getCtc());
            p.setString(19, proBean.getIodine());
            p.setString(20, proBean.getUnit_id());
            p.setString(21, proBean.getLot_no());
            p.setString(22, proBean.getCreate_by());
            p.executeUpdate();

            System.out.println("getPgroup_id = " + proBean.getPgroup_id());
            System.out.println("currentYear = " + currentYear);

            if (proBean.getPgroup_id().equals("IMP") || proBean.getPgroup_id().equals("WIP-FC")) {

                sql = "select count(product_id) as num from mproduct_price where product_id ='" + proBean.getProduct_id() + "'"
                        + " and pgroup_id = '" + proBean.getPgroup_id() + "'"
                        + " and price_year = '" + currentYear + "' and delete_flag <> 'Y' ";
                System.out.println("sql = " + sql);

                if (objuti.numRowdatabase(sql) == 0) {

                    sql = "INSERT INTO mproduct_price(pgroup_id,price_year,iodine,product_id,lot_no,create_by,create_date) values(?,?,?,?,?,?,?)";
                    System.out.println("Insert = " + sql);
                    p = con.prepareStatement(sql);
                    p.setString(1, proBean.getPgroup_id());
                    p.setString(2, ScurrentYear);
                    p.setString(3, proBean.getIodine());
                    p.setString(4, proBean.getProduct_id());
                    p.setString(5, proBean.getLot_no());
                    p.setString(6, proBean.getCreate_by());
                    p.setTimestamp(7, proBean.getCreate_date());
                    Returnvalue = p.executeUpdate();

                } else {

                    sql = "update mproduct_price set pgroup_id=?,price_year=?,iodine=?,product_id=?,lot_no=?,update_by=?,update_date=? "
                            + " where product_id ='" + proBean.getProduct_id() + "'"
                            + " and pgroup_id = '" + proBean.getPgroup_id() + "'"
                            + " and price_year = '" + currentYear + "' and delete_flag <> 'Y' ";
                    System.out.println("Update sql product = " + sql);
                    p = con.prepareStatement(sql);
                    p.setString(1, proBean.getPgroup_id());
                    p.setString(2, ScurrentYear);
                    p.setString(3, proBean.getIodine());
                    p.setString(4, proBean.getProduct_id());
                    p.setString(5, proBean.getLot_no());
                    p.setString(6, proBean.getCreate_by());
                    p.setTimestamp(7, proBean.getCreate_date());
                    p.executeUpdate();

                }

                System.out.println("Returnvalue = " + Returnvalue);
                if (Returnvalue == 1) {
                    send_email(proBean, con);
                }
            }

        } catch (Exception e) {
            return false;
        } finally {
            try {
                con.close();
                System.out.println("Close Connection Mproduct_Price");
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return true;
    }

    public void updateDel(ProductBean proBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mproduct SET delete_flag = 'Y' where product_id=?";
        PreparedStatement p;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, proBean.getProduct_id());
            p.executeUpdate();
        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public void update(ProductBean proBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mproduct SET "
                + "pgroup_id=?,ptype_id=?,pcat_id=?,name_t=?,price=?,min=?,max=?,safety=?,quantity=?,weight=?,location_id=?,value=?,remark=?,update_date=?,size_id=?,butane=?,ctc=?,iodine=?,unit_id=?,lot_no=?,update_by=? "
                + "where product_id = ? and delete_flag = 'N'";
        PreparedStatement p;

        System.out.println("Current_Year" + currentYear);

        try {
            p = con.prepareStatement(sql);
            p.setString(1, proBean.getPgroup_id());
            p.setString(2, proBean.getPtype_id());
            p.setString(3, proBean.getPcat_id());
            p.setString(4, proBean.getName_t());
            p.setString(5, proBean.getPrice());
            p.setString(6, proBean.getMin());
            p.setString(7, proBean.getMax());
            p.setString(8, proBean.getSafety());
            p.setString(9, proBean.getQuantity());
            p.setString(10, proBean.getWeight());
            p.setString(11, proBean.getLocation_id());
            p.setString(12, proBean.getValue());
            p.setString(13, proBean.getRemark());
            p.setTimestamp(14, proBean.getUpdate_date());
            p.setString(15, proBean.getSize_id());
            p.setString(16, proBean.getButane());
            p.setString(17, proBean.getCtc());
            p.setString(18, proBean.getIodine());
            p.setString(19, proBean.getUnit_id());
            p.setString(20, proBean.getLot_no());
            p.setString(21, proBean.getCreate_by());
            p.setString(22, proBean.getProduct_id());
            p.executeUpdate();

            System.out.println("getPgroup_id = " + proBean.getPgroup_id());
            System.out.println("currentYear = " + currentYear);

            if (proBean.getPgroup_id().equals("IMP") || proBean.getPgroup_id().equals("WIP-FC")) {

                sql = "select count(product_id) as num from mproduct_price where product_id ='" + proBean.getProduct_id() + "'"
                        + " and pgroup_id = '" + proBean.getPgroup_id() + "'"
                        + " and price_year = '" + currentYear + "' and delete_flag <> 'Y' ";
                System.out.println("sql = " + sql);

                if (objuti.numRowdatabase(sql) == 0) {

                    sql = "INSERT INTO mproduct_price(pgroup_id,price_year,iodine,product_id,lot_no,create_by,create_date) values(?,?,?,?,?,?,?)";
                    System.out.println("Insert = " + sql);
                    p = con.prepareStatement(sql);
                    p.setString(1, proBean.getPgroup_id());
                    p.setString(2, ScurrentYear);
                    p.setString(3, proBean.getIodine());
                    p.setString(4, proBean.getProduct_id());
                    p.setString(5, proBean.getLot_no());
                    p.setString(6, proBean.getCreate_by());
                    p.setTimestamp(7, proBean.getCreate_date());
                    p.executeUpdate();

                } else {

                    sql = "update mproduct_price set pgroup_id=?,price_year=?,iodine=?,product_id=?,lot_no=?,update_by=?,update_date=? "
                            + " where product_id ='" + proBean.getProduct_id() + "'"
                            + " and pgroup_id = '" + proBean.getPgroup_id() + "'"
                            + " and price_year = '" + currentYear + "' and delete_flag <> 'Y' ";
                    System.out.println("Update sql product = " + sql);
                    p = con.prepareStatement(sql);
                    p.setString(1, proBean.getPgroup_id());
                    p.setString(2, ScurrentYear);
                    p.setString(3, proBean.getIodine());
                    p.setString(4, proBean.getProduct_id());
                    p.setString(5, proBean.getLot_no());
                    p.setString(6, proBean.getCreate_by());
                    p.setTimestamp(7, proBean.getCreate_date());
                    p.executeUpdate();

                }
            }

        } finally {
            try {
                //p.close();
                con.close();
                System.out.println("Close Connection UPDATE");
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public ProductBean selectData(String id) throws Exception {

        ProductBean proBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mproduct where product_id = ? AND delete_flag <> 'Y'";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, id);
            rs = p.executeQuery();
            while (rs.next()) {
                proBean = new ProductBean();
                proBean.setProduct_id(rs.getString("product_id"));
                proBean.setDelete_fag(rs.getString("delete_flag"));

            }

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return proBean;
    }

    public void send_email(ProductBean proBean, Connection con) throws Exception {

        DataBeanSendMail dataBeansendmail = new SendMail(con, proBean.getScreen_id()).Return_DataBeanSendMail();

        if (!dataBeansendmail.getEmail_from().equals("") && !dataBeansendmail.getEmail_to().equals("")
                && !dataBeansendmail.getEmail_server().equals("") && !dataBeansendmail.getEmail_port().equals("")) {

            String subject = "CGC ERP System : มีการเพิ่มรหัสสินค้าใหม่ : " + proBean.getProduct_id() + " Lot No : " + proBean.getLot_no();

            String message = "-------------------------------------------------------------------------------------------------";
            message = message + "<br>";
            message = message + "รหัสสินค้าใหม่ : " + proBean.getProduct_id();
            message = message + "<br>";
            message = message + " Lot No : " + proBean.getLot_no();
            message = message + "<br>";
            message = message + "รายละเอียดสินค้า : " + proBean.getName_t();
            message = message + "<br>";
            message = message + "Iodine : " + proBean.getIodine();
            message = message + "<br>";
            message = message + " กลุ่มสินค้า : " + proBean.getPgroup_id();
            message = message + "<br>";
            message = message + "ปี : " + ScurrentYear;
            message = message + "<br>" + "-------------------------------------------------------------------------------------------------";
            message = message + "<br>" + "เพื่อความถูกต้องสมบูรณ์ โปรดตรวจสอบรายการอีกครั้ง";

            System.out.println("message = " + message);

            //message = message + "<br>" + "<a href=\"http://202.183.167.6:8089/CGC_ERP\">CGC ERP LOGIN กรุณาล๊อคอิน</a>";  
            String[] array_to = dataBeansendmail.getEmail_to().split(";");
            for (String array_to1 : array_to) {
                SendMail sendMail = new SendMail(dataBeansendmail.getEmail_from(), array_to1, subject, message);
                sendMail.send(dataBeansendmail.getEmail_server(), dataBeansendmail.getEmail_port());
                System.out.println(array_to1);
                System.out.println(subject);
                //System.out.println(sendMail);

            }
        }

    }

}
