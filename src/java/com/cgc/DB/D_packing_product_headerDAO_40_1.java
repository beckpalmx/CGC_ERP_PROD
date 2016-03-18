/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Calculator.Cal_Total_Pack;
import com.cgc.Calculator.Cal_Total_Withdraw_Over;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_packing_product_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Beckpalmx No7
 */
public class D_packing_product_headerDAO_40_1 {

    private int Returnvalue;

    public int insert(DataBeanD_packing_product_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_packing_product_header "
                + "(doc_id,doc_date,job_id,time_from,time_to,emp_id,shift,wh_in,wh_out,lost_weight,total_bag_withdraw,total_weight_withdraw,total_bag,total_weight,create_date,update_date,create_by,runner_id,complete_flag,count_send_complete,sum_pack_month,sum_pack_year)"
                + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        String[] column_cal = new String[]{"bag", "weight"};
        String[] column_cal_total = new String[]{"bag_doc_type", "weight_doc_type"};
        String[] column_cal_total_withdraw_over = new String[]{"bag", "weight"};
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getJob_id());
            p.setString(4, dataBean.getTime_from());
            p.setString(5, dataBean.getTime_to());
            p.setString(6, dataBean.getEmp_id());
            p.setString(7, dataBean.getShift());
            p.setString(8, dataBean.getWh_in());
            p.setString(9, dataBean.getWh_out());
            p.setString(10, dataBean.getLost_weight());
            p.setString(11, objuti.NotNull(dataBean.getTotal_bag_withdraw(), "0"));
            p.setString(12, objuti.NotNull(dataBean.getTotal_weight_withdraw(), "0"));
            p.setString(13, objuti.NotNull(dataBean.getTotal_bag(), "0"));
            p.setString(14, objuti.NotNull(dataBean.getTotal_weight(), "0"));
            p.setTimestamp(15, dataBean.getDate());
            p.setTimestamp(16, dataBean.getDate());
            p.setString(17, dataBean.getBy());
            p.setString(18, dataBean.getRunner_id());
            p.setString(19, dataBean.getComplete_flag());
            p.setString(20, Count_sendcomplete("d_packing_product_header", dataBean.getDoc_id(), dataBean.getComplete_flag(), con));
            p.setString(21, dataBean.getSum_pack_month());
            p.setString(22, dataBean.getSum_pack_year());
            Returnvalue = p.executeUpdate();
            //**********************************************ถ่านเบิก******************************************
            sql = "select count(doc_id) as num from d_packing_product_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_packing_product_detail set doc_date=?,create_by=?,job_id=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getBy());
                p.setString(3, dataBean.getJob_id());
                p.setString(4, dataBean.getComplete_flag());
                p.setString(5, dataBean.getDoc_id());
                p.executeUpdate();
                ///************************************************Calculater_TOtal
                Cal_Total_Pack cal = new Cal_Total_Pack("vd_packing_product_detail", column_cal, dataBean.getDoc_id(), " and complete_flag = '" + dataBean.getComplete_flag() + "'", column_cal.length);
                String[] Total = cal.Return_Total().split(",");
                sql = "update d_packing_product_header set total_bag_withdraw=?,total_weight_withdraw=? where doc_id = ? and delete_flag <> 'Y' and complete_flag=?";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, Total[0]);
                p.setString(2, Total[1]);
                p.setString(3, dataBean.getDoc_id());
                p.setString(4, dataBean.getComplete_flag());
                p.executeUpdate();
                dataBean.setTotal_bag_withdraw(Total[0]);
                dataBean.setTotal_weight_withdraw(Total[1]);

                // Withdraw Over 
                Cal_Total_Withdraw_Over cal2 = new Cal_Total_Withdraw_Over("vd_packing_product_detail", column_cal_total_withdraw_over, dataBean.getDoc_id(), " and complete_flag = '" + dataBean.getComplete_flag() + "'", column_cal_total_withdraw_over.length);
                String[] Total2 = cal2.Return_Total().split(",");
                sql = "update d_packing_product_header set total_bag_withdraw_over=? , total_withdraw_over=? where doc_id = ? and delete_flag <> 'Y' and complete_flag=?";
                System.out.println("Withdraw Over" + sql);
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, Total2[0]);
                p.setString(2, Total2[1]);
                p.setString(3, dataBean.getDoc_id());
                p.setString(4, dataBean.getComplete_flag());
                p.executeUpdate();
                dataBean.setTotal_bag_withdraw_over(Total2[0]);
                dataBean.setTotal_withdraw_over(Total2[1]);
            }
            //*************************************************ถ่านได้**********************************************
            sql = "select count(doc_id) as num from d_packing_product_detail_prod where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_packing_product_detail_prod set doc_date=?,create_by=?,job_id=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getBy());
                p.setString(3, dataBean.getJob_id());
                p.setString(4, dataBean.getComplete_flag());
                p.setString(5, dataBean.getDoc_id());
                p.executeUpdate();
                ///************************************************Calculater_TOtal
                Cal_Total_Pack cal = new Cal_Total_Pack("vd_packing_product_detail_prod", column_cal, dataBean.getDoc_id(), " and complete_flag = '" + dataBean.getComplete_flag() + "'", column_cal.length);
                String[] Total = cal.Return_Total().split(",");
                sql = "update d_packing_product_header set total_bag=?,total_weight=? where doc_id = ? and delete_flag <> 'Y' and complete_flag =?";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, Total[0]);
                p.setString(2, Total[1]);
                p.setString(3, dataBean.getDoc_id());
                p.setString(4, dataBean.getComplete_flag());
                p.executeUpdate();
                dataBean.setTotal_bag(Total[0]);
                dataBean.setTotal_weight(Total[1]);

            }
            p = null;
            p = con.prepareStatement("update d_packing_product_header  SET lost_weight  = (select trim(to_char(to_number(total_weight_withdraw,'9999990') - to_number(total_weight,'9999990'),'9999990')) from d_packing_product_header  where doc_id = '" + dataBean.getDoc_id() + "') where doc_id = '" + dataBean.getDoc_id() + "' ");
            p.executeUpdate();

            //if (dataBean.getComplete_flag().equals("Y")) {
            //    CopyToD_packing_product_wh(dataBean);
            //}


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

    public int update(DataBeanD_packing_product_header dataBean) throws Exception {
        Returnvalue = 0;
        String[] column_cal = new String[]{"bag", "weight"};
        String[] column_cal_total = new String[]{"bag_doc_type", "weight_doc_type"};
        String[] column_cal_total_withdraw_over = new String[]{"bag", "weight"};
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql =
                "update d_packing_product_header set  "
                //+ "doc_date=?,job_id=?,time_from=?,time_to=?,emp_id=?,shift=?,wh_in=?,wh_out=?,lost_weight=?,total_bag_withdraw=?,total_weight_withdraw=?,total_bag=?,total_weight=?,update_date=?,update_by=?,runner_id=?,complete_flag=?,count_send_complete=?,sum_pack_month=?,sum_pack_year=?"
                + "doc_date=?,lost_weight=?,total_bag_withdraw=?,total_weight_withdraw=?,total_bag=?,total_weight=?,update_date=?,update_by=?"
                //+ " where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                + " where doc_id=? and delete_flag <> 'Y' ";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getLost_weight());
            p.setString(3, objuti.NotNull(dataBean.getTotal_bag_withdraw(), "0"));
            p.setString(4, objuti.NotNull(dataBean.getTotal_weight_withdraw(), "0"));
            p.setString(5, objuti.NotNull(dataBean.getTotal_bag(), "0"));
            p.setString(6, objuti.NotNull(dataBean.getTotal_weight(), "0"));
            p.setTimestamp(7, dataBean.getDate());
            p.setString(8, dataBean.getBy());
            //p.setString(9, dataBean.getRunner_id());
            //p.setString(17, dataBean.getComplete_flag());
            //p.setString(17, Count_sendcomplete("d_packing_product_header", dataBean.getDoc_id(), dataBean.getComplete_flag(), con));
            //p.setString(17, dataBean.getSum_pack_month());
            //p.setString(18, dataBean.getSum_pack_year());
            p.setString(9, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
            //**********************************************ถ่านเบิก******************************************
            //sql = "select count(doc_id) as num from d_packing_product_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            sql = "select count(doc_id) as num from d_packing_product_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' ";
            if (objuti.numRowdatabase(sql) != 0) {
                //sql = "update d_packing_product_detail set doc_date=?,create_by=?,job_id=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                sql = "update d_packing_product_detail set doc_date=?,create_by=?,job_id=? where doc_id = ? and delete_flag <> 'Y' ";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getBy());
                p.setString(3, dataBean.getJob_id());
                //p.setString(4, dataBean.getComplete_flag());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
                ///************************************************Calculater_TOtal
                Cal_Total_Pack cal = new Cal_Total_Pack("vd_packing_product_detail", column_cal, dataBean.getDoc_id(), " and complete_flag = 'Y'", column_cal.length);
                String[] Total = cal.Return_Total().split(",");
                //sql = "update d_packing_product_header set total_bag_withdraw=?,total_weight_withdraw=? where doc_id = ? and delete_flag <> 'Y' and complete_flag=?";
                sql = "update d_packing_product_header set total_bag_withdraw=?,total_weight_withdraw=? where doc_id = ? and delete_flag <> 'Y' ";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, Total[0]);
                p.setString(2, Total[1]);
                p.setString(3, dataBean.getDoc_id());
                //p.setString(4, dataBean.getComplete_flag());
                p.executeUpdate();
                dataBean.setTotal_bag_withdraw(Total[0]);
                dataBean.setTotal_weight_withdraw(Total[1]);

                // Withdraw Over 
                Cal_Total_Withdraw_Over cal2 = new Cal_Total_Withdraw_Over("vd_packing_product_detail", column_cal_total_withdraw_over, dataBean.getDoc_id(), " and complete_flag = 'Y'", column_cal_total_withdraw_over.length);
                String[] Total2 = cal2.Return_Total().split(",");
                //sql = "update d_packing_product_header set total_bag_withdraw_over=? , total_withdraw_over=? where doc_id = ? and delete_flag <> 'Y' and complete_flag=?";
                sql = "update d_packing_product_header set total_bag_withdraw_over=? , total_withdraw_over=? where doc_id = ? and delete_flag <> 'Y' ";
                System.out.println("Withdraw Over = " + sql);
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, Total2[0]);
                p.setString(2, Total2[1]);
                p.setString(3, dataBean.getDoc_id());
                //p.setString(4, dataBean.getComplete_flag());
                p.executeUpdate();
                dataBean.setTotal_bag_withdraw_over(Total2[0]);
                dataBean.setTotal_withdraw_over(Total2[1]);
            }
            //*************************************************ถ่านได้**********************************************
            //sql = "select count(doc_id) as num from d_packing_product_detail_prod where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            sql = "select count(doc_id) as num from d_packing_product_detail_prod where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' ";
            if (objuti.numRowdatabase(sql) != 0) {
                //sql = "update d_packing_product_detail_prod set doc_date=?,create_by=?,job_id=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                sql = "update d_packing_product_detail_prod set doc_date=?,create_by=?,job_id=? where doc_id = ? and delete_flag <> 'Y' ";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getBy());
                p.setString(3, dataBean.getJob_id());
                //p.setString(4, dataBean.getComplete_flag());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
                ///************************************************Calculater_TOtal
                //Cal_Total_Pack cal = new Cal_Total_Pack("vd_packing_product_detail_prod", column_cal_total, dataBean.getDoc_id(), " and complete_flag = '" + dataBean.getComplete_flag() + "'", column_cal.length);
                Cal_Total_Pack cal = new Cal_Total_Pack("vd_packing_product_detail_prod", column_cal_total, dataBean.getDoc_id(), "", column_cal.length);
                String[] Total = cal.Return_Total().split(",");
                //sql = "update d_packing_product_header set total_bag=?,total_weight=? where doc_id = ? and delete_flag <> 'Y' and complete_flag =?";
                sql = "update d_packing_product_header set total_bag=?,total_weight=? where doc_id = ? and delete_flag <> 'Y' ";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, Total[0]);
                p.setString(2, Total[1]);
                p.setString(3, dataBean.getDoc_id());
                //p.setString(4, dataBean.getComplete_flag());
                p.executeUpdate();
                dataBean.setTotal_bag(Total[0]);
                dataBean.setTotal_weight(Total[1]);
            }
            p = null;
            p = con.prepareStatement("update d_packing_product_header  SET lost_weight  = (select trim(to_char(to_number(total_weight_withdraw,'9999990') - to_number(total_weight,'9999990'),'9999990')) from d_packing_product_header  where delete_flag <> 'Y' and doc_id = '" + dataBean.getDoc_id() + "') where delete_flag <> 'Y' and  doc_id = '" + dataBean.getDoc_id() + "' ");
            p.executeUpdate();
            //if (dataBean.getComplete_flag().equals("Y")) {
            UpdateToD_packing_product_wh(dataBean);
            //}
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

    public void UpDel(DataBeanD_packing_product_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_packing_product_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_packing_product_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail_prod = "update d_packing_product_detail_prod set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            for (int i = 0; i < 3; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else if (i == 2) {
                    p = con.prepareStatement(sqldetail);
                } else {
                    p = con.prepareStatement(sqldetail_prod);
                }
                p.setString(1, "Y");
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }

    }

    private void UpdateToD_packing_product_wh(DataBeanD_packing_product_header dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String SQLcount_detail = "select count(doc_id) as num from d_packing_product_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'";
        String SQLcount_detail_prod = "select count(doc_id) as num from d_packing_product_detail_prod where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'";
        String SQLcopy_detail = "Select * from  d_packing_product_detail where doc_id='" + dataBean.getDoc_id() + "' and complete_flag ='Y' and delete_flag ='N' order by  to_number(line_no,'9999')";
        String SQLcopy_prod = "Select * from  d_packing_product_detail_prod where doc_id='" + dataBean.getDoc_id() + "' and complete_flag ='Y' and delete_flag ='N' order by  to_number(line_no,'9999')";        
        String SQLUpdate_header =
		"update d_packing_product_header_wh set  "                
                + "doc_date=?,lost_weight=?,total_bag_withdraw=?,total_weight_withdraw=?,total_bag=?,total_weight=?,update_date=?,update_by=?"                
                + " where doc_id=? and delete_flag <> 'Y' ";        
        String SQLUpdate_detail = "update d_packing_product_detail_wh set doc_type = ?,update_date=?,update_by=? where doc_id=? and line_no=? and delete_flag <> 'Y' ";
        String SQLUpdate_detail_prod = "update d_packing_product_detail_prod_wh set doc_type = ?,update_date=?,update_by=? where doc_id=? and line_no=? and delete_flag <> 'Y' ";
        ResultSet rs = null;
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(SQLUpdate_header);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getLost_weight());
            p.setString(3, objuti.NotNull(dataBean.getTotal_bag_withdraw(), "0"));
            p.setString(4, objuti.NotNull(dataBean.getTotal_weight_withdraw(), "0"));
            p.setString(5, objuti.NotNull(dataBean.getTotal_bag(), "0"));
            p.setString(6, objuti.NotNull(dataBean.getTotal_weight(), "0"));
            p.setTimestamp(7, dataBean.getDate());
            p.setString(8, dataBean.getBy());
            p.setString(9, dataBean.getDoc_id());
            p.executeUpdate();
            if (objuti.numRowdatabase(SQLcount_detail) != 0) {
                rs = con.createStatement().executeQuery(SQLcopy_detail);
                while (rs.next()) {
                    p = null;
                    p = con.prepareStatement(SQLUpdate_detail);
                    p.setString(1, rs.getString("doc_type"));
                    p.setTimestamp(2, dataBean.getDate());
                    p.setString(3, dataBean.getBy());                    
                    p.setString(4, rs.getString("doc_id"));
                    p.setString(5, rs.getString("line_no"));
                    p.executeUpdate();
                }
            }
            if (objuti.numRowdatabase(SQLcount_detail_prod) != 0) {
                rs = con.createStatement().executeQuery(SQLcopy_prod);
                while (rs.next()) {
                    p = null;
                    p = con.prepareStatement(SQLUpdate_detail_prod);
                    p.setString(1, rs.getString("doc_type"));
                    p.setTimestamp(2, dataBean.getDate());
                    p.setString(3, dataBean.getBy());                    
                    p.setString(4, rs.getString("doc_id"));
                    p.setString(5, rs.getString("line_no"));
                    p.executeUpdate();
                }
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

    private void CopyToD_packing_product_wh(DataBeanD_packing_product_header dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String SQLcount_detail = "select count(doc_id) as num from d_packing_product_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'";
        String SQLcount_detail_prod = "select count(doc_id) as num from d_packing_product_detail_prod where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'";
        String SQLcopy_detail = "Select * from  d_packing_product_detail where doc_id='" + dataBean.getDoc_id() + "' and complete_flag ='Y' and delete_flag ='N' order by  to_number(line_no,'9999')";
        String SQLcopy_prod = "Select * from  d_packing_product_detail_prod where doc_id='" + dataBean.getDoc_id() + "' and complete_flag ='Y' and delete_flag ='N' order by  to_number(line_no,'9999')";
        String SQLinsert_header = "insert into d_packing_product_header_wh "
                + "(doc_id,doc_date,job_id,time_from,time_to,emp_id,shift,wh_in,wh_out,lost_weight,total_bag_withdraw,total_weight_withdraw,total_bag,total_weight,create_date,update_date,create_by,runner_id,sum_pack_month,sum_pack_year)"
                + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        String SQLinsert_detail = "update into d_packing_product_detail_wh "
                + "(doc_id,line_no,wh_id,product_id,place_prd,palate_no,size,i2,bag,weight,remark,create_date,create_by,fraction_bag,product_no,job_id,doc_date,doc_type) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        String SQLinsert_detail_prod = "insert into d_packing_product_detail_prod_wh "
                + "(doc_id,line_no,wh_id,product_id,size,i2,bag,weight,remark,create_date,create_by,weight_unit,product_no,job_id,doc_date,pack_repacking_status,carbon_trap_status,doc_type) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        ResultSet rs = null;
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(SQLinsert_header);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getJob_id());
            p.setString(4, dataBean.getTime_from());
            p.setString(5, dataBean.getTime_to());
            p.setString(6, dataBean.getEmp_id());
            p.setString(7, dataBean.getShift());
            p.setString(8, dataBean.getWh_in());
            p.setString(9, dataBean.getWh_out());
            p.setString(10, dataBean.getLost_weight());
            p.setString(11, dataBean.getTotal_bag_withdraw());
            p.setString(12, dataBean.getTotal_weight_withdraw());
            p.setString(13, dataBean.getTotal_bag());
            p.setString(14, dataBean.getTotal_weight());
            p.setTimestamp(15, dataBean.getDate());
            p.setTimestamp(16, dataBean.getDate());
            p.setString(17, dataBean.getBy());
            p.setString(18, dataBean.getRunner_id());
            p.setString(19, dataBean.getSum_pack_month());
            p.setString(20, dataBean.getSum_pack_year());
            p.executeUpdate();
            if (objuti.numRowdatabase(SQLcount_detail) != 0) {
                rs = con.createStatement().executeQuery(SQLcopy_detail);
                while (rs.next()) {
                    p = null;
                    p = con.prepareStatement(SQLinsert_detail);
                    p.setString(1, rs.getString("doc_id"));
                    p.setString(2, rs.getString("line_no"));
                    p.setString(3, rs.getString("wh_id"));
                    p.setString(4, rs.getString("product_id"));
                    p.setString(5, rs.getString("place_prd"));
                    p.setString(6, rs.getString("palate_no"));
                    p.setString(7, rs.getString("size"));
                    p.setString(8, rs.getString("i2"));
                    p.setString(9, rs.getString("bag"));
                    p.setString(10, rs.getString("weight"));
                    p.setString(11, rs.getString("remark"));
                    p.setTimestamp(12, dataBean.getDate());
                    p.setString(13, dataBean.getBy());
                    p.setString(14, rs.getString("fraction_bag"));
                    p.setString(15, rs.getString("product_no"));
                    p.setString(16, rs.getString("job_id"));
                    p.setString(17, rs.getString("doc_date"));
                    p.setString(18, rs.getString("doc_type"));
                    p.executeUpdate();
                }
            }
            if (objuti.numRowdatabase(SQLcount_detail_prod) != 0) {
                rs = con.createStatement().executeQuery(SQLcopy_prod);
                while (rs.next()) {
                    p = null;
                    p = con.prepareStatement(SQLinsert_detail_prod);
                    p.setString(1, rs.getString("doc_id"));
                    p.setString(2, rs.getString("line_no"));
                    p.setString(3, rs.getString("wh_id"));
                    p.setString(4, rs.getString("product_id"));
                    p.setString(5, rs.getString("size"));
                    p.setString(6, rs.getString("i2"));
                    p.setString(7, rs.getString("bag"));
                    p.setString(8, rs.getString("weight"));
                    p.setString(9, rs.getString("remark"));
                    p.setTimestamp(10, dataBean.getDate());
                    p.setString(11, dataBean.getBy());
                    p.setString(12, rs.getString("weight_unit"));
                    p.setString(13, rs.getString("product_no"));
                    p.setString(14, rs.getString("job_id"));
                    p.setString(15, rs.getString("doc_date"));
                    p.setString(16, rs.getString("pack_repacking_status"));
                    p.setString(17, rs.getString("carbon_trap_status"));
                    p.setString(18, rs.getString("doc_type"));
                    p.executeUpdate();
                }
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

    public String Count_sendcomplete(String Table_name, String Doc_id, String Complete_flag, Connection con) throws Exception {
        ResultSet rs = null;
        String SQL = "", Return = "0";
        UtiDatabase objuti = new UtiDatabase();
        try {
            if (Complete_flag.equalsIgnoreCase("Y")) {
                SQL = "select count(doc_id) as num from " + Table_name + " where doc_id = '" + Doc_id + "' and delete_flag = 'N' and complete_flag = 'N'";
                if (objuti.numRowdatabase(SQL) != 0) {
                    SQL = "select count_send_complete from " + Table_name + " where doc_id = '" + Doc_id + "' and delete_flag = 'N' and complete_flag = 'N'";
                    rs = con.createStatement().executeQuery(SQL);
                    while (rs.next()) {
                        Return = Integer.toString(Integer.parseInt(rs.getString("count_send_complete")) + 1);
                    }

                } else {
                    Return = "1";
                }
            } else {
                SQL = "select count(doc_id) as num from " + Table_name + " where doc_id = '" + Doc_id + "' and delete_flag = 'N' and complete_flag = 'N'";
                if (objuti.numRowdatabase(SQL) != 0) {
                    SQL = "select count_send_complete from " + Table_name + " where doc_id = '" + Doc_id + "' and delete_flag = 'N' and complete_flag = 'N'";
                    rs = con.createStatement().executeQuery(SQL);
                    while (rs.next()) {
                        Return = rs.getString("count_send_complete");
                    }

                }
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);

        } finally {
            if (rs != null) {
                rs.close();
            }
            return Return;
        }
    }
}
