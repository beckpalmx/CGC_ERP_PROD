package com.cgc.DB;

import com.cgc.bean.DataBeanD_FUEL_Receive;
import java.sql.*;

public class D_fuel_receiveDAO {

    private int Returnvalue;

    public int insert(DataBeanD_FUEL_Receive dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_fuel_receive "
                + "(doc_id,doc_date,wh_in,supplier_id,position_no,scale_no,car_weight_in,car_weight_out,total_weight,car_date_in,"
                + "car_time_in,car_date_out,car_time_out,car_no,product_id,driver_name,reporter,checker1,remark,price_unit,"
                + "total_price,moisture,moisture_std,deduct_weight_moisture,net_weight_receive,net_weight_payment,status,"
                + "create_date,create_by) "
                + "values(?,?,?,?,?,?,?,?,?,?,"
                + "?,?,?,?,?,?,?,?,?,?,"
                + "?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getWh_in());
            p.setString(4, dataBean.getSupplier_id());
            p.setString(5, dataBean.getPosition_no());
            p.setString(6, dataBean.getScale_no());
            p.setString(7, dataBean.getCar_weight_in());
            p.setString(8, dataBean.getCar_weight_out());
            p.setString(9, dataBean.getTotal_weight());
            p.setString(10, dataBean.getCar_date_in());
            p.setString(11, dataBean.getCar_time_in());
            p.setString(12, dataBean.getCar_date_out());
            p.setString(13, dataBean.getCar_time_out());
            p.setString(14, dataBean.getCar_no());
            p.setString(15, dataBean.getProduct_id());
            p.setString(16, dataBean.getDriver_name());
            p.setString(17, dataBean.getReporter());
            p.setString(18, dataBean.getChecker1());
            p.setString(19, dataBean.getRemark());
            p.setString(20, dataBean.getPrice_unit());
            p.setString(21, dataBean.getTotal_price());
            p.setString(22, dataBean.getMoisture());
            p.setString(23, dataBean.getMoisture_std());
            p.setString(24, dataBean.getDeduct_weight_moisture());
            p.setString(25, dataBean.getNet_weight_receive());
            p.setString(26, dataBean.getNet_weight_payment());
            p.setString(27, dataBean.getStatus());
            p.setTimestamp(28, dataBean.getDate());
            p.setString(29, dataBean.getBy());
            //p.setString(30, dataBean.getComplete_flag());  
            Returnvalue = p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_FUEL_Receive dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_fuel_receive set  doc_date=?,wh_in=?,supplier_id=?,position_no=? "
                + ",scale_no=?,car_weight_in=?,car_weight_out=?,total_weight=? "
                + ",car_date_in=?,car_time_in=?,car_date_out=?,car_time_out=? "
                + ",car_no=?,product_id=?,driver_name=?,reporter=? "
                + ",checker1=?,remark=?,price_unit=?,total_price=?,moisture=? "
                + ",moisture_std=?,deduct_weight_moisture=? "
                + ",net_weight_receive=?,net_weight_payment=?,status=? "
                + ",update_date=?,update_by=?,complete_flag=? "
                + "where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getWh_in());
            p.setString(3, dataBean.getSupplier_id());
            p.setString(4, dataBean.getPosition_no());
            p.setString(5, dataBean.getScale_no());
            p.setString(6, dataBean.getCar_weight_in());
            p.setString(7, dataBean.getCar_weight_out());
            p.setString(8, dataBean.getTotal_weight());
            p.setString(9, dataBean.getCar_date_in());
            p.setString(10, dataBean.getCar_time_in());
            p.setString(11, dataBean.getCar_date_out());
            p.setString(12, dataBean.getCar_time_out());
            p.setString(13, dataBean.getCar_no());
            p.setString(14, dataBean.getProduct_id());
            p.setString(15, dataBean.getDriver_name());
            p.setString(16, dataBean.getReporter());
            p.setString(17, dataBean.getChecker1());
            p.setString(18, dataBean.getRemark());
            p.setString(19, dataBean.getPrice_unit());
            p.setString(20, dataBean.getTotal_price());
            p.setString(21, dataBean.getMoisture());
            p.setString(22, dataBean.getMoisture_std());
            p.setString(23, dataBean.getDeduct_weight_moisture());
            p.setString(24, dataBean.getNet_weight_receive());
            p.setString(25, dataBean.getNet_weight_payment());
            p.setString(26, dataBean.getStatus());
            p.setTimestamp(27, dataBean.getDate());
            p.setString(28, dataBean.getBy());
            p.setString(29, dataBean.getComplete_flag());
            p.setString(30, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();

            if (dataBean.getComplete_flag().equals("Y")) {
                    UpCompeteFlag(dataBean.getComplete_flag(),dataBean.getScale_no());
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public int UpDel(DataBeanD_FUEL_Receive dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_fuel_receive set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return Returnvalue;
    }

    public int UpCompeteFlag(String doc_id,String scale_no) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_fuel_receive set complete_flag = 'Y' where doc_id=? ";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, doc_id);
            Returnvalue = p.executeUpdate();

            sql = "update d_ticketbuy_fuel set doc_type = 'Y' where ticket_text = ? ";
            p = con.prepareStatement(sql);
            p.setString(1, scale_no);
            Returnvalue = p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return Returnvalue;
    }
}
