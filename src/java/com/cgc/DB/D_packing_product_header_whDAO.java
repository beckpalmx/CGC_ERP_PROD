/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Calculator.Cal_Total;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_packing_product_header;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Beck
 */
public class D_packing_product_header_whDAO {

    private int Returnvalue;

    public int insert(DataBeanD_packing_product_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_packing_product_header_wh "
                + "(doc_id,doc_date,job_id,time_from,time_to,emp_id,shift,wh_in,wh_out,lost_weight,total_bag_withdraw,total_weight_withdraw,total_bag,total_weight,create_date,update_date,create_by,runner_id,sum_pack_month,sum_pack_year)"
                + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        String[] column_cal = new String[]{"bag", "weight"};
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
            Returnvalue = p.executeUpdate();
            //**********************************************ถ่านเบิก******************************************
            sql = "select count(doc_id) as num from d_packing_product_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_packing_product_detail set doc_date=?,create_by=?,job_id=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getBy());
                p.setString(3, dataBean.getJob_id());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
                ///************************************************Calculater_TOtal
                Cal_Total cal = new Cal_Total("d_packing_product_detail", column_cal, dataBean.getDoc_id(), " and complete_flag <> 'Y'", column_cal.length);
                String[] Total = cal.Return_Total().split(",");
                sql = "update d_packing_product_header set total_bag_withdraw=?,total_weight_withdraw=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, Total[0]);
                p.setString(2, Total[1]);
                p.setString(3, dataBean.getDoc_id());
                p.executeUpdate();

            }
            //*************************************************ถ่านได้**********************************************
            sql = "select count(doc_id) as num from d_packing_product_detail_prod where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_packing_product_detail_prod set doc_date=?,create_by=?,job_id=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getBy());
                p.setString(3, dataBean.getJob_id());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
                ///************************************************Calculater_TOtal
                Cal_Total cal = new Cal_Total("d_packing_product_detail_prod", column_cal, dataBean.getDoc_id(), " and complete_flag <> 'Y'", column_cal.length);
                String[] Total = cal.Return_Total().split(",");
                sql = "update d_packing_product_header set total_bag=?,total_weight=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, Total[0]);
                p.setString(2, Total[1]);
                p.setString(3, dataBean.getDoc_id());
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

        return Returnvalue;
    }

    public int update(DataBeanD_packing_product_header dataBean) throws Exception {
        Returnvalue = 0;
        String[] column_cal = new String[]{"bag", "weight"};
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        PreparedStatement p = null;
        String sql =
                "update d_packing_product_header_wh set  "
                + "update_by=?,update_date=?,doc_type=?"
                + " where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        p = con.prepareStatement(sql);
        p.setString(1, dataBean.getBy());
        p.setTimestamp(2,dataBean.getDate());
        p.setString(3, dataBean.getDoc_type());
        p.setString(4, dataBean.getDoc_id());
        p.executeUpdate();
        p.clearParameters();
        try {
            if (dataBean.getComplete_flag().equalsIgnoreCase("N")) {
                sql = "select count(doc_id) as num from d_packing_product_detail_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
                if (objuti.numRowdatabase(sql) != 0) {
                    sql = "update d_packing_product_detail_wh set doc_date=?,update_by=?,job_id=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    p = null;
                    p = con.prepareStatement(sql);
                    p.setString(1, dataBean.getDoc_date());
                    p.setString(2, dataBean.getBy());
                    p.setString(3, dataBean.getJob_id());
                    p.setString(4, dataBean.getDoc_id());
                    p.executeUpdate();
                    ///************************************************Calculater_TOtal
                    if (objuti.numRowdatabase("select count(doc_id) as num from d_packing_product_detail_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'") == 0) {
                        Cal_Total cal = new Cal_Total("d_packing_product_detail_wh", column_cal, dataBean.getDoc_id(), " and complete_flag <> 'Y'", column_cal.length);
                        String[] Total = cal.Return_Total().split(",");
                        sql = "update d_packing_product_header_wh set total_bag_withdraw_wh=?,total_weight_withdraw_wh=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                        p = null;
                        p = con.prepareStatement(sql);
                        p.setString(1, Total[0]);
                        p.setString(2, Total[1]);
                        p.setString(3, dataBean.getDoc_id());
                        p.executeUpdate();
                    }
                } else {
                    if (objuti.numRowdatabase("select count(doc_id) as num from d_packing_product_detail_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'") == 0) {
                        sql = "update d_packing_product_header_wh set total_bag_withdraw_wh=?,total_weight_withdraw_wh=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                        p = null;
                        p = con.prepareStatement(sql);
                        p.setString(1, "0");
                        p.setString(2, "0");
                        p.setString(3, dataBean.getDoc_id());
                        p.executeUpdate();
                    }
                }
                sql = "select count(doc_id) as num from d_packing_product_detail_prod_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
                if (objuti.numRowdatabase(sql) != 0) {
                    sql = "update d_packing_product_detail_prod_wh set doc_date=?,update_by=?,job_id=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    p = null;
                    p = con.prepareStatement(sql);
                    p.setString(1, dataBean.getDoc_date());
                    p.setString(2, dataBean.getBy());
                    p.setString(3, dataBean.getJob_id());
                    p.setString(4, dataBean.getDoc_id());
                    p.executeUpdate();
                    ///************************************************Calculater_TOtal
                    if (objuti.numRowdatabase("select count(doc_id) as num from d_packing_product_detail_prod_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'") == 0) {
                        Cal_Total cal = new Cal_Total("d_packing_product_detail_prod_wh", column_cal, dataBean.getDoc_id(), " and complete_flag <> 'Y'", column_cal.length);
                        String[] Total = cal.Return_Total().split(",");
                        sql = "update d_packing_product_header_wh set total_bag_wh=?,total_weight_wh=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                        p = null;
                        p = con.prepareStatement(sql);
                        p.setString(1, Total[0]);
                        p.setString(2, Total[1]);
                        p.setString(3, dataBean.getDoc_id());
                        p.executeUpdate();
                    }
                } else {
                    if (objuti.numRowdatabase("select count(doc_id) as num from d_packing_product_detail_prod_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'") == 0) {
                        sql = "update d_packing_product_header_wh set total_bag_wh=?,total_weight_wh=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                        p = null;
                        p = con.prepareStatement(sql);
                        p.setString(1, "0");
                        p.setString(2, "0");
                        p.setString(3, dataBean.getDoc_id());
                        p.executeUpdate();
                    }
                }
            } else {
                Returnvalue = Return_Document("d_packing_product", dataBean.getDoc_id(), con, p, objuti);
            }
        }catch(Exception e){
            e.printStackTrace(System.out);
        } finally {
            if(p != null){
                p.close();
            }if(con != null){
                con.close();
            }
            return Returnvalue;
        }
        

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

    public int Return_Document(String Table_name, String doc_id, Connection con, PreparedStatement p, UtiDatabase Objuti) throws Exception {
        String SQLDetail = "", SQLDetail_Prod = "";
        int status_return = 0;
        try {
            //SQLHeader = "Select count(doc_id) as num from "+Table_name+"_header_wh where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'Y'";
            SQLDetail = "Select count(doc_id) as num from " + Table_name + "_detail_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'";
            SQLDetail_Prod = "Select count(doc_id) as num from " + Table_name + "_detail_prod_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'";
            if (Objuti.numRowdatabase(SQLDetail) == 0 && Objuti.numRowdatabase(SQLDetail_Prod) == 0) {
                //***************Delete Warehouse********************************
                p = con.prepareStatement("DELETE FROM " + Table_name + "_header_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'N'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("DELETE FROM " + Table_name + "_detail_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'N'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("DELETE FROM " + Table_name + "_detail_prod_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'N'");
                p.executeUpdate();
                //***************************************************************
                p.clearParameters();
                //**************return Complet_flag *****************************
                p = con.prepareStatement("UPDATE " + Table_name + "_header set complete_flag = 'N' WHERE doc_id ='" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("UPDATE " + Table_name + "_detail set complete_flag = 'N' WHERE doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("UPDATE " + Table_name + "_detail_prod set complete_flag = 'N' WHERE doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                //***************************************************************
                status_return = 1;
            } else {
                status_return = -1;
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            return status_return;
        }
    }
}
