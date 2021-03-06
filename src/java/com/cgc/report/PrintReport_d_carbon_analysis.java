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
public class PrintReport_d_carbon_analysis {
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
                    rs = con.createStatement().executeQuery("select doc_id,tname1,tname2,tname3,ttime1,ttime2,ttime3,reporter_name,approve_name from vd_carbon_out_analysis_header where doc_date = '"+doc_date+"' and delete_flag = 'N'");
                    while (rs.next()) {
                        Return_String.append("<tr>\n");
                        Return_String.append(("<td class=\"forborder\" width=\"6%\">" + count_line + "</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"15%\"><input type =\"button\" class=\"cgcButton_9\" id=\"print_" + count_line + "\" name\"print\" value =\"" + rs.getString("doc_id") + "\" onclick=\"send_print('" + rs.getString("doc_id") + "','RP_0721')\"></td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"8%\">" + (rs.getString("tname1").equals("") || rs.getString("tname1") == null ? "-" : rs.getString("tname1")) + "</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"5%\">" + (rs.getString("ttime1").equals("") || rs.getString("ttime1") == null ? "-" : rs.getString("ttime1")) + "</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"8%\">" + (rs.getString("tname2").equals("") || rs.getString("tname2") == null ? "-" : rs.getString("tname2")) + "</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"5%\">" + (rs.getString("ttime2").equals("") || rs.getString("ttime2") == null ? "-" : rs.getString("ttime2")) + "</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"8%\">" + (rs.getString("tname3").equals("") || rs.getString("tname3") == null ? "-" : rs.getString("tname3")) + "</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"5%\">" + (rs.getString("ttime3").equals("") || rs.getString("ttime3") == null ? "-" : rs.getString("ttime3")) + "</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"20%\">" + (rs.getString("reporter_name").equals("") || rs.getString("reporter_name") == null ? "-" : rs.getString("reporter_name")) + "</td>\n"));                           
                        Return_String.append(("<td class=\"forborder\" width=\"20%\">" + (rs.getString("approve_name").equals("") || rs.getString("approve_name") == null ? "-" : rs.getString("approve_name")) + "</td>\n"));                        
                        Return_String.append("</tr>\n");
                        count_line += 1;
                    }
                    break;
                case 2:
                    count_line = 1;
                    rs = con.createStatement().executeQuery("select doc_id,doc_date,reporter_full_name,checker_full_name,approve_status from  vd_carbon_analyze_header  where doc_date = '"+doc_date+"' and delete_flag ='N'");
                    while(rs.next()){
                        Return_String.append("<tr>\n");
                        Return_String.append(("<td class=\"forborder\" width=\"5%\">"+count_line+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"20%\"><input type =\"button\" class=\"cgcButton_9\" id=\"print_"+count_line+"\" name\"print\" value =\""+rs.getString("doc_id")+"\" onclick=\"send_print('"+rs.getString("doc_id")+"','RP_092')\"></td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"15%\">"+rs.getString("doc_date")+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"25%\">"+rs.getString("reporter_full_name")+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"25%\">"+rs.getString("checker_full_name")+"</td>\n"));
                        Return_String.append(("<td class=\"forborder\" width=\"10%\">"+(rs.getString("approve_status").equals("Y")?"อนุมัติ":"ยังไม่อนุมัติ")+"</td>\n"));
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
