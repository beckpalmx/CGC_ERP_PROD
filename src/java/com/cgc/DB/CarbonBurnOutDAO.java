package com.cgc.DB;

import com.cgc.bean.CarbonBurnOutBean;
import com.cgc.bean.T_StockBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CarbonBurnOutDAO {
    public void insertDetail(CarbonBurnOutBean carbonBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO d_carbon_burn_out_detail() values(?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            //p.setInt(1, carbonBean.get());

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
    public void insertTransectionStock(T_StockBean t_stockBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO t_transaction_stock() values(?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            //p.setInt(1, carbonBean.get());

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

    public ArrayList<CarbonBurnOutBean> selectDataSearch(String id) throws Exception {
        CarbonBurnOutBean carbonBean = null;
        ArrayList<CarbonBurnOutBean> list = new ArrayList<CarbonBurnOutBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from vd_carbon_burn_out_detail_wh where delete_flag <> 'Y' and complete_flag = 'N' and doc_id=? order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, id);
            rs = p.executeQuery();

            while (rs.next()) {
                carbonBean = new CarbonBurnOutBean();
                carbonBean.setProduction_no(rs.getString("production_no"));
                carbonBean.setProduct_id(rs.getString("product_id"));
                carbonBean.setLocation_id(rs.getString("loc_id"));
                carbonBean.setRaw_mat(rs.getString("rawmatt_id"));
                carbonBean.setSize(rs.getString("size"));
                carbonBean.setBag(rs.getString("bag"));
                carbonBean.setWeight(rs.getString("weight"));
                carbonBean.setCtc_i2(rs.getString("ctc_i2"));
                carbonBean.setProduct_no(rs.getString("production_no"));

                list.add(carbonBean);
            }
        }catch (Exception e){
            e.printStackTrace(System.out);
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
    //-->
}
