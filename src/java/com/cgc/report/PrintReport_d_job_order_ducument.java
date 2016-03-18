/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.report;

import com.cgc.DB.DBConnect;
import com.cgc.Util.UtiDatabase;
import java.sql.Connection;
import java.sql.ResultSet;

/**
 *
 * @author Beckpalmx No7
 */
public class PrintReport_d_job_order_ducument {

    public String ShowDetail(String cust_id, String size_name) throws Exception {
        StringBuffer Return_String = new StringBuffer();
        Connection con = new DBConnect().openNewConnection();
        UtiDatabase objuti = new UtiDatabase();
        ResultSet rs = null;
        int count_line = 1;
        String Cond0, Cond1 = "";

        System.out.println("param 2 " + cust_id);
        System.out.println("param 3 " + size_name);

        if (cust_id == "") {
            Cond0 = "where cust_id like '%' ";
        } else {
            Cond0 = "where cust_id = '" + cust_id + "' ";
        }

        String Str = size_name;

        String[] Str_Cond = new String[2];
        int i = 0;
        for (String retval : Str.split("\\?", 2)) {
            Str_Cond[i] = retval;
            System.out.println("value = " + i + " : " + Str_Cond[i]);

            if (i == 0 && !(Str_Cond[i].equals(""))) {
                Cond1 = " And size_name = '" + Str_Cond[i] + "' ";
            }

            System.out.println(Cond1);

            i++;
        }

        try {
            Return_String.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n");

            count_line = 1;

            String SQL = "select * from vd_job_order_header "
                    + Cond0
                    + Cond1
                    + "and delete_flag = 'N' Order By Runno Desc";

            System.out.println("SQL = " + SQL);
            String sql1 = "select count(doc_id) as num from vd_job_order_header "
                    + Cond0
                    + Cond1
                    + "and delete_flag = 'N' ";
            if (objuti.numRowdatabase(sql1) >= 1) {

                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    Return_String.append("<tr>\n");
                    Return_String.append(("<td class=\"forborder\" width=\"3%\">" + count_line + "</td>\n"));
                    Return_String.append(("<td class=\"forborder\" width=\"5%\"><input type =\"button\" class=\"cgcButton_9\" id=\"print_" + count_line + "\" name\"print\" value =\"" + rs.getString("doc_id") + "\" onclick=\"send_print('" + rs.getString("doc_id") + "','RP_046')\"></td>\n"));
                    Return_String.append(("<td class=\"forborder\" width=\"5%\">" + rs.getString("doc_date") + "</td>\n"));
                    Return_String.append(("<td class=\"forborder\" width=\"7%\">" + rs.getString("cust_name") + "</td>\n"));
                    Return_String.append(("<td class=\"forborder\" width=\"6%\">" + rs.getString("size_name") + "</td>\n"));
                    Return_String.append(("<td class=\"forborder\" width=\"6%\">" + rs.getString("i2") + "</td>\n"));
                    Return_String.append(("<td class=\"forborder\" width=\"6%\">" + rs.getString("weight") + "</td>\n"));
                    Return_String.append("</tr>\n");
                    count_line += 1;
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
