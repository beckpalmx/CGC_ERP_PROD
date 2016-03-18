/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_product_receive_header;
import com.cgc.bean.DataBeanD_transaction_product_receive;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Beckpalmx No7
 */
public class D_product_receive_headerDAO {

    private int Returnvalue;

    public int insert(DataBeanD_product_receive_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_product_receive_header "
                + "(doc_id,doc_date,job_id,product_id,size,ctc_i2,inc_bal,palate_no,wh_in,wh_out,create_date,update_date,create_by,mashed_machine_chk,pan_chk,ball_mill_chk,pill_flat_chk,mag_chk,job_edit_chk,wash_chk,roast_chk,roast_edit_chk,mashed_machine,pan,ball_mill,pill_flat,mag,job_edit,wash,roast,roast_edit,complete_flag,remark,count_send_complete,process_order) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getJob_id());
            p.setString(4, dataBean.getProduct_id());
            p.setString(5, dataBean.getSize());
            p.setString(6, dataBean.getCtc_i2());
            p.setString(7, dataBean.getInc_bal());
            p.setString(8, dataBean.getPalate_no());
            p.setString(9, dataBean.getWh_in());
            p.setString(10, dataBean.getWh_out());
            p.setTimestamp(11, dataBean.getDate());
            p.setTimestamp(12, dataBean.getDate());
            p.setString(13, dataBean.getBy());
            p.setString(14, dataBean.getMashed_machine_chk());
            p.setString(15, dataBean.getPan_chk());
            p.setString(16, dataBean.getBall_mill_chk());
            p.setString(17, dataBean.getPill_flat_chk());
            p.setString(18, dataBean.getMag_chk());
            p.setString(19, dataBean.getJob_edit_chk());
            p.setString(20, dataBean.getWash_chk());
            p.setString(21, dataBean.getRoast_chk());
            p.setString(22, dataBean.getRoast_edit_chk());
            p.setString(23, dataBean.getMashed_machine());
            p.setString(24, dataBean.getPan());
            p.setString(25, dataBean.getBall_mill());
            p.setString(26, dataBean.getPill_flat());
            p.setString(27, dataBean.getMag());
            p.setString(28, dataBean.getJob_edit());
            p.setString(29, dataBean.getWash());
            p.setString(30, dataBean.getRoast());
            p.setString(31, dataBean.getRost_edit());
            p.setString(32, dataBean.getJob_id_complete());
            p.setString(33, dataBean.getRemark());
            p.setString(34, objuti.Count_sendcomplete("d_carbon_withdraw_header", dataBean.getDoc_id(), dataBean.getJob_id_complete(), con));
            p.setString(35, dataBean.getProcess_order());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_product_receive_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_product_receive_detail set wh_in=?,wh_out=?,doc_date=?,create_by=?,c_type=?,job_id=?,complete_flag=?,process_order=? where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getWh_in());
                p.setString(2, dataBean.getWh_out());
                p.setString(3, dataBean.getDoc_date());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getProduct_id());
                p.setString(6, dataBean.getJob_id());
                p.setString(7, dataBean.getJob_id_complete());
                p.setString(8, dataBean.getProcess_order());
                p.setString(9, dataBean.getDoc_id());
                p.executeUpdate();
            }
            sql = "select count(doc_id) as num from d_product_receive_detail_prod where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_product_receive_detail_prod set wh_in=?,wh_out=?,doc_date=?,create_by=?,c_type=?,job_id=?,complete_flag=?,process_order=?  where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getWh_in());
                p.setString(2, dataBean.getWh_out());
                p.setString(3, dataBean.getDoc_date());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getProduct_id());
                p.setString(6, dataBean.getJob_id());
                p.setString(7, dataBean.getJob_id_complete());
                p.setString(8, dataBean.getProcess_order());
                p.setString(9, dataBean.getDoc_id());
                p.executeUpdate();
            }
            if (dataBean.getJob_id_end().equals("Y")) {
                update_D_job_order(con, p, dataBean.getJob_id(), dataBean.getJob_id_end());
                ArrayList<DataBeanD_transaction_product_receive> obj_AL = new ArrayList<DataBeanD_transaction_product_receive>();
                D_transaction_product_receiveDAO obj_tran = new D_transaction_product_receiveDAO();
                obj_AL = obj_tran.Select_Mem_AL(obj_AL, con, "d_product_receive_detail", dataBean.getJob_id());
                obj_AL = obj_tran.Select_Mem_AL(obj_AL, con, "d_product_receive_detail_prod", dataBean.getJob_id());
                System.out.println("p insert = " + p);
                obj_tran.main(obj_AL, con, p);
            } else {
                update_D_job_order(con, p, dataBean.getJob_id(), dataBean.getJob_id_end());
            }
            if (dataBean.getJob_id_complete().equalsIgnoreCase("Y")) {
                CopyToD_product_receive_wh(dataBean, con);
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

    public int update(DataBeanD_product_receive_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql
                = "update d_product_receive_header set  "
                + "doc_date=?,job_id=?,product_id=?,size=?,ctc_i2=?,inc_bal=?,palate_no=?,wh_in=?,wh_out=?,update_date=?,update_by=?,mashed_machine_chk=?,pan_chk=?,ball_mill_chk=?,pill_flat_chk=?,mag_chk=?,job_edit_chk=?,wash_chk=?,roast_chk=?,roast_edit_chk=?,mashed_machine=?,pan=?,ball_mill=?,pill_flat=?,mag=?,job_edit=?,wash=?,roast=?,roast_edit=?,complete_flag=?,remark=?,count_send_complete=?,process_order=?"
                + " where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getJob_id());
            p.setString(3, dataBean.getProduct_id());
            p.setString(4, dataBean.getSize());
            p.setString(5, dataBean.getCtc_i2());
            p.setString(6, dataBean.getInc_bal());
            p.setString(7, dataBean.getPalate_no());
            p.setString(8, dataBean.getWh_in());
            p.setString(9, dataBean.getWh_out());
            p.setTimestamp(10, dataBean.getDate());
            p.setString(11, dataBean.getBy());
            p.setString(12, dataBean.getMashed_machine_chk());
            p.setString(13, dataBean.getPan_chk());
            p.setString(14, dataBean.getBall_mill_chk());
            p.setString(15, dataBean.getPill_flat_chk());
            p.setString(16, dataBean.getMag_chk());
            p.setString(17, dataBean.getJob_edit_chk());
            p.setString(18, dataBean.getWash_chk());
            p.setString(19, dataBean.getRoast_chk());
            p.setString(20, dataBean.getRoast_edit_chk());
            p.setString(21, dataBean.getMashed_machine());
            p.setString(22, dataBean.getPan());
            p.setString(23, dataBean.getBall_mill());
            p.setString(24, dataBean.getPill_flat());
            p.setString(25, dataBean.getMag());
            p.setString(26, dataBean.getJob_edit());
            p.setString(27, dataBean.getWash());
            p.setString(28, dataBean.getRoast());
            p.setString(29, dataBean.getRost_edit());
            p.setString(30, dataBean.getJob_id_complete());
            p.setString(31, dataBean.getRemark());
            p.setString(32, objuti.Count_sendcomplete("d_carbon_withdraw_header", dataBean.getDoc_id(), dataBean.getJob_id_complete(), con));
            p.setString(33, dataBean.getProcess_order());
            p.setString(34, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_product_receive_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_product_receive_detail set wh_in=?,wh_out=?,doc_date=?,create_by=?,job_id=?,complete_flag=?,process_order=? where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getWh_in());
                p.setString(2, dataBean.getWh_out());
                p.setString(3, dataBean.getDoc_date());
                p.setString(4, dataBean.getBy());                
                p.setString(5, dataBean.getJob_id());
                p.setString(6, dataBean.getJob_id_complete());
                p.setString(7, dataBean.getProcess_order());
                p.setString(8, dataBean.getDoc_id());
                p.executeUpdate();
            }
            sql = "select count(doc_id) as num from d_product_receive_detail_prod where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
            if (objuti.numRowdatabase(sql) != 0) {
                sql = "update d_product_receive_detail_prod set wh_in=?,wh_out=?,doc_date=?,create_by=?,c_type=?,job_id=?,complete_flag=?,process_order=?  where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getWh_in());
                p.setString(2, dataBean.getWh_out());
                p.setString(3, dataBean.getDoc_date());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getProduct_id());
                p.setString(6, dataBean.getJob_id());
                p.setString(7, dataBean.getJob_id_complete());
                p.setString(8, dataBean.getProcess_order());
                p.setString(9, dataBean.getDoc_id());
                p.executeUpdate();
            }
            if (dataBean.getJob_id_end().equals("Y")) {
                update_D_job_order(con, p, dataBean.getJob_id(), dataBean.getJob_id_end());
                System.out.println("dataBean.getJob_id_end() = " + dataBean.getJob_id_end());
                ArrayList<DataBeanD_transaction_product_receive> obj_AL = new ArrayList<DataBeanD_transaction_product_receive>();
                D_transaction_product_receiveDAO obj_tran = new D_transaction_product_receiveDAO();
                obj_AL = obj_tran.Select_Mem_AL(obj_AL, con, "d_product_receive_detail", dataBean.getJob_id());
                obj_AL = obj_tran.Select_Mem_AL(obj_AL, con, "d_product_receive_detail_prod", dataBean.getJob_id());
                System.out.println("p update = " + p);
                obj_tran.main(obj_AL, con, p);
            } else {
                update_D_job_order(con, p, dataBean.getJob_id(), dataBean.getJob_id_end());
            }
            if (dataBean.getJob_id_complete().equalsIgnoreCase("Y")) {
                CopyToD_product_receive_wh(dataBean, con);
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

    public void update_D_job_order(Connection con, PreparedStatement p, String job_id, String job_id_end) throws Exception {
        String SQL = "update d_job_order_header set doc_type = ?  where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'";
        try {
            p = con.prepareStatement(SQL);
            p.setString(1, job_id_end);
            p.setString(2, job_id);
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
        }

    }

    public void UpDel(DataBeanD_product_receive_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_product_receive_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        String sqldetail = "update d_product_receive_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        String sqldetail_prod = "update d_product_receive_detail_prod set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            for (int i = 0; i < 3; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else if (i == 2) {
                    p = con.prepareStatement(sqldetail);
                } else {
                    p = con.prepareStatement(sqldetail_prod);
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

    public void UpDel_wh(DataBeanD_product_receive_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_product_receive_header_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? ";
        String sqldetail = "update d_product_receive_detail_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? ";
        String sqldetail_prod = "update d_product_receive_detail_prod_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? ";
        PreparedStatement p = null;
        try {
            for (int i = 0; i < 3; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else if (i == 2) {
                    p = con.prepareStatement(sqldetail);
                } else {
                    p = con.prepareStatement(sqldetail_prod);
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

    private void CopyToD_product_receive_wh(DataBeanD_product_receive_header dataBean, Connection con) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        //String SQLcount_header_wh = "select count(doc_id) as num from d_product_receive_header_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' ";
        //String SQLcount_detail_wh = "select count(doc_id) as num from d_product_receive_detail_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' ";
        //String SQLcount_detail_prod_wh = "select count(doc_id) as num from d_product_receive_detail_prod_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' ";

        String SQLcount = "select count(doc_id) as num from d_product_receive_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'",
                SQLcount_prod = "select count(doc_id) as num from d_product_receive_detail_prod where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'";
        String SQLcopy = "Select * from  d_product_receive_detail where doc_id='" + dataBean.getDoc_id() + "' and complete_flag ='Y' and delete_flag ='N' order by  to_number(line_no,'9999')",
                SQLcompy_prod = "Select * from  d_product_receive_detail_prod where doc_id='" + dataBean.getDoc_id() + "' and complete_flag ='Y' and delete_flag ='N' order by  to_number(line_no,'9999')";
        String SQLinsert_header = "insert into d_product_receive_header_wh "
                + "(doc_id,doc_date,job_id,product_id,size,ctc_i2,inc_bal,palate_no,wh_in,wh_out,create_date,update_date,create_by,mashed_machine_chk,pan_chk,ball_mill_chk,pill_flat_chk,mag_chk,job_edit_chk,wash_chk,roast_chk,roast_edit_chk,mashed_machine,pan,ball_mill,pill_flat,mag,job_edit,wash,roast,roast_edit,job_id_complete,remark) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        String SQLinsert_detail = "insert into d_product_receive_detail_wh "
                + "(doc_id,doc_date,line_no,wh_in,wh_out,burn_no,location_id,size,job_edit_no,ctc_i2,qty,shift,palate_no,emp_id,create_date,wh_id,create_by,unit_id,c_type,job_type_id,job_type_desc,remark,job_id)"
                + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                SQLinsert_detail_prod = "insert into d_product_receive_detail_prod_wh "
                + "(doc_id,doc_date,line_no,wh_in,wh_out,machine,shift,size,weight,palate_complete_code,palate_no,palate_complete,ctc_i2,bag,emp_id,create_date,create_by,palate_chk,unit_id,job_type_id,job_type_desc,c_type,job_id,size_by) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        ResultSet rs = null;
        PreparedStatement p = null;

        //if (objuti.numRowdatabase(SQLcount_header_wh) != 0) {
        // ลบข้อมูลเดิมของ Warehouse ก่อน (ถ้ามี)
            UpDel_wh(dataBean);
        //}

        try {
            p = con.prepareStatement(SQLinsert_header);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getJob_id());
            p.setString(4, dataBean.getProduct_id());
            p.setString(5, dataBean.getSize());
            p.setString(6, dataBean.getCtc_i2());
            p.setString(7, dataBean.getInc_bal());
            p.setString(8, dataBean.getPalate_no());
            p.setString(9, dataBean.getWh_in());
            p.setString(10, dataBean.getWh_out());
            p.setTimestamp(11, dataBean.getDate());
            p.setTimestamp(12, dataBean.getDate());
            p.setString(13, dataBean.getBy());
            p.setString(14, dataBean.getMashed_machine_chk());
            p.setString(15, dataBean.getPan_chk());
            p.setString(16, dataBean.getBall_mill_chk());
            p.setString(17, dataBean.getPill_flat_chk());
            p.setString(18, dataBean.getMag_chk());
            p.setString(19, dataBean.getJob_edit_chk());
            p.setString(20, dataBean.getWash_chk());
            p.setString(21, dataBean.getRoast_chk());
            p.setString(22, dataBean.getRoast_edit_chk());
            p.setString(23, dataBean.getMashed_machine());
            p.setString(24, dataBean.getPan());
            p.setString(25, dataBean.getBall_mill());
            p.setString(26, dataBean.getPill_flat());
            p.setString(27, dataBean.getMag());
            p.setString(28, dataBean.getJob_edit());
            p.setString(29, dataBean.getWash());
            p.setString(30, dataBean.getRoast());
            p.setString(31, dataBean.getRost_edit());
            p.setString(32, dataBean.getJob_id_complete());
            p.setString(33, dataBean.getRemark());
            p.executeUpdate();

            if (objuti.numRowdatabase(SQLcount) != 0) {
                rs = con.createStatement().executeQuery(SQLcopy);
                p = null;
                p = con.prepareStatement(SQLinsert_detail);
                while (rs.next()) {
                    p.setString(1, dataBean.getDoc_id());
                    p.setString(2, dataBean.getDoc_date());
                    p.setString(3, rs.getString("line_no"));
                    p.setString(4, dataBean.getWh_in());
                    p.setString(5, dataBean.getWh_out());
                    p.setString(6, rs.getString("burn_no"));
                    p.setString(7, rs.getString("location_id"));
                    p.setString(8, rs.getString("size"));
                    p.setString(9, rs.getString("job_edit_no"));
                    p.setString(10, rs.getString("ctc_i2"));
                    p.setString(11, rs.getString("qty"));
                    p.setString(12, rs.getString("shift"));
                    p.setString(13, rs.getString("palate_no"));
                    p.setString(14, rs.getString("emp_id"));
                    p.setTimestamp(15, dataBean.getDate());
                    p.setString(16, rs.getString("wh_id"));
                    p.setString(17, dataBean.getBy());
                    p.setString(18, rs.getString("unit_id"));
                    p.setString(19, dataBean.getProduct_id());
                    p.setString(20, rs.getString("job_type_id"));
                    p.setString(21, rs.getString("job_type_desc"));
                    p.setString(22, rs.getString("remark"));
                    p.setString(23, dataBean.getJob_id());
                    p.addBatch();
                }
                p.executeBatch();
                p.clearBatch();
            }
            if (objuti.numRowdatabase(SQLcount_prod) != 0) {
                rs = con.createStatement().executeQuery(SQLcompy_prod);
                p = null;
                p = con.prepareStatement(SQLinsert_detail_prod);
                while (rs.next()) {
                    p.setString(1, dataBean.getDoc_id());
                    p.setString(2, dataBean.getDoc_date());
                    p.setString(3, rs.getString("line_no"));
                    p.setString(4, dataBean.getWh_in());
                    p.setString(5, dataBean.getWh_out());
                    p.setString(6, rs.getString("machine"));
                    p.setString(7, rs.getString("shift"));
                    p.setString(8, rs.getString("size"));
                    p.setString(9, rs.getString("weight"));
                    p.setString(10, rs.getString("palate_complete_code"));
                    p.setString(11, rs.getString("palate_no"));
                    p.setString(12, rs.getString("palate_complete"));
                    p.setString(13, rs.getString("ctc_i2"));
                    p.setString(14, rs.getString("bag"));
                    p.setString(15, rs.getString("emp_id"));
                    p.setTimestamp(16, dataBean.getDate());
                    p.setString(17, dataBean.getBy());
                    p.setString(18, rs.getString("palate_chk"));
                    p.setString(19, rs.getString("unit_id"));
                    p.setString(20, rs.getString("job_type_id"));
                    p.setString(21, rs.getString("job_type_desc"));
                    p.setString(22, dataBean.getProduct_id());
                    p.setString(23, dataBean.getJob_id());
                    p.setString(24, rs.getString("size_by"));
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

        }
    }
}
