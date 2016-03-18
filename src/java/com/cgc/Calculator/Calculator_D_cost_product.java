/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.Calculator;

import java.text.DecimalFormat;

/**
 *
 * @author Beck
 */
public class Calculator_D_cost_product {
    DecimalFormat df = new DecimalFormat("##0.000");
    public String Cost_per_Unit(String Warehouse_Value,String Weight){
        return Double.toString(Round(Double.parseDouble(df.format(Double.parseDouble(Warehouse_Value)/Double.parseDouble(Weight))),2));
    }
    public String Calculator_Cost(String Cost_per_unit,String Lot_Weight){
        return Double.toString(Round(Double.parseDouble(df.format(Double.parseDouble(Cost_per_unit)*Double.parseDouble(Lot_Weight))),2));
    }
    public String Calculator_WH_Total_value(String WH_Total_value,String Recive_value){
        return Double.toString(Round(Double.parseDouble(df.format(Double.parseDouble(WH_Total_value)+Double.parseDouble(Recive_value))),2));
    }
    public  double Round(double Rval, int Rpl)
    {

        float p = (float) Math.pow(10, Rpl);
        Rval = Rval * p;
        double tmp = Math.round(Rval);
        return (double) tmp / p;
    }
}
