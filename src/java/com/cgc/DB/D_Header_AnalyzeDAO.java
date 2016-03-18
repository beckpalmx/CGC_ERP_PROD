/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanDHeaderAnalyze;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author com02
 */
public class D_Header_AnalyzeDAO {

    public boolean insert(DataBeanDHeaderAnalyze ppBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO d_header_analyze "
                + "(doc_id,job_id,psd_1,psd_2,psd_3,psd_4,psd_5,psd_6,psd_7,psd_8,psd_9,psd_10,psd_11,psd_12,psd_13,psd_14,psd_15 "
                + ",h2o,butane,iod,pass,n_pass,grade,remark,create_date,update_date,create_by,doc_type) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, ppBean.getDoc_id());
            p.setString(2, ppBean.getJob_id());
            p.setString(3, ppBean.getPsd_1());
            p.setString(4, ppBean.getPsd_2());
            p.setString(5, ppBean.getPsd_3());
            p.setString(6, ppBean.getPsd_4());
            p.setString(7, ppBean.getPsd_5());
            p.setString(8, ppBean.getPsd_6());
            p.setString(9, ppBean.getPsd_7());
            p.setString(10, ppBean.getPsd_8());
            p.setString(11, ppBean.getPsd_9());
            p.setString(12, ppBean.getPsd_10());
            p.setString(13, ppBean.getPsd_11());
            p.setString(14, ppBean.getPsd_12());
            p.setString(15, ppBean.getPsd_13());
            p.setString(16, ppBean.getPsd_14());
            p.setString(17, ppBean.getPsd_15());
            p.setString(18, ppBean.getH2o());
            p.setString(19, ppBean.getButane());
            p.setString(20, ppBean.getIod());
            p.setString(21, ppBean.getPass());
            p.setString(22, ppBean.getN_pass());
            p.setString(23, ppBean.getGrade());
            p.setString(24, ppBean.getRemark());           
            p.setTimestamp(25, ppBean.getCreate_date());
            p.setTimestamp(26, ppBean.getUpdate_date());
            p.setString(27, ppBean.getCreate_by());             
            p.setString(28, ppBean.getDoc_type());          
            p.executeUpdate();

            return true;

        } catch (Exception e) {
            return false;
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public ArrayList<DataBeanDHeaderAnalyze> selectDataAll() throws Exception {
        DataBeanDHeaderAnalyze ppBean = null;
        ArrayList<DataBeanDHeaderAnalyze> list = new ArrayList<DataBeanDHeaderAnalyze>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from d_header_analyze where delete_flag <> 'Y' order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            rs = p.executeQuery();

            while (rs.next()) {
                ppBean = new DataBeanDHeaderAnalyze();
            p.setString(1, ppBean.getDoc_id());
            p.setString(2, ppBean.getJob_id());
            p.setString(3, ppBean.getPsd_1());
            p.setString(4, ppBean.getPsd_2());
            p.setString(5, ppBean.getPsd_3());
            p.setString(6, ppBean.getPsd_4());
            p.setString(7, ppBean.getPsd_5());
            p.setString(8, ppBean.getPsd_6());
            p.setString(9, ppBean.getPsd_7());
            p.setString(10, ppBean.getPsd_8());
            p.setString(11, ppBean.getPsd_9());
            p.setString(12, ppBean.getPsd_10());
            p.setString(13, ppBean.getPsd_11());
            p.setString(14, ppBean.getPsd_12());
            p.setString(15, ppBean.getPsd_13());
            p.setString(16, ppBean.getPsd_14());
            p.setString(17, ppBean.getPsd_15());
            p.setString(18, ppBean.getH2o());
            p.setString(19, ppBean.getButane());
            p.setString(20, ppBean.getIod());
            p.setString(21, ppBean.getPass());
            p.setString(22, ppBean.getN_pass());
            p.setString(23, ppBean.getGrade());
            p.setString(24, ppBean.getRemark());           
            p.setTimestamp(25, ppBean.getCreate_date());
            p.setTimestamp(26, ppBean.getUpdate_date());
            p.setString(27, ppBean.getCreate_by());  
                list.add(ppBean);
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return list;
        }
    }

    public void updateDel(DataBeanDHeaderAnalyze ppBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE d_header_analyze SET delete_flag = 'Y' where doc_id=?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, ppBean.getDoc_id());
            p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public void update(DataBeanDHeaderAnalyze ppBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE d_header_analyze SET doc_id=?,job_id=?,psd_1=?,psd_2=?,psd_3=?"
                + ",psd_4=?,psd_5=?,psd_6=?,psd_7=?"
                + ",psd_8=?,psd_9=?,psd_10=?,psd_11=?,psd_12=?,psd_13=?,psd_14=?,psd_15=?"
                + ",h2o=?,butane=?,iod=?,pass=?,n_pass=?,grade=?,remark=?"
                + ",update_date=?,update_by=? where doc_id = ? ";
        PreparedStatement p = null;
        System.out.println("update sql = " + sql);
        try {
            p = con.prepareStatement(sql);
            p.setString(1, ppBean.getDoc_id());
            p.setString(2, ppBean.getJob_id());
            p.setString(3, ppBean.getPsd_1());
            p.setString(4, ppBean.getPsd_2());
            p.setString(5, ppBean.getPsd_3());
            p.setString(6, ppBean.getPsd_4());
            p.setString(7, ppBean.getPsd_5());
            p.setString(8, ppBean.getPsd_6());
            p.setString(9, ppBean.getPsd_7());
            p.setString(10, ppBean.getPsd_8());
            p.setString(11, ppBean.getPsd_9());
            p.setString(12, ppBean.getPsd_10());
            p.setString(13, ppBean.getPsd_11());
            p.setString(14, ppBean.getPsd_12());
            p.setString(15, ppBean.getPsd_13());
            p.setString(16, ppBean.getPsd_14());
            p.setString(17, ppBean.getPsd_15());
            p.setString(18, ppBean.getH2o());
            p.setString(19, ppBean.getButane());
            p.setString(20, ppBean.getIod());
            p.setString(21, ppBean.getPass());
            p.setString(22, ppBean.getN_pass());
            p.setString(23, ppBean.getGrade());
            p.setString(24, ppBean.getRemark());               
            p.setTimestamp(25, ppBean.getUpdate_date());
            p.setString(26, ppBean.getUpdate_by());  
            p.setString(27, ppBean.getDoc_id());  
            p.executeUpdate();
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public boolean copy(DataBeanDHeaderAnalyze ppBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE d_header_analyze SET doc_id=?,job_id=?,psd_1=?,psd_2=?,psd_3=?"
                + ",psd_4=?,psd_5=?,psd_6=?,psd_7=?"
                + ",psd_8=?,psd_9=?,psd_10=?,psd_11=?,psd_12=?,psd_13=?,psd_14=?,psd_15=?"
                + ",h2o=?,butane=?,iod=?,pass=?,n_pass=?,grade=?,remark=?"
                + ",update_date=?,update_by=? where doc_id = ? ";
        PreparedStatement p = null;
        System.out.println("update sql = " + sql);
        try {
            p = con.prepareStatement(sql);
            p.setString(1, ppBean.getDoc_id());
            p.setString(2, ppBean.getJob_id());
            p.setString(3, ppBean.getPsd_1());
            p.setString(4, ppBean.getPsd_2());
            p.setString(5, ppBean.getPsd_3());
            p.setString(6, ppBean.getPsd_4());
            p.setString(7, ppBean.getPsd_5());
            p.setString(8, ppBean.getPsd_6());
            p.setString(9, ppBean.getPsd_7());
            p.setString(10, ppBean.getPsd_8());
            p.setString(11, ppBean.getPsd_9());
            p.setString(12, ppBean.getPsd_10());
            p.setString(13, ppBean.getPsd_11());
            p.setString(14, ppBean.getPsd_12());
            p.setString(15, ppBean.getPsd_13());
            p.setString(16, ppBean.getPsd_14());
            p.setString(17, ppBean.getPsd_15());
            p.setString(18, ppBean.getH2o());
            p.setString(19, ppBean.getButane());
            p.setString(20, ppBean.getIod());
            p.setString(21, ppBean.getPass());
            p.setString(22, ppBean.getN_pass());
            p.setString(23, ppBean.getGrade());
            p.setString(24, ppBean.getRemark());               
            p.setTimestamp(25, ppBean.getUpdate_date());
            p.setString(26, ppBean.getUpdate_by());  
            p.setString(27, ppBean.getDoc_id());  
            p.executeUpdate();
            return true;
        } catch (Exception e) {
            return false;
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
    }

    
    public DataBeanDHeaderAnalyze selectData(String doc_id) throws Exception {
        DataBeanDHeaderAnalyze ppBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        //String job_id ,iod ;
        String sql = "SELECT * From d_header_analyze where doc_id = ? AND delete_flag <> 'Y'";
        System.out.println("SQL Select = " + sql);
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, doc_id);
            //p.setString(2, job_id);
            //p.setString(3, iod);
            System.out.println("sel job_id = " + doc_id);
            //System.out.println("sel job_id = " + job_id);
            rs = p.executeQuery();
            while (rs.next()) {
                ppBean = new DataBeanDHeaderAnalyze();
                ppBean.setDoc_id(rs.getString("doc_id"));
                ppBean.setJob_id(rs.getString("job_id"));
                ppBean.setIod(rs.getString("iod"));
                ppBean.setRemark(rs.getString("remark"));
                ppBean.setDelete_flag(rs.getString("delete_flag"));
                
                System.out.println("res doc_id = " + rs.getString("doc_id"));
                System.out.println("res job_id = " + rs.getString("job_id"));
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
            return ppBean;
        }
    }
}
