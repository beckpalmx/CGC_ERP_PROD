/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.report;

import com.cgc.DB.DBConnect;
import com.cgc.Util.UtiDatabase;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DecimalFormat;

/**
 *
 * @author Beckpalmx No7
 */
public class PrintReport_Rawmat_bigbag_balance {

    public String ShowDetail(String month_id, String price_year, String location_id) throws Exception {
        StringBuffer Return_String = new StringBuffer();
        Connection con = new DBConnect().openNewConnection();
        UtiDatabase objuti = new UtiDatabase();
        ResultSet rs = null;
        int count_line = 1;
        String Cond0, Cond1 = "";

        System.out.println("param 1 " + price_year);
        System.out.println("param 2 " + month_id);
        System.out.println("param 3 " + location_id);

        if (month_id.equals("") && price_year.equals("")) {
            Cond0 = "Where month like '%' and year like '%' ";
        } else {
            Cond0 = "Where (month BETWEEN '01' and '" + month_id + "') and year = '" + price_year + "' ";

        }
        int prev_month = 0;

        if (Integer.parseInt(month_id) > 1) {
            prev_month = Integer.parseInt(month_id) - 1 ;
        } else {
            prev_month = Integer.parseInt(month_id);
        }
        
        System.out.println("prev_month = " + prev_month);

        String Str = location_id;

        String[] Str_Cond = new String[2];
        int i = 0;
        for (String retval : Str.split("\\?", 2)) {
            Str_Cond[i] = retval;
            System.out.println("value = " + i + " : " + Str_Cond[i]);

            if (!(Str_Cond[0].equals("-"))) {
                Cond1 = " and location_id = '" + Str_Cond[0] + "' ";
            } else {
                Cond1 = " and location_id like '%' ";
            }

            System.out.println("loop " + i + " Cond1 = " + Cond1);

            i++;
        }

        String condition = Cond0 + Cond1 + " and (process_id = 'PR_025' or process_id = 'PR_057') ";

        try {

            count_line = 1;

            //String SQL = "Select product_id,wh_id,location_id,sum(weight_total) as weight_total From vt_transaction_stock_process_report " + condition + "and delete_flag = 'N' "
                    //+ " Group By product_id,wh_id,location_id "
                    //+ " Having sum(weight_total) > 0 "
                    //+ " Order By product_id,wh_id,location_id ";
            
            String SQL = "Select product_id,location_id,sum(weight_total) as weight_total From vt_transaction_stock_process_report " + condition + "and delete_flag = 'N' "
                    + " Group By product_id,location_id "
                    + " Having sum(weight_total) > 0 "
                    + " Order By product_id,location_id ";            

            System.out.println("SQL = " + SQL);
            String sql1
                    = sql1 = "Select COUNT(doc_id) as num From vt_transaction_stock_process_report "
                    + condition
                    + "and delete_flag = 'N' ";
            if (objuti.numRowdatabase(sql1) >= 1) {

                Return_String.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n");
                Return_String.append(("<td class=\"headergrid\" width=\"100%\">เดือน " + month_id + " ปี " + price_year + "</td>\n"));
                Return_String.append("</table>");

                Return_String.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n");

                Return_String.append("<tr>\n");
                Return_String.append(("<td class=\"row5\" width=\"5%\">ลำดับ</td>\n"));
                Return_String.append(("<td class=\"row5\" width=\"7%\">ประเภทวัตถุดิบ</td>\n"));
                //Return_String.append(("<td class=\"row5\" width=\"7%\">คลังวัตถุดิบ</td>\n"));
                Return_String.append(("<td class=\"row5\" width=\"6%\">กองที่</td>\n"));
                Return_String.append(("<td class=\"row5\" width=\"6%\">จำนวน</td>\n"));

                //System.out.println(Return_String);
                DecimalFormat df = new DecimalFormat("#,###,##0.00");

                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {

                    //System.out.println("D weight_total = " + rs.getDouble("weight_total"));
                    if (rs.getDouble("weight_total") > 0) {

                        Return_String.append("<tr>\n");
                        Return_String.append(("<td class=\"forborder\" width=\"3%\">" + count_line + "</td>\n"));
                        //Return_String.append(("<td class=\"forborder\" width=\"5%\"><input type =\"button\" id=\"print_" + count_line + "\" name\"print\" value =\"" + rs.getString("doc_id") + "\" onclick=\"send_print('" + rs.getString("doc_id") + "','RP_046')\"></td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"5%\">" + rs.getString("product_id") + "</td>\n"));
                        //Return_String.append(("<td class=\"forborder\" width=\"7%\">" + rs.getString("wh_id") + "</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"6%\">" + rs.getString("location_id") + "</td>\n"));
                        //Return_String.append(("<td class=\"forborder\" width=\"6%\">" + rs.getString("i2") + "</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"6%\"><p align = \"right\">" + df.format(rs.getDouble("weight_total")) + "</p></td>\n"));
                        Return_String.append("</tr>\n");
                        count_line += 1;
                    }
                }

                Return_String.append("</table>");
            } else {
                Return_String.append("<br>");
                Return_String.append("<b>ไม่พบข้อมูล</b>");
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            return Return_String.toString();
        }

    }

}
