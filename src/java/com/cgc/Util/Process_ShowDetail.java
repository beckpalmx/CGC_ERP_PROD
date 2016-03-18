/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.Util;

/**
 *
 * @author Beck
 */
public class Process_ShowDetail {

    String[] Str_Show;

    public Process_ShowDetail(String Process_id) {
        if (Process_id.equals("PR_022")) {
            Str_Show = new String[]{"product_id", "carbon_net", "position_no", "wh_in","total_price"};
        } else if (Process_id.equals("PR_023")) {
            Str_Show = new String[]{"product_id", "weight", "location_id", "wh_in","wh_out"};
        }else if(Process_id.equals("PR_027")){
            Str_Show = new String[]{"product_id","weight","location_id","silo_no","wh_out"};
        }else if(Process_id.equals("PR_029")){
            Str_Show = new String[]{"product_id","wh_weight","location_id2","wh_out","wh_in"};
        }else if(Process_id.equals("PR_034")){
            Str_Show = new String[]{"product_id","weight","","",""};
        }else if(Process_id.equals("PR_036")){
            Str_Show = new String[]{"product_id","weight","","",""};
        }
        else if(Process_id.equals("PR_040")){
            Str_Show = new String[]{"product_id","weight","location_id","wh_id","wh_id"};
        }else if(Process_id.equals("PR_042")){
            Str_Show = new String[]{"product_id","weight","lot_no","wh_in","wh_out"};
        }else if(Process_id.equals("PR_115")){
            Str_Show = new String[]{"product_id","weight","location_id","wh_in","wh_in"};
        }
    }

    public String Return_FillProduct_id() {
        return Str_Show[0];
    }

    public String Return_FillWeight() {
        return Str_Show[1];
    }

    public String Retrun_FillLocation_id() {
        return Str_Show[2];
    }

    public String Retrun_FillWarehouse_id() {
        return Str_Show[3];
    }
    public String Return_FillTotal_price(){
        return Str_Show[4];
    }
    public String Return_FillWarehouse_in(){
        return  Str_Show[4];
    }
}
