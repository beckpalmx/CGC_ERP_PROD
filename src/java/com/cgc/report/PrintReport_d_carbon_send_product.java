/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.report;

import com.cgc.DB.DBConnect;
import java.sql.Connection;
import java.sql.ResultSet;

/**
 *
 * @author Beckpalmx No7
 */
public class PrintReport_d_carbon_send_product {
    public String ShowDetail(int Select_case,String doc_date)throws Exception{
        StringBuffer Return_String = new StringBuffer();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        int count_line = 1;
        try{
            Return_String.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n");
            switch(Select_case){
                case 1:
                    count_line = 1;
                    rs = con.createStatement().executeQuery("select * from vd_carbon_send_product_detail_doc "
                            + "where doc_date = '"+doc_date+"' "
                            + "and weight <> '0' "
                            + "and delete_flag = 'N'");
                    while(rs.next()){
                        Return_String.append("<tr>\n");
                        Return_String.append(("<td class=\"forborder\" width=\"3%\">"+count_line+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"5%\"><input type =\"button\" class=\"cgcButton_9\" id=\"print_"+count_line+"\" name\"print\" value =\""+rs.getString("doc_id")+"\" onclick=\"send_print('"+rs.getString("doc_id")+"','RP_096_A')\"></td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"5%\">"+rs.getString("doc_date")+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"7%\">"+rs.getString("job_type2")+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"6%\">"+rs.getString("size_name")+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"6%\">"+rs.getString("job_id")+"</td>\n"));                        
                        Return_String.append(("<td class=\"forborder\" width=\"6%\">"+rs.getString("product_no")+"</td>\n"));
/*                        
                        Return_String.append(("<td class=\"forborder\" width=\"5%\">"+rs.getString("lab_leader_name")+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"20%\">"+rs.getString("warehouse_emp_name")+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"20%\">"+rs.getString("warehouse_leader_name")+"</td>\n"));
*/        
                        Return_String.append("</tr>\n");
                        count_line += 1;
                    }
                    break;
                case 2:
                    count_line = 1;
                    rs = con.createStatement().executeQuery("select * from vd_carbon_send_product_header_analyze where doc_date = '"+doc_date+"' and delete_flag ='N'");
                    while(rs.next()){
                        Return_String.append("<tr>\n");
                        Return_String.append(("<td class=\"forborder\" width=\"5%\">"+count_line+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"20%\"><input type =\"button\" class=\"cgcButton_9\" id=\"print_"+count_line+"\" name\"print\" value =\""+rs.getString("doc_id")+"\" onclick=\"send_print('"+rs.getString("doc_id")+"','RP_097')\"></td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"15%\">"+rs.getString("doc_date")+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"25%\">"+rs.getString("lab_emp_name")+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"25%\">"+rs.getString("lab_leader_name")+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"10%\">"+(rs.getString("quality_confirm").equals("Y")?"อนุมัติ":"ยังไม่อนุมัติ")+"</td>\n"));
                        Return_String.append("</tr>\n");
                        count_line += 1;
                    }
                    break;
            }
            Return_String.append("</table>");
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            return  Return_String.toString();
        }
        
        
    }
}
