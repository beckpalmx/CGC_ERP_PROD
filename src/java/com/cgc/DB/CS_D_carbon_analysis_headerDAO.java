/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import static com.cgc.DB.D_job_order_headerDAO.Return_Detail;
import com.cgc.bean.DataBeanCS_D_carbon_analysis_detail;
import com.cgc.bean.DataBeanCS_D_carbon_analysis_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import com.cgc.Util.SendMail;
import com.cgc.bean.DataBeanSendMail;
import com.cgc.Util.UtiDatabase;

/**
 *
 * @author Man
 */
public class CS_D_carbon_analysis_headerDAO {

    public int insert(DataBeanCS_D_carbon_analysis_header DataBean, ArrayList<DataBeanCS_D_carbon_analysis_detail> ObjAL_Detail) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        UtiDatabase objuti = new UtiDatabase();
        String Table_Header = "";
        String Table_detail = "";
        String SQL_Count, SQL_VH = "";
        PreparedStatement p = null;
        ResultSet rs = null;
        try {

            Table_Header = "d_carbon_analysis_all_header";
            Table_detail = "d_carbon_analysis_all_detail";

            int i = 1;

            p = con.prepareStatement("insert into " + Table_Header + "(doc_id,doc_date,job_type"
                    + ",lab_leader_id,create_by"
                    + ",create_date,update_date,quality_confirm,doc_type,send_doc_time,lab_emp_id) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?)");

            p.setString(i, DataBean.getDoc_id());
            i += 1;
            p.setString(i, DataBean.getDoc_date());
            i += 1;
            p.setString(i, DataBean.getJob_type());
            i += 1;
            p.setString(i, DataBean.getLab_leader_id());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getQuality_confirm());
            i += 1;
            p.setString(i, DataBean.getDoc_type());
            i += 1;
            p.setString(i, DataBean.getSend_doc_time());
            i += 1;
            p.setString(i, DataBean.getLab_emp_id());
            i += 1;            
            p.executeUpdate();
            p.clearParameters();

            p = con.prepareStatement("insert into " + Table_detail + "(doc_id,doc_date,line_no,bag_quatity,machine_id,job_id,param_header_id"
                    + ",product_id,product_no,h2o,butane,iod,remark"
                    + ",create_by,create_date,update_date,doc_type,job_type,h2o_header,butane_header,iod_header"
                    + ",psd_1_header,psd_2_header,psd_3_header,psd_4_header,psd_5_header,psd_6_header,psd_7_header,psd_8_header,psd_9_header"
                    + ",psd_10_header,psd_11_header,psd_12_header,psd_13_header,psd_14_header,psd_15_header,pass_header,n_pass_header,grade_header,remark_header,size_name"
                    + ") "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

            for (int count = 0; count < ObjAL_Detail.size(); count++) {
                i = 1;
                p.setString(i, DataBean.getDoc_id());
                i += 1;
                p.setString(i, DataBean.getDoc_date());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getLine_no());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getBag_quatity());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getMachine_id());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getJob_id());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getParam_header_id());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getProduct_id());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getProduct_no());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getH2o());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getButane());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getIod());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getRemark());
                i += 1;
                p.setString(i, DataBean.getBy());
                i += 1;
                p.setTimestamp(i, DataBean.getDate());
                i += 1;
                p.setTimestamp(i, DataBean.getDate());
                i += 1;
                p.setString(i, DataBean.getDoc_type());
                i += 1;
                p.setString(i, DataBean.getJob_type());
                i += 1;

                SQL_Count = "select count(doc_id) as num from d_header_analyze where doc_id = '" + ObjAL_Detail.get(count).getParam_header_id() + "' and delete_flag = 'N' ";

                if (objuti.numRowdatabase(SQL_Count) == 0) {

                    p.setString(i, "H2O (%)");
                    i += 1;
                    p.setString(i, "Butane (%)");
                    i += 1;
                    p.setString(i, "ไอโอดีน (mg/g)");
                    i += 1;

                    for (int x = 1; x <= 15; x = x + 1) {
                        p.setString(i, " ");
                        i += 1;
                    }

                    p.setString(i, "ผ่าน");
                    i += 1;
                    p.setString(i, "ไม่ผ่าน");
                    i += 1;
                    p.setString(i, "เกรด");
                    i += 1;
                    p.setString(i, "หมายเหตุ");
                    i += 1;

                    p.setString(i, ObjAL_Detail.get(count).getSize_name());
                    i += 1;
                    System.out.println("Size Name = " + ObjAL_Detail.get(count).getSize_name());

                } else {
                    SQL_VH = "select * from d_header_analyze where doc_id = '" + ObjAL_Detail.get(count).getParam_header_id() + "' and delete_flag = 'N' ";

                    System.out.println("SQL_VH : " + SQL_VH);

                    rs = con.createStatement().executeQuery(SQL_VH);
                    while (rs.next()) {
                        System.out.println(rs.getString("h2o"));
                        System.out.println(rs.getString("butane"));
                        System.out.println(rs.getString("iod"));

                        p.setString(i, rs.getString("h2o"));
                        i += 1;
                        p.setString(i, rs.getString("butane"));
                        i += 1;
                        p.setString(i, rs.getString("iod"));
                        i += 1;
                        p.setString(i, rs.getString("psd_1"));
                        i += 1;
                        p.setString(i, rs.getString("psd_2"));
                        i += 1;
                        p.setString(i, rs.getString("psd_3"));
                        i += 1;
                        p.setString(i, rs.getString("psd_4"));
                        i += 1;
                        p.setString(i, rs.getString("psd_5"));
                        i += 1;
                        p.setString(i, rs.getString("psd_6"));
                        i += 1;
                        p.setString(i, rs.getString("psd_7"));
                        i += 1;
                        p.setString(i, rs.getString("psd_8"));
                        i += 1;
                        p.setString(i, rs.getString("psd_9"));
                        i += 1;
                        p.setString(i, rs.getString("psd_10"));
                        i += 1;
                        p.setString(i, rs.getString("psd_11"));
                        i += 1;
                        p.setString(i, rs.getString("psd_12"));
                        i += 1;
                        p.setString(i, rs.getString("psd_13"));
                        i += 1;
                        p.setString(i, rs.getString("psd_14"));
                        i += 1;
                        p.setString(i, rs.getString("psd_15"));
                        i += 1;
                        p.setString(i, rs.getString("pass"));
                        i += 1;
                        p.setString(i, rs.getString("n_pass"));
                        i += 1;
                        p.setString(i, rs.getString("grade"));
                        i += 1;
                        p.setString(i, rs.getString("remark"));
                        i += 1;
                        p.setString(i, rs.getString("size_name"));
                        i += 1;

                        System.out.println("From Table Size Name = " + rs.getString("size_name"));
                    }
                }

                System.out.println("getMachine_id = " + ObjAL_Detail.get(count).getMachine_id());
                System.out.println("getProduct_id = " + ObjAL_Detail.get(count).getProduct_id());
                System.out.println("getProduct_no = " + ObjAL_Detail.get(count).getProduct_no());

                if ((ObjAL_Detail.get(count).getMachine_id().equals("") || ObjAL_Detail.get(count).getMachine_id() == null) && (ObjAL_Detail.get(count).getProduct_id().equals("") || ObjAL_Detail.get(count).getProduct_id() == null) && (ObjAL_Detail.get(count).getProduct_no().equals("") || ObjAL_Detail.get(count).getProduct_no() == null)) {
                    System.out.println("Not Insert Data If Empty Data ???");
                } else {
                    p.addBatch();
                }

            }

            System.out.println("p = " + p);

            p.executeBatch();

            p = null;

            //del_detail_empty(DataBean);
        } catch (Exception e) {
            e.printStackTrace(System.out);
            return 0;
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
            return 1;
        }
    }

    public int update(DataBeanCS_D_carbon_analysis_header DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        UtiDatabase objuti = new UtiDatabase();
        PreparedStatement p = null;
        int i = 1;
        try {
            p = con.prepareStatement("update d_carbon_analysis_all_header set lab_leader_id=?"
                    + ",update_by=?,update_date=?"
                    + ",quality_confirm=?,send_doc_time=?,lab_emp_id=?"
                    + "where doc_id = ? and delete_flag = 'N'");

            p.setString(i, DataBean.getLab_leader_id());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getQuality_confirm());
            i += 1;
            p.setString(i, DataBean.getSend_doc_time());
            i += 1;
            p.setString(i, DataBean.getLab_emp_id());
            i += 1;
            p.setString(i, DataBean.getDoc_id());
            i += 1;            
            
            p.executeUpdate();
            p = null;

            //Set Complete Flag To table Detail 
/*            
             String sql = "select count(doc_id) as num from d_carbon_analysis_all_detail where doc_id ='" + DataBean.getDoc_id() + "' and delete_flag <> 'Y' ";
             if (objuti.numRowdatabase(sql) != 0) {
             sql = "update d_carbon_analysis_all_detail set update_by=?,update_date=?,complete_flag='Y' where doc_id = ? and delete_flag <> 'Y' ";
             p = null;
             p = con.prepareStatement(sql);
             p.setString(1, DataBean.getBy());
             p.setTimestamp(2, DataBean.getDate());                
             p.setString(3, DataBean.getDoc_id());
             p.executeUpdate();
             }
             */
        } catch (Exception e) {
            e.printStackTrace(System.out);
            return 0;
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
            return 1;
        }
    }

    public int updel(DataBeanCS_D_carbon_analysis_header DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        try {
            for (int i = 1; i <= 2; i++) {
                p = con.prepareStatement("update " + (i == 1 ? "d_carbon_analysis_all_header" : "d_carbon_analysis_all_detail") + " set delete_flag=?,delete_by=?,delete_date=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'");
                p.setString(1, "Y");
                p.setString(2, DataBean.getBy());
                p.setTimestamp(3, DataBean.getDate());
                p.setString(4, DataBean.getDoc_id());
                p.executeUpdate();
                p.clearParameters();
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
            return 0;
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
            return 1;
        }
    }

    public int del_detail_empty(DataBeanCS_D_carbon_analysis_header DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        String SQL_Cond = "";

        //if  (DataBean.getDoc_id().equals("PT")) {
        SQL_Cond = "Delete from d_carbon_analysis_all_detail where doc_id = '" + DataBean.getDoc_id() + "'"
                + " and product_id = '' and machine_id = '' and product_no = '' ";
        //}

        System.out.println("Delete SQL_Cond = " + SQL_Cond);

        try {

            p = con.prepareStatement(SQL_Cond);
            p.executeUpdate();
            p.clearParameters();

        } catch (Exception e) {
            e.printStackTrace(System.out);
            return 0;
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
            return 1;
        }
    }

}
