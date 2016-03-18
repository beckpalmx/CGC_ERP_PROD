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
public class D_transaction_product_receiveDAO {

    public void insert(ArrayList<DataBeanD_transaction_product_receive> ObjAL, Connection con, PreparedStatement p) throws Exception {
        try {
            String SQL = "insert into d_transaction_product_receive"
                        + "(job_id,size,job_type_id,job_type_desc,shift,weight,doc_date,doc_type,withdraw_type,ctc_i2,c_type,doc_id,line_no,doc_date_system) "
                        + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                p = con.prepareStatement(SQL);
            for (int i = 0; i < ObjAL.size(); i++) {
                p.setString(1, ObjAL.get(i).getJob_id());
                p.setString(2, ObjAL.get(i).getSize());
                p.setString(3, ObjAL.get(i).getJob_type_id());
                p.setString(4, ObjAL.get(i).getJob_type_desc());
                p.setString(5, ObjAL.get(i).getShift());
                p.setString(6, ObjAL.get(i).getWeight());
                p.setString(7, ObjAL.get(i).getDoc_date());
                p.setString(8, ObjAL.get(i).getDoc_type());
                p.setString(9, ObjAL.get(i).getWithdraw_type());
                p.setString(10, ObjAL.get(i).getCtc_i2());
                p.setString(11, ObjAL.get(i).getC_type());
                p.setString(12, ObjAL.get(i).getDoc_id());
                p.setString(13, ObjAL.get(i).getLine_no());
                p.setString(14, ObjAL.get(i).getDoc_date_system());
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

    public void insert(String job_id,
            String doc_date,
            String job_type_id,
            String job_type_desc,
            String ctc_i2,
            String size,
            String shift,
            String c_type,
            String doc_type,
            String weight,
            String withdraw_type,
            String doc_id,
            String line_no,
            Connection con, PreparedStatement p) throws Exception {
        try {
            String SQL = "insert into d_transaction_product_receive"
                    + "(job_id,size,job_type_id,job_type_desc,shift,weight,doc_date,doc_type,withdraw_type,ctc_i2,c_type,doc_id,line_no) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
            p = con.prepareStatement(SQL);
            p.setString(1, job_id);
            p.setString(2, size);
            p.setString(3, job_type_id);
            p.setString(4, job_type_desc);
            p.setString(5, shift);
            p.setString(6, weight);
            p.setString(7, doc_date);
            p.setString(8, doc_type);
            p.setString(9, withdraw_type);
            p.setString(10, ctc_i2);
            p.setString(11, c_type);
            p.setString(12, doc_id);
            p.setString(13, line_no);
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
        }
    }

    public void update(String job_id,
            String doc_date,
            String job_type_id,
            String job_type_desc,
            String ctc_i2,
            String size,
            String shift,
            String c_type,
            String doc_type,
            String weight,
            String withdraw_type,
            String doc_id,
            String line_no,
            Connection con, PreparedStatement p) throws Exception {
        try {
            String SQL = "update  d_transaction_product_receive set "
                    + "size=?,job_type_id=?,job_type_desc=?,shift=?,weight=?,doc_date=?,doc_type=?,ctc_i2=?,c_type=? "
                    + " where doc_id = ? and line_no = ? and job_id = ? and withdraw_type=?";
            p = con.prepareStatement(SQL);
            p.setString(1, size);
            p.setString(2, job_type_id);
            p.setString(3, job_type_desc);
            p.setString(4, shift);
            p.setString(5, weight);
            p.setString(6, doc_date);
            p.setString(7, doc_type);
            p.setString(8, ctc_i2);
            p.setString(9, c_type);
            p.setString(10, doc_id);
            p.setString(11, line_no);
            p.setString(12, job_id);
            p.setString(13, withdraw_type);
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
        }
    }

    public void update(ArrayList<DataBeanD_transaction_product_receive> ObjAL, Connection con, PreparedStatement p, UtiDatabase objuti) throws Exception {
        //UtiDatabase objuti = new UtiDatabase();
        try {
            for (int i = 0; i < ObjAL.size(); i++) {
                if (objuti.numRowdatabase("select count(*) as num from d_transaction_product_receive where "
                        + "doc_id = '" + ObjAL.get(i).getDoc_id() + "' and "
                        + "line_no = '" + ObjAL.get(i).getLine_no() + "' and "
                        + "job_id ='" + ObjAL.get(i).getJob_id() + "'")
                        == 0) {
                    insert(ObjAL.get(i).getJob_id(),
                            ObjAL.get(i).getDoc_date(),
                            ObjAL.get(i).getJob_type_id(),
                            ObjAL.get(i).getJob_type_desc(),
                            ObjAL.get(i).getCtc_i2(),
                            ObjAL.get(i).getSize(),
                            ObjAL.get(i).getShift(),
                            ObjAL.get(i).getC_type(),
                            ObjAL.get(i).getDoc_type(),
                            ObjAL.get(i).getWeight(),
                            ObjAL.get(i).getWithdraw_type(),
                            ObjAL.get(i).getDoc_id(),
                            ObjAL.get(i).getLine_no(),
                            con, p);
                } else {
                    if (objuti.numRowdatabase("select count(*) as num from d_transaction_product_receive where "
                            + "doc_id = '" + ObjAL.get(i).getDoc_id() + "' and "
                            + "line_no = '" + ObjAL.get(i).getLine_no() + "' and "
                            + "job_id = '" + ObjAL.get(i).getJob_id() + "' and "
                            + "doc_date = '" + ObjAL.get(i).getDoc_date() + "' and "
                            + "job_type_id ='" + ObjAL.get(i).getJob_type_id() + "' and "
                            + "job_type_desc = '" + ObjAL.get(i).getJob_type_desc() + "' and "
                            + "ctc_i2 = '" + ObjAL.get(i).getCtc_i2() + "' and "
                            + "size = '" + ObjAL.get(i).getSize() + "' and "
                            + "shift = '" + ObjAL.get(i).getShift() + "' and "
                            + "c_type = '" + ObjAL.get(i).getC_type() + "' and "
                            + "withdraw_type = '" + ObjAL.get(i).getWithdraw_type() + "' and "
                            + "weight = '" + ObjAL.get(i).getWeight() + "'")
                            == 0) {
                        update(ObjAL.get(i).getJob_id(),
                                ObjAL.get(i).getDoc_date(),
                                ObjAL.get(i).getJob_type_id(),
                                ObjAL.get(i).getJob_type_desc(),
                                ObjAL.get(i).getCtc_i2(),
                                ObjAL.get(i).getSize(),
                                ObjAL.get(i).getShift(),
                                ObjAL.get(i).getC_type(),
                                ObjAL.get(i).getDoc_type(),
                                ObjAL.get(i).getWeight(),
                                ObjAL.get(i).getWithdraw_type(),
                                ObjAL.get(i).getDoc_id(),
                                ObjAL.get(i).getLine_no(),
                                con, p);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
        }
    }

    public void main(ArrayList<DataBeanD_transaction_product_receive> ObjAL, Connection con, PreparedStatement p) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        D_summary_product_main obj_summary = new D_summary_product_main();
        D_product_receive_track_mainDAO obj_track = new D_product_receive_track_mainDAO();
        D_transaction_total_product_receiveDAO obj_tran_total = new D_transaction_total_product_receiveDAO();
        try {
            if (!ObjAL.isEmpty()) {
                if (objuti.numRowdatabase("select count(*) as num from d_transaction_product_receive where job_id = '" + ObjAL.get(0).getJob_id() + "' and delete_flag = 'N'") == 0) {
                    System.out.println("1p = " + p);
                    insert(ObjAL, con, p);
                } else {
                    System.out.println("1p = " + p);
                    Delete(ObjAL.get(0).getJob_id(), con, p);
                    insert(ObjAL, con, p);
                }
                System.out.println("1p = " + p);
                obj_tran_total.main(ObjAL.get(0).getJob_id(), con, p);
                obj_track.main(con, p, ObjAL.get(0).getJob_id());
                obj_summary.main(con, p, ObjAL.get(0).getJob_id());
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            ObjAL.clear();
        }
    }

    public ArrayList<DataBeanD_transaction_product_receive> Select_Mem_AL(ArrayList<DataBeanD_transaction_product_receive> objAl, Connection con, String Table_name, String job_id) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        String SQL = "";
        ResultSet rs = null;
        try {
            SQL = "SELECT * from " + Table_name + " where job_id = '" + job_id + "' and delete_flag = 'N' order by to_date(doc_date,'DD-MM-YYYY'),to_number(line_no,'999')";
            System.out.println("XC SQL = " + SQL);
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                DataBeanD_transaction_product_receive bean = new DataBeanD_transaction_product_receive();
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setJob_id(rs.getString("job_id"));
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setDoc_date_system(objuti.Format_Date_System(rs.getString("doc_date")));
                bean.setJob_type_id(rs.getString("job_type_id"));
                bean.setJob_type_desc(rs.getString("job_type_desc"));
                bean.setC_type(rs.getString("c_type"));
                bean.setCtc_i2(rs.getString("ctc_i2"));
                bean.setShift(rs.getString("shift"));
                bean.setSize(rs.getString("size"));
                bean.setWeight(rs.getString(Table_name.equals("d_product_receive_detail") ? "qty" : "weight"));
                bean.setWithdraw_type(Table_name.equals("d_product_receive_detail") ? "N" : "Y");
                bean.setDoc_type("+");
                objAl.add(bean);
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            return objAl;
        }
    }
    
    public void Delete(String job_id,Connection con,PreparedStatement p)throws Exception{
        String SQL = "";
        try{
            SQL = "DELETE FROM  d_transaction_product_receive  WHERE job_id =?";
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
}
