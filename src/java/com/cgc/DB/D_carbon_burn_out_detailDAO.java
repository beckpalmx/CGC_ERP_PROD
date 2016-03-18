/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.bean.DataBeanD_carbon_burn_out_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.cgc.Util.UtiDatabase;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Beckpalmx No7
 */
public class D_carbon_burn_out_detailDAO {

    private int Returnvalue;
    UtiDatabase uti = new UtiDatabase();

    public int insert(DataBeanD_carbon_burn_out_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_carbon_burn_out_detail (doc_id,line_no,wh_in,wh_out,doc_date,production_no,size,g_code,g_sum,ctc_i2,bag,weight,lost,remark,create_date,create_by) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getWh_in());
            p.setString(4, dataBean.getWh_out());
            p.setString(5, dataBean.getDoc_date());
            p.setString(6, dataBean.getProduction_no());
            p.setString(7, dataBean.getSize());
            p.setString(8, dataBean.getG_code());
            p.setString(9, dataBean.getG_sum());
            p.setString(10, dataBean.getCtc_i2());
            p.setString(11, dataBean.getBag());
            p.setString(12, dataBean.getWeight());
            p.setString(13, dataBean.getLost());
            p.setString(14, dataBean.getRemark());
            p.setTimestamp(15, dataBean.getDate());
            p.setString(16, dataBean.getBy());                       
            
            String SqlCount = "Select Count(doc_id) As num from  d_carbon_burn_out_detail where doc_id = '" + dataBean.getDoc_id() + "' and delete_flag = 'N' and line_no = '" + dataBean.getLine_no() + "' ;";
            System.out.println("SqlCount = " + SqlCount);
            if (uti.numRowdatabase(SqlCount) == 0) {
                Returnvalue = p.executeUpdate();
                System.out.println("Returnvalue = " + Returnvalue);
            }                        
            
        } finally {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_carbon_burn_out_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql
                = "update d_carbon_burn_out_detail set  wh_in=?,wh_out=?,doc_date=?,production_no=?,size=?,g_code=?,g_sum=?,ctc_i2=?,bag=?,weight=?,lost=?,remark=?,update_date=?,update_by=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getWh_in());
            p.setString(2, dataBean.getWh_out());
            p.setString(3, dataBean.getDoc_date());
            p.setString(4, dataBean.getProduction_no());
            p.setString(5, dataBean.getSize());
            p.setString(6, dataBean.getG_code());
            p.setString(7, dataBean.getG_sum());
            p.setString(8, dataBean.getCtc_i2());
            p.setString(9, dataBean.getBag());
            p.setString(10, dataBean.getWeight());
            p.setString(11, dataBean.getLost());
            p.setString(12, dataBean.getRemark());
            p.setTimestamp(13, dataBean.getDate());
            p.setString(14, dataBean.getBy());
            p.setString(15, dataBean.getDoc_id());
            p.setString(16, dataBean.getLine_no());
            Returnvalue = p.executeUpdate();

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

    public DataBeanD_carbon_burn_out_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_carbon_burn_out_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String SQL = "Select * from d_carbon_burn_out_detail where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and delete_flag = 'N' and complete_flag = 'N'";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setWh_in(rs.getString("wh_in"));
                bean.setWh_out(rs.getString("wh_out"));
                bean.setProduction_no(rs.getString("production_no"));
                bean.setSize(rs.getString("size"));
                bean.setG_code(rs.getString("g_code"));
                bean.setG_sum(rs.getString("g_sum"));
                bean.setCtc_i2(rs.getString("ctc_i2"));
                bean.setBag(rs.getString("bag"));
                bean.setWeight(rs.getString("weight"));
                bean.setLost(rs.getString("lost"));
                bean.setRemark(rs.getString("remark"));
            }
        } finally {
            try {
                rs.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return bean;
    }
    //ทำการลบ Line_no ตามบรรทัดที่เลื่อกแล้วทำการ update 

    public String DeleteLine_no(String inputarry, DataBeanD_carbon_burn_out_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        boolean ckclose = false;
        boolean pclose = false;
        String strTotal = "0,0";
        int count = 1;
        int total = 0;
        int total2 = 0;
        ResultSet rs;
        PreparedStatement p;
        String sql, sql2;
        try {

            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (String strarry1 : strarry) {
                    //JOptionPane.showConfirmDialog(null,strarry[i]);
                    sql = "update d_carbon_burn_out_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry1);
                    p.executeUpdate();
                }
                pclose = true;
                if (strarry.length != -1) {
                    sql = "select count(doc_id) as num from d_carbon_burn_out_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                    if (uti.numRowdatabase(sql) != 0) {
                        sql2 = "Select line_no from  d_carbon_burn_out_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N' order by runno ";
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            sql = "update d_carbon_burn_out_detail set line_no=? where doc_id=? and line_no=?";
                            p = con.prepareStatement(sql);
                            p.setString(1, Integer.toString(count));
                            p.setString(2, bean.getDoc_id());
                            p.setString(3, rs.getString("line_no"));
                            p.executeUpdate();
                            count = count + 1;
                        }
                        sql2 = "select weight,lost from d_carbon_burn_out_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N' order by runno ";
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            total = total + Integer.parseInt(rs.getString("weight"));
                            total2 = total2 + Integer.parseInt(rs.getString("lost"));
                        }
                        strTotal = Integer.toString(total) + "," + Integer.toString(total2);
                    }
                    ckclose = true;
                }

            } else {
                strTotal = "-1";
            }

        } finally {
            try {
                if (ckclose) {
                    //rs.close();
                }
                if (pclose) {
                    //p.close();
                    con.close();
                }

            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        //JOptionPane.showConfirmDialog(null, total);
        return strTotal;

    }

    public String Delete_line_no_All(DataBeanD_carbon_burn_out_detail dataBean) throws Exception {
        String strTotal = "0,0";
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_carbon_burn_out_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p;
        try {

            p = con.prepareStatement(sqldetail);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
            p.executeUpdate();

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return strTotal;
    }

    public String showDetail(String doc_id) throws Exception {
        String strOutput = "";
        ThaiUtil objth = new ThaiUtil();
        String SQL1, SQL;
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>\n";

        strOutput += "<tr>";
        strOutput += "<td class=\"row3\" width=\"3px\"><input type=\"checkbox\" name=\"chk_all\"  id=\"chk_all\" value=\"chk_all\" onClick=\"javascript:ckall(this.checked);\"/></td>";
        strOutput += "<td class=\"row3\" width=\"7%\">ลำดับที่&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">รหัส&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">ขนาด&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">รหัสยกมา&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">ยอดยกมา&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">I2&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">หน่วยบรรจุ&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">น้ำหนัก&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">หมายเหตุ&nbsp;</td>";
        strOutput += "</tr>";

        SQL1 = "Select Count(doc_id) As num from  d_carbon_burn_out_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' ";
        int a = uti.numRowdatabase(SQL1);
        SQL = "Select doc_id,line_no,production_no,size,g_code,g_sum,ctc_i2,bag,weight,remark from d_carbon_burn_out_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' and complete_flag ='N' order by line_no";
        DBConnect objcon = new DBConnect();
        try (Connection con = objcon.openNewConnection()) {
            ResultSet rs;
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                strOutput += "<tr>\n";
                strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>\n";
                strOutput += "<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,total_weight,lost_weight,username','../SCREEN/CS_030.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\">" + rs.getString("line_no") + "</a></td>\n";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("production_no") + "&nbsp;</td>\n";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("size") + "&nbsp;</td>\n";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("g_code") + "&nbsp;</td>\n";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("g_sum") + "&nbsp;</td>\n";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("ctc_i2") + "&nbsp;</td>\n";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("bag") + "&nbsp;</td>\n";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("weight") + "&nbsp;</td>\n";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("remark") + "&nbsp;</td>\n";
                strOutput += "</tr>\n";
            }
            rs.close();
        }

        strOutput += "</table>\n";
        //JOptionPane.showConfirmDialog(null, "test");
        return strOutput;
    }

    public String showDetail_031(String doc_id) throws Exception {
        String wh_en = "";
        //String wh_en_name = "";
        String strOutput = "";
        String location_id = "";
        String product_id = "";
        ThaiUtil objth = new ThaiUtil();
        String SQL1, SQL;
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";
        SQL1 = "Select Count(doc_id) As num from  d_carbon_burn_out_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' ";
        int a = uti.numRowdatabase(SQL1);
        SQL = "Select doc_id,line_no,production_no,product_id,location_id,size,g_code,g_sum,ctc_i2,bag,weight,remark,wh_id from d_carbon_burn_out_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' and complete_flag ='N' order by line_no";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs;
        rs = con.createStatement().executeQuery(SQL);
        while (rs.next()) {
            strOutput += "<tr>";
            strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox_" + rs.getString("line_no") + "' name='ckbox' value='" + rs.getString("line_no") + "'></td>";
            strOutput += "<td class='forborder' width='7%'>" + rs.getString("line_no") + "</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("production_no") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("size") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("g_sum") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='7%'>" + rs.getString("ctc_i2") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("bag") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("weight") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'><input type='text' name='wh_id_" + rs.getString("line_no") + "' id='wh_id_" + rs.getString("line_no") + "' value='" + NotNull(rs.getString("wh_id")) + "' size=7 readonly><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('mwarehouse&textinput=" + "wh_id_" + rs.getString("line_no") + "', 48, 'Search_Detail.jsp')\"></a></td>";
            strOutput += "<td class='forborder' width='10%'><input type='text' id='location_id_" + rs.getString("line_no") + "' name='location_id_" + rs.getString("line_no") + "' value = '" + NotNull(rs.getString("location_id")) + "' size=8></td>";
            strOutput += "<td class='forborder' width='15%'><input type='text' id='product_id_" + rs.getString("line_no") + "' name='product_id_" + rs.getString("line_no") + "' value = '" + NotNull(rs.getString("product_id")) + "' size=8 readonly><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=" + "product_id_" + rs.getString("line_no") + "', 31, 'Search_Detail.jsp')\"></a></td>";
            strOutput += "</tr>";
        }
        strOutput += "</table>";

        return strOutput;
    }

    public int UpdateDetail_031(ArrayList<DataBeanD_carbon_burn_out_detail> arrayobj) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_carbon_burn_out_detail set  wh_id=?,location_id=?,product_id=?,update_date=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p;
        try {
            for (DataBeanD_carbon_burn_out_detail objloop : arrayobj) {
                p = con.prepareStatement(sql);
                p.setString(1, objloop.getWh_id());
                p.setString(2, objloop.getLocation_id());
                p.setString(3, objloop.getProduct_id());
                p.setTimestamp(4, objloop.getDate());
                p.setString(5, objloop.getDoc_id());
                p.setString(6, objloop.getLine_no());
                Returnvalue = p.executeUpdate();

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

    public String NotNull(String input_str) {
        if (input_str == null) {
            input_str = "";
        }
        return input_str;
    }
}
