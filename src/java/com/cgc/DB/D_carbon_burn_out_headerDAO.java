/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Calculator.Cal_Total;
import com.cgc.bean.DataBeanD_carbon_burn_out_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.cgc.Util.UtiDatabase;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;

/**
 *
 * @author Beckpalmx No7
 */
public class D_carbon_burn_out_headerDAO {

    private int Returnvalue;
    private double lost_total;

    public int insert(DataBeanD_carbon_burn_out_header dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        DecimalFormat df = new DecimalFormat();
        df.applyPattern("###.00");
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();

        String sql = "insert into d_carbon_burn_out_header "
                + "(doc_id,doc_date,work_date,time_from,time_to,runner_id,shift,wh_in,wh_out,burn_no,product_id,ch_from,ch_to,weight_split,burn_out_date,lost_weight,total_weight,create_date,update_date,create_by,report_id,complete_flag,count_send_complete)"
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getWork_date());
            p.setString(4, dataBean.getTime_from());
            p.setString(5, dataBean.getTime_to());
            p.setString(6, dataBean.getRunner_id());
            p.setString(7, dataBean.getShift());
            p.setString(8, dataBean.getWh_in());
            p.setString(9, dataBean.getWh_out());
            p.setString(10, dataBean.getBurn_no());
            p.setString(11, dataBean.getProduct_id());
            p.setString(12, dataBean.getCh_from());
            p.setString(13, dataBean.getCh_to());
            p.setString(14, dataBean.getWeight_split());
            p.setString(15, dataBean.getBurn_out_date());
            p.setString(16, dataBean.getLost_weight());
            p.setString(17, dataBean.getTotal_weight());
            p.setTimestamp(18, dataBean.getDate());
            p.setTimestamp(19, dataBean.getDate());
            p.setString(20, dataBean.getBy());
            p.setString(21, dataBean.getReport_id());
            p.setString(22, dataBean.getComplete_flag());
            p.setString(23, objuti.Count_sendcomplete("d_carbon_burn_out_header", dataBean.getDoc_id(), dataBean.getComplete_flag(), con));
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_carbon_burn_out_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

            if (objuti.numRowdatabase(sql) != 0) {//ตรวจสอบว่ารหัสนี้มี Row ใน Detail หรือไม่

                sql = "update d_carbon_burn_out_detail set doc_date=?,wh_in=?,wh_out=?,create_by=?,shift=?,complete_flag=?,burn_no=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getWh_in());
                p.setString(3, dataBean.getWh_out());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getShift());
                p.setString(6, dataBean.getComplete_flag());
                p.setString(7, dataBean.getBurn_no());
                p.setString(8, dataBean.getDoc_id());
                p.executeUpdate();
                //________________________________________________________
                lost_total = 0;
                if (dataBean.getComplete_flag().equals("N")) {// ตรวจสอบว่า Complete_flag == N
                    Cal_Total cal = new Cal_Total("d_carbon_burn_out_detail", "weight", dataBean.getDoc_id(), "and complete_flag = 'N'");
                    lost_total = (Double.parseDouble(cal.Return_Total()) - Double.parseDouble(dataBean.getWeight_split()));//*(-1) ;
                    dataBean.setTotal_weight(cal.Return_Total());
                    dataBean.setLost_weight(df.format(lost_total));
                    sql = "update d_carbon_burn_out_header set lost_weight=?,total_weight=? where doc_id = ? and delete_flag <> 'Y' and complete_flag = 'N'";
                } else {// ตรวจสอบว่า Complete_flag == Y
                    Cal_Total cal = new Cal_Total("d_carbon_burn_out_detail", "weight", dataBean.getDoc_id(), "and complete_flag = 'Y'");
                    lost_total = (Double.parseDouble(cal.Return_Total()) - Double.parseDouble(dataBean.getWeight_split()));
                    dataBean.setTotal_weight(cal.Return_Total());
                    dataBean.setLost_weight(df.format(lost_total));
                    sql = "update d_carbon_burn_out_header set lost_weight=?,total_weight=? where doc_id = ? and delete_flag <> 'Y' and complete_flag = 'Y'";
                }
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getLost_weight());
                p.setString(2, dataBean.getTotal_weight());
                p.setString(3, dataBean.getDoc_id());
                p.executeUpdate();
                //_________________________________________________________
            }
            if (dataBean.getComplete_flag().equals("Y")) {//ถ้าcomplete_flag == Y ให้ทำการ copyไปอีก Table
                CopyToD_carbon_burn_out_wh(dataBean);
            }
        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_carbon_burn_out_header dataBean) throws Exception {
        DecimalFormat df = new DecimalFormat();
        df.applyPattern("###.00");
        UtiDatabase objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql =
                "update d_carbon_burn_out_header set "
                + "doc_date=?,work_date=?,time_from=?,time_to=?,runner_id=?,shift=?,wh_in=?,wh_out=?,burn_no=?,product_id=?,ch_from=?,ch_to=?,weight_split=?,burn_out_date=?,lost_weight=?,total_weight=?,update_date=?,update_by=?,report_id=?,complete_flag=?,count_send_complete=? "
                + "where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getWork_date());
            p.setString(3, dataBean.getTime_from());
            p.setString(4, dataBean.getTime_to());
            p.setString(5, dataBean.getRunner_id());
            p.setString(6, dataBean.getShift());
            p.setString(7, dataBean.getWh_in());
            p.setString(8, dataBean.getWh_out());
            p.setString(9, dataBean.getBurn_no());
            p.setString(10, dataBean.getProduct_id());
            p.setString(11, dataBean.getCh_from());
            p.setString(12, dataBean.getCh_to());
            p.setString(13, dataBean.getWeight_split());
            p.setString(14, dataBean.getBurn_out_date());
            p.setString(15, dataBean.getLost_weight());
            p.setString(16, dataBean.getTotal_weight());
            p.setTimestamp(17, dataBean.getDate());
            p.setString(18, dataBean.getBy());
            p.setString(19, dataBean.getReport_id());
            p.setString(20, dataBean.getComplete_flag());
            p.setString(21, objuti.Count_sendcomplete("d_carbon_burn_out_header", dataBean.getDoc_id(), dataBean.getComplete_flag(), con));
            p.setString(22, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_carbon_burn_out_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_carbon_burn_out_detail set doc_date=?,wh_in=?,wh_out=?,create_by=?,shift=?,complete_flag=?,burn_no=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                //p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getWh_in());
                p.setString(3, dataBean.getWh_out());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getShift());
                p.setString(6, dataBean.getComplete_flag());
                p.setString(7, dataBean.getBurn_no());
                p.setString(8, dataBean.getDoc_id());
                p.executeUpdate();
                //________________________________________________________
                lost_total = 0;
                if (dataBean.getComplete_flag().equals("N")) {
                    Cal_Total cal = new Cal_Total("d_carbon_burn_out_detail", "weight", dataBean.getDoc_id(), "and complete_flag = 'N'");
                    lost_total = (Double.parseDouble(cal.Return_Total()) - Double.parseDouble(dataBean.getWeight_split()));//*(-1) ;
                    dataBean.setTotal_weight(cal.Return_Total());
                    dataBean.setLost_weight(df.format(lost_total));
                    sql = "update d_carbon_burn_out_header set lost_weight=?,total_weight=? where doc_id = ? and delete_flag <> 'Y' and complete_flag = 'N'";
                } else {
                    Cal_Total cal = new Cal_Total("d_carbon_burn_out_detail", "weight", dataBean.getDoc_id(), "and complete_flag = 'Y'");
                    lost_total = (Double.parseDouble(cal.Return_Total()) - Double.parseDouble(dataBean.getWeight_split()));
                    dataBean.setTotal_weight(cal.Return_Total());
                    dataBean.setLost_weight(df.format(lost_total));
                    sql = "update d_carbon_burn_out_header set lost_weight=?,total_weight=? where doc_id = ? and delete_flag <> 'Y' and complete_flag = 'Y'";
                }
                //p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getLost_weight());
                p.setString(2, dataBean.getTotal_weight());
                p.setString(3, dataBean.getDoc_id());
                p.executeUpdate();
                //_________________________________________________________

            }
            if (dataBean.getComplete_flag().equals("Y")) {
                CopyToD_carbon_burn_out_wh(dataBean);
            }
        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public void UpDel(DataBeanD_carbon_burn_out_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_carbon_burn_out_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_carbon_burn_out_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            for (int i = 0; i < 2; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else {
                    p = con.prepareStatement(sqldetail);
                }
                p.setString(1, "Y");
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
            }

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }

    }

    public void UpDel_wh(DataBeanD_carbon_burn_out_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_carbon_burn_out_header_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? ";
        String sqldetail = "update d_carbon_burn_out_detail_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? ";
        PreparedStatement p = null;
        try {
            for (int i = 0; i < 2; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else {
                    p = con.prepareStatement(sqldetail);
                }
                p.setString(1, "Y");
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
            }

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }

    }    
    
    private void CopyToD_carbon_burn_out_wh(DataBeanD_carbon_burn_out_header dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        
        //String SQLcount_header_wh = "select count(doc_id) as num from d_carbon_burn_out_header_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' ";
        
        String SQLcount = "select count(doc_id) as num from d_carbon_burn_out_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'";
        String SQLcopy = "Select * from  d_carbon_burn_out_detail where doc_id='" + dataBean.getDoc_id() + "' and complete_flag ='Y' and delete_flag ='N' order by  to_number(line_no,'9999')";
        String SQLinsert_header = "insert into d_carbon_burn_out_header_wh "
                + "(doc_id,doc_date,work_date,time_from,time_to,runner_id,shift,wh_in,wh_out,burn_no,product_id,ch_from,ch_to,weight_split,burn_out_date,lost_weight,total_weight,create_date,update_date,create_by,report_id)"
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        String SQLinsert_detail = "insert into d_carbon_burn_out_detail_wh "
                + "(doc_id,line_no,wh_in,wh_out,doc_date,production_no,size,g_code,g_sum,ctc_i2,bag,weight,lost,remark,create_date,create_by,shift,wh_weight,weight_diff,wh_weight_final,burn_no) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        ResultSet rs = null;
        PreparedStatement p = null;

        //if (objuti.numRowdatabase(SQLcount_header_wh) != 0) {
        // ลบข้อมูลเดิมของ Warehouse ก่อน (ถ้ามี)
            UpDel_wh(dataBean);
        //}        
        
        try {
            p = con.prepareStatement(SQLinsert_header);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getWork_date());
            p.setString(4, dataBean.getTime_from());
            p.setString(5, dataBean.getTime_to());
            p.setString(6, dataBean.getRunner_id());
            p.setString(7, dataBean.getShift());
            p.setString(8, dataBean.getWh_in());
            p.setString(9, dataBean.getWh_out());
            p.setString(10, dataBean.getBurn_no());
            p.setString(11, dataBean.getProduct_id());
            p.setString(12, dataBean.getCh_from());
            p.setString(13, dataBean.getCh_to());
            p.setString(14, dataBean.getWeight_split());
            p.setString(15, dataBean.getBurn_out_date());
            p.setString(16, dataBean.getLost_weight());
            p.setString(17, dataBean.getTotal_weight());
            p.setTimestamp(18, dataBean.getDate());
            p.setTimestamp(19, dataBean.getDate());
            p.setString(20, dataBean.getBy());
            p.setString(21, dataBean.getReport_id());
            p.executeUpdate();

            if (objuti.numRowdatabase(SQLcount) != 0) {
                rs = con.createStatement().executeQuery(SQLcopy);
                p = null;
                p = con.prepareStatement(SQLinsert_detail);
                while (rs.next()) {
                    p.setString(1, rs.getString("doc_id"));
                    p.setString(2, rs.getString("line_no"));
                    p.setString(3, rs.getString("wh_in"));
                    p.setString(4, rs.getString("wh_out"));
                    p.setString(5, rs.getString("doc_date"));
                    p.setString(6, rs.getString("production_no"));
                    p.setString(7, rs.getString("size"));
                    p.setString(8, rs.getString("g_code"));
                    p.setString(9, rs.getString("g_sum"));
                    p.setString(10, rs.getString("ctc_i2"));
                    p.setString(11, rs.getString("bag"));
                    p.setString(12, rs.getString("weight"));
                    p.setString(13, rs.getString("lost"));
                    p.setString(14, rs.getString("remark"));
                    p.setTimestamp(15, dataBean.getDate());
                    p.setString(16, dataBean.getBy());
                    p.setString(17, rs.getString("shift"));
                    p.setString(18, "0");
                    p.setString(19, "0");
                    p.setString(20, "0");
                    p.setString(21, dataBean.getBurn_no());
                    p.addBatch();
                }
                p.executeBatch();
                p.clearBatch();
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (p != null) {
                p.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}
