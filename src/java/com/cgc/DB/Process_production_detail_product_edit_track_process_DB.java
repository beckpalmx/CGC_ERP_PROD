/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanD_product_receive_process_track_detail;
import com.cgc.bean.DataBeanD_product_receive_process_track_header;
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
public class Process_production_detail_product_edit_track_process_DB {

    public void generater_transaction_process(String job_id,String user_login,Timestamp ts) throws Exception {
        DataBeanD_product_receive_process_track_detail dataBean = new DataBeanD_product_receive_process_track_detail();
        DataBeanD_product_receive_process_track_header dataBean_header = new DataBeanD_product_receive_process_track_header();
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

        String shift = "";
        String machine = "";
        String size = "";
        String month = "";
        String year = "";

        String sqlDelete_Header, sqlDelete_Detail = "";

        String Table_Detail_prod = "vd_product_receive_detail_prod";
        String Table_Track_Header = "d_product_receive_process_track_header";
        String Table_Track_Detail = "d_product_receive_process_track_detail";
        String Table_Track_Detail_sum = "vd_product_receive_process_track_detail_sum";

        //Double total_weight = 0.00;
        try {

            sqlDelete_Detail = "DELETE FROM " + Table_Track_Detail + " WHERE job_id = '" + job_id + "'"
                    + " and doc_type = '3' ";
            delete(sqlDelete_Detail, con, p);

            SQL_Res1 = " select * from " + Table_Detail_prod + " where job_id = '" + job_id + "'"
                    + " and size = size_job_id "
                    + " order by to_date(format_date(doc_date),'YYYY-MM-DD')";

            System.out.println("SQL_Res1 = " + SQL_Res1);

            rs = con.createStatement().executeQuery(SQL_Res1);

            while (rs.next()) {

                //System.out.println("SubLastString = " + struti.SubLastString(rs.getString("job_type_desc"), 1));
                //System.out.println("doc_date = " + rs.getString("doc_date"));
                if (!struti.SubLastString(rs.getString("job_type_desc"), 1).equals("1") || rs.getString("job_type_id").equals("008")) {

                    //System.out.println("doc_id = " + rs.getString("doc_id"));
                    //System.out.println("size_job_id = " + rs.getString("size_job_id"));
//                    System.out.println("size = " + rs.getString("size"));
//                    System.out.println(" True job_type_id = " + rs.getString("job_type_id"));
//                    System.out.println(" True job_type_desc = " + rs.getString("job_type_desc"));
//                    System.out.println(" True doc_id = " + rs.getString("doc_id"));
                    
                    SQL_Res2 = " select count(*) as num from " + Table_Track_Detail
                            + " where job_id = '" + job_id + "'"
                            + " and doc_type = '3'"
                            + " and shift = '" + rs.getString("shift") + "'"
                            + " and machine = '" + rs.getString("job_type_desc") + "'"
                            + " and size = '" + rs.getString("size") + "'"
                            + " and month = '" + rs.getString("month") + "'"
                            + " and year = '" + rs.getString("year") + "'"
                            + "";

                    machine = rs.getString("job_type_desc");
                    shift = rs.getString("shift");
                    size = rs.getString("size");
                    month = rs.getString("month");
                    year = rs.getString("year");
                    

                    statusnum = objuti.numRowdatabase(SQL_Res2);

                    dataBean.setJob_id(rs.getString("job_id"));
                    dataBean.setShift(rs.getString("shift"));
                    dataBean.setSize(rs.getString("size"));
                    dataBean.setMachine(rs.getString("job_type_desc"));
                    dataBean.setMonth(rs.getString("month"));
                    dataBean.setYear(rs.getString("year"));
                    dataBean.setDoc_type("3");
                    
		    dataBean.setBy(user_login);                    
                    dataBean.setDate(ts);         
                    
                    dataBean.setD_1(rs.getString("doc_date").substring(0, 2).equals("01") ? rs.getDouble("weight") : 0);
                    dataBean.setD_2(rs.getString("doc_date").substring(0, 2).equals("02") ? rs.getDouble("weight") : 0);
                    dataBean.setD_3(rs.getString("doc_date").substring(0, 2).equals("03") ? rs.getDouble("weight") : 0);
                    dataBean.setD_4(rs.getString("doc_date").substring(0, 2).equals("04") ? rs.getDouble("weight") : 0);
                    dataBean.setD_5(rs.getString("doc_date").substring(0, 2).equals("05") ? rs.getDouble("weight") : 0);
                    dataBean.setD_6(rs.getString("doc_date").substring(0, 2).equals("06") ? rs.getDouble("weight") : 0);
                    dataBean.setD_7(rs.getString("doc_date").substring(0, 2).equals("07") ? rs.getDouble("weight") : 0);
                    dataBean.setD_8(rs.getString("doc_date").substring(0, 2).equals("08") ? rs.getDouble("weight") : 0);
                    dataBean.setD_9(rs.getString("doc_date").substring(0, 2).equals("09") ? rs.getDouble("weight") : 0);
                    dataBean.setD_10(rs.getString("doc_date").substring(0, 2).equals("10") ? rs.getDouble("weight") : 0);
                    dataBean.setD_11(rs.getString("doc_date").substring(0, 2).equals("11") ? rs.getDouble("weight") : 0);
                    dataBean.setD_12(rs.getString("doc_date").substring(0, 2).equals("12") ? rs.getDouble("weight") : 0);
                    dataBean.setD_13(rs.getString("doc_date").substring(0, 2).equals("13") ? rs.getDouble("weight") : 0);
                    dataBean.setD_14(rs.getString("doc_date").substring(0, 2).equals("14") ? rs.getDouble("weight") : 0);
                    dataBean.setD_15(rs.getString("doc_date").substring(0, 2).equals("15") ? rs.getDouble("weight") : 0);
                    dataBean.setD_16(rs.getString("doc_date").substring(0, 2).equals("16") ? rs.getDouble("weight") : 0);
                    dataBean.setD_17(rs.getString("doc_date").substring(0, 2).equals("17") ? rs.getDouble("weight") : 0);
                    dataBean.setD_18(rs.getString("doc_date").substring(0, 2).equals("18") ? rs.getDouble("weight") : 0);
                    dataBean.setD_19(rs.getString("doc_date").substring(0, 2).equals("19") ? rs.getDouble("weight") : 0);
                    dataBean.setD_20(rs.getString("doc_date").substring(0, 2).equals("20") ? rs.getDouble("weight") : 0);
                    dataBean.setD_21(rs.getString("doc_date").substring(0, 2).equals("21") ? rs.getDouble("weight") : 0);
                    dataBean.setD_22(rs.getString("doc_date").substring(0, 2).equals("22") ? rs.getDouble("weight") : 0);
                    dataBean.setD_23(rs.getString("doc_date").substring(0, 2).equals("23") ? rs.getDouble("weight") : 0);
                    dataBean.setD_24(rs.getString("doc_date").substring(0, 2).equals("24") ? rs.getDouble("weight") : 0);
                    dataBean.setD_25(rs.getString("doc_date").substring(0, 2).equals("25") ? rs.getDouble("weight") : 0);
                    dataBean.setD_26(rs.getString("doc_date").substring(0, 2).equals("26") ? rs.getDouble("weight") : 0);
                    dataBean.setD_27(rs.getString("doc_date").substring(0, 2).equals("27") ? rs.getDouble("weight") : 0);
                    dataBean.setD_28(rs.getString("doc_date").substring(0, 2).equals("28") ? rs.getDouble("weight") : 0);
                    dataBean.setD_29(rs.getString("doc_date").substring(0, 2).equals("29") ? rs.getDouble("weight") : 0);
                    dataBean.setD_30(rs.getString("doc_date").substring(0, 2).equals("30") ? rs.getDouble("weight") : 0);
                    dataBean.setD_31(rs.getString("doc_date").substring(0, 2).equals("31") ? rs.getDouble("weight") : 0);

                    System.out.println("weight" + rs.getDouble("weight"));
                    //total_weight = total_weight + rs.getDouble("weight");
                    //System.out.println("total_weight = " + total_weight);
                    
                    if (statusnum == 0) {
                        /*
                         System.out.println("Insert");
                         System.out.print(" job_id = " + rs.getString("job_id"));
                         System.out.print(" shift = " + rs.getString("shift"));
                         System.out.print(" machine = " + rs.getString("job_type_desc"));
                         System.out.print(" month = " + rs.getString("month"));
                         System.out.print(" year = " + rs.getString("year"));
                         */

                        insert_product(dataBean, con, p);

                    } else {
                        /*                        
                         System.out.println("Update");
                         System.out.print(" job_id = " + rs.getString("job_id"));
                         System.out.print(" shift = " + rs.getString("shift"));
                         System.out.print(" machine = " + rs.getString("job_type_desc"));
                         System.out.print(" month = " + rs.getString("month"));
                         System.out.print(" year = " + rs.getString("year"));
                         */

                        update_product(dataBean, con, p);

                    }

                }
                //else {
                //    System.out.println(" Fasle job_type_desc = " + rs.getString("job_type_desc"));
                //}

            }

            //** Summary Product to Header 
            String SQL_Track_Cond = " where job_id = '" + job_id + "'"
                    + " and doc_type = '3' "
                    + " and machine = '" + machine + "'"
                    + " and size = '" + size + "'"
                    + " and month = '" + month + "'"
                    + " and year = '" + year + "'"
                    + "";

            String SQL_Delete_Track_Header = "Delete From " + Table_Track_Header + SQL_Track_Cond;

            delete(SQL_Delete_Track_Header, con, p);

            SQL_Res3 = " select * from " + Table_Track_Detail_sum + SQL_Track_Cond;

            System.out.println("SQL_Res3" + SQL_Res3);
            rs = con.createStatement().executeQuery(SQL_Res3);
            Double day_weight[] = new Double[32];
            Double day_sum[] = new Double[32];
            Double d_sum = 0.00;
            while (rs.next()) {
                for (int loop = 1; loop <= 31; loop++) {
                    day_weight[loop] = rs.getDouble("sum_d_" + loop);
                    //System.out.println("sum_d_" + loop + " = " + day_weight[loop]);
                }

                for (int i = 1; i <= 31; i++) {
                    d_sum += (day_weight[i]);
                    day_sum[i] = d_sum;

                    //System.out.println("In Loop = " + i + " value " + day_weight[i] + " | " + day_sum[i]);
/*                    
                     System.out.println("Loop = " + i + " value " + day_weight[1] + " | " + day_sum[1]);
                     System.out.println("Loop = " + i + " value " + day_weight[2] + " | " + day_sum[2]);
                     System.out.println("Loop = " + i + " value " + day_weight[3] + " | " + day_sum[3]);
                     System.out.println("Loop = " + i + " value " + day_weight[4] + " | " + day_sum[4]);
                     System.out.println("Loop = " + i + " value " + day_weight[5] + " | " + day_sum[5]);
                     System.out.println("Loop = " + i + " value " + day_weight[6] + " | " + day_sum[6]);
                     System.out.println("Loop = " + i + " value " + day_weight[7] + " | " + day_sum[7]);
                     System.out.println("Loop = " + i + " value " + day_weight[8] + " | " + day_sum[8]);
                     */
                    /*                    
                     dataBean_header.setD_1(day_sum[1]);
                     dataBean_header.setD_2(day_sum[2]);
                     dataBean_header.setD_3(day_sum[3]);
                     dataBean_header.setD_4(day_sum[4]);
                     dataBean_header.setD_5(day_sum[5]);
                     dataBean_header.setD_6(day_sum[6]);
                     dataBean_header.setD_7(day_sum[7]);
                     dataBean_header.setD_8(day_sum[8]);
                     dataBean_header.setD_9(day_sum[9]);
                     dataBean_header.setD_10(day_sum[10]);
                     dataBean_header.setD_11(day_sum[11]);
                     dataBean_header.setD_12(day_sum[12]);
                     dataBean_header.setD_13(day_sum[13]);
                     dataBean_header.setD_14(day_sum[14]);
                     dataBean_header.setD_15(day_sum[15]);
                     dataBean_header.setD_16(day_sum[16]);
                     dataBean_header.setD_17(day_sum[17]);
                     dataBean_header.setD_18(day_sum[18]);
                     dataBean_header.setD_19(day_sum[19]);
                     dataBean_header.setD_20(day_sum[20]);
                     dataBean_header.setD_21(day_sum[21]);
                     dataBean_header.setD_22(day_sum[22]);
                     dataBean_header.setD_23(day_sum[23]);
                     dataBean_header.setD_24(day_sum[24]);
                     dataBean_header.setD_25(day_sum[25]);
                     dataBean_header.setD_26(day_sum[26]);
                     dataBean_header.setD_27(day_sum[27]);
                     dataBean_header.setD_28(day_sum[28]);
                     dataBean_header.setD_29(day_sum[29]);
                     dataBean_header.setD_30(day_sum[30]);
                     dataBean_header.setD_31(day_sum[31]);
        
                     */
                    //System.out.print("loop x[" + i + "] = " + x[i] +  "> d_sum = " + d_sum + " | ");
                    //System.out.println("loop day_sum[" + i + "] = " + day_sum[i] + " * ");
                }

                dataBean_header.setJob_id(job_id);
                dataBean_header.setMachine(machine);
                dataBean_header.setSize(size);
                dataBean_header.setMonth(month);
                dataBean_header.setYear(year);
                dataBean_header.setDoc_type("3");
                
                dataBean_header.setBy(user_login);                   
                dataBean_header.setDate(ts);         

//                System.out.println(rs.getDouble("sum_d_" + 8));
//                System.out.println(rs.getDouble("sum_d_" + 9));
//                System.out.println(rs.getDouble("sum_d_" + 10));
            }

            //System.out.println("Out Loop = " + 1 + " value " + day_weight[1] + " | " + day_sum[1]);
            
            dataBean_header.setD_1(day_weight[1] > 0 ? day_sum[1] : 0);
            dataBean_header.setD_2(day_weight[2] > 0 ? day_sum[2] : 0);
            dataBean_header.setD_3(day_weight[3] > 0 ? day_sum[3] : 0);
            dataBean_header.setD_4(day_weight[4] > 0 ? day_sum[4] : 0);
            dataBean_header.setD_5(day_weight[5] > 0 ? day_sum[5] : 0);
            dataBean_header.setD_6(day_weight[6] > 0 ? day_sum[6] : 0);
            dataBean_header.setD_7(day_weight[7] > 0 ? day_sum[7] : 0);
            dataBean_header.setD_8(day_weight[8] > 0 ? day_sum[8] : 0);
            dataBean_header.setD_9(day_weight[9] > 0 ? day_sum[9] : 0);
            dataBean_header.setD_10(day_weight[10] > 0 ? day_sum[10] : 0);
            dataBean_header.setD_11(day_weight[11] > 0 ? day_sum[11] : 0);
            dataBean_header.setD_12(day_weight[12] > 0 ? day_sum[12] : 0);
            dataBean_header.setD_13(day_weight[13] > 0 ? day_sum[13] : 0);
            dataBean_header.setD_14(day_weight[14] > 0 ? day_sum[14] : 0);
            dataBean_header.setD_15(day_weight[15] > 0 ? day_sum[15] : 0);
            dataBean_header.setD_16(day_weight[16] > 0 ? day_sum[16] : 0);
            dataBean_header.setD_17(day_weight[17] > 0 ? day_sum[17] : 0);
            dataBean_header.setD_18(day_weight[18] > 0 ? day_sum[18] : 0);
            dataBean_header.setD_19(day_weight[19] > 0 ? day_sum[19] : 0);
            dataBean_header.setD_20(day_weight[20] > 0 ? day_sum[20] : 0);
            dataBean_header.setD_21(day_weight[21] > 0 ? day_sum[21] : 0);
            dataBean_header.setD_22(day_weight[22] > 0 ? day_sum[22] : 0);
            dataBean_header.setD_23(day_weight[23] > 0 ? day_sum[23] : 0);
            dataBean_header.setD_24(day_weight[24] > 0 ? day_sum[24] : 0);
            dataBean_header.setD_25(day_weight[25] > 0 ? day_sum[25] : 0);
            dataBean_header.setD_26(day_weight[26] > 0 ? day_sum[26] : 0);
            dataBean_header.setD_27(day_weight[27] > 0 ? day_sum[27] : 0);
            dataBean_header.setD_28(day_weight[28] > 0 ? day_sum[28] : 0);
            dataBean_header.setD_29(day_weight[29] > 0 ? day_sum[29] : 0);
            dataBean_header.setD_30(day_weight[30] > 0 ? day_sum[30] : 0);
            dataBean_header.setD_31(day_weight[31] > 0 ? day_sum[31] : 0);

            insert_product_header(dataBean_header, con, p);

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

    private void insert_product(DataBeanD_product_receive_process_track_detail dataBean, Connection con, PreparedStatement p) throws Exception {
        String SQL_Insert = "";
        try {

            SQL_Insert = "insert into d_product_receive_process_track_detail"
                    + "(d_1,d_2,d_3,d_4,d_5,d_6,d_7,d_8,d_9,d_10,d_11,d_12,d_13,d_14,d_15,d_16,d_17,d_18,d_19,d_20,d_21,d_22,d_23,d_24,d_25,d_26,d_27,d_28,d_29,d_30,d_31,doc_id,doc_type,job_id,shift,size,machine,month,year,create_by,create_date) "
                    + "values(?,?,?,?,?,?,?,?,?,?"
                    + ",?,?,?,?,?,?,?,?,?,?"
                    + ",?,?,?,?,?,?,?,?,?,?"
                    + ",?,?,?,?,?,?,?,?,?,?,?)";

            p = con.prepareStatement(SQL_Insert);

            System.out.println("SQL_Insert = " + SQL_Insert);
            p.setDouble(1, dataBean.getD_1());
            p.setDouble(2, dataBean.getD_2());
            p.setDouble(3, dataBean.getD_3());
            p.setDouble(4, dataBean.getD_4());
            p.setDouble(5, dataBean.getD_5());
            p.setDouble(6, dataBean.getD_6());
            p.setDouble(7, dataBean.getD_7());
            p.setDouble(8, dataBean.getD_8());
            p.setDouble(9, dataBean.getD_9());
            p.setDouble(10, dataBean.getD_10());
            p.setDouble(11, dataBean.getD_11());
            p.setDouble(12, dataBean.getD_12());
            p.setDouble(13, dataBean.getD_13());
            p.setDouble(14, dataBean.getD_14());
            p.setDouble(15, dataBean.getD_15());
            p.setDouble(16, dataBean.getD_16());
            p.setDouble(17, dataBean.getD_17());
            p.setDouble(18, dataBean.getD_18());
            p.setDouble(19, dataBean.getD_19());
            p.setDouble(20, dataBean.getD_20());
            p.setDouble(21, dataBean.getD_21());
            p.setDouble(22, dataBean.getD_22());
            p.setDouble(23, dataBean.getD_23());
            p.setDouble(24, dataBean.getD_24());
            p.setDouble(25, dataBean.getD_25());
            p.setDouble(26, dataBean.getD_26());
            p.setDouble(27, dataBean.getD_27());
            p.setDouble(28, dataBean.getD_28());
            p.setDouble(29, dataBean.getD_29());
            p.setDouble(30, dataBean.getD_30());
            p.setDouble(31, dataBean.getD_31());
            p.setString(32, dataBean.getDoc_id());
            p.setString(33, dataBean.getDoc_type());
            p.setString(34, dataBean.getJob_id());
            p.setString(35, dataBean.getShift());
            p.setString(36, dataBean.getSize());
            p.setString(37, dataBean.getMachine());
            p.setString(38, dataBean.getMonth());
            p.setString(39, dataBean.getYear());
            p.setString(40, dataBean.getBy());
            p.setTimestamp(41, dataBean.getDate());

            p.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
        }
    }

    private void update_product(DataBeanD_product_receive_process_track_detail dataBean, Connection con, PreparedStatement p) throws Exception {
        String SQL_Update = "";
        try {

            SQL_Update = "update d_product_receive_process_track_detail set "
                    + " d_1=d_1+?,d_2=d_2+?,d_3=d_3+?,d_4=d_4+?,d_5=d_5+?,d_6=d_6+?,d_7=d_7+?,d_8=d_8+?,d_9=d_9+?,d_10=d_10+?,d_11=d_11+?,d_12=d_12+?,d_13=d_13+?,d_14=d_14+?,d_15=d_15+?"
                    + ",d_16=d_16+?,d_17=d_17+?,d_18=d_18+?,d_19=d_19+?,d_20=d_20+?,d_21=d_21+?,d_22=d_22+?,d_23=d_23+?,d_24=d_24+?,d_25=d_25+?,d_26=d_26+?,d_27=d_27+?,d_28=d_28+?,d_29=d_29+?,d_30=d_30+?,d_31=d_31+? "
                    + " where job_id = ?"
                    + " and doc_type = '3' "
                    + " and shift = ?"
                    + " and machine = ?"
                    + " and size = ?"
                    + " and month = ?"
                    + " and year = ?";

            p = con.prepareStatement(SQL_Update);

            System.out.println("SQL_Update = " + SQL_Update);
            p.setDouble(1, dataBean.getD_1());
            p.setDouble(2, dataBean.getD_2());
            p.setDouble(3, dataBean.getD_3());
            p.setDouble(4, dataBean.getD_4());
            p.setDouble(5, dataBean.getD_5());
            p.setDouble(6, dataBean.getD_6());
            p.setDouble(7, dataBean.getD_7());
            p.setDouble(8, dataBean.getD_8());
            p.setDouble(9, dataBean.getD_9());
            p.setDouble(10, dataBean.getD_10());
            p.setDouble(11, dataBean.getD_11());
            p.setDouble(12, dataBean.getD_12());
            p.setDouble(13, dataBean.getD_13());
            p.setDouble(14, dataBean.getD_14());
            p.setDouble(15, dataBean.getD_15());
            p.setDouble(16, dataBean.getD_16());
            p.setDouble(17, dataBean.getD_17());
            p.setDouble(18, dataBean.getD_18());
            p.setDouble(19, dataBean.getD_19());
            p.setDouble(20, dataBean.getD_20());
            p.setDouble(21, dataBean.getD_21());
            p.setDouble(22, dataBean.getD_22());
            p.setDouble(23, dataBean.getD_23());
            p.setDouble(24, dataBean.getD_24());
            p.setDouble(25, dataBean.getD_25());
            p.setDouble(26, dataBean.getD_26());
            p.setDouble(27, dataBean.getD_27());
            p.setDouble(28, dataBean.getD_28());
            p.setDouble(29, dataBean.getD_29());
            p.setDouble(30, dataBean.getD_30());
            p.setDouble(31, dataBean.getD_31());
            p.setString(32, dataBean.getJob_id());
            p.setString(33, dataBean.getShift());
            p.setString(34, dataBean.getMachine());
            p.setString(35, dataBean.getSize());
            p.setString(36, dataBean.getMonth());
            p.setString(37, dataBean.getYear());
            p.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
        }
    }

    private void insert_product_header(DataBeanD_product_receive_process_track_header dataBean_header, Connection con, PreparedStatement p) throws Exception {
        String SQL_Insert = "";
        try {

            SQL_Insert = " insert into d_product_receive_process_track_header "
                    + " (d_1,d_2,d_3,d_4,d_5,d_6,d_7,d_8,d_9,d_10,d_11,d_12,d_13,d_14,d_15,d_16,d_17,d_18,d_19,d_20,d_21,d_22,d_23,d_24,d_25,d_26,d_27,d_28,d_29,d_30,d_31,job_id,machine,size,month,year,doc_type,create_by,create_date) "
                    + " values(?,?,?,?,?,?,?,?,?,?"
                    + ",?,?,?,?,?,?,?,?,?,?"
                    + ",?,?,?,?,?,?,?,?,?,?"
                    + ",?,?,?,?,?,?,?,?,?)";

            p = con.prepareStatement(SQL_Insert);

            //System.out.println("SQL_Insert = " + SQL_Insert);
            p.setDouble(1, dataBean_header.getD_1());
            p.setDouble(2, dataBean_header.getD_2());
            p.setDouble(3, dataBean_header.getD_3());
            p.setDouble(4, dataBean_header.getD_4());
            p.setDouble(5, dataBean_header.getD_5());
            p.setDouble(6, dataBean_header.getD_6());
            p.setDouble(7, dataBean_header.getD_7());
            p.setDouble(8, dataBean_header.getD_8());
            p.setDouble(9, dataBean_header.getD_9());
            p.setDouble(10, dataBean_header.getD_10());
            p.setDouble(11, dataBean_header.getD_11());
            p.setDouble(12, dataBean_header.getD_12());
            p.setDouble(13, dataBean_header.getD_13());
            p.setDouble(14, dataBean_header.getD_14());
            p.setDouble(15, dataBean_header.getD_15());
            p.setDouble(16, dataBean_header.getD_16());
            p.setDouble(17, dataBean_header.getD_17());
            p.setDouble(18, dataBean_header.getD_18());
            p.setDouble(19, dataBean_header.getD_19());
            p.setDouble(20, dataBean_header.getD_20());
            p.setDouble(21, dataBean_header.getD_21());
            p.setDouble(22, dataBean_header.getD_22());
            p.setDouble(23, dataBean_header.getD_23());
            p.setDouble(24, dataBean_header.getD_24());
            p.setDouble(25, dataBean_header.getD_25());
            p.setDouble(26, dataBean_header.getD_26());
            p.setDouble(27, dataBean_header.getD_27());
            p.setDouble(28, dataBean_header.getD_28());
            p.setDouble(29, dataBean_header.getD_29());
            p.setDouble(30, dataBean_header.getD_30());
            p.setDouble(31, dataBean_header.getD_31());
            p.setString(32, dataBean_header.getJob_id());
            p.setString(33, dataBean_header.getMachine());
            p.setString(34, dataBean_header.getSize());
            p.setString(35, dataBean_header.getMonth());
            p.setString(36, dataBean_header.getYear());
            p.setString(37, dataBean_header.getDoc_type());
            p.setString(38, dataBean_header.getBy());
            p.setTimestamp(39, dataBean_header.getDate());

            p.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
        }
    }

}
