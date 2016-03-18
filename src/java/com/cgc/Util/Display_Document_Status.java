/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.Util;

import com.cgc.DB.DBConnect;
import com.cgc.bean.DataBean_Display_Document_Status;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Beck
 */
public class Display_Document_Status {

    /**
     *
     * @param objBean
     * @param input_nuberScreen
     * @return
     * @throws Exception
     */
    public DataBean_Display_Document_Status Fn_Record_Count(DataBean_Display_Document_Status objBean,String input_nuberScreen)throws Exception{
        String SQL = input_nuberScreen;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs ;
        try{
            rs = con.createStatement().executeQuery(SQL);
            while(rs.next()){
                objBean.setRecord_count(rs.getString("record_count"));
            }
        }finally{
            try{
                //rs.close();
                con.close();
            }catch(SQLException e){
                e.printStackTrace(System.out);
            }
        }
        return objBean;

    }
    
    public DataBean_Display_Document_Status Fn_Doc_ID_Last(DataBean_Display_Document_Status objBean,String input_nuberScreen)throws Exception{
        String SQL = input_nuberScreen;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs ;
        try{
            rs = con.createStatement().executeQuery(SQL);
            while(rs.next()){
                objBean.setDoc_id_last(rs.getString("doc_id_last"));
            }
        }finally{
            try{
                //rs.close();
                con.close();
            }catch(SQLException e){
                e.printStackTrace(System.out);
            }
        }
        return objBean;

    }    
}
