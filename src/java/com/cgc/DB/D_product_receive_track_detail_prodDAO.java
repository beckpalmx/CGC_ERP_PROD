/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_product_receive_track_detail_prod;
import com.cgc.bean.DataBeanD_product_receive_track_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Beck
 */
public class D_product_receive_track_detail_prodDAO {

    public ArrayList<DataBeanD_product_receive_track_detail_prod> Select_Data(Connection con, ArrayList<DataBeanD_product_receive_track_header> inputAL, ArrayList<DataBeanD_product_receive_track_detail_prod> outputAL) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        String SQL = "";
        ResultSet rs = null;
        try {
            for (int i = 0; i < inputAL.size(); i++) {
                for (int j = 0; j <= 1; j++) {
                    SQL = "select count(job_id) as num from d_transaction_total_product_receive  "
                            + "where job_id = '" + inputAL.get(i).getJob_id() + "' and "
                            + "job_type_id = '" + inputAL.get(i).getJob_type_id() + "' and  "
                            + "job_type_desc = '" + inputAL.get(i).getJob_type_desc() + "' and  withdraw_type = '";
                    SQL += (j == 0) ? "N" : "Y";
                    SQL += "' and "
                            + "size <> (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '"+inputAL.get(i).getJob_id()+"') and "
                            + "to_date(doc_date_system,'YYYY-MM-DD') between '" + inputAL.get(i).getJob_year() + "-" + inputAL.get(i).getJob_month() + "-01' and '" + objuti.End_Date(inputAL.get(i).getJob_month(), inputAL.get(i).getJob_year()) + "'";
                    System.out.println("Prod SQL = " + SQL);
                    if(objuti.numRowdatabase(SQL) != 0){
                        SQL = "select size,job_type_id,job_type_desc,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,ctc_i2,withdraw_type "
                                + "from d_transaction_product_receive  "
                                + "where "
                                + "to_date(doc_date_system,'YYYY-MM-DD') between '" + inputAL.get(i).getJob_year() + "-" + inputAL.get(i).getJob_month() + "-01' and '" + objuti.End_Date(inputAL.get(i).getJob_month(), inputAL.get(i).getJob_year()) + "' "
                                + " group by size,job_type_id,job_type_desc,ctc_i2,job_id,withdraw_type "
                                + "having job_id = '"+inputAL.get(i).getJob_id()+"' and  "
                                + "job_type_id = '"+inputAL.get(i).getJob_type_id()+"' and  "
                                + "job_type_desc = '"+inputAL.get(i).getJob_type_desc()+"' and withdraw_type = '";
                         SQL += (j == 0) ? "N" : "Y";
                         SQL += "' and size <> (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '"+inputAL.get(i).getJob_id()+"') ";
                         System.out.println("SQL Track = " + SQL);
                         rs = con.createStatement().executeQuery(SQL);
                         while(rs.next()){
                             DataBeanD_product_receive_track_detail_prod bean = new DataBeanD_product_receive_track_detail_prod();
                             bean.setDoc_id(inputAL.get(i).getDoc_id());
                             bean.setJob_id(inputAL.get(i).getJob_id());
                             bean.setSize(rs.getString("size"));
                             bean.setCtc_i2(rs.getString("ctc_i2"));
                             bean.setWeight(rs.getString("weight"));
                             bean.setDoc_type(rs.getString("withdraw_type"));
                             outputAL.add(bean);
                         }
                    }
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            return outputAL;
        }
    }
    public void insert(Connection con ,PreparedStatement p ,ArrayList<DataBeanD_product_receive_track_detail_prod> inputAL)throws Exception{
        String SQL = "";
        try{
            SQL = "insert into d_product_receive_track_detail_prod"
                    + "(doc_id,job_id,size,ctc_i2,weight,doc_type) "
                    + "values(?,?,?,?,?,?)";
            p = con.prepareStatement(SQL);
            for(int i = 0 ; i< inputAL.size();i++){
                p.setString(1, inputAL.get(i).getDoc_id());
                p.setString(2, inputAL.get(i).getJob_id());
                p.setString(3, inputAL.get(i).getSize());
                p.setString(4, inputAL.get(i).getCtc_i2());
                p.setString(5, inputAL.get(i).getWeight());
                p.setString(6, inputAL.get(i).getDoc_type());
                p.executeUpdate();
            }
        }catch(Exception e){

        }finally{
            if(p != null){
                p.close();
            }
        }
    }
}
