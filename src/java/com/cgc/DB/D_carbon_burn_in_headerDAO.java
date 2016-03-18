package com.cgc.DB;

import com.cgc.Calculator.Cal_Total;
import com.cgc.bean.DataBeanD_carbon_burn_in_header;
import com.cgc.Util.UtiDatabase;
import java.sql.*;

public class D_carbon_burn_in_headerDAO {

    private int Returnvalue;

    public int insert(DataBeanD_carbon_burn_in_header dataBean) throws Exception {
        //DataBeanCalculate objbean = new DataBeanCalculate();
        UtiDatabase objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_carbon_burn_in_header (doc_id,doc_date,time_from,time_to,runner_id,shift,burn_no,wh_in,wh_out,total_weight,create_date,update_date,create_by,tank_qty,operate_id,remark,bu,iod,complete_flag,count_send_complete) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p;
        try {

            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getTime_from());
            p.setString(4, dataBean.getTime_to());
            p.setString(5, dataBean.getRunner_id());
            p.setString(6, dataBean.getShift());
            p.setString(7, dataBean.getBurn_no());
            p.setString(8, dataBean.getWh_in());
            p.setString(9, dataBean.getWh_out());
            p.setString(10, dataBean.getTotal_weight());
            p.setTimestamp(11, dataBean.getDate());
            p.setTimestamp(12, dataBean.getDate());
            p.setString(13, dataBean.getBy());
            p.setString(14, dataBean.getTank_qty());
            p.setString(15, dataBean.getOperate_id());
            p.setString(16, dataBean.getRemark());
            p.setString(17, dataBean.getBu());
            p.setString(18, dataBean.getIod());
            p.setString(19, dataBean.getComplete_flag());
            p.setString(20, objuti.Count_sendcomplete("d_carbon_burn_in_header", dataBean.getDoc_id(), dataBean.getComplete_flag(), con));
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_carbon_burn_in_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if (objuti.numRowdatabase(sql) != 0) {//ตรวจสอบ Row ใน Detail ว่าหรือไม่
                //________________________________________________________
                Cal_Total cal = new Cal_Total("d_carbon_burn_in_detail", "weight", dataBean.getDoc_id(), "");//ทำการรวมน้ำหนักทั้งหมดที่อยู่ภายใน Detail
                sql = "update d_carbon_burn_in_header set total_weight=?,tank_qty=? where doc_id = ? and delete_flag <> 'Y' and complete_flag = '" + dataBean.getComplete_flag() + "'";
                //p = null;
                p = con.prepareStatement(sql);
                p.setString(1, cal.Return_Total());
                p.setString(2, Integer.toString(objuti.numRowdatabase("Select count(doc_id) as num from d_carbon_burn_in_detail where doc_id = '" + dataBean.getDoc_id() + "' and delete_flag <> 'Y'")));
                p.setString(3, dataBean.getDoc_id());
                p.executeUpdate();
                //_________________________________________________________
                sql = "update d_carbon_burn_in_detail set doc_date=?,wh_in=?,wh_out=?,create_by=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                //p = null;

                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getWh_in());
                p.setString(3, dataBean.getWh_out());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getComplete_flag());
                p.setString(6, dataBean.getDoc_id());
                p.executeUpdate();
            }
            if (dataBean.getComplete_flag().equals("Y")) {//ถ้าcomplete_flag == Y ให้ทำการ copyไปอีก Table
                CopyToD_carbon_burn_in_wh(dataBean, con);
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

    public int update(DataBeanD_carbon_burn_in_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql
                = "update d_carbon_burn_in_header set  doc_date=?,time_from=?,time_to=?,runner_id=?,shift=?,burn_no=?,wh_in=?,wh_out=?,total_weight=?,update_date=?,update_by=?,tank_qty=?,operate_id=?,remark=?,bu=?,iod=?,complete_flag=?,count_send_complete=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getTime_from());
            p.setString(3, dataBean.getTime_to());
            p.setString(4, dataBean.getRunner_id());
            p.setString(5, dataBean.getShift());
            p.setString(6, dataBean.getBurn_no());
            p.setString(7, dataBean.getWh_in());
            p.setString(8, dataBean.getWh_out());
            p.setString(9, dataBean.getTotal_weight());
            p.setTimestamp(10, dataBean.getDate());
            p.setString(11, dataBean.getBy());
            p.setString(12, dataBean.getTank_qty());
            p.setString(13, dataBean.getOperate_id());
            p.setString(14, dataBean.getRemark());
            p.setString(15, dataBean.getBu());
            p.setString(16, dataBean.getIod());
            p.setString(17, dataBean.getComplete_flag());
            p.setString(18, objuti.Count_sendcomplete("d_carbon_burn_in_header", dataBean.getDoc_id(), dataBean.getComplete_flag(), con));
            p.setString(19, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_carbon_burn_in_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if (objuti.numRowdatabase(sql) != 0) {
                //________________________________________________________
                Cal_Total cal = new Cal_Total("d_carbon_burn_in_detail", "weight", dataBean.getDoc_id(), "");
                sql = "update d_carbon_burn_in_header set total_weight=?,tank_qty=? where doc_id = ? and delete_flag <> 'Y' and complete_flag = '" + dataBean.getComplete_flag() + "'";
                //p = null;
                p = con.prepareStatement(sql);
                p.setString(1, cal.Return_Total());
                p.setString(2, Integer.toString(objuti.numRowdatabase("Select count(doc_id) as num from d_carbon_burn_in_detail where doc_id = '" + dataBean.getDoc_id() + "' and delete_flag <> 'Y'")));
                p.setString(3, dataBean.getDoc_id());
                p.executeUpdate();
                //_________________________________________________________
                sql = "update d_carbon_burn_in_detail set doc_date=?,wh_in=?,wh_out=?,update_by=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y'";
                //p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getWh_in());
                p.setString(3, dataBean.getWh_out());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getComplete_flag());
                p.setString(6, dataBean.getDoc_id());
                p.executeUpdate();
            }
            if (dataBean.getComplete_flag().equals("Y")) {//ถ้าcomplete_flag == Y ให้ทำการ copyไปอีก Table
                CopyToD_carbon_burn_in_wh(dataBean, con);
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

    public void UpDel(DataBeanD_carbon_burn_in_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_carbon_burn_in_header set delete_flag = ?,delete_date=? ,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_carbon_burn_in_detail set delete_flag = ?,delete_date=? ,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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

    public void UpDel_wh(DataBeanD_carbon_burn_in_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_carbon_burn_in_header_wh set delete_flag = ?,delete_date=? ,delete_by=? where doc_id=? ";
        String sqldetail = "update d_carbon_burn_in_detail_wh set delete_flag = ?,delete_date=? ,delete_by=? where doc_id=? ";
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

    private void CopyToD_carbon_burn_in_wh(DataBeanD_carbon_burn_in_header dataBean, Connection con) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        String SQLcount = "select count(doc_id) as num from d_carbon_burn_in_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'";
        String SQLcopy = "Select doc_id,doc_date,line_no,product_id,tank_suite,weight,weight_tank,weight_tot,silo_no,location_id,channel,remark from  d_carbon_burn_in_detail where doc_id='" + dataBean.getDoc_id() + "' and complete_flag ='Y' and delete_flag ='N' order by  to_number(line_no,'9999')";
        String SQLinsert_header = "insert into d_carbon_burn_in_header_wh"
                + "(doc_id,doc_date,time_from,time_to,runner_id,shift,burn_no,wh_in,wh_out,total_weight,create_date,update_date,create_by,tank_qty,operate_id,remark,bu,iod,doc_type,complete_flag) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        String SQLinsert_detail = "insert into d_carbon_burn_in_detail_wh"
                + "(doc_id,doc_date,line_no,product_id,tank_suite,weight,weight_tank,weight_tot,silo_no,location_id,create_date,create_by,channel,remark,wh_product_id,wh_warehouse_id,wh_location_id,wh_weight_final,complete_flag) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        ResultSet rs = null;
        PreparedStatement p = null;

        UpDel_wh(dataBean); // ลบข้อมูลเดิมของ Warehouse ก่อน (ถ้ามี)

        try {
            p = con.prepareStatement(SQLinsert_header);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getTime_from());
            p.setString(4, dataBean.getTime_to());
            p.setString(5, dataBean.getRunner_id());
            p.setString(6, dataBean.getShift());
            p.setString(7, dataBean.getBurn_no());
            p.setString(8, dataBean.getWh_in());
            p.setString(9, dataBean.getWh_out());
            p.setString(10, dataBean.getTotal_weight());
            p.setTimestamp(11, dataBean.getDate());
            p.setTimestamp(12, dataBean.getDate());
            p.setString(13, dataBean.getBy());
            p.setString(14, dataBean.getTank_qty());
            p.setString(15, dataBean.getOperate_id());
            p.setString(16, dataBean.getRemark());
            p.setString(17, dataBean.getBu());
            p.setString(18, dataBean.getIod());
            p.setString(19, "Y");
            p.setString(20, "Y");
            p.executeUpdate();

            if (objuti.numRowdatabase(SQLcount) != 0) {
                rs = con.createStatement().executeQuery(SQLcopy);
                p = null;
                p = con.prepareStatement(SQLinsert_detail);
                //doc_id,line_no,product_id,tank_suite,weight,weight_tank,weight_tot,silo_no,location_id,channel,remark
                while (rs.next()) {
                    p.setString(1, rs.getString("doc_id"));
                    p.setString(2, rs.getString("doc_date"));
                    p.setString(3, rs.getString("line_no"));
                    p.setString(4, rs.getString("product_id"));
                    p.setString(5, rs.getString("tank_suite"));
                    p.setString(6, rs.getString("weight"));
                    p.setString(7, rs.getString("weight_tank"));
                    p.setString(8, rs.getString("weight_tot"));
                    p.setString(9, rs.getString("silo_no"));
                    p.setString(10, rs.getString("location_id"));
                    p.setTimestamp(11, dataBean.getDate());
                    p.setString(12, dataBean.getBy());
                    p.setString(13, rs.getString("channel"));
                    p.setString(14, rs.getString("remark"));
                    p.setString(15, rs.getString("product_id"));
                    p.setString(16, rs.getString("silo_no"));
                    p.setString(17, rs.getString("location_id"));
                    p.setString(18, rs.getString("weight"));
                    p.setString(19, "Y");
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
