/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Calculator.Cal_Total;
import com.cgc.bean.DataBeanD_requisition_product_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.cgc.Util.UtiDatabase;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Beckpalmx No7
 */
public class D_requisition_product_headerDAO {

    private int Returnvalue;
    UtiDatabase uti = new UtiDatabase();

    public int insert(DataBeanD_requisition_product_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_requisition_product_header "
                + "(doc_id,doc_date,wh_in,wh_out,job_id,contain_no,contain_type,palate_type,approver,payment_prod,receiver,car_no,net_weight,po_no,item_id,seal_no,create_date,update_date,create_by,cust_id,complete_flag,count_send_complete)"
                + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getWh_in());
            p.setString(4, dataBean.getWh_out());
            p.setString(5, dataBean.getJob_id());
            p.setString(6, dataBean.getContain_no());
            p.setString(7, dataBean.getContain_type());
            p.setString(8, dataBean.getPalate_type());
            p.setString(9, dataBean.getApprover());
            p.setString(10, dataBean.getPayment_prod());
            p.setString(11, dataBean.getReceiver());
            p.setString(12, dataBean.getCar_no());
            p.setString(13, dataBean.getNet_weight());
            p.setString(14, dataBean.getPo_no());
            p.setString(15, dataBean.getItem_id());
            p.setString(16, dataBean.getSeal_no());
            p.setTimestamp(17, dataBean.getDate());
            p.setTimestamp(18, dataBean.getDate());
            p.setString(19, dataBean.getBy());
            p.setString(20, dataBean.getCust_id());
            p.setString(21, dataBean.getComplete_flag());
            p.setString(22, uti.Count_sendcomplete("d_requisition_product_header", dataBean.getDoc_id(), dataBean.getComplete_flag(), con));
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_requisition_product_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

            if (uti.numRowdatabase(sql) != 0) {
                //*************************Detail*************************
                sql = "update d_requisition_product_detail set doc_date=?,wh_in=?,wh_out=?,create_by=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getWh_in());
                p.setString(3, dataBean.getWh_out());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getComplete_flag());
                p.setString(6, dataBean.getDoc_id());
                p.executeUpdate();
                //**************************Header*************************
                Cal_Total cal = new Cal_Total("d_requisition_product_detail", "weight", dataBean.getDoc_id(), " and complete_flag  = '" + dataBean.getComplete_flag() + "'");
                sql = "update d_requisition_product_header set net_weight=? where doc_id = ? and delete_flag <> 'Y' and complete_flag  = '" + dataBean.getComplete_flag() + "'";
                p = con.prepareStatement(sql);
                p.setString(1, cal.Return_Total());
                p.setString(2, dataBean.getDoc_id());
                p.executeUpdate();
                dataBean.setNet_weight(cal.Return_Total());
            }
            if (dataBean.getComplete_flag().equals("Y")) {
                CopyToD_requisition_product_wh(dataBean);
            }
        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_requisition_product_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql
                = "update d_requisition_product_header set  "
                + "doc_date=?,wh_in=?,wh_out=?,job_id=?,contain_no=?,contain_type=?,palate_type=?,approver=?,payment_prod=?,receiver=?,car_no=?,net_weight=?,po_no=?,item_id=?,seal_no=?,update_date=?,update_by=?,cust_id=?,complete_flag=?,count_send_complete=?"
                + " where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getWh_in());
            p.setString(3, dataBean.getWh_out());
            p.setString(4, dataBean.getJob_id());
            p.setString(5, dataBean.getContain_no());
            p.setString(6, dataBean.getContain_type());
            p.setString(7, dataBean.getPalate_type());
            p.setString(8, dataBean.getApprover());
            p.setString(9, dataBean.getPayment_prod());
            p.setString(10, dataBean.getReceiver());
            p.setString(11, dataBean.getCar_no());
            p.setString(12, dataBean.getNet_weight());
            p.setString(13, dataBean.getPo_no());
            p.setString(14, dataBean.getItem_id());
            p.setString(15, dataBean.getSeal_no());
            p.setTimestamp(16, dataBean.getDate());
            p.setString(17, dataBean.getBy());
            p.setString(18, dataBean.getCust_id());
            p.setString(19, dataBean.getComplete_flag());
            p.setString(20, uti.Count_sendcomplete("d_requisition_product_header", dataBean.getDoc_id(), dataBean.getComplete_flag(), con));
            p.setString(21, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_requisition_product_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

            if (uti.numRowdatabase(sql) != 0) {
                //*************************Detail*************************
                sql = "update d_requisition_product_detail set doc_date=?,wh_in=?,wh_out=?,create_by=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getWh_in());
                p.setString(3, dataBean.getWh_out());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getComplete_flag());
                p.setString(6, dataBean.getDoc_id());
                p.executeUpdate();
                //**************************Header*************************
                Cal_Total cal = new Cal_Total("d_requisition_product_detail", "weight", dataBean.getDoc_id(), " and complete_flag  = '" + dataBean.getComplete_flag() + "'");
                sql = "update d_requisition_product_header set net_weight=? where doc_id = ? and delete_flag <> 'Y' and complete_flag  = '" + dataBean.getComplete_flag() + "'";
                p = con.prepareStatement(sql);
                p.setString(1, cal.Return_Total());
                p.setString(2, dataBean.getDoc_id());
                p.executeUpdate();
                dataBean.setNet_weight(cal.Return_Total());
            }
            if (dataBean.getComplete_flag().equals("Y")) {
                CopyToD_requisition_product_wh(dataBean);
            }
        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public void UpDel(DataBeanD_requisition_product_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_requisition_product_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_requisition_product_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p;
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
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }

    }

    public void UpDel_wh(DataBeanD_requisition_product_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_requisition_product_header_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? ";
        String sqldetail = "update d_requisition_product_detail_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? ";
        PreparedStatement p;
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
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }

    }

    private void CopyToD_requisition_product_wh(DataBeanD_requisition_product_header dataBean) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String SQLcount = "select count(doc_id) as num from d_requisition_product_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'";
        String SQLcopy = "Select * from  d_requisition_product_detail where doc_id='" + dataBean.getDoc_id() + "' and complete_flag ='Y' and delete_flag ='N' order by  to_number(line_no,'9999')";
        String SQLinsert_header = "insert into d_requisition_product_header_wh "
                + "(doc_id,doc_date,wh_in,wh_out,job_id,contain_no,contain_type,palate_type,approver,payment_prod,receiver,car_no,net_weight,po_no,item_id,seal_no,create_date,update_date,create_by,cust_id)"
                + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        String SQLinsert_detail = "insert into d_requisition_product_detail_wh "
                + "(doc_id,line_no,product_id,weight,bag,lot_no,remark,wh_in,wh_out,doc_date,create_date,create_by,quantity,job_id)"
                + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        ResultSet rs = null;
        PreparedStatement p;

        UpDel_wh(dataBean); //ลบข้อมูลเดิม Warehouse ก่อน (ถ้ามี)

        try {
            p = con.prepareStatement(SQLinsert_header);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getWh_in());
            p.setString(4, dataBean.getWh_out());
            p.setString(5, dataBean.getJob_id());
            p.setString(6, dataBean.getContain_no());
            p.setString(7, dataBean.getContain_type());
            p.setString(8, dataBean.getPalate_type());
            p.setString(9, dataBean.getApprover());
            p.setString(10, dataBean.getPayment_prod());
            p.setString(11, dataBean.getReceiver());
            p.setString(12, dataBean.getCar_no());
            p.setString(13, dataBean.getNet_weight());
            p.setString(14, dataBean.getPo_no());
            p.setString(15, dataBean.getItem_id());
            p.setString(16, dataBean.getSeal_no());
            p.setTimestamp(17, dataBean.getDate());
            p.setTimestamp(18, dataBean.getDate());
            p.setString(19, dataBean.getBy());
            p.setString(20, dataBean.getCust_id());
            p.executeUpdate();

            if (uti.numRowdatabase(SQLcount) != 0) {
                rs = con.createStatement().executeQuery(SQLcopy);
                while (rs.next()) {
                    p = con.prepareStatement(SQLinsert_detail);
                    p.setString(1, rs.getString("doc_id"));
                    p.setString(2, rs.getString("line_no"));
                    p.setString(3, rs.getString("product_id"));
                    p.setString(4, rs.getString("weight"));
                    p.setString(5, rs.getString("bag"));
                    p.setString(6, rs.getString("lot_no"));
                    p.setString(7, rs.getString("remark"));
                    p.setString(8, rs.getString("wh_in"));
                    p.setString(9, rs.getString("wh_out"));
                    p.setString(10, rs.getString("doc_date"));
                    p.setTimestamp(11, dataBean.getDate());
                    p.setString(12, dataBean.getBy());
                    p.setString(13, rs.getString("quantity"));
                    p.setString(14, rs.getString("job_id"));
                    p.executeUpdate();
                }
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            //if (sp != null) {
            //p.close();
            //}
            if (con != null) {
                con.close();
            }
        }
    }
}
