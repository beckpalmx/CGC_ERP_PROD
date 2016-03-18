package com.cgc.DB;

import com.cgc.bean.CostProductBean;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class AddCostDAO {
    public void insertDetail(CostProductBean costBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO d_cost_product(doc_id,job_id,std_id,std_sub_id,oh_id,driver_id,cost_value,create_date,create_by) values(?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, costBean.getDoc_id());
            p.setString(2, costBean.getJob_id());
            p.setString(3, costBean.getStd_id());
            p.setString(4, costBean.getStd_sub_id());
            p.setString(5, costBean.getOh_id());
            p.setString(6, costBean.getDriver_id());
            p.setString(7, costBean.getCost_value());
            p.setTimestamp(8, costBean.getCreate_date());
            p.setString(9, costBean.getCreate_by());
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
