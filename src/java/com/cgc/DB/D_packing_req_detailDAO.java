/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.DataBeanD_packing_req_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Beckpalmx No7
 */
public class D_packing_req_detailDAO {
private int Returnvalue;

    public int insert(DataBeanD_packing_req_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_packing_req_detail (doc_id,line_no,product_id,place_prd,palate_no,qty_use,qty_balance,remark,wh_in,wh_out,doc_date,create_date,create_by) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getProduct_id());
            p.setString(4, dataBean.getPlace_prd());
            p.setString(5, dataBean.getPalate_no());
            p.setString(6, dataBean.getQty_use());
            p.setString(7, dataBean.getQty_balance());
            p.setString(8, dataBean.getRemark());
            p.setString(9, dataBean.getWh_in());
            p.setString(10, dataBean.getWh_out());
            p.setString(11, dataBean.getDoc_date());
            p.setTimestamp(12, dataBean.getDate());
            p.setString(13, dataBean.getBy());
            Returnvalue = p.executeUpdate();
        } finally {
            //JOptionPane.showConfirmDialog(null, "test");
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_packing_req_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql =
                "update d_packing_req_detail set  product_id=?,place_prd=?,palate_no=?,qty_use=?,qty_balance=?,remark=?,wh_in=?,wh_out=?,doc_date=?,update_date=?,update_by=? where doc_id=? and line_no=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            //p.setString(1, dataBean.getDoc_date());
            p.setString(1, dataBean.getProduct_id());
            p.setString(2, dataBean.getPlace_prd());
            p.setString(3, dataBean.getPalate_no());
            p.setString(4, dataBean.getQty_use());
            p.setString(5, dataBean.getQty_balance());
            p.setString(6, dataBean.getRemark());
            p.setString(7, dataBean.getWh_in());
            p.setString(8, dataBean.getWh_out());
            p.setString(9, dataBean.getDoc_date());
            p.setTimestamp(10, dataBean.getDate());
            p.setString(11, dataBean.getBy());
            p.setString(12, dataBean.getDoc_id());
            p.setString(13, dataBean.getLine_no());
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

    public DataBeanD_packing_req_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_packing_req_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        //JOptionPane.showConfirmDialog(null, "test");
        String SQL = "Select doc_id,doc_date,line_no,product_id,prod_name,place_prd,palate_no,qty_use,qty_balance,remark,wh_in,wh_out from vd_packing_req_detail where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setProduct_id(rs.getString("product_id"));
                bean.setProd_name(rs.getString("prod_name"));
                bean.setPlace_prd(rs.getString("place_prd"));
                bean.setPalate_no(rs.getString("palate_no"));
                bean.setQty_use(rs.getString("qty_use"));
                bean.setQty_balance(rs.getString("qty_balance"));
                bean.setRemark(rs.getString("remark"));
                bean.setWh_in(rs.getString("wh_in"));
                bean.setWh_out(rs.getString("wh_out"));
            }
        } finally {
            try {
                rs.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return bean;
    }
    //ทำการลบ Line_no ตามบรรทัดที่เลื่อกแล้วทำการ update ข

    public void DeleteLine_no(String inputarry, DataBeanD_packing_req_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        int count = 1;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 = "";
        try {
            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (int i = 0; i < strarry.length; i++) {
                    //JOptionPane.showConfirmDialog(null,strarry[i]);
                    sql = "update d_packing_req_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry[i]);
                    p.executeUpdate();
                }
                if (strarry.length != -1) {
                    ///strarryMem_line_no.clear();

                    p = null;
                    sql2 = "Select line_no from  d_packing_req_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno ";
                    rs = con.createStatement().executeQuery(sql2);
                    while (rs.next()) {
                        sql = "update d_packing_req_detail set line_no=? where doc_id=? and line_no=?";
                        p = con.prepareStatement(sql);
                        p.setString(1, Integer.toString(count));
                        p.setString(2, bean.getDoc_id());
                        p.setString(3, rs.getString("line_no"));
                        p.executeUpdate();
                        count = count + 1;
                    }
                }
            }
        } finally {
            try {
                if (inputarry.length() != 0)
                {
                rs.close();
                p.close();
                con.close();
                }
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }

    }

    public void Delete_line_no_All(DataBeanD_packing_req_detail dataBean) throws Exception {

        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_packing_req_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {

            p = con.prepareStatement(sqldetail);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
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
