/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_carbon_return_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Beckpalmx No7
 */
public class D_carbon_return_headerDAO {

    private int Returnvalue;

    public int insert(DataBeanD_carbon_return_header dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_carbon_return_header "
                + "(doc_id,doc_date,doc_time,bu_id,sending_id,remark,create_date,update_date,create_by,complete_flag,count_send_complete) "
                + "values(?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {

            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getDoc_time());
            p.setString(4, dataBean.getPrd_emp_id());
            p.setString(5, dataBean.getSending_id());
            p.setString(6, dataBean.getRemark());
            p.setTimestamp(7, dataBean.getDate());
            p.setTimestamp(8, dataBean.getDate());
            p.setString(9, dataBean.getBy());
            p.setString(10,dataBean.getComplete_flag());
            p.setString(11,objuti.Count_sendcomplete("d_carbon_return_header", dataBean.getDoc_id(), dataBean.getComplete_flag(), con));
            Returnvalue = p.executeUpdate();

            sql = "select count(doc_id) as num from d_carbon_return_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_carbon_return_detail set doc_date=?,create_by=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;

                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getBy());
                p.setString(3, dataBean.getComplete_flag());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
            }
            if(dataBean.getComplete_flag().equals("Y")){//ถ้าcomplete_flag == Y ให้ทำการ copyไปอีก Table
                CopyToD_carbon_return_wh(dataBean);
            }
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_carbon_return_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql =
                "update d_carbon_return_header set  "
                + "doc_date=?,doc_time=?,bu_id=?,sending_id=?,remark=?,update_date=?,update_by=?,complete_flag=?,count_send_complete=? "
                + "where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getDoc_time());
            p.setString(3, dataBean.getPrd_emp_id());
            p.setString(4, dataBean.getSending_id());
            p.setString(5, dataBean.getRemark());
            p.setTimestamp(6, dataBean.getDate());
            p.setString(7, dataBean.getBy());
            p.setString(8, dataBean.getComplete_flag());
            p.setString(9,objuti.Count_sendcomplete("d_carbon_return_header", dataBean.getDoc_id(), dataBean.getComplete_flag(), con));
            p.setString(10, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();

            sql = "select count(doc_id) as num from d_carbon_return_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_carbon_return_detail set doc_date=?,update_by=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;

                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getBy());
                p.setString(3, dataBean.getComplete_flag());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
            }
            if(dataBean.getComplete_flag().equals("Y")){//ถ้าcomplete_flag == Y ให้ทำการ copyไปอีก Table
                CopyToD_carbon_return_wh(dataBean);
            }
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public void UpDel(DataBeanD_carbon_return_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_carbon_return_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        String sqldetail = "update d_carbon_return_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            for (int i = 0; i < 2; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else {
                    p = con.prepareStatement(sqldetail);
                }
                p.setString(1, "Y");
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }

    }

    public void UpDel_wh(DataBeanD_carbon_return_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_carbon_return_header_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? ";
        String sqldetail = "update d_carbon_return_detail_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? ";
        PreparedStatement p = null;
        try {
            for (int i = 0; i < 2; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else {
                    p = con.prepareStatement(sqldetail);
                }
                p.setString(1, "Y");
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }

    }
    
    private void CopyToD_carbon_return_wh(DataBeanD_carbon_return_header dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String SQLcount = "select count(doc_id) as num from d_carbon_return_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'";
        String SQLcopy = "Select * from  d_carbon_return_detail where doc_id='" + dataBean.getDoc_id() + "' and complete_flag ='Y' and delete_flag ='N' order by  to_number(line_no,'9999')";
        String SQLinsert_header = "insert into d_carbon_return_header_wh (doc_id,doc_date,doc_time,bu_id,sending_id,remark,create_date,update_date,create_by) values(?,?,?,?,?,?,?,?,?)";
        String SQLinsert_detail = "insert into d_carbon_return_detail_wh (doc_id,line_no,prd_no,size,c_type,iod,comp_palate,late_no,machine,size_cont,bag,s_weight,weight,reason_ret,remark,create_date,create_by,doc_date) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        ResultSet rs = null;
        PreparedStatement p = null;
        
        UpDel_wh(dataBean); //ลบข้อมูลเดิม Warehouse ก่อน (ถ้ามี)
        
        try {
            p = con.prepareStatement(SQLinsert_header);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getDoc_time());
            p.setString(4, dataBean.getPrd_emp_id());
            p.setString(5, dataBean.getSending_id());
            p.setString(6, dataBean.getRemark());
            p.setTimestamp(7, dataBean.getDate());
            p.setTimestamp(8, dataBean.getDate());
            p.setString(9, dataBean.getBy());
            p.executeUpdate();

            if (objuti.numRowdatabase(SQLcount) != 0) {
                rs = con.createStatement().executeQuery(SQLcopy);
                p = null;
                p = con.prepareStatement(SQLinsert_detail);
                while (rs.next()) {
                    p.setString(1, rs.getString("doc_id"));
                    p.setString(2, rs.getString("line_no"));
                    p.setString(3, rs.getString("prd_no"));
                    p.setString(4, rs.getString("size"));
                    p.setString(5, rs.getString("c_type"));
                    p.setString(6, rs.getString("iod"));
                    p.setString(7, rs.getString("comp_palate"));
                    p.setString(8, rs.getString("late_no"));
                    p.setString(9, rs.getString("machine"));
                    p.setString(10, rs.getString("size_cont"));
                    p.setString(11, rs.getString("bag"));
                    p.setString(12, rs.getString("s_weight"));
                    p.setString(13, rs.getString("weight"));
                    p.setString(14, rs.getString("reason_ret"));
                    p.setString(15, rs.getString("remark"));
                    p.setTimestamp(16, rs.getTimestamp("create_date"));
                    p.setString(17, rs.getString("create_by"));
                    p.setString(18, dataBean.getDoc_date());
                    p.addBatch();
                }
                p.executeBatch();
                p.clearBatch();
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (p != null) {
                p.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}
