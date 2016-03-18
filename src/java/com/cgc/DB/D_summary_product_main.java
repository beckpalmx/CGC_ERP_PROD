/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_summary_product_detail;
import com.cgc.bean.DataBeanD_summary_product_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.naming.spi.DirStateFactory.Result;

/**
 *
 * @author Beck
 */
public class D_summary_product_main extends D_product_receive_track_mainDAO{
    public void main(Connection con,PreparedStatement p,String job_id)throws Exception{
        String SQL = "";
        UtiDatabase objuti = new UtiDatabase();
        ArrayList<DataBeanD_summary_product_detail> obj_AL = new ArrayList<DataBeanD_summary_product_detail>();
            DataBeanD_summary_product_header bean_header = new DataBeanD_summary_product_header();
            D_summary_product_headerDAO objDAO_header = new D_summary_product_headerDAO();
            D_summary_product_detailDAO objDAO_deteail = new D_summary_product_detailDAO();
        try{
            bean_header = objDAO_header.Select_Data(con, bean_header, job_id);
            obj_AL = objDAO_deteail.Select_Case_Calculator(job_id, con, obj_AL);
            bean_header = Sum_Weight_Weithdraw_Prod(obj_AL, bean_header);
            obj_AL = Calculater_Percent(obj_AL, bean_header);
            if(objuti.numRowdatabase("select count(*) num from d_summary_product_header where job_id = '"+job_id+"'") != 0){
                Delete(job_id, "d_summary_product_header", con, p);
            }
            if(objuti.numRowdatabase("select count(*) num from d_summary_product_detail where job_id = '"+job_id+"'") != 0){
                Delete(job_id, "d_summary_product_detail", con, p);
            }
            if(objuti.numRowdatabase("select count(*) num from d_summary_product_detail_prod where job_id = '"+job_id+"'") != 0){
                Delete(job_id, "d_summary_product_detail_prod", con, p);
            }
            objDAO_header.insert(con, p, bean_header);
            System.out.println("Insert d_summary_product_detail_prod");
            objDAO_deteail.insert(con, p, obj_AL);
            bean_header = Cal_Production_rate(obj_AL, bean_header, con);
            objDAO_header.update(con, p, bean_header);
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(p != null){
                p.close();
            }
            if(!obj_AL.isEmpty()){
                obj_AL.clear();
            }
            if(bean_header != null){
                bean_header = null;
            }

        }
    }
    public DataBeanD_summary_product_header Sum_Weight_Weithdraw_Prod(ArrayList<DataBeanD_summary_product_detail> input_AL,DataBeanD_summary_product_header input_bean)throws Exception{
        int[] tottal_weight =  new int[3];
        float lost_percent = 0;
        float total_weight_percent = 0;
        try{
            tottal_weight[0] = 0;
            tottal_weight[1] = 0;
            for(int i = 0 ; i<input_AL.size();i++){
                if(input_AL.get(i).getDoc_type().equals("N")){
                    tottal_weight[0] = tottal_weight[0] + Integer.parseInt(input_AL.get(i).getWeight());
                }else{
                    tottal_weight[1] = tottal_weight[1] + Integer.parseInt(input_AL.get(i).getWeight());
                }
            }
            tottal_weight[2] = tottal_weight[1]-tottal_weight[0];
            input_bean.setLost_weight(Integer.toString(tottal_weight[2]));
            input_bean.setTotal_weight(Integer.toString(tottal_weight[1]));
            input_bean.setWithdraw_total_weight(Integer.toString(tottal_weight[0]));
            input_bean.setLost_weight_percent(Float.toString(Round(((float)(tottal_weight[2]*100)/(float)tottal_weight[0]),2)));
            input_bean.setTotal_weight_percent(Float.toString(Round(((float)(tottal_weight[1]*100)/(float)tottal_weight[0]),2)));
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            return input_bean;
        }
    }
    public ArrayList<DataBeanD_summary_product_detail> Calculater_Percent(ArrayList<DataBeanD_summary_product_detail> input_AL,DataBeanD_summary_product_header input_bean)throws Exception{
        try{
            for(int i = 0;i< input_AL.size();i++){
                if(input_AL.get(i).getDoc_type().equals("Y")){
                    input_AL.get(i).setPercent(Float.toString(Round((Float.parseFloat(input_AL.get(i).getWeight())*100)/Float.parseFloat(input_bean.getWithdraw_total_weight()),2)));
                }
            }
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            return input_AL;
        }
    }
    
    public  float Round(float Rval, int Rpl)
    {

        float p = (float) Math.pow(10, Rpl);
        Rval = Rval * p;
        float tmp = Math.round(Rval);
        return (float) tmp / p;
    }
    public DataBeanD_summary_product_header Cal_Production_rate(ArrayList<DataBeanD_summary_product_detail> input_AL,DataBeanD_summary_product_header inputBean,Connection con)throws Exception{
        ResultSet rs = null;
        String SQL ="",Size = "",Weight = "0";
        int days = 0;
        int shift = 0;
        try{
            SQL = "select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '"+inputBean.getJob_id()+"'";
            rs = con.createStatement().executeQuery(SQL);
            while(rs.next()){
                Size = rs.getString("spec_size");
            }
            for(int i = 0;i<input_AL.size();i++){
                if(input_AL.get(i).getDoc_type().equals("Y") && input_AL.get(i).getSize().equals(Size)){
                    Weight = input_AL.get(i).getWeight();
                    break;
                }
            }
            SQL = "select (to_date(end_date_product,'YYYY-MM-DD') - to_date(begin_date_product,'YYYY-MM-DD') ) as days  from d_summary_product_header  where job_id = '"+inputBean.getJob_id()+"'";
            rs = null;
            rs = con.createStatement().executeQuery(SQL);
            while(rs.next()){
                  days = rs.getInt("days");
            }
            SQL = "select shift from d_transaction_product_receive  where job_id  = '"+inputBean.getJob_id()+"' group by shift";
            rs = null;
            rs = con.createStatement().executeQuery(SQL);
            while(rs.next()){
                shift += 1;
            }
           inputBean.setProduction_rate(Float.toString(Round(((Float.parseFloat(Weight))/(days == 0?1:days) )/shift, 2)));
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(rs!= null){
                rs.close();
            }
            return inputBean;
        }
    }
    
}
