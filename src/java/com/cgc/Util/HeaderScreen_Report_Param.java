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
public class HeaderScreen_Report_Param {
    public DataBean_Screen_Report Fn_Report(DataBean_Screen_Report objBean,String input_nuberScreen)throws Exception{
        String SQL = "select * from vmreport_param where report_id ='"+input_nuberScreen+"' and delete_flag != 'Y'";
        System.out.println(SQL);
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        try{
            rs = con.createStatement().executeQuery(SQL);
            while(rs.next()){
                objBean.setPath(rs.getString("report_id"));
                objBean.setLookup(rs.getString("lookup_name"));
                objBean.setDoc_eff_date(rs.getString("doc_eff_date"));
                objBean.setDoc_no(rs.getString("doc_no"));
            }

        }finally{
            try{
                rs.close();
                con.close();
            }catch(Exception e){
                e.printStackTrace(System.out);
            }
        }
        return objBean;

    }
}
