/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanD_carbon_out_analysis_detail;
import com.cgc.bean.DataBeanD_carbon_out_analysis_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Man
 */
public class D_carbon_out_analysis_headerDAO {

    public int insert(DataBeanD_carbon_out_analysis_header DataBean, ArrayList<DataBeanD_carbon_out_analysis_detail> ObjAL_Detail) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        try {
            p = con.prepareStatement("insert into d_carbon_out_analysis_header(doc_id,doc_date,c_type,tdate1,tname1,ttime1,tdate2,tname2,ttime2,tdate3,tname3,ttime3,reporter_id,approve_id,approve_status,create_by,create_date,update_date) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            p.setString(i, DataBean.getDoc_id());
            i += 1;
            p.setString(2, DataBean.getDoc_date());
            i += 1;
            p.setString(3, DataBean.getTdate1());
            i += 1;
            p.setString(4, DataBean.getTdate1());
            i += 1;
            p.setString(5, DataBean.getTname1());
            i += 1;
            p.setString(6, DataBean.getTtime1());
            i += 1;
            p.setString(7, DataBean.getTdate2());
            i += 1;
            p.setString(8, DataBean.getTname2());
            i += 1;
            p.setString(9, DataBean.getTtime2());
            i += 1;
            p.setString(10, DataBean.getTdate3());
            i += 1;
            p.setString(11, DataBean.getTname3());
            i += 1;
            p.setString(12, DataBean.getTtime3());
            i += 1;
            p.setString(13, DataBean.getReporter_id());
            i += 1;
            p.setString(14, DataBean.getApprove_id());
            i += 1;
            p.setString(15, DataBean.getApprove_status());
            i += 1;
            p.setString(16, DataBean.getBy());
            i += 1;
            p.setTimestamp(17, DataBean.getDate());
            i += 1;
            p.setTimestamp(18, DataBean.getDate());
            i += 1;
            p.executeUpdate();

            p.clearParameters();
            p = con.prepareStatement("insert into d_carbon_out_analysis_detail(doc_id,line_no,c_type1,c_type2,c_type3,bu1,bu2,bu3,avg1,avg2,avg3,create_by,create_date,update_date,doc_date) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            for (int count = 0; count < ObjAL_Detail.size(); count++) {
                i = 1;
                p.setString(i, DataBean.getDoc_id());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getLine_no());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getC_type1());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getC_type2());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getC_type3());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getBu1());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getBu2());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getBu3());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getAvg1());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getAvg2());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getAvg3());
                i += 1;
                p.setString(i, DataBean.getBy());
                i += 1;
                p.setTimestamp(i, DataBean.getDate());
                i += 1;
                p.setTimestamp(i, DataBean.getDate());
                i += 1;
                p.setString(i, DataBean.getDoc_date());
                i += 1;
                p.addBatch();
            }
            p.executeBatch();
            p = null;
            Avg_carbon_out_analysis(con, p, DataBean.getDoc_id());

        } catch (Exception e) {
            e.printStackTrace(System.out);
            return 0;
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
        return 1;
    }

    public int update_new(DataBeanD_carbon_out_analysis_header DataBean, ArrayList<DataBeanD_carbon_out_analysis_detail> ObjAL_Detail) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        try {
            p = con.prepareStatement("update d_carbon_out_analysis_header set doc_date=?,c_type=?,tdate1=?,tdate2=?,tdate3=?,tname1=?,tname2=?,tname3=?,ttime1=?,ttime2=?,ttime3=?,reporter_id=?,approve_id=?,approve_status=?,update_by=?,update_date=? where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'");
            p.setString(i, DataBean.getDoc_date());
            i += 1;
            p.setString(i, DataBean.getC_type());
            i += 1;
            p.setString(i, DataBean.getTdate1());
            i += 1;
            p.setString(i, DataBean.getTdate2());
            i += 1;
            p.setString(i, DataBean.getTdate3());
            i += 1;
            p.setString(i, DataBean.getTname1());
            i += 1;
            p.setString(i, DataBean.getTname2());
            i += 1;
            p.setString(i, DataBean.getTname3());
            i += 1;
            p.setString(i, DataBean.getTtime1());
            i += 1;
            p.setString(i, DataBean.getTtime2());
            i += 1;
            p.setString(i, DataBean.getTtime3());
            i += 1;
            p.setString(i, DataBean.getReporter_id());
            i += 1;
            p.setString(i, DataBean.getApprove_id());
            i += 1;
            p.setString(i, DataBean.getApprove_status());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getDoc_id());
            i += 1;
            p.executeUpdate();

            p.clearParameters();
            p = con.prepareStatement("update d_carbon_out_analysis_detail set "
                    + "c_type1=?,c_type2=?,c_type3=?,bu1=?,bu2=?,bu3=?,avg1=?,avg2=?,avg3=?,update_by=?,update_date=?,doc_date=?"
                    + " where doc_id=? and line_no=?");

            for (int count = 0; count < ObjAL_Detail.size(); count++) {
                i = 1;
                p.setString(i, ObjAL_Detail.get(count).getC_type1());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getC_type2());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getC_type3());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getBu1());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getBu2());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getBu3());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getAvg1());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getAvg2());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getAvg3());
                i += 1;
                p.setString(i, DataBean.getBy());
                i += 1;
                p.setTimestamp(i, DataBean.getDate());
                i += 1;
                p.setString(i, DataBean.getDoc_date());
                i += 1;
                p.setString(i, DataBean.getDoc_id());
                i += 1;
                p.setString(i, ObjAL_Detail.get(count).getLine_no());
                i += 1;
                p.addBatch();
            }
            p.executeBatch();
            p = null;

            Avg_carbon_out_analysis(con, p, DataBean.getDoc_id());

        } catch (Exception e) {
            e.printStackTrace(System.out);
            return 0;
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
        return 1;
    }

    public int update(DataBeanD_carbon_out_analysis_header DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        try {
            p = con.prepareStatement("update d_carbon_out_analysis_header set doc_date=?,c_type=?,tdate1=?,tdate2=?,tdate3=?,tname1=?,tname2=?,tname3=?,ttime1=?,ttime2=?,ttime3=?,reporter_id=?,approve_id=?,approve_status=?,update_by=?,update_date=? where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'");
            p.setString(i, DataBean.getDoc_date());
            i += 1;
            p.setString(i, DataBean.getC_type());
            i += 1;
            p.setString(i, DataBean.getTdate1());
            i += 1;
            p.setString(i, DataBean.getTdate2());
            i += 1;
            p.setString(i, DataBean.getTdate3());
            i += 1;
            p.setString(i, DataBean.getTname1());
            i += 1;
            p.setString(i, DataBean.getTname2());
            i += 1;
            p.setString(i, DataBean.getTname3());
            i += 1;
            p.setString(i, DataBean.getTtime1());
            i += 1;
            p.setString(i, DataBean.getTtime2());
            i += 1;
            p.setString(i, DataBean.getTtime3());
            i += 1;
            p.setString(i, DataBean.getReporter_id());
            i += 1;
            p.setString(i, DataBean.getApprove_id());
            i += 1;
            p.setString(i, DataBean.getApprove_status());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getDoc_id());
            i += 1;
            p.executeUpdate();
            p = null;
            Avg_carbon_out_analysis(con, p, DataBean.getDoc_id());
        } catch (Exception e) {
            e.printStackTrace(System.out);
            return 0;
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
        return 1;
    }

    public int updel(DataBeanD_carbon_out_analysis_header DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        try {
            for (int i = 1; i <= 2; i++) {
                p = con.prepareStatement("update " + (i == 1 ? "d_carbon_out_analysis_header" : "d_carbon_out_analysis_detail") + " set delete_flag=?,delete_by=?,delete_date=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'");
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

    public void Avg_carbon_out_analysis(Connection con, PreparedStatement p, String doc_id) throws Exception {
        String[] return_value = new String[6];
        String SQL = "select "
                + "(select trim(to_char(avg(to_number(bu1,'999990.00')),'999990.00')) as avg_bu1_1_12 from d_carbon_out_analysis_detail where doc_id = '" + doc_id + "' and delete_flag = 'N' and to_number(line_no,'90') between 1 and 12 and to_number(bu1,'999990.00') > 0) as avg_bu1_1_12,"
                + "(select trim(to_char(avg(to_number(bu1,'999990.00')),'999990.00')) as avg_bu1_13_24 from d_carbon_out_analysis_detail where doc_id = '" + doc_id + "' and delete_flag = 'N' and to_number(line_no,'90') between 13 and 24 and to_number(bu1,'999990.00') > 0) as avg_bu1_13_24,"
                + "(select trim(to_char(avg(to_number(bu2,'999990.00')),'999990.00')) as avg_bu2_1_12 from d_carbon_out_analysis_detail where doc_id = '" + doc_id + "' and delete_flag = 'N' and to_number(line_no,'90') between 1 and 12 and to_number(bu2,'999990.00') > 0) as avg_bu2_1_12,"
                + "(select trim(to_char(avg(to_number(bu2,'999990.00')),'999990.00')) as avg_bu2_13_24 from d_carbon_out_analysis_detail where doc_id = '" + doc_id + "' and delete_flag = 'N' and to_number(line_no,'90') between 13 and 24 and to_number(bu2,'999990.00') > 0) as avg_bu2_13_24,"
                + "(select trim(to_char(avg(to_number(bu3,'999990.00')),'999990.00')) as avg_bu3_1_12 from d_carbon_out_analysis_detail where doc_id = '" + doc_id + "' and delete_flag = 'N' and to_number(line_no,'90') between 1 and 12 and to_number(bu3,'999990.00') > 0) as avg_bu3_1_12,"
                + "(select trim(to_char(avg(to_number(bu3,'999990.00')),'999990.00')) as avg_bu3_13_24 from d_carbon_out_analysis_detail where doc_id = '" + doc_id + "' and delete_flag = 'N' and to_number(line_no,'90') between 13 and 24 and to_number(bu3,'999990.00') > 0) as avg_bu3_13_24 "
                + "from d_carbon_out_analysis_detail where doc_id = '" + doc_id + "' and delete_flag = 'N' group by avg_bu1_1_12,avg_bu1_13_24,avg_bu2_1_12,avg_bu2_13_24,avg_bu3_1_12,avg_bu3_13_24 ";
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                return_value[0] = (rs.getString("avg_bu1_1_12") == null) ? "0" : rs.getString("avg_bu1_1_12");
                return_value[1] = (rs.getString("avg_bu1_13_24") == null) ? "0" : rs.getString("avg_bu1_13_24");
                return_value[2] = (rs.getString("avg_bu2_1_12") == null) ? "0" : rs.getString("avg_bu2_1_12");
                return_value[3] = (rs.getString("avg_bu2_13_24") == null) ? "0" : rs.getString("avg_bu2_13_24");
                return_value[4] = (rs.getString("avg_bu3_1_12") == null) ? "0" : rs.getString("avg_bu3_1_12");
                return_value[5] = (rs.getString("avg_bu3_13_24") == null) ? "0" : rs.getString("avg_bu3_13_24");
                System.out.println("1 = " + return_value[0]);
                System.out.println("2 = " + return_value[1]);
                System.out.println("3 = " + return_value[2]);
                System.out.println("4 = " + return_value[3]);
                System.out.println("5 = " + return_value[4]);
                System.out.println("6 = " + return_value[5]);
            }
            SQL = "update d_carbon_out_analysis_header set "
                    + "ba_avg11=" + return_value[0] + ","
                    + "ba_avg12=" + return_value[1] + ","
                    + "ba_avg21=" + return_value[2] + ","
                    + "ba_avg22=" + return_value[3] + ","
                    + "ba_avg31=" + return_value[4] + ","
                    + "ba_avg32=" + return_value[5] + ""
                    + " where doc_id = '" + doc_id + "' and delete_flag = 'N'";
            p = con.prepareStatement(SQL);
            //System.out.println("P1 " + SQL);
            p.executeUpdate();
            p.clearParameters();
            for (int i = 0; i < return_value.length; i++) {

                if (i == 0) {
                    SQL = "update d_carbon_out_analysis_detail set avg1=" + return_value[i] + " where doc_id = '" + doc_id + "' and delete_flag = 'N' and line_no = '1'";
                } else if (i == 1) {
                    SQL = "update d_carbon_out_analysis_detail set avg1=" + return_value[i] + " where doc_id = '" + doc_id + "' and delete_flag = 'N' and line_no = '13'";
                } else if (i == 2) {
                    SQL = "update d_carbon_out_analysis_detail set avg2=" + return_value[i] + " where doc_id = '" + doc_id + "' and delete_flag = 'N' and line_no = '1'";
                } else if (i == 3) {
                    SQL = "update d_carbon_out_analysis_detail set avg2=" + return_value[i] + " where doc_id = '" + doc_id + "' and delete_flag = 'N' and line_no = '13'";
                } else if (i == 4) {
                    SQL = "update d_carbon_out_analysis_detail set avg3=" + return_value[i] + " where doc_id = '" + doc_id + "' and delete_flag = 'N' and line_no = '1'";
                } else if (i == 5) {
                    SQL = "update d_carbon_out_analysis_detail set avg3=" + return_value[i] + " where doc_id = '" + doc_id + "' and delete_flag = 'N' and line_no = '13'";
                }

                /*SQL = "update d_carbon_out_analysis_detail set "
                 + ((i == 0 || i == 1) ? "avg1=" + return_value[i] : "avg2=" + return_value[i])
                 + " where doc_id = '" + doc_id + "' and delete_flag = 'N' and line_no = '"
                 + ((i == 0 || i == 2) ? "1" : "13") + "'"; */
                p = con.prepareStatement(SQL);
                //System.out.println("P2 " + i + "return value = " + return_value.length + "= " + SQL);
                p.executeUpdate();
                p.clearParameters();
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (p != null) {
                p = null;
            }
            //return return_value;
        }
    }

    public void Avg_carbon_out_analysis2(Connection con, PreparedStatement p, String doc_id) throws Exception {
        try {
        } catch (Exception e) {
        } finally {
        }
    }
}
