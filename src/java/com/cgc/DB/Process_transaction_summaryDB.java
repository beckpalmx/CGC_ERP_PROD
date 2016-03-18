/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBean_Transaction_Process_Summary;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;

/**
 *
 * @author Beckpalmx No7
 */
public class Process_transaction_summaryDB {

    public void generater_transaction_process(String date_from, String date_to, String process_id, String table, String doc_type, String r, String username) throws Exception {
        ArrayList<DataBean_Transaction_Process_Summary> obj_AL_process_transaction = new ArrayList<DataBean_Transaction_Process_Summary>();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs, rs1 = null;
        PreparedStatement p = null;
        //Random r = new Random();
        String SQL_DEL, SQL_DEL1, SQL, SQL1, SQL2, token, SQL_TimeStamp;
        int Record, count_loop = 0;
        //System.out.println("Table : " + table);
        //System.out.println("r : " + r);
        //System.out.println("Date From Param Send : " + date_from);
        //System.out.println("Date To Param Send : " + date_to);
        System.out.println("Start Process process_id : " + process_id);
        //System.out.println("doc_type : " + doc_type);

        SQL_DEL = " delete from t_transaction_stock_process where process_id = '" + process_id + "'";
        SQL_DEL1 = " delete from t_transaction_stock_process_error where process_id = '" + process_id + "'";

        delete(SQL_DEL, con, p);
        delete(SQL_DEL1, con, p);

        if (process_id.equals("PR_115") || process_id.equals("PR_117")) {
            SQL = " select runno,doc_id,doc_date,line_no,doc_type,wh_product_id,wh_weight_final,wh_warehouse_id,wh_location_id,iodine,pgroup_id from " + table
                    + " where delete_flag <> 'Y' and complete_flag = 'Y' "
                    + " and to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date('" + date_from + "'),'YYYY-MM-DD') AND to_date(format_date('" + date_to + "'),'YYYY-MM-DD')";
        } else if (process_id.equals("PR_060")) {
            SQL = " select runno,doc_id,doc_date,line_no,doc_type,wh_product_id,wh_weight_final,wh_warehouse_id,wh_location_id,wh_iodine as iodine,pgroup_id "
                    + " from " + table
                    + " where delete_flag <> 'Y' and complete_flag = 'Y' and (weight <> '0' and weight <> '') "
                    + " and to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date('" + date_from + "'),'YYYY-MM-DD') AND to_date(format_date('" + date_to + "'),'YYYY-MM-DD')";
            System.out.println("60 SQL = " + SQL);        
        
        } else {
            SQL = " select runno,doc_id,doc_date,line_no,wh_product_id,wh_weight_final,wh_warehouse_id,wh_location_id,iodine,pgroup_id from " + table
                    + " where delete_flag <> 'Y' and complete_flag = 'Y' "
                    + " and to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date('" + date_from + "'),'YYYY-MM-DD') AND to_date(format_date('" + date_to + "'),'YYYY-MM-DD')";
        }

        
        SQL = SQL + " order by to_date(format_date(doc_date),'YYYY-MM-DD')" ;
        System.out.println("Main SQL = " + SQL);
        
        SQL1 = " select count(*) from " + table
                + " where delete_flag <> 'Y' "
                + " and to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date('" + date_from + "'),'YYYY-MM-DD') AND to_date(format_date('" + date_to + "'),'YYYY-MM-DD')";

        
        
        //System.out.println("SQL_DEL = " + SQL_DEL);
        //System.out.println("SQL_DEL1 = " + SQL_DEL1);
        //System.out.println("SQL = " + SQL);
        //System.out.println("SQL1 = " + SQL1);
        Record = numrow(SQL1, con);
        //System.out.println("process_id = " + process_id);
        //System.out.println(process_id + " = " + Record);
        token = process_id + "_" + new SimpleDateFormat("ddMMyy_hhmmssS").format(new Date());
        //System.out.println("Token = " + token);
        SQL_TimeStamp = " Insert into t_process_log (log_id,process_id,start_time,create_by) values ('" + token + "','" + process_id + "','" + new Timestamp(new java.util.Date().getTime()) + "','" + username + "')";
        //System.out.println("SQL_TimeStamp = " + SQL_TimeStamp);
        InsTimeStamp(SQL_TimeStamp, con, p);

        if (Record >= 1) {
            rs = con.createStatement().executeQuery(SQL);
            DataBean_Transaction_Process_Summary bean = new DataBean_Transaction_Process_Summary();
            //String Doc_date, Price_Month, Price_Year, Pgroup_id, Iodine, MonthString = "";
            String Doc_date, Price_Month, Price_Year, MonthString, Price_Per_Unit = "";
            int Month = 0;
            while (rs.next()) {

                bean.setProcess_id(process_id);
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setProduct_id(rs.getString("wh_product_id") == null ? "" : rs.getString("wh_product_id"));

                if (rs.getString("doc_date") == null) {
                    bean.setDoc_date("-");
                } else {
                    bean.setDoc_date(rs.getString("doc_date"));
                    Doc_date = rs.getString("doc_date");
                    Price_Month = Doc_date.substring(3, 5);
                    Price_Year = Doc_date.substring(6, 10);

                    //Pgroup_id = rs.getString("pgroup_id");
                    //Iodine = rs.getString("iodine");
                    //System.out.println("Doc Date : " + Doc_date);                    
                    //System.out.println(Price_Year + " : " + Price_Year);                    
                    /*                    
                     SQL2 = " Select * from mproduct_price "
                     + " where delete_flag <> 'Y' "
                     + "and price_year = '" + Price_Year + "'"
                     + " and pgroup_id = '" + rs.getString("pgroup_id") + "'"
                     + " and iodine = '" + rs.getString("iodine") + "'";                        
                     */
                    
                    System.out.println("TTT : DATA = " + process_id + " : " + rs.getString("doc_id") +  " : " + rs.getString("wh_product_id") + " : " + rs.getString("pgroup_id"));
                    
                    if (rs.getString("pgroup_id").equals("IMP") || rs.getString("pgroup_id").equals("WIP-FC") || rs.getString("pgroup_id").equals("RAW")) {
                        SQL2 = " Select * from mproduct_price "
                                + " where delete_flag <> 'Y' "
                                + "and price_year = '" + Price_Year + "'"
                                + " and product_id = '" + rs.getString("wh_product_id") + "'";
                    System.out.println("Case XXX = " + SQL2);                        
                    } else {
                        SQL2 = " Select * from mproduct_price "
                                + " where delete_flag <> 'Y' "
                                + "and price_year = '" + Price_Year + "'"
                                + " and pgroup_id = '" + rs.getString("pgroup_id") + "'"
                                + " and iodine = '" + rs.getString("iodine") + "'";
                    }                    
                    System.out.println("Case YYY = " + SQL2);   
                    Month = Integer.parseInt(Price_Month);

                    Price_Per_Unit = "0";

                    //System.out.println(Price_Month + " : " + Month);
                    rs1 = con.createStatement().executeQuery(SQL2);
                    while (rs1.next()) {
                        //System.out.println(SQL2 + " : " + SQL2);
                        switch (Month) {
                            case 1:
                                MonthString = "January";
                                Price_Per_Unit = (rs1.getString("price_month_1"));
                                break;
                            case 2:
                                MonthString = "February";
                                Price_Per_Unit = (rs1.getString("price_month_2"));
                                break;
                            case 3:
                                MonthString = "March";
                                Price_Per_Unit = (rs1.getString("price_month_3"));
                                break;
                            case 4:
                                MonthString = "April";
                                Price_Per_Unit = (rs1.getString("price_month_4"));
                                break;
                            case 5:
                                MonthString = "May";
                                Price_Per_Unit = (rs1.getString("price_month_5"));
                                break;
                            case 6:
                                MonthString = "June";
                                Price_Per_Unit = (rs1.getString("price_month_6"));
                                break;
                            case 7:
                                MonthString = "July";
                                Price_Per_Unit = (rs1.getString("price_month_7"));
                                break;
                            case 8:
                                MonthString = "August";
                                Price_Per_Unit = (rs1.getString("price_month_8"));
                                break;
                            case 9:
                                MonthString = "September";
                                Price_Per_Unit = (rs1.getString("price_month_9"));
                                break;
                            case 10:
                                MonthString = "October";
                                Price_Per_Unit = (rs1.getString("price_month_10"));
                                break;
                            case 11:
                                MonthString = "November";
                                Price_Per_Unit = (rs1.getString("price_month_11"));
                                break;

                            default:
                                MonthString = "December";
                                Price_Per_Unit = (rs1.getString("price_month_12"));
                                break;
                        }

                        System.out.println("Price_Year : " + Price_Year);
                        System.out.println("Iodine = " + rs1.getString("iodine"));
                        System.out.println("pgroup_id = " + rs1.getString("pgroup_id"));
                        System.out.println("price_month_1 = " + rs1.getString("price_month_1"));
                        System.out.println("price_month_2 = " + rs1.getString("price_month_2"));
                        System.out.println("price_month_3 = " + rs1.getString("price_month_3"));
                        System.out.println("price_month_4 = " + rs1.getString("price_month_4"));
                        System.out.println("price_month_5 = " + rs1.getString("price_month_5"));
                        System.out.println("price_month_6 = " + rs1.getString("price_month_6"));
                        System.out.println("price_month_7 = " + rs1.getString("price_month_7"));
                        System.out.println("price_month_8 = " + rs1.getString("price_month_8"));
                        System.out.println("price_month_9 = " + rs1.getString("price_month_9"));
                        System.out.println("price_month_10 = " + rs1.getString("price_month_10"));
                        System.out.println("price_month_11 = " + rs1.getString("price_month_11"));
                        System.out.println("price_month_12 = " + rs1.getString("price_month_12"));
                        System.out.println("MonthString = " + MonthString);
                    }
                }

                bean.setPrice_per_unit(Price_Per_Unit);

                if (process_id.equals("PR_115") || process_id.equals("PR_117")) {
                    bean.setDoc_type(rs.getString("doc_type"));
                } else {
                    bean.setDoc_type(doc_type);
                }

                bean.setLine_no(rs.getString("line_no") == null ? "-" : rs.getString("line_no"));
                bean.setWeight(rs.getString("wh_weight_final") == null ? "0" : rs.getString("wh_weight_final"));
                bean.setWh_id(rs.getString("wh_warehouse_id") == null ? "-" : rs.getString("wh_warehouse_id"));
                bean.setLocation_id(rs.getString("wh_location_id") == null ? "-" : rs.getString("wh_location_id"));
                
                bean.setPgroup_id_chk(rs.getString("pgroup_id") == null ? "-" : rs.getString("pgroup_id"));
                
                

                if (process_id.equals("PR_022")) {
                    System.out.println("process_id = " + process_id + "Check WH Process_ID = " + process_id + " ,PRODUCT ID ," + rs.getString("wh_product_id") + "," + rs.getString("doc_date") + ",wh_weight_final = ," + rs.getString("wh_weight_final") + " | "  + rs.getString("pgroup_id"));
                }

                if (process_id.equals("PR_023")) {
                    System.out.println("process_id = " + process_id + "Check WH Process_ID = " + process_id + " ,PRODUCT ID ," + rs.getString("wh_product_id") + "," + rs.getString("doc_date") + ",wh_weight_final = ," + rs.getString("wh_weight_final") + " | "  + rs.getString("pgroup_id"));
                }

                if (process_id.equals("PR_025") || process_id.equals("PR_057")) {
                    System.out.println("process_id = " + process_id + "Check WH Process_ID = " + process_id + " ,PRODUCT ID ," + rs.getString("wh_product_id") + "," + rs.getString("doc_date") + ",wh_weight_final = ," + rs.getString("wh_weight_final") + " | "  + rs.getString("pgroup_id"));
                }

                if (process_id.equals("PR_115")) {
                    System.out.println("process_id = " + process_id + "Check WH PRODUCT ID " + rs.getString("wh_product_id") + " | " + rs.getString("doc_date") + " | "  + rs.getString("pgroup_id") + " | doc_type = " + rs.getString("doc_type") + " | doc_id = " + rs.getString("doc_id"));
                }
                
                if (process_id.equals("PR_117")) {
                    System.out.println("process_id = " + process_id + "Check WH PRODUCT ID " + rs.getString("wh_product_id") + " | " + rs.getString("doc_date") + " | "  + rs.getString("pgroup_id") + " | doc_type = " + rs.getString("doc_type")+ " | doc_id = " + rs.getString("doc_id"));
                }          
                
                if (process_id.equals("PR_060")) {
                    System.out.println("process_id = " + process_id + " Check WH PRODUCT ID " + rs.getString("wh_product_id") + " | doc_id = " + rs.getString("doc_id") + " | "+ rs.getString("doc_date") + " | "  + rs.getString("pgroup_id"));
                }                
                
                obj_AL_process_transaction.add(bean);

                if (rs.getString("wh_product_id").equals(null) || rs.getString("wh_product_id").equals("") || rs.getString("doc_date").equals(null) || rs.getString("doc_date").equals("")) {
                    //System.out.println("Error" + rs.getString("wh_product_id") );
                    insert_error(obj_AL_process_transaction, con, p);
                    System.out.println("1 > Process ID = " + process_id + " : " + rs.getString("wh_product_id") + " : " +  rs.getString("doc_id"));
                } else {
                    insert(obj_AL_process_transaction, con, p);
                    System.out.println("2 > Process ID = " + process_id + " : " + rs.getString("wh_product_id") + " : " + rs.getString("doc_id"));
                }

                count_loop++;
            }
        }
        //System.out.println("P1 count_loop = " + count_loop);
        SQL_TimeStamp = " Update t_process_log set condition = '" + SQL.replace("'", "#") + "', remark = '" + Record + " Record',complete_flag = 'Y' , end_time = '" + new Timestamp(new java.util.Date().getTime()) + "', update_by = '" + username + "' where log_id = '" + token + "'";
        //System.out.println("SQL_TimeStamp = " + SQL_TimeStamp);
        InsTimeStamp(SQL_TimeStamp, con, p);
        System.out.println("End Process process_id : " + process_id);
    }

    private static int numrow(String SQL, Connection con) throws Exception {
        ResultSet rs = null;
        int numrow = 0;
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                numrow = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            return numrow;
        }
    }

    private void insert(ArrayList<DataBean_Transaction_Process_Summary> obj_AL, Connection con, PreparedStatement p) throws Exception {

        int i;
        try {
            p = con.prepareStatement("insert into t_transaction_stock_process "
                    + "(process_id,doc_id,line_no,doc_date,doc_type,product_id,price_per_unit,weight,wh_id,location_id,create_date,create_by,pgroup_id_chk) "
                    + "values"
                    + "(?,?,?,?,?,?,?,?,?,?,?,?,?)");

            for (DataBean_Transaction_Process_Summary bean : obj_AL) {
                i = 1;
                p.setString(i++, bean.getProcess_id());
                p.setString(i++, bean.getDoc_id());
                p.setString(i++, bean.getLine_no());
                p.setString(i++, bean.getDoc_date());
                p.setString(i++, bean.getDoc_type());
                p.setString(i++, bean.getProduct_id());
                p.setString(i++, bean.getPrice_per_unit());
                p.setString(i++, bean.getWeight());
                //p.setString(i++, bean.getUnit());
                p.setString(i++, bean.getWh_id());
                p.setString(i++, bean.getLocation_id());
                p.setTimestamp(i++, new Timestamp(new java.util.Date().getTime()));
                p.setString(i++, ("System"));
                p.setString(i++, bean.getPgroup_id_chk());
                //System.out.println(i++);
                //System.out.println("Price_Unit = " + bean.getPrice_per_unit());
                p.addBatch();
                //p.executeUpdate();
            }
            p.executeBatch();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.clearBatch();
                p.clearParameters();
            }
            obj_AL.clear();
        }
    }

    private void insert_error(ArrayList<DataBean_Transaction_Process_Summary> obj_AL, Connection con, PreparedStatement p) throws Exception {

        int i;
        try {
            p = con.prepareStatement("insert into t_transaction_stock_process_error "
                    + "(process_id,doc_id,line_no,doc_date,doc_type,product_id,price_per_unit,weight,wh_id,location_id,create_date,create_by,pgroup_id_chk) "
                    + "values"
                    + "(?,?,?,?,?,?,?,?,?,?,?,?,?)");
            for (DataBean_Transaction_Process_Summary bean : obj_AL) {
                i = 1;
                p.setString(i++, bean.getProcess_id());
                p.setString(i++, bean.getDoc_id());
                p.setString(i++, bean.getLine_no());
                p.setString(i++, bean.getDoc_date());
                p.setString(i++, bean.getDoc_type());
                p.setString(i++, bean.getProduct_id());
                p.setString(i++, bean.getPrice_per_unit());
                p.setString(i++, bean.getWeight());
                //p.setString(i++, bean.getUnit());
                p.setString(i++, bean.getWh_id());
                p.setString(i++, bean.getLocation_id());
                p.setTimestamp(i++, new Timestamp(new java.util.Date().getTime()));
                p.setString(i++, ("System"));
                p.setString(i++, bean.getPgroup_id_chk());
                //System.out.println(i++);
                //System.out.println(bean.getProduct_id());
                p.addBatch();
                //p.executeUpdate();
            }
            p.executeBatch();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.clearBatch();
                p.clearParameters();
            }
            obj_AL.clear();
        }
    }

    private void InsTimeStamp(String SQL_TimeStamp, Connection con, PreparedStatement p) throws Exception {
        try {
            p = con.prepareStatement(SQL_TimeStamp);
            p.executeUpdate();
            p.clearParameters();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
        }
    }

    private void delete(String SQL_DEL, Connection con, PreparedStatement p) throws Exception {
        try {
            System.out.println("Function Delete : " + SQL_DEL);
            p = con.prepareStatement(SQL_DEL);
            p.executeUpdate();
            p.clearParameters();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            p = null;
        }
    }
}
