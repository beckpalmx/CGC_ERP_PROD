/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_transaction_product_receive;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Beck
 */
public class D_transaction_total_product_receiveDAO {

    public void main(String job_id, Connection con, PreparedStatement p) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        ArrayList<DataBeanD_transaction_product_receive> obj_AL_Gen = new ArrayList<DataBeanD_transaction_product_receive>();
        ArrayList<DataBeanD_transaction_product_receive> objAL_insert = new ArrayList<DataBeanD_transaction_product_receive>();
        try {
            if (objuti.numRowdatabase("Select count(job_id) as num  from  d_transaction_total_product_receive where job_id ='" + job_id + "'") != 0) {
                Delete(job_id, con, p);
            }
            obj_AL_Gen = Select_Type_Gen(obj_AL_Gen, job_id, con);
            objAL_insert = Select_Sum_Daliy(obj_AL_Gen, objAL_insert, job_id, con);
            insert(objAL_insert, con, p);
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            if (!objAL_insert.isEmpty()) {
                objAL_insert.clear();
            }
            if (!obj_AL_Gen.isEmpty()) {
                obj_AL_Gen.clear();
            }

        }

    }

    public void Delete(String job_id, Connection con, PreparedStatement p) throws Exception {
        String SQL = "";
        try {
            SQL = "DELETE FROM  d_transaction_total_product_receive  WHERE job_id =?";
            p = con.prepareStatement(SQL);
            p.setString(1, job_id);
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
        }
    }

    public ArrayList<DataBeanD_transaction_product_receive> Select_Type_Gen(ArrayList<DataBeanD_transaction_product_receive> obj_ALGen, String job_id, Connection con) throws Exception {
        String SQL = "select job_id,size,job_type_id,job_type_desc,ctc_i2,withdraw_type,c_type "
                + "from d_transaction_product_receive  "
                + "group by job_id,size,job_type_id,job_type_desc,ctc_i2,withdraw_type,c_type  "
                + "having job_id = '" + job_id + "'  "
                + "order by withdraw_type,to_number(job_type_id,'999')";
        System.out.println("Type Gen : " + SQL);
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                DataBeanD_transaction_product_receive bean = new DataBeanD_transaction_product_receive();
                bean.setJob_id(rs.getString("job_id"));
                bean.setSize(rs.getString("size"));
                bean.setJob_type_id(rs.getString("job_type_id"));
                bean.setJob_type_desc(rs.getString("job_type_desc"));
                bean.setCtc_i2(rs.getString("ctc_i2"));
                bean.setWithdraw_type(rs.getString("withdraw_type"));
                bean.setC_type(rs.getString("c_type"));
                obj_ALGen.add(bean);
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            return obj_ALGen;
        }
    }

    public ArrayList<DataBeanD_transaction_product_receive> Select_Sum_Daliy(ArrayList<DataBeanD_transaction_product_receive> obj_ALGen, ArrayList<DataBeanD_transaction_product_receive> objAL, String job_id, Connection con) throws Exception {
        String SQL = "";
        int sum_daliy = 0;
        ResultSet rs = null;
        try {
            for (int i = 0; i < obj_ALGen.size(); i++) {
                sum_daliy = 0;
                SQL = "select job_id,size,job_type_id,job_type_desc,ctc_i2,withdraw_type,doc_date,c_type,doc_date_system,"
                        + "trim(to_char(sum(to_number(weight,'9999999999999999999990')),'9999999999999999999990')) as weight_total "
                        + "from d_transaction_product_receive  group by job_id,doc_date_system,doc_date,size,job_type_id,job_type_desc,ctc_i2,withdraw_type,c_type "
                        + "having "
                        + "job_id = '" + obj_ALGen.get(i).getJob_id() + "' and "
                        + "withdraw_type = '" + obj_ALGen.get(i).getWithdraw_type() + "' and "
                        + "size = '" + obj_ALGen.get(i).getSize() + "' and  "
                        + "job_type_id = '" + obj_ALGen.get(i).getJob_type_id() + "' and "
                        + "job_type_desc = '" + obj_ALGen.get(i).getJob_type_desc() + "' and "
                        + "c_type = '" + obj_ALGen.get(i).getC_type() + "' and "
                        + "ctc_i2 = '" + obj_ALGen.get(i).getCtc_i2() + "' "
                        + "order by to_date(doc_date,'DD-MM-YYYY')";
                rs = con.createStatement().executeQuery(SQL);
                System.out.println("App Gen : " + SQL);
                while (rs.next()) {
                    sum_daliy = sum_daliy + Integer.parseInt(rs.getString("weight_total"));
                    DataBeanD_transaction_product_receive bean = new DataBeanD_transaction_product_receive();
                    bean.setJob_id(rs.getString("job_id"));
                    bean.setSize(rs.getString("size"));
                    bean.setJob_type_id(rs.getString("job_type_id"));
                    bean.setJob_type_desc(rs.getString("job_type_desc"));
                    bean.setCtc_i2(rs.getString("ctc_i2"));
                    bean.setWithdraw_type(rs.getString("withdraw_type"));
                    bean.setC_type(rs.getString("c_type"));
                    bean.setDoc_date(rs.getString("doc_date"));
                    bean.setDoc_date_system(rs.getString("doc_date_system"));
                    bean.setWeight(Integer.toString(sum_daliy));
                    objAL.add(bean);
                }
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            return objAL;
        }
    }

    public void insert(ArrayList<DataBeanD_transaction_product_receive> objAl, Connection con, PreparedStatement p) throws Exception {
        String SQL = "";
        try {
            SQL = "insert into d_transaction_total_product_receive"
                    + "(job_id,size,job_type_id,job_type_desc,ctc_i2,withdraw_type,c_type,doc_date,total_weight_daily,doc_date_system) "
                    + "values(?,?,?,?,?,?,?,?,?,?)";
            p = con.prepareStatement(SQL);
            for (int i = 0; i < objAl.size(); i++) {
                p.setString(1, objAl.get(i).getJob_id());
                p.setString(2, objAl.get(i).getSize());
                p.setString(3, objAl.get(i).getJob_type_id());
                p.setString(4, objAl.get(i).getJob_type_desc());
                p.setString(5, objAl.get(i).getCtc_i2());
                p.setString(6, objAl.get(i).getWithdraw_type());
                p.setString(7, objAl.get(i).getC_type());
                p.setString(8, objAl.get(i).getDoc_date());
                p.setString(9, objAl.get(i).getWeight());
                p.setString(10, objAl.get(i).getDoc_date_system());
                p.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
        }
    }
}
