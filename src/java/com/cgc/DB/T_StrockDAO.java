package com.cgc.DB;

import com.cgc.bean.T_StockBean;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class T_StrockDAO {

    public void insertDetail(T_StockBean stockBean, String wh) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO t_transaction_stock(doc_no,process_id,location_id,product_id,weight,"+wh+",doc_type,create_date,create_by) values(?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, stockBean.getDoc_no());
            p.setString(2, stockBean.getProcess_id());
            p.setString(3, stockBean.getLocation_id());
            p.setString(4, stockBean.getProduct_id());
            p.setString(5, stockBean.getWeight());
            p.setString(6, stockBean.getWh_in());
            p.setString(7, stockBean.getDoc_type());
            p.setTimestamp(8, stockBean.getCreate_date());
            p.setString(9, stockBean.getCreate_by());
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
