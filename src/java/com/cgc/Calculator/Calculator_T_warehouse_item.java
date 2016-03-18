/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.Calculator;

import com.cgc.DB.DBConnect;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DecimalFormat;

/**
 *
 * @author Beck
 */
public class Calculator_T_warehouse_item {

    private DecimalFormat df = new DecimalFormat("##0.00");
    private DecimalFormat df2 = new DecimalFormat("##0.000");
//ทำการคำนวณน้ำหนัก Doc_type = + //weight =น้าหนัก//weight_positive=น้ำหนักที่บวก
    public String Cal_Positive(String weight, String weight_positive) {
        System.out.println("weight = " + weight + " weight_positive = " + weight_positive);
        Double weightD = 0.00
             , weightPosD = 0.00;
        
        if (weight!=null){
            weightD = Double.parseDouble(weight);
        }
        if (weight_positive!=null){
            weightPosD = Double.parseDouble(weight_positive);
        }
        
        return df.format(weightD + weightPosD);
    }
//ทำการคำนวณน้ำหนัก Doc_type = - //weight =น้าหนัก//weight_negative=น้ำหนักที่ลบ

    public String Cal_Negative(String weight, String weight_negative) {
        
        Double weightD = 0.00
             , weightNegD = 0.00;
        
        if (weight!=null){
            weightD = Double.parseDouble(weight);
        }
        if (weight_negative!=null){
            weightNegD = Double.parseDouble(weight_negative);
        }
        
        return df.format(weightD - weightNegD);        
        
        //return df.format(Double.parseDouble(weight) - Double.parseDouble(weight_negative));
    }
//ทำการคำนวณ โดยรวมมูลค่าของ สิ้นค่าตัวเก่าและต้วใหม่เช่น ในคลังมีมูลค่าเก่าคือ 200,000.00 ของใหม่คือ 50,000.00 จะได้ 250,000.00

    public String Cal_WH_Total_Value(String WH_total_value, String Recive_value) {
        
        Double WH_totalD = 0.00
             , ReciveD = 0.00;
        
/*        
        if (WH_total_value!=null){
            WH_totalD = Double.parseDouble(WH_total_value);
        }
        if (Recive_value!=null){
            ReciveD = Double.parseDouble(Recive_value);
        }
*/        
        return df.format(WH_totalD + ReciveD);                       
        
        //return df.format(Double.parseDouble(WH_total_value) + Double.parseDouble(Recive_value));
    }
    //*******หาว่าสินค้าราคาของสินค้าตัวนี้ว่าราค่าต่อหน่วย มีมูลค่าเท่าไร ******เช่น*****
    //Warehouse_value = 2750 Bath
    //Weight = 500 kg
    //จะได้ 2750/500  = 5.5 Bath/unit
    public String Cost_per_Unit(String Warehouse_Value,String Weight){
        return Weight.equals("0.00")?"0.00":Double.toString(Double.parseDouble(Warehouse_Value)/Double.parseDouble(Weight));
    }
    //*******หาว่าสินค้าตัวนั้นราคาต่อหน่วย มีมูลค้าของสินค้าเท่าไร******เช่น******
    //Cost_Per_unit = 5.5 Bath/unit
    //Lot_Weight = 500Kg
    //จะได้ 500*5.5 = 2750 Bath
    public String RawMat_value(String Cost_per_unit,String Lot_Weight){
        return df.format(Double.parseDouble(Cost_per_unit) * Double.parseDouble(Lot_Weight));
    }
    //********หามูลค่าของ สินค่าโดยดูจากค่าของ Doc_type ว่าเป็น + หรือ เป็น - ถ้า เป็น + ให้ทำการบวกกับมูลค่าเดิมของสินค้าที่มีอยู่ แต่ถ้าเป็นลบให้ทำการลบมูลค่าของสินค้าตัวนั้นออก เช่น
    //WH_Total_Value = 50000
    //RawMat_value = (500(kg) * 5.5(Bath/unit)) = 2750
    //DocType = -
    //จะได้ 50000-2750 = 47250
    public String Product_value(String WH_Total_Value,String RawMat_value,String Doc_type){
        if(Doc_type.equals("-")){
            return df.format(Double.parseDouble(WH_Total_Value) - Double.parseDouble(RawMat_value));            
        }else{
            return df.format(Double.parseDouble(WH_Total_Value) + Double.parseDouble(RawMat_value));
        }
        
    }
//ทำการรวมน้ำหนักทั้งหมด โดยดูที่ warehouse_id และ product_id เดียวกัน

    public String Cal_T_warehouse_item_total(String warehouse_id, String product_id) throws Exception {
        String Str_retuen = "";
        String SQL = "select trim(to_char(sum(to_number(weight,'999999999999999999999999999999999999999990.00')),'999999999999999999999999999999999999999990.00')) as weight_total "
                //+",trim(to_char(avg(to_number(price,'99999999999999.99')),'99999999999999.99')) as price_avg "
                + "from t_warehouse_item  where "
                + "warehouse_id = '" + warehouse_id + "' and "
                + "product_id ='" + product_id + "' and delete_flag = 'N'";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                Str_retuen = rs.getString("weight_total");
                //Str_retuen += ","+rs.getString("price_avg
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return Str_retuen;

    }
    //ทำการรวม น้ำหนักของสินค้าทั้งหมด

    public String Cal_T_warehouse_item_product(String Product_id) throws Exception {
        String str_return = "";
        String SQL = "select trim(to_char(sum(to_number(weight,'999999999999999999999999999999999999999990.00')),'999999999999999999999999999999999999999990.00')) as weight_total "
                + "from t_warehouse_item "
                + "where product_id = '" + Product_id + "' ";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                str_return = rs.getString("weight_total");
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return str_return;
    }
    public  double Round(double Rval, int Rpl)
    {

        float p = (float) Math.pow(10, Rpl);
        Rval = Rval * p;
        double tmp = Math.round(Rval);
        return (double) tmp / p;
    }
}
