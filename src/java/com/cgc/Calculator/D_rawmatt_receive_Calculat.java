/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.Calculator;

import com.cgc.DB.DBConnect;
import com.cgc.Util.UtiDatabase;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DecimalFormat;


/**
 *
 * @author Beckpalmx No7
 */
public class D_rawmatt_receive_Calculat {

    private String Returnweight,ReturnKg,weight,ashes_percent,dust_percent,volatile_percent,moise_percent,contamination_percent,remark,price;
    private DecimalFormat df;
    private String SQL;
    private UtiDatabase objuti;

    public String Weight_Calculat(String inputScale_no) throws Exception//คำนวณค่าในTable vd_rawmatt_receive โดยหาค่าของน้ำหนักถ่านที่ลบจากน้ำหนักกระสอบ
    {
        df = new DecimalFormat();
        df.applyPattern("###.00");
        SQL = "Select carbon_net,bag_weight from vd_rawmatt_receive where doc_id = '" + inputScale_no + "' and complete_flag <> 'Y'";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                Returnweight = rs.getString("carbon_net");//df.format(Float.parseFloat(rs.getString("total_weight")) - Float.parseFloat(rs.getString("bag_weight")));
            }
            //JOptionPane.showConfirmDialog(null, df.parse(Returnweight));
        } finally {
            try {
                rs.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return Returnweight;
    }

    public String Page_D_rawmat_receive_Cal(String inputScale_no,String inputProduct_id) throws Exception {
        String SQLnumrow = "";
        objuti = new UtiDatabase();
        df = new DecimalFormat();
        df.applyPattern("###.00");
        SQLnumrow = "Select Count(*) As num from  d_rawmatt_analyze_detail where doc_id = '" + inputScale_no + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
        
        if (objuti.numRowdatabase(SQLnumrow) != 0) {
            
            DBConnect objcon = new DBConnect();
                Connection con = objcon.openNewConnection();
                ResultSet rs = null;
            try {
                SQL = "select weight,ashes_percent,dust_percent,volatile_percent,moisture_percent,mixed_percent,remark from d_rawmatt_analyze_detail where doc_id ='" + inputScale_no + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
                
                rs = con.createStatement().executeQuery(SQL);
                
                while(rs.next())
                {
                    weight = rs.getString("weight");
                    ashes_percent = rs.getString("ashes_percent");
                    dust_percent = rs.getString("dust_percent");
                    volatile_percent = rs.getString("volatile_percent");
                    moise_percent = rs.getString("moisture_percent");
                    contamination_percent = rs.getString("mixed_percent");
                    remark = rs.getString("remark");
                }
                SQL = "select price from vproduct where product_id ='"+inputProduct_id+"' and pgroup_id = 'G001'";
                rs = null;
                rs = con.createStatement().executeQuery(SQL);
                while(rs.next())
                {
                    price = rs.getString("price");
                }
                Returnweight = ashes_percent+","+dust_percent+","+volatile_percent+","+moise_percent+","+contamination_percent+",";
                Returnweight += Percent_to_Kg(weight, ashes_percent)+","+Percent_to_Kg(weight, dust_percent)+","+Percent_to_Kg(weight, volatile_percent)+","+Percent_to_Kg(weight, moise_percent)+","+Percent_to_Kg(weight, contamination_percent)+",";
                Float PersentTotal = Float.parseFloat(ashes_percent)+Float.parseFloat(dust_percent)+Float.parseFloat(volatile_percent)+Float.parseFloat(moise_percent)+Float.parseFloat(contamination_percent);
                Returnweight += df.format(Float.parseFloat(weight)-Float.parseFloat(Percent_to_Kg(weight, Float.toString(PersentTotal))))+",";
                //Returnweight += df.format((Float.parseFloat(weight)-Float.parseFloat(Percent_to_Kg(weight, Float.toString(PersentTotal))))*Float.parseFloat(price));
                Returnweight += remark;

            } finally {
                try {
                    rs.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.out);
                }
            }

        } else {
            Returnweight = "0";
        }
        //JOptionPane.showConfirmDialog(null, Returnweight);
        return Returnweight;
    }
    public String Percent_to_Kg(String weight,String persent){
        df = new DecimalFormat();
        df.applyPattern("###.00");
        System.out.println("weight = " + weight);
        System.out.println("persent = " + persent);
        ReturnKg = df.format(Float.parseFloat(weight)*(Float.parseFloat(persent)/100));        
        return ReturnKg;
    }
}
