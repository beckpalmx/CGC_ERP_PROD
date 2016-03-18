/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.Util;

import com.cgc.DB.DBConnect;
import com.cgc.bean.DataBean_Screen_Report;
import java.sql.Connection;
import java.sql.ResultSet;

/**
 *
 * @author Beck
 */
public class HeaderScreen_Report {

    public DataBean_Screen_Report Fn_Report(DataBean_Screen_Report objBean, String input_nuberScreen) throws Exception {
        String SQL = "", Input_Type = "";
        System.out.println("input_nuberScreen = " + input_nuberScreen);
        if (!input_nuberScreen.equalsIgnoreCase("") && input_nuberScreen != null) {
            System.out.println("SUB MENU " + input_nuberScreen.substring(0, 1));
            Input_Type = input_nuberScreen.substring(0, 1);

            if (Input_Type.equalsIgnoreCase("S")) {
                SQL = "select screen_id,sub_menu_id,lookup_name,doc_eff_date,doc_no,name_t,report_cond1,report_cond2 from vmmenu_sub where sub_menu_id ='" + input_nuberScreen + "' and delete_flag != 'Y'";
            } else {
                SQL = "select screen_id,sub_menu_id,lookup_name,doc_eff_date,doc_no,name_t,report_cond1,report_cond2 from vmmenu_sub where screen_id ='" + input_nuberScreen + "' and delete_flag != 'Y'";
            }

            System.out.println("SQL = " + SQL);
            DBConnect objcon = new DBConnect();
            Connection con = objcon.openNewConnection();
            ResultSet rs = null;
            try {
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    objBean.setPath(rs.getString("screen_id"));
                    objBean.setSub_menu_id(rs.getString("sub_menu_id"));
                    objBean.setLookup(rs.getString("lookup_name"));
                    objBean.setDoc_eff_date(rs.getString("doc_eff_date"));
                    objBean.setDoc_no(rs.getString("doc_no"));
                    objBean.setName_t(rs.getString("name_t"));
                    objBean.setReport_code1(rs.getString("report_cond1"));
                    objBean.setReport_code2(rs.getString("report_cond2"));
                    System.out.println("Result sub_menu_id = " + rs.getString("sub_menu_id"));                    
                    System.out.println("Result screen_id = " + rs.getString("screen_id"));
                    System.out.println("Result name_t = " + rs.getString("name_t"));
                    System.out.println("Result doc_no = " + rs.getString("doc_no"));
                    System.out.println("Result doc_eff_date = " + rs.getString("doc_eff_date"));                    
                    System.out.println("Result report_code1 = " + rs.getString("report_cond1"));
                    System.out.println("Result report_code2 = " + rs.getString("report_cond2"));
                }

            } finally {
                try {
                    rs.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.out);
                }
            }
        } else {
            objBean.setDoc_eff_date("-");
            objBean.setDoc_no("-");
        }
        
        return objBean;

    }

}
