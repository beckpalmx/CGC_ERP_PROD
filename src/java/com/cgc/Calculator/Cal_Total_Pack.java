/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.Calculator;

import com.cgc.DB.DBConnect;
import com.cgc.bean.DataBeanCalculate;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DecimalFormat;


/**
 *
 * @author Beck
 */
public class Cal_Total_Pack {
    //DataBeanCalculate

    private String SQL;
    private DecimalFormat df;
    private double Total;
    private double[] Total_arry;
    DataBeanCalculate objbean;

    public Cal_Total_Pack(String Table_name, String Column_name, String Doc_ID, String Stadment_Where) throws Exception {
        objbean = new DataBeanCalculate();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        try {
            df = new DecimalFormat();
            df.applyPattern("##0");
            Total = 0;
            SQL = "SELECT trim(to_char(sum(to_number("+Column_name+",'999999990')),'999999990')) as cal_total FROM " + Table_name + " WHERE doc_id = '" + Doc_ID + "' and delete_flag <> 'Y' and doc_type <> '-' " + Stadment_Where;
            System.out.println("PACK 1 SQL");
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                Total = Total + Double.parseDouble(rs.getString("cal_total"));

            }
            objbean.setReturn_value(df.format(Total));
        } finally {
            try {
                rs.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

    }

    public Cal_Total_Pack(String Table_name, String[] Column_name, String Doc_ID, String Stadment_Where,int ArrayMem) throws Exception {
        objbean = new DataBeanCalculate();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        String strMath = "";
        Total_arry = new double[ArrayMem];
        try {
            df = new DecimalFormat();
            df.applyPattern("##0");
            Total = 0;
            for (int i = 0; i < Column_name.length; i++) {
                strMath += Column_name[i] + ",";
            }
            strMath = strMath.substring(0, strMath.length()-1);
            if (Table_name.equals("vd_packing_product_detail")) {
                //SQL = "SELECT " + strMath + " FROM " + Table_name + " WHERE doc_id = '" + Doc_ID + "' and delete_flag <> 'Y' and (pack_repacking_status <> 'Y' or doc_type <> '-')  " + Stadment_Where;
                SQL = "SELECT " + strMath + " FROM " + Table_name + " WHERE doc_id = '" + Doc_ID + "' and delete_flag <> 'Y' and (pack_repacking_status <> 'Y')  " + Stadment_Where;
            } else {
                SQL = "SELECT " + strMath + " FROM " + Table_name + " WHERE doc_id = '" + Doc_ID + "' and delete_flag <> 'Y' and doc_type <> '-' " + Stadment_Where;
            }
            System.out.println("PACK 2 SQL");
            System.out.println("SQL = " + SQL);
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                for(int i=0;i<Total_arry.length;i++){
                    Total_arry[i] = Total_arry[i] + Double.parseDouble(rs.getString(Column_name[i]));
                    //System.out.println("Total_arry[i] = " + Total_arry[i]);
                }
            }
            strMath = "";
            for(int i=0;i<Total_arry.length;i++){
                strMath += df.format(Total_arry[i])+",";
            }
            strMath = strMath.substring(0, strMath.length()-1);
            objbean.setReturn_value(strMath);
        } finally {
            try {
                rs.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

    }
    public String Return_Total() {
        return objbean.getReturn_value();
    }
    //ปัดเศษทศนิยม 2 ตำแหน่ง ตัวอย่าง 18.657 เท่ากับ 18.66
    public  float Round(float Rval, int Rpl)
    {

        float p = (float) Math.pow(10, Rpl);
        Rval = Rval * p;
        float tmp = Math.round(Rval);
        return (float) tmp / p;
    }

}
