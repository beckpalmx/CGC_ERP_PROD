/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanD_product_receive_process_track_result;
import com.cgc.Util.UtiDatabase;
import com.cgc.Util.String_Util;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

/**
 *
 * @author
 */
public class Process_production_detail_track_withdraw_all_process_DB {

    public void generater_transaction_process(String job_id, String user_login,Timestamp ts) throws Exception {
        DataBeanD_product_receive_process_track_result dataBean = new DataBeanD_product_receive_process_track_result();
        UtiDatabase objuti = new UtiDatabase();
        String_Util struti = new String_Util();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        ResultSet rs_2 = null;
        PreparedStatement p = null;
        PreparedStatement p1 = null;
        int statusnum = 0;
        String SQL_Res1, SQL_Res2, SQL_Res3, SQL_update_2 = "";

        String iodine = "";
        String machine = "";
        String size = "";
        String month = "";
        String year = "";
        String weight_string = "";
        Double total_weight = 0.00;

        String sqlDelete_Detail = "";
        String Table_Detail = "vd_product_receive_detail";
        String Table_Track_Detail = "d_product_receive_process_track_result";

        try {

            sqlDelete_Detail = "DELETE FROM " + Table_Track_Detail + " WHERE job_id = '" + job_id + "'"
                    + " and doc_type = '1' ";
            delete(sqlDelete_Detail, con, p);

            SQL_Res1 = " select * from " + Table_Detail + " where job_id = '" + job_id + "'"
                    //+ " and size = size_job_id "
                    + " and job_type_id <> '008'"
                    + " order by to_date(format_date(doc_date),'YYYY-MM-DD')";

            System.out.println("SQL_Res1 = " + SQL_Res1);

            rs = con.createStatement().executeQuery(SQL_Res1);

            while (rs.next()) {

                //System.out.println("SubLastString = " + struti.SubLastString(rs.getString("job_type_desc"), 1));
                //System.out.println("doc_date = " + rs.getString("doc_date"));
                //if (struti.SubLastString(rs.getString("job_type_desc"), 1).equals("1")) {
                if (rs.getString("job_type_id").equals("002")) {
                    //System.out.println("doc_id = " + rs.getString("doc_id"));
                    //System.out.println("size_job_id = " + rs.getString("size_job_id"));
                    //System.out.println("size = " + rs.getString("size"));
                    //System.out.println(" True job_type_desc = " + rs.getString("job_type_desc"));
                    SQL_Res2 = " select count(*) as num from " + Table_Track_Detail
                            + " where job_id = '" + job_id + "'"
                            + " and doc_type = '1'"
                            + " and iodine = '" + rs.getString("ctc_i2") + "'"
                            + " and machine = '" + rs.getString("job_type_desc") + "'"
                            + " and size = '" + rs.getString("size") + "'"
                            + " and month = '" + rs.getString("month") + "'"
                            + " and year = '" + rs.getString("year") + "'"
                            + "";

                    machine = rs.getString("job_type_desc");
                    iodine = rs.getString("ctc_i2");
                    size = rs.getString("size");
                    month = rs.getString("month");
                    year = rs.getString("year");

                    statusnum = objuti.numRowdatabase(SQL_Res2);

                    dataBean.setJob_id(rs.getString("job_id"));
                    dataBean.setSize(rs.getString("size"));
                    dataBean.setIodine(rs.getString("ctc_i2"));
                    dataBean.setMachine(rs.getString("job_type_desc"));
                    dataBean.setMonth(rs.getString("month"));
                    dataBean.setYear(rs.getString("year"));
                    dataBean.setWeight_string(rs.getString("qty"));
                    dataBean.setTotal_weight(rs.getDouble("qty"));
                    dataBean.setDoc_type("1");

                    dataBean.setBy(user_login);
                    dataBean.setDate(ts);

                    //System.out.println("weight" + rs.getDouble("weight"));
                    //total_weight = total_weight + rs.getDouble("weight");
                    //System.out.println("total_weight = " + total_weight);
                    if (statusnum == 0) {
                        /*
                         System.out.println("Insert");
                         System.out.print(" job_id = " + rs.getString("job_id"));                         
                         System.out.print(" machine = " + rs.getString("job_type_desc"));
                         System.out.print(" month = " + rs.getString("month"));
                         System.out.print(" year = " + rs.getString("year"));
                         */

                        insert_withdraw(dataBean, con, p);

                    } else {
                        /*                        
                         System.out.println("Update");
                         System.out.print(" job_id = " + rs.getString("job_id"));
                         System.out.print(" shift = " + rs.getString("shift"));
                         System.out.print(" machine = " + rs.getString("job_type_desc"));
                         System.out.print(" month = " + rs.getString("month"));
                         System.out.print(" year = " + rs.getString("year"));
                         */

                        update_withdraw(dataBean, con, p);

                    }

                }
                //else {
                //    System.out.println(" Fasle job_type_desc = " + rs.getString("job_type_desc"));
                //}

            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
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

    private void insert_withdraw(DataBeanD_product_receive_process_track_result dataBean, Connection con, PreparedStatement p) throws Exception {
        String SQL_Insert = "";
        try {

            SQL_Insert = "insert into d_product_receive_process_track_result"
                    + "(job_id,machine,doc_type,size,iodine,month,year,weight_string,total_weight,create_by,create_date) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?)";

            p = con.prepareStatement(SQL_Insert);

            //System.out.println("SQL_Insert = " + SQL_Insert);
            p.setString(1, dataBean.getJob_id());
            p.setString(2, dataBean.getMachine());
            p.setString(3, dataBean.getDoc_type());
            p.setString(4, dataBean.getSize());
            p.setString(5, dataBean.getIodine());
            p.setString(6, dataBean.getMonth());
            p.setString(7, dataBean.getYear());
            p.setString(8, dataBean.getWeight_string());
            p.setDouble(9, dataBean.getTotal_weight());
            p.setString(10, dataBean.getBy());
            p.setTimestamp(11, dataBean.getDate());

            p.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
        }
    }

    private void update_withdraw(DataBeanD_product_receive_process_track_result dataBean, Connection con, PreparedStatement p) throws Exception {
        String SQL_Update = "";
        String weight_string = "";
        try {

            SQL_Update = "update d_product_receive_process_track_result set "
                    + " weight_string=CONCAT(weight_string,?),total_weight=total_weight+?"
                    + ",update_by='system'"
                    + " where job_id = ?"
                    + " and doc_type = '1' "
                    + " and iodine = ?"
                    + " and machine = ?"
                    + " and size = ?"
                    + " and month = ?"
                    + " and year = ?";

            p = con.prepareStatement(SQL_Update);

//            System.out.println("SQL_Update = " + SQL_Update);
//            System.out.println("dataBean.getWeight_string() = " + dataBean.getWeight_string());
//            System.out.println("dataBean.getTotal_weight() = " + dataBean.getTotal_weight());
//            System.out.println("dataBean.getJob_id() = " + dataBean.getJob_id());
//            System.out.println("dataBean.getMachine() = " + dataBean.getMachine());
//            System.out.println("dataBean.getSize() = " + dataBean.getSize());
//            System.out.println("dataBean.getIodine() = " + dataBean.getIodine());
//            System.out.println("dataBean.getMonth() = " + dataBean.getMonth());
//            System.out.println("dataBean.getYear() = " + dataBean.getYear());
            weight_string = "," + dataBean.getWeight_string() + "";
//            System.out.println("XXX weight_string = " + weight_string);
            p.setString(1, weight_string);
            p.setDouble(2, dataBean.getTotal_weight());
            p.setString(3, dataBean.getJob_id());
            p.setString(4, dataBean.getIodine());
            p.setString(5, dataBean.getMachine());
            p.setString(6, dataBean.getSize());
            p.setString(7, dataBean.getMonth());
            p.setString(8, dataBean.getYear());

            p.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
        }
    }

}
