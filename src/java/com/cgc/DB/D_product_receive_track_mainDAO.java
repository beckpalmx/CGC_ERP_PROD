/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_product_receive_track_detail;
import com.cgc.bean.DataBeanD_product_receive_track_detail_prod;
import com.cgc.bean.DataBeanD_product_receive_track_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;

/**
 *
 * @author Beck
 */
public class D_product_receive_track_mainDAO {

    public void main(Connection con, PreparedStatement p, String Job_id) throws Exception {

        UtiDatabase objuti = new UtiDatabase();
        D_product_receive_track_headerDAO objDAO_header = new D_product_receive_track_headerDAO();
        D_product_receive_track_detailDAO objDAO_detail = new D_product_receive_track_detailDAO();
        D_product_receive_track_detail_prodDAO objDAO_detail_prod = new D_product_receive_track_detail_prodDAO();
        ArrayList<DataBeanD_product_receive_track_header> objAL_header = new ArrayList<DataBeanD_product_receive_track_header>();
        ArrayList<DataBeanD_product_receive_track_detail> objAL_detail = new ArrayList<DataBeanD_product_receive_track_detail>();
        ArrayList<DataBeanD_product_receive_track_detail_prod> objAL_detail_prod = new ArrayList<DataBeanD_product_receive_track_detail_prod>();
        try {

            objAL_header = objDAO_header.Select_d_transaction_product_receive(objAL_header, con, Job_id);
            objAL_detail = objDAO_detail.Select_Data(con, objAL_header,objAL_detail);
            objAL_detail_prod = objDAO_detail_prod.Select_Data(con, objAL_header, objAL_detail_prod);
            if(objuti.numRowdatabase("select count(*) num from d_product_receive_track_header where job_id = '"+Job_id+"'") != 0){
                Delete(Job_id, "d_product_receive_track_header", con, p);
            }
            if(objuti.numRowdatabase("select count(*) num from d_product_receive_track_detail where job_id = '"+Job_id+"'") != 0){
                Delete(Job_id, "d_product_receive_track_detail", con, p);
            }
            if(objuti.numRowdatabase("select count(*) num from d_product_receive_track_detail_prod where job_id = '"+Job_id+"'") != 0){
                Delete(Job_id, "d_product_receive_track_detail_prod", con, p);
            }
            objDAO_detail.insert( con, p,objAL_detail);
            objDAO_detail_prod.insert(con, p, objAL_detail_prod);
            objAL_header = Check_header(objAL_header);
            objDAO_header.insert(con, p, objAL_header);
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if(!objAL_header.isEmpty()){
                objAL_header.clear();
            }
            if(!objAL_detail.isEmpty()){
                objAL_detail.clear();
            }
            if(!objAL_detail.isEmpty()){
                objAL_detail_prod.clear();
            }
        }
    }
    public void Delete(String job_id,String Table,Connection con,PreparedStatement p)throws Exception{
        String SQL = "";
        try{
            SQL = "DELETE FROM  "+Table+"  WHERE job_id =?";
            p = con.prepareStatement(SQL);
            p.setString(1, job_id);
            p.executeUpdate();
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(p != null){
                p.close();
            }
        }
    }
    public ArrayList<DataBeanD_product_receive_track_header> Check_header(ArrayList<DataBeanD_product_receive_track_header> objAL_header)throws Exception{
        for(int i = 0 ; i< objAL_header.size();i++){
            if(Check_Table("d_product_receive_track_detail","d_product_receive_track_detail_prod", objAL_header.get(i).getDoc_id())){
                objAL_header.remove(i);
            }
        }
        return objAL_header;
    }
    public boolean  Check_Table(String Tablename,String Tablename2,String doc_id)throws Exception{
        UtiDatabase objuti = new UtiDatabase();
        boolean check = true;
        if(objuti.numRowdatabase("select count(*) as num from "+Tablename+" where doc_id = '"+doc_id+"' and delete_flag = 'N'")!=0){
            check = false;
        }
        if(objuti.numRowdatabase("select count(*) as num from "+Tablename2+" where doc_id = '"+doc_id+"' and delete_flag = 'N'")!=0){
            check = false;
        }

        return check;
    }
}
