/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.DataBeanD_summary_product_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Beck
 */
public class D_summary_product_headerDAO {
    public DataBeanD_summary_product_header Select_Data(Connection con ,DataBeanD_summary_product_header input_bean,String job_id)throws Exception{
        String SQL = "",math_str = "";
        ResultSet rs  = null;
        try{
            input_bean.setJob_id(job_id);
            SQL = "select ((select mjob_type.name_t from mjob_type where mjob_type.job_type_id = d_transaction_product_receive.job_type_id and delete_flag = 'N')||job_type_desc) as machine from d_transaction_product_receive  group by job_type_id,job_type_desc,job_id having job_id = '"+job_id+"'";
            rs = con.createStatement().executeQuery(SQL);
            while(rs.next()){
                math_str += rs.getString("machine")+",";
            }
            input_bean.setMachine(math_str.substring(0, math_str.length()-1));
            rs = null;
            SQL = "select min(to_date(doc_date_system,'YYYY-MM-DD')) as degin_date_product,max(to_date(doc_date_system,'YYYY-MM-DD')) as end_date_product  from d_transaction_product_receive  where job_id = '"+job_id+"'";
            rs = con.createStatement().executeQuery(SQL);
            while(rs.next()){
                input_bean.setBegin_date_product( rs.getString("degin_date_product"));
                input_bean.setEnd_date_product(rs.getString("end_date_product"));
            }
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(rs != null){
                rs.close();
            }
            return input_bean;
        }
    }
    public void insert(Connection con , PreparedStatement p,DataBeanD_summary_product_header bean)throws Exception{
        String SQL = "";
        try{
            SQL = "insert into d_summary_product_header(job_id,machine,begin_date_product,end_date_product,lost_weight,withdraw_total_weight,total_weight,lost_weight_percent,total_weight_percent) "
                    + "values(?,?,?,?,?,?,?,?,?)";
            p = con.prepareStatement(SQL);
            p.setString(1, bean.getJob_id());
            p.setString(2, bean.getMachine());
            p.setString(3, bean.getBegin_date_product());
            p.setString(4, bean.getEnd_date_product());
            p.setString(5, bean.getLost_weight());
            p.setString(6, bean.getWithdraw_total_weight());
            p.setString(7, bean.getTotal_weight());
            p.setString(8, bean.getLost_weight_percent());
            p.setString(9, bean.getTotal_weight_percent());
            p.executeUpdate();

        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(p != null){
                p.close();
            }
        }
    }
    public void update(Connection con , PreparedStatement p,DataBeanD_summary_product_header bean)throws Exception{
        String SQL = "";
        try{
            SQL = "update d_summary_product_header set production_rates=? "
                    + "where job_id = ?";
            p = con.prepareStatement(SQL);
            p.setString(1, bean.getProduction_rate());
            p.setString(2, bean.getJob_id());
            p.executeUpdate();

        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(p != null){
                p.close();
            }
        }
    }
}
