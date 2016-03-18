/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanD_job_order_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.cgc.Util.UtiDatabase;
import java.sql.ResultSet;
import com.cgc.Util.ThaiUtil;

/**
 *
 * @author Beckpalmx No7
 */
public class D_job_order_detailDAO {

    private int Returnvalue;

    public int insert(DataBeanD_job_order_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_job_order_detail (doc_id,line_no,param,method,spec,add_desc,create_date,create_by) values(?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getParam());
            p.setString(4, dataBean.getMethod());
            p.setString(5, dataBean.getSpec());
            p.setString(6, dataBean.getAdd_desc());
            p.setTimestamp(7, dataBean.getDate());
            p.setString(8, dataBean.getBy());
            Returnvalue = p.executeUpdate();
            //ArrayBean.size();

        } finally {
            //JOptionPane.showConfirmDialog(null, "test");
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_job_order_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql
                = "update d_job_order_detail set  param=?,method=?,spec=?,add_desc=?,update_date=?,update_by=? where doc_id=? and line_no=?  and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getParam());
            p.setString(2, dataBean.getMethod());
            p.setString(3, dataBean.getSpec());
            p.setString(4, dataBean.getAdd_desc());
            p.setTimestamp(5, dataBean.getDate());
            p.setString(6, dataBean.getBy());
            p.setString(7, dataBean.getDoc_id());
            p.setString(8, dataBean.getLine_no());
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

    public DataBeanD_job_order_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_job_order_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String SQL = "Select doc_id,line_no,param,method,add_desc,spec from vd_job_order_detail where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setParam(rs.getString("param"));
                bean.setMethod(rs.getString("method"));
                bean.setAdd_desc(rs.getString("add_desc"));
                bean.setSpec(rs.getString("spec"));
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

    public void DeleteLine_no(String inputarry, DataBeanD_job_order_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        UtiDatabase objuti = new UtiDatabase();
        Connection con = dbConnect.openNewConnection();
        int count = 15;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 = "";
        boolean ckp = false;
        boolean ckr = false;
        try {

            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (int i = 0; i < strarry.length; i++) {
                    sql = "update d_job_order_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=?";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry[i]);
                    p.executeUpdate();
                    ckp = true;
                }

                if (strarry.length != -1) {
                    sql = "select count(doc_id) as num from d_job_order_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                    if (objuti.numRowdatabase(sql) != 0) {
                        p = null;
                        sql2 = "Select line_no from  d_job_order_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno ";
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            if (Integer.parseInt(rs.getString("line_no")) > 14) {
                                sql = "update d_job_order_detail set line_no=? where doc_id=? and line_no=?";
                                p = con.prepareStatement(sql);
                                p.setString(1, Integer.toString(count));
                                p.setString(2, bean.getDoc_id());
                                p.setString(3, rs.getString("line_no"));
                                p.executeUpdate();
                                count = count + 1;
                            }
                        }
                        ckr = true;
                    }
                }

            }

        } finally {
            try {
                if (ckr) {
                    rs.close();
                }
                if (ckp) {
                    p.close();
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        //JOptionPane.showConfirmDialog(null, total);

    }

    public void Delete_line_no_All(DataBeanD_job_order_detail dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        ResultSet rs = null;
        String sql, sql2 = "";
        boolean ckp = false;
        boolean ckr = false;
        PreparedStatement p = null;
        try {
            sql = "select count(doc_id) as num from d_job_order_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
            if (objuti.numRowdatabase(sql) != 0) {
                p = null;
                sql2 = "Select * from  d_job_order_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno ";
                rs = con.createStatement().executeQuery(sql2);
                while (rs.next()) {
                    if (Integer.parseInt(rs.getString("line_no")) > 14) {
                        sql = "update d_job_order_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=?";
                        p = con.prepareStatement(sql);
                        p.setString(1, "Y");
                        p.setTimestamp(2, dataBean.getDate());
                        p.setString(3, dataBean.getBy());
                        p.setString(4, dataBean.getDoc_id());
                        p.setString(5, rs.getString("line_no"));
                        p.executeUpdate();
                        ckp = true;
                    } else {
                        ckr = true;
                    }
                }
            }

        } finally {
            try {
                if (ckr) {
                    rs.close();
                }
                if (ckp) {
                    p.close();
                }

                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }

    }

    public String showDetail(String doc_id) throws Exception {
        int i = 1;
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL1, SQL;
        StringBuffer strOutput = new StringBuffer();

        strOutput.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>");
        strOutput.append("<tr>");
        //strOutput.append("<td class='row3' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"3px\" style='font-weight: bold'><input type=\"checkbox\" name=\"chk_all\" id=\"chk_all\" value=\"chk_all\" onClick=\"javascript:ckall(this.checked);\"/></td>");
        strOutput.append("<td class=\"row3\" width=\"7%\" style='font-weight: bold'>ลำดับ&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"25%\" style='font-weight: bold'>Parameter&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"25%\" style='font-weight: bold'>Test Method&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"20%\" style='font-weight: bold'>Specification&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"20%\" style='font-weight: bold'>เพิ่มเติม&nbsp;</td>");
        strOutput.append("</tr>");

        System.out.println(strOutput);

        //SQL1 = "Select Count(doc_id) As num from  d_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' and complete_flag <> 'Y' ";
        SQL1 = "Select Count(doc_id) As num from  d_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y'  ";
        int a = objuti.numRowdatabase(SQL1);
        if (a != 0) {
            //SQL = "Select doc_id,line_no,param,method,spec,add_desc from vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and to_number(line_no,'99') >14 and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno";
            SQL = "Select doc_id,line_no,param,method,spec,add_desc from vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and to_number(line_no,'99') >14 and delete_flag <> 'Y' order by runno";
            DBConnect objcon = new DBConnect();
            Connection con = objcon.openNewConnection();
            ResultSet rs = null;
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                //if (Integer.parseInt(rs.getString("line_no")) > 14) {
                strOutput.append("<tr>");
                strOutput.append("<td class=\"forborder\" width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>");
                strOutput.append("<td class=\"forborder\" width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,username','../SCREEN/CS_033.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\">" + rs.getString("line_no") + "</a></td>");
                strOutput.append("<td class=\"forborder\" width='25%' style='font-weight: bold'>" + rs.getString("param") + "&nbsp;</td>");
                strOutput.append("<td class=\"forborder\" width='25%' style='font-weight: bold'>" + rs.getString("method") + "&nbsp;</td>");
                strOutput.append("<td class=\"forborder\" width='20%' style='font-weight: bold'>" + rs.getString("spec") + "&nbsp;</td>");
                strOutput.append("<td class=\"forborder\" width='20%' style='font-weight: bold'>" + rs.getString("add_desc") + "&nbsp;</td>"); 
                strOutput.append("</tr>");
                //}
            }
            rs.close();
            con.close();
            strOutput.append("</table>");
            return strOutput.toString();
        } else {
            strOutput.append("</table>");
            return strOutput.toString();
        }
    }

    public String showDetail2(String doc_id) throws Exception {
        int i = 1;
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL1, SQL;
        StringBuffer strOutput = new StringBuffer();

        strOutput.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>");
        strOutput.append("<tr>");
        strOutput.append("<td class='row3' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
        //strOutput.append("<td class=\"row3\" width=\"3px\"><input type=\"checkbox\" name=\"chk_all\" id=\"chk_all\" value=\"chk_all\" onClick=\"javascript:ckall(this.checked);\"/></td>");            
        strOutput.append("<td class=\"row3\" width=\"7%\" style='font-weight: bold'>ลำดับ&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"25%\" style='font-weight: bold'>Parameter&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"25%\" style='font-weight: bold'>Test Method&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"20%\" style='font-weight: bold'>Specification&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"20%\" style='font-weight: bold'>เพิ่มเติม&nbsp;</td>");
        strOutput.append("</tr>");

        System.out.println("strOutput = " + strOutput);

        //SQL1 = "Select Count(doc_id) As num from  d_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and to_number(line_no,'99') >14 and delete_flag <> 'Y' and complete_flag <> 'Y' ";
        SQL1 = "Select Count(doc_id) As num from  d_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and to_number(line_no,'99') >14 and delete_flag <> 'Y'  ";
        int a = objuti.numRowdatabase(SQL1);
        if (a != 0) {
            //SQL = "Select doc_id,line_no,param,method,spec,add_desc from vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and to_number(line_no,'99') >14 and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno";
            SQL = "Select doc_id,line_no,param,method,spec,add_desc from vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and to_number(line_no,'99') >14 and delete_flag <> 'Y'  order by runno";
            DBConnect objcon = new DBConnect();
            Connection con = objcon.openNewConnection();
            ResultSet rs = null;
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                strOutput.append("<tr>");
                strOutput.append("<td class='forborder' width='3px'>&nbsp;</td>");
                strOutput.append("<td class='forborder' width='7%' style='font-weight: bold'>" + rs.getString("line_no") + "&nbsp;</td>");
                strOutput.append("<td class='forborder' width='25%' style='font-weight: bold'>" + rs.getString("param") + "&nbsp;</td>");
                strOutput.append("<td class='forborder' width='25%' style='font-weight: bold'>" + rs.getString("method") + "&nbsp;</td>");
                strOutput.append("<td class='forborder' width='20%' style='font-weight: bold'>" + rs.getString("spec") + "&nbsp;</td>");
                strOutput.append("<td class='forborder' width='20%' style='font-weight: bold'>" + rs.getString("add_desc") + "&nbsp;</td>");                   
                strOutput.append("</tr>");
            }
            rs.close();
            con.close();
            strOutput.append("</table>");
            return strOutput.toString();
        } else {
            return "";
        }
    }
}
