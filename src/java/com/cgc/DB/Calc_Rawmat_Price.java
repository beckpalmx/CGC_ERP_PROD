/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.cgc.Util.UtiDatabase;
import java.sql.SQLException;
import java.text.DecimalFormat;

/**
 *
 * @author Beckpalmx No7
 */
public class Calc_Rawmat_Price {

    private final UtiDatabase objuti = new UtiDatabase();

    public void generater_transaction_process(String date_from, String date_to, String process_id, String table, String doc_type, String r, String username) throws Exception {

        Connection con = new DBConnect().openNewConnection();
        Connection con1 = new DBConnect().openNewConnection();
        Connection con2 = new DBConnect().openNewConnection();

        ResultSet rs ;
        ResultSet rs1 ;

        PreparedStatement p ;
        PreparedStatement p1;
        PreparedStatement p2;

        String SQL, SQL_MAIN, SQL_MAIN_SEARCH, SQL_MAIN_SELECT, SQL_MAIN_SELECT_WHERE ;

        String MonthString ;

        String Update_String ;

        String currentYear = date_from.substring(6, 10);

        DecimalFormat df = new DecimalFormat("#.00");
        double d_price_per_unit ;
        String s_price_per_unit ;        
        String smonth ;

        System.out.println("currentYear = " + currentYear);

        // currentYear = "2558";
        System.out.println("Start Process process");

        try {

            // คำนวณราคาต่อหน่วยตาม ชนิดถ่าน - หมายเลขกอง
/*             
             SQL = " select product_id,position_no,sum(to_number(total_weight,'999999.99')) as total_weight,sum(to_number(total_price,'999999.99')) as total_price "
             + " ,(sum(to_number(total_price,'999999.99'))/sum(to_number(total_weight,'999999.99'))) as price_per_unit "
             + " from " + table
             + " where delete_flag <> 'Y' and complete_flag = 'Y' "
             //+ " and to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date('" + date_from + "'),'YYYY-MM-DD') AND to_date(format_date('" + date_to + "'),'YYYY-MM-DD')"
             + " group by product_id,position_no "
             + " order by product_id,position_no ";
             */
            // คำนวณราคาต่อหน่วยตาม ชนิดถ่าน
            /*            
             SQL = " select product_id,sum(to_number(total_weight,'999999.99')) as total_weight,sum(to_number(total_price,'999999.99')) as total_price "
             + " ,(sum(to_number(total_price,'999999.99'))/sum(to_number(total_weight,'999999.99'))) as price_per_unit "
             + " from vd_rawmatt_receive"
             + " where delete_flag <> 'Y'"
             + " and to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date('01-01-2558'),'YYYY-MM-DD') AND to_date(format_date('31-01-2558'),'YYYY-MM-DD') "
             + " group by product_id"
             + " order by product_id";
             */
            // คำนวณราคาต่อหน่วยตาม ชนิดถ่าน , ปี , เดือน 
            SQL = " select product_id,ryear,rmonth,sum(to_number(total_weight,'999999.99')) as total_weight,sum(to_number(total_price,'999999.99')) as total_price "
                    + " ,(sum(to_number(total_price,'999999.99'))/sum(to_number(total_weight,'999999.99'))) as price_per_unit "
                    + " from vd_rawmatt_receive"
                    + " where delete_flag <> 'Y'"
                    //+ " and to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date('01-01-2558'),'YYYY-MM-DD') AND to_date(format_date('31-01-2558'),'YYYY-MM-DD') "
                    + " group by product_id,ryear,rmonth"
                    + " order by product_id,ryear,rmonth";

            System.out.print("SQL = " + SQL);

            p = con.prepareStatement(SQL);
            rs = p.executeQuery();
            while (rs.next()) {

                d_price_per_unit = rs.getDouble("total_price") / rs.getDouble("total_weight");

                //System.out.println("dtotal_price = " + df.format(dtotal_price));
                s_price_per_unit = df.format(d_price_per_unit);

                //System.out.print(rs.getString("product_id") + " : " + rs.getString("position_no") + " : " + rs.getString("total_weight") + " : " + rs.getString("total_price") + " : " + s_price_per_unit);
//              System.out.print(rs.getString("product_id") + " : " + rs.getString("total_weight") + " : " + rs.getString("total_price") + " : " + s_price_per_unit);
//              System.out.print(rs.getString("product_id") + " : " + rs.getString("ryear") + " : " + rs.getString("rmonth") + " : " + rs.getString("total_weight") + " : " + rs.getString("total_price") + " : " + s_price_per_unit);                
                SQL_MAIN_SELECT_WHERE = " where product_id = '" + rs.getString("product_id") + "'"
                        + " and pgroup_id = '" + "RAW'"
                        + " and price_year = '" + rs.getString("ryear") + "'"
                        + " and delete_flag <> 'Y' ";

                SQL_MAIN_SEARCH = " select count(*) as num from mproduct_price " + SQL_MAIN_SELECT_WHERE;

                if (objuti.numRowdatabase(SQL_MAIN_SEARCH) > 0) {

                    SQL_MAIN_SELECT = " select * from mproduct_price ";

                    p1 = con.prepareStatement(SQL_MAIN_SELECT + SQL_MAIN_SELECT_WHERE);
                    rs1 = p1.executeQuery();
                    while (rs1.next()) {

                        int imonth = Integer.parseInt(rs.getString("rmonth"));

                        switch (imonth) {
                            case 1:
                                MonthString = "January";
                                System.out.println(MonthString + " --> " + s_price_per_unit + " : " + (rs1.getString("price_month_1")));
                                smonth = Integer.toString(imonth);
                                break;
                            case 2:
                                MonthString = "February";
                                System.out.println(MonthString + " --> " + s_price_per_unit + " : " + (rs1.getString("price_month_2")));
                                smonth = Integer.toString(imonth);
                                break;
                            case 3:
                                MonthString = "March";
                                System.out.println(MonthString + " --> " + s_price_per_unit + " : " + (rs1.getString("price_month_3")));
                                smonth = Integer.toString(imonth);
                                break;
                            case 4:
                                MonthString = "April";
                                System.out.println(MonthString + " --> " + s_price_per_unit + " : " + (rs1.getString("price_month_4")));
                                smonth = Integer.toString(imonth);
                                break;
                            case 5:
                                MonthString = "May";
                                System.out.println(MonthString + " --> " + s_price_per_unit + " : " + (rs1.getString("price_month_5")));
                                smonth = Integer.toString(imonth);
                                break;
                            case 6:
                                MonthString = "June";
                                System.out.println(MonthString + " --> " + s_price_per_unit + " : " + (rs1.getString("price_month_6")));
                                smonth = Integer.toString(imonth);
                                break;
                            case 7:
                                MonthString = "July";
                                System.out.println(MonthString + " --> " + s_price_per_unit + " : " + (rs1.getString("price_month_7")));
                                smonth = Integer.toString(imonth);
                                break;
                            case 8:
                                MonthString = "August";
                                System.out.println(MonthString + " --> " + s_price_per_unit + " : " + (rs1.getString("price_month_8")));
                                smonth = Integer.toString(imonth);
                                break;
                            case 9:
                                MonthString = "September";
                                System.out.println(MonthString + " --> " + s_price_per_unit + " : " + (rs1.getString("price_month_9")));
                                smonth = Integer.toString(imonth);
                                break;
                            case 10:
                                MonthString = "October";
                                System.out.println(MonthString + " --> " + s_price_per_unit + " : " + (rs1.getString("price_month_10")));
                                smonth = Integer.toString(imonth);
                                break;
                            case 11:
                                MonthString = "November";
                                System.out.println(MonthString + " --> " + s_price_per_unit + " : " + (rs1.getString("price_month_11")));
                                smonth = Integer.toString(imonth);
                                break;

                            default:
                                MonthString = "December";
                                System.out.println(MonthString + " --> " + s_price_per_unit + " : " + (rs1.getString("price_month_12")));
                                smonth = Integer.toString(imonth);
                                break;
                        }

                        Update_String = " update mproduct_price set price_month_" + smonth + " = '" + s_price_per_unit + "'" + SQL_MAIN_SELECT_WHERE;

                        System.out.println("Update String = " + Update_String);                        
                        p2 = con.prepareStatement(Update_String);
                        p2.executeUpdate();

                        //System.out.println("mproduct_price --> " + rs1.getString("product_id") + " || " + s_price_per_unit + " : " + rs1.getString("price_year"));
                    }
                }

            }

        } finally {
            try {                
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }
        System.out.println("End Process process ");
    }
}
