/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.ProductPriceBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import com.cgc.engine.Process_transaction;
import java.sql.SQLException;

/**
 *
 * @author com02
 */
public class ProductPriceDAO {

    Process_transaction objcom = new Process_transaction();

    public boolean insert(ProductPriceBean ppBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mproduct_price(pgroup_id,price_year,price_month_1,price_month_2,price_month_3,price_month_4,price_month_5,price_month_6,price_month_7,price_month_8,price_month_9,price_month_10,price_month_11,price_month_12,create_date,iodine,product_none_iodine,product_id,lot_no,remark) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, ppBean.getPgroup_id());
            p.setString(2, ppBean.getPrice_year());
            p.setString(3, ppBean.getPrice_month_1());
            p.setString(4, ppBean.getPrice_month_2());
            p.setString(5, ppBean.getPrice_month_3());
            p.setString(6, ppBean.getPrice_month_4());
            p.setString(7, ppBean.getPrice_month_5());
            p.setString(8, ppBean.getPrice_month_6());
            p.setString(9, ppBean.getPrice_month_7());
            p.setString(10, ppBean.getPrice_month_8());
            p.setString(11, ppBean.getPrice_month_9());
            p.setString(12, ppBean.getPrice_month_10());
            p.setString(13, ppBean.getPrice_month_11());
            p.setString(14, ppBean.getPrice_month_12());
            p.setTimestamp(15, ppBean.getCreate_date());
            p.setString(16, ppBean.getIodine());
            p.setString(17, ppBean.getProduct_none_iodine());
            p.setString(18, ppBean.getProduct_id());
            p.setString(19, ppBean.getLot_no());
            p.setString(20, ppBean.getRemark());
            p.executeUpdate();

            return true;

        } catch (SQLException e) {
            return false;
        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public ArrayList<ProductPriceBean> selectDataAll() throws Exception {
        ProductPriceBean ppBean;
        ArrayList<ProductPriceBean> list = new ArrayList<>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from mproduct_price where delete_flag <> 'Y' order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            rs = p.executeQuery();

            while (rs.next()) {
                ppBean = new ProductPriceBean();
                ppBean.setPgroup_id(rs.getString("pgroup_id"));
                ppBean.setPrice_year(rs.getString("price_year"));
                ppBean.setPrice_month_1(rs.getString("price_month_1"));
                ppBean.setPrice_month_2(rs.getString("price_month_2"));
                ppBean.setPrice_month_3(rs.getString("price_month_3"));
                ppBean.setPrice_month_4(rs.getString("price_month_4"));
                ppBean.setPrice_month_5(rs.getString("price_month_5"));
                ppBean.setPrice_month_6(rs.getString("price_month_6"));
                ppBean.setPrice_month_7(rs.getString("price_month_7"));
                ppBean.setPrice_month_8(rs.getString("price_month_8"));
                ppBean.setPrice_month_9(rs.getString("price_month_9"));
                ppBean.setPrice_month_10(rs.getString("price_month_10"));
                ppBean.setPrice_month_11(rs.getString("price_month_11"));
                ppBean.setPrice_month_12(rs.getString("price_month_12"));
                ppBean.setIodine(rs.getString("iodine"));
                ppBean.setProduct_id(rs.getString("product_id"));
                ppBean.setLot_no(rs.getString("lot_no"));
                ppBean.setRemark(rs.getString("remark"));
                ppBean.setRunno(rs.getInt("runno"));
                list.add(ppBean);
            }

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return list;
    }

    public void updateDel(ProductPriceBean ppBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mproduct_price SET delete_flag = 'Y' where runno = ?";
        PreparedStatement p;

        try {
            p = con.prepareStatement(sql);
            p.setInt(1, ppBean.getRunno());
            p.executeUpdate();
        } finally {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public void update(ProductPriceBean ppBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mproduct_price SET price_month_1=?,price_month_2=?,price_month_3=?"
                + ",price_month_4=?,price_month_5=?,price_month_6=?,price_month_7=?"
                + ",price_month_8=?,price_month_9=?,price_month_10=?,price_month_11=?,price_month_12=?"
                + ",update_date=?,product_none_iodine=?,product_id=?,lot_no=?,remark=?,update_by=? "
                + " where pgroup_id = ? and price_year = ? and iodine=? and runno=?";
        PreparedStatement p = null;
        System.out.println("update sql = " + sql);
        try {
            p = con.prepareStatement(sql);
            p.setString(1, ppBean.getPrice_month_1());
            p.setString(2, ppBean.getPrice_month_2());
            p.setString(3, ppBean.getPrice_month_3());
            p.setString(4, ppBean.getPrice_month_4());
            p.setString(5, ppBean.getPrice_month_5());
            p.setString(6, ppBean.getPrice_month_6());
            p.setString(7, ppBean.getPrice_month_7());
            p.setString(8, ppBean.getPrice_month_8());
            p.setString(9, ppBean.getPrice_month_9());
            p.setString(10, ppBean.getPrice_month_10());
            p.setString(11, ppBean.getPrice_month_11());
            p.setString(12, ppBean.getPrice_month_12());
            p.setTimestamp(13, ppBean.getUpdate_date());
            p.setString(14, ppBean.getProduct_none_iodine());
            p.setString(15, ppBean.getProduct_id());
            p.setString(16, ppBean.getLot_no());
            p.setString(17, ppBean.getRemark());
            p.setString(18, ppBean.getUpdate_by());
            p.setString(19, ppBean.getPgroup_id());
            p.setString(20, ppBean.getPrice_year());
            p.setString(21, ppBean.getIodine());
            p.setInt(22, ppBean.getRunno());
            p.executeUpdate();

            //if (ppBean.getPgroup_id().equalsIgnoreCase("RAW")) {
            //    System.out.println("RAW");
            //} else {
            //    objcom.main_check(ppBean.getStart_year(), ppBean.getCurrent_date(),"System Product_Price","WAREHOUSE");
            //}
        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public ProductPriceBean selectData(String productid, String price_year, String iodine, int runno) throws Exception {
        ProductPriceBean ppBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs;
        Connection con = dbConnect.openNewConnection();
        //String sql = "SELECT * From mproduct_price where pgroup_id = ? AND price_year = ? AND iodine = ? AND product_id = ? and lot_no = ? AND delete_flag <> 'Y'";
        String sql = "SELECT * From mproduct_price where runno = " + runno;
        System.out.println("SQL Select = " + sql);
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, productid);
            p.setString(2, price_year);
            p.setString(3, iodine);
            System.out.println("sel productid = " + productid);
            System.out.println("sel price_year = " + price_year);
            rs = p.executeQuery();
            while (rs.next()) {
                ppBean = new ProductPriceBean();
                ppBean.setRunno(rs.getInt("runno"));
                ppBean.setPgroup_id(rs.getString("pgroup_id"));
                ppBean.setProduct_id(rs.getString("product_id"));
                ppBean.setIodine(rs.getString("iodine"));
                ppBean.setLot_no(rs.getString("lot_no"));
                ppBean.setRemark(rs.getString("remark"));
                ppBean.setDelete_flag(rs.getString("delete_flag"));

                System.out.println("res pgroup_id = " + rs.getString("pgroup_id"));
                System.out.println("res price_year = " + rs.getString("price_year"));
            }

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return ppBean;
    }
}
