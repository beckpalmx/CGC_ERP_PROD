/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBean_Transaction_Process_Production_Result;
import com.cgc.Util.UtiDatabase;
import com.cgc.Util.String_Util;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

/**
 *
 * @author Beckpalmx No7
 */
public class Process_production_1 {

    public void generater_transaction_process(String job_id, String user_login, Timestamp ts) throws Exception {
        DataBean_Transaction_Process_Production_Result dataBean = new DataBean_Transaction_Process_Production_Result();
        UtiDatabase objuti = new UtiDatabase();
        String_Util struti = new String_Util();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        PreparedStatement p = null;
        PreparedStatement p1 = null;
        String SQL_Res1, SQL_update_2 = "";
        String sqlDelete_Header, sqlDelete_Detail = "";
        //String job_type_id_withdraw = "'001','002','004','005','006','010'";
        String job_type_id_product = "('001','002','004','005','006','008','010')";
        String Doc_ID_Header = "";
        String Table_product_receive_Header = "vd_product_receive_header";
        ResultSet rs_header = null;

        SQL_Res1 = " Select doc_id from " + Table_product_receive_Header + " where job_id = '" + job_id + "'";
        rs_header = con.createStatement().executeQuery(SQL_Res1);
        while (rs_header.next()) {
            Doc_ID_Header = Doc_ID_Header + rs_header.getString("doc_id") + ",";
        }

        System.out.println("Doc_ID_Header = " + Doc_ID_Header);

        //String Test_String = "JOB_ID";
        //System.out.println("Test Substring = " + struti.SubLastString(Test_String, 3));
        ResultSet rs = null;
        try {

            sqlDelete_Header = "DELETE FROM d_product_receive_header_result " + " WHERE job_id = '" + job_id + "'";
            sqlDelete_Detail = "DELETE FROM d_product_receive_detail_result " + " WHERE job_id = '" + job_id + "'";
            delete(sqlDelete_Header, con, p);
            delete(sqlDelete_Detail, con, p);

            // หารายการที่ผลิตถ่านได้ตามใบแจ้งการผลิต
            SQL_Res1 = " Select job_id,job_type_id,size,sum(to_number(weight,'999999.99')) as weight from d_product_receive_detail_prod where job_id = '" + job_id
                    + "' and job_type_id in " + job_type_id_product
                    + " Group By job_id,job_type_id,size"
                    + " Order By job_id,job_type_id,size desc";
            //System.out.println("SQL_Res1 = " + SQL_Res1);
            rs = con.createStatement().executeQuery(SQL_Res1);
            while (rs.next()) {

                dataBean.setJob_id(rs.getString("job_id"));
                dataBean.setSize(rs.getString("size"));
                dataBean.setJob_type_id(rs.getString("job_type_id"));
                dataBean.setTotal_receive(rs.getString("weight"));
                dataBean.setBy(user_login);
                dataBean.setDate(ts);

                if (rs.getString("job_type_id").equals("008")) {
                    //System.out.println("1 job_id = " + rs.getString("job_id") + " | job_type_id = " + rs.getString("job_type_id") + " | " + rs.getString("size") + " | " + rs.getString("weight"));
                    update_result_002(dataBean, con, p);
                } else {
                    //System.out.println("2 job_id = " + rs.getString("job_id") + " | job_type_id = " + rs.getString("job_type_id") + " | " + rs.getString("size") + " | " + rs.getString("weight"));
                    insert_result(dataBean, con, p);
                }

            }

            // หารายการเบิกถ่านเพื่อผลิตตามใบแจ้งการผลิต
            SQL_Res1 = " Select job_id,job_type_id,size,sum(to_number(qty,'999999.99')) as weight from d_product_receive_detail where job_id = '" + job_id
                    + "' and job_type_id in " + job_type_id_product
                    + " Group By job_id,job_type_id,size"
                    + " Order By job_id,job_type_id,size desc";
            //System.out.println("SQL_Res1 = " + SQL_Res1);
            rs = con.createStatement().executeQuery(SQL_Res1);
            while (rs.next()) {

                dataBean.setJob_id(rs.getString("job_id"));
                dataBean.setSize(rs.getString("size"));
                dataBean.setJob_type_id(rs.getString("job_type_id"));
                dataBean.setTotal_withdraw_1(rs.getString("weight"));

                //System.out.println("Before Loop job_id = " + rs.getString("job_id") + " | job_type_id = " + rs.getString("job_type_id") + " | " + rs.getString("size") + " | " + rs.getString("weight"));
                //* Check ว่าเป็นการแก้งานที่ Step ใด  (008 = การร่อนแก้ จับคู่กับ 002 การร่อน) 
                if (rs.getString("job_type_id").equals("008") && (!rs.getString("weight").equals("") || rs.getString("weight") != null)) {
                    //System.out.println("3 job_id = " + rs.getString("job_id") + " | job_type_id = " + rs.getString("job_type_id") + " | " + rs.getString("size") + " | " + rs.getString("weight"));

                    /* Special Process */
                    SQL_update_2 = " update d_product_receive_detail_result set "
                            + " total_withdraw_2 = trim(to_char(to_number(total_withdraw_2,'999999.99')+?,'999999.99'))"
                            + " where job_id='" + rs.getString("job_id") + "' and size = '" + rs.getString("size") + "' and job_type_id = '002'";
                    //System.out.print("SQL_update = " + SQL_update_2);
                    p1 = con.prepareStatement(SQL_update_2);
                    p1.setDouble(1, rs.getDouble("weight"));
                    p1.executeUpdate();

                    /* Special Process */
                    //update_withdraw_002(dataBean, con, p);
                } else {
                    if (!rs.getString("weight").equals("") || rs.getString("weight") != null) {
                        update_withdraw_001(dataBean, con, p);
                    }
                }

            }

            /**
             * For Header Data *
             */
            SQL_Res1 = " select sum(weight) as total_withdraw from vd_product_receive_detail_sum_report  where job_id = '" + job_id + "'";
            //System.out.println("SQL_Res1 = " + SQL_Res1);
            rs = con.createStatement().executeQuery(SQL_Res1);
            Double total_withdraw = 0.00;
            while (rs.next()) {
                total_withdraw = rs.getDouble("total_withdraw");
            }
            //System.out.println("total_withdraw = " + total_withdraw);

            SQL_Res1 = " select sum(total_receive_detail) as total_receive_detail,sum(percent_total_receive_detail) as percent_total_receive_detail from vd_product_receive_detail_prod_result  where job_id = '" + job_id + "'";
            //System.out.println("SQL_Res1 = " + SQL_Res1);
            rs = con.createStatement().executeQuery(SQL_Res1);
            Double total_receive = 0.00;
            Double percent_total_receive = 0.00;
            Double total_lost = 0.00;
            Double percent_total_lost = 0.00;
            Double percent_total_receive1 = 0.00;
            while (rs.next()) {
                total_receive = rs.getDouble("total_receive_detail");
                percent_total_receive1 = rs.getDouble("percent_total_receive_detail");
            }
            percent_total_receive = (total_receive * 100) / total_withdraw;
            total_lost = total_receive - total_withdraw;
            percent_total_lost = (total_lost * 100) / total_withdraw;
            //System.out.println("total_receive = " + total_receive);
            //System.out.println("percent_total_receive = " + percent_total_receive);
            //System.out.println("percent_total_receive1 = " + percent_total_receive1);
            //System.out.println("total_lost = " + total_lost);
            //System.out.println("percent_total_lost = " + percent_total_lost);

            String SQL_Insert_header = " insert into d_product_receive_header_result "
                    + " (job_id,total_withdraw,total_receive,percent_total_receive,total_lost,percent_total_lost,create_by,create_date,remark) "
                    + " values (?,?,?,?,?,?,?,?,?) ";

            p = con.prepareStatement(SQL_Insert_header);

            p.setString(1, job_id);
            p.setString(2, total_withdraw.toString());
            p.setString(3, total_receive.toString());
            p.setString(4, percent_total_receive.toString());
            p.setString(5, total_lost.toString());
            p.setString(6, percent_total_lost.toString());
            p.setString(7, user_login);            
            p.setTimestamp(8, ts);
            p.setString(9, Doc_ID_Header);
            
            p.executeUpdate();

            /**
             * For Header Data *
             */
        } finally {
            try {
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

    }

    private void delete(String SQL_DEL, Connection con, PreparedStatement p) throws Exception {
        try {
            //System.out.println("Function Delete : " + SQL_DEL);
            p = con.prepareStatement(SQL_DEL);
            p.executeUpdate();
            p.clearParameters();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
        }
    }

    private void insert_result(DataBean_Transaction_Process_Production_Result dataBean, Connection con, PreparedStatement p) throws Exception {
        String SQL_Insert = "";
        try {

            SQL_Insert = "insert into d_product_receive_detail_result "
                    + "(job_id,size,job_type_id,total_receive,create_by,create_date) "
                    + "values (?,?,?,?,?,?)";

            p = con.prepareStatement(SQL_Insert);

            p.setString(1, dataBean.getJob_id());
            p.setString(2, dataBean.getSize());
            p.setString(3, dataBean.getJob_type_id());
            p.setString(4, dataBean.getTotal_receive());
            p.setString(5, dataBean.getBy());
            p.setTimestamp(6, dataBean.getDate());

            p.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
        }
    }

    private void update_result_002(DataBean_Transaction_Process_Production_Result dataBean, Connection con, PreparedStatement p) throws Exception {
        String SQL_update = "";
        try {

            SQL_update = " update d_product_receive_detail_result set "
                    + " total_receive= trim(to_char(to_number(total_receive,'999999.99')+?,'999999.99'))"
                    + " where job_id='" + dataBean.getJob_id() + "' and size = '" + dataBean.getSize() + "' and job_type_id = '002'";
            //System.out.print("SQL_update = " + SQL_update);
            p = con.prepareStatement(SQL_update);
            p.setDouble(1, Double.parseDouble(dataBean.getTotal_receive()));
            //System.out.println("getTotal_receive = " + Double.parseDouble(dataBean.getTotal_receive()));
            p.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
        }
    }

    private void update_withdraw_001(DataBean_Transaction_Process_Production_Result dataBean, Connection con, PreparedStatement p) throws Exception {
        String SQL_update = "";
        try {

            SQL_update = " update d_product_receive_detail_result set "
                    + " total_withdraw_1= trim(to_char(to_number(total_withdraw_1,'999999.99')+?,'999999.99'))"
                    + " where job_id='" + dataBean.getJob_id() + "'";
            //System.out.print("SQL_update = " + SQL_update);
            p = con.prepareStatement(SQL_update);
            p.setDouble(1, Double.parseDouble(dataBean.getTotal_withdraw_1()));
            //System.out.println("getTotal_withdraw_1 = " + Double.parseDouble(dataBean.getTotal_withdraw_1()));
            p.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
        }
    }

    private void update_withdraw_002(DataBean_Transaction_Process_Production_Result dataBean, Connection con, PreparedStatement p) throws Exception {
        String SQL_update = "";
        try {

            //System.out.println("QQ getTotal_withdraw_2 = " + Double.parseDouble(dataBean.getTotal_withdraw_2()));
            SQL_update = " update d_product_receive_detail_result set "
                    + " total_withdraw_2 = trim(to_char(to_number(total_withdraw_2,'999999.99')+?,'999999.99'))"
                    + " where job_id='" + dataBean.getJob_id() + "' and size = '" + dataBean.getSize() + "' and job_type_id = '002'";
            //System.out.print("SQL_update = " + SQL_update);
            p = con.prepareStatement(SQL_update);
            p.setDouble(1, Double.parseDouble(dataBean.getTotal_withdraw_2()));
            //System.out.println("getTotal_withdraw_2 = " + Double.parseDouble(dataBean.getTotal_withdraw_2()));

            p.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
        }
    }
}
