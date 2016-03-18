/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_qc_report_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Beckpalmx No7
 */
public class D_qc_report_detailDAO {
 private int Returnvalue;

    public int insert(DataBeanD_qc_report_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_qc_report_detail (doc_id,line_no,pkg_shift,pkg_code,weight,hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10,hd11,hd12,hd13,hd14,hd15,create_date,create_by) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getPkg_shift());
            p.setString(4, dataBean.getPkg_code());
            p.setString(5, dataBean.getWeight());
            p.setString(6, dataBean.getHd1());
            p.setString(7, dataBean.getHd2());
            p.setString(8, dataBean.getHd3());
            p.setString(9, dataBean.getHd4());
            p.setString(10, dataBean.getHd5());
            p.setString(11, dataBean.getHd6());
            p.setString(12, dataBean.getHd7());
            p.setString(13, dataBean.getHd8());
            p.setString(14, dataBean.getHd9());
            p.setString(15, dataBean.getHd10());
            p.setString(16, dataBean.getHd11());
            p.setString(17, dataBean.getHd12());
            p.setString(18, dataBean.getHd13());
            p.setString(19, dataBean.getHd14());
            p.setString(20, dataBean.getHd15());
            p.setTimestamp(21, dataBean.getDate());
            p.setString(22, dataBean.getBy());
            Returnvalue = p.executeUpdate();
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

    public int update(DataBeanD_qc_report_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql =
                "update d_qc_report_detail set  pkg_shift=?,pkg_code=?,weight=?,hd1=?,hd2=?,hd3=?,hd4=?,hd5=?,hd6=?,hd7=?,hd8=?,hd9=?,hd10=?,hd11=?,hd12=?,hd13=?,hd14=?,hd15=?,update_date=?,update_by=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getPkg_shift());
            p.setString(2, dataBean.getPkg_code());
            p.setString(3, dataBean.getWeight());
            p.setString(4, dataBean.getHd1());
            p.setString(5, dataBean.getHd2());
            p.setString(6, dataBean.getHd3());
            p.setString(7, dataBean.getHd4());
            p.setString(8, dataBean.getHd5());
            p.setString(9, dataBean.getHd6());
            p.setString(10, dataBean.getHd7());
            p.setString(11, dataBean.getHd8());
            p.setString(12, dataBean.getHd9());
            p.setString(13, dataBean.getHd10());
            p.setString(14, dataBean.getHd11());
            p.setString(15, dataBean.getHd12());
            p.setString(16, dataBean.getHd13());
            p.setString(17, dataBean.getHd14());
            p.setString(18, dataBean.getHd15());
            p.setTimestamp(19, dataBean.getDate());
            p.setString(20, dataBean.getBy());
            p.setString(21, dataBean.getDoc_id());
            p.setString(22, dataBean.getLine_no());
            Returnvalue = p.executeUpdate();

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

    public DataBeanD_qc_report_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_qc_report_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String SQL = "Select * from vd_qc_report_detail where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and complete_flag ='N'";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setPkg_shift(rs.getString("pkg_shift"));
                bean.setPkg_code(rs.getString("pkg_code"));
                bean.setWeight(rs.getString("weight"));
                bean.setHd1(rs.getString("hd1"));
                bean.setHd2(rs.getString("hd2"));
                bean.setHd3(rs.getString("hd3"));
                bean.setHd4(rs.getString("hd4"));
                bean.setHd5(rs.getString("hd5"));
                bean.setHd6(rs.getString("hd6"));
                bean.setHd7(rs.getString("hd7"));
                bean.setHd8(rs.getString("hd8"));
                bean.setHd9(rs.getString("hd9"));
                bean.setHd10(rs.getString("hd10"));
                bean.setHd11(rs.getString("hd11"));
                bean.setHd12(rs.getString("hd12"));
                bean.setHd13(rs.getString("hd13"));
                bean.setHd14(rs.getString("hd14"));
                bean.setHd15(rs.getString("hd15"));
            }
        } finally {
            try {
                rs.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return bean;
    }
    //ทำการลบ Line_no ตามบรรทัดที่เลื่อกแล้วทำการ update ข

    public void DeleteLine_no(String inputarry, DataBeanD_qc_report_detail bean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        boolean ckclose = false;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        int count = 1;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 = "";
        try {
            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (int i = 0; i < strarry.length; i++) {

                    sql = "update d_qc_report_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry[i]);
                    p.executeUpdate();
                }
                if (strarry.length != -1) {
                    sql = "select count(doc_id) as num from d_qc_report_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                    if (objuti.numRowdatabase(sql) != 0) {
                        p = null;
                        sql2 = "Select line_no from  d_qc_report_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag ='N' order by runno ";
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            sql = "update d_qc_report_detail set line_no=? where doc_id=? and line_no=?";
                            p = con.prepareStatement(sql);
                            p.setString(1, Integer.toString(count));
                            p.setString(2, bean.getDoc_id());
                            p.setString(3, rs.getString("line_no"));
                            p.executeUpdate();
                            count = count + 1;
                        }

                        ckclose = true;
                    }
                }
            }
        } finally {
            try {
                if (ckclose) {
                    rs.close();
                    p.close();
                    con.close();
                }

            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }

    }

    public void Delete_line_no_All(DataBeanD_qc_report_detail dataBean) throws Exception {

        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_qc_report_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {

            p = con.prepareStatement(sqldetail);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
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

    public String showDetail(String doc_id) throws Exception {
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL, SQL1, strOutput = "";
        SQL1 = "Select Count(doc_id) As num from  d_qc_report_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag = 'N' and complete_flag ='N' ";
        int a = objuti.numRowdatabase(SQL1);
        //JOptionPane.showConfirmDialog(null, objuti.numRowdatabase(SQL1));
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";
        SQL = "Select runno,doc_id,line_no,pkg_shift,pkg_code,weight,hd1,hd2,hd3,hd4,hd5,hd6  from vd_qc_report_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "'and delete_flag = 'N' and complete_flag = 'N' order by runno";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        rs = con.createStatement().executeQuery(SQL);
        while (rs.next()) {
            strOutput += "<tr>";
            strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
            strOutput += "<td class='forborder' width='5%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10,hc11,hc12,hc13,hc14,hc15,username','../SCREEN/CS_113.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</a></td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("pkg_shift") + "</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("pkg_code") + "</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("weight") + "</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("hd1") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("hd2") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("hd3") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("hd4") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("hd5") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("hd6") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='13%'>&nbsp;More...&nbsp;</td>";
            strOutput += "</tr>";
        }
        rs.close();
        con.close();
        strOutput += "</table>";
        return strOutput;
    }
    public String ReturnStringPass(String inputvalue) {
        String stroutput = "";
        if (inputvalue.equals("Y")) {
            stroutput = "ผ่าน";
        } else {
            stroutput = "ไม่ผ่าน";
        }
        return stroutput;
    }
}
