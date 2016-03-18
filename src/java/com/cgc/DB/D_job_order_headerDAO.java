/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.bean.DataBeanD_job_order_header;
import com.cgc.bean.DataBeanD_job_order_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.sql.ResultSet;
import com.cgc.Util.UtiDatabase;
import com.cgc.Util.SendMail;
import com.cgc.bean.DataBeanSendMail;
import java.sql.SQLException;
//import com.cgc.Util.SendMultipartMail;

/**
 *
 * @author Beckpalmx No7
 */
public class D_job_order_headerDAO {

    private int Returnvalue, count;

    public int insert(DataBeanD_job_order_header dataBean, ArrayList<DataBeanD_job_order_detail> ArrayBean) throws Exception {
        Returnvalue = 0;
        count = 0;
        String size_name = "";
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        /* Check For job doc main*/
        String sDoc_id = dataBean.getDoc_id();
        String ValidChars = "0123456789/";
        String job_doc_main;
        int x;
        boolean IsNumber = true;
        char Char;

        for (x = 0; x < sDoc_id.length() && IsNumber == true; x++) {
            Char = sDoc_id.charAt(x);
            if (ValidChars.indexOf(Char) == -1) {
                IsNumber = false;
                System.out.println("false --> ");
                break;
            }
        }

        System.out.println("Result  = " + IsNumber);

        if (IsNumber == true) {
            System.out.println("2 Result --> " + IsNumber);
            job_doc_main = "Y";
        } else {
            System.out.println("2 Result --> " + IsNumber);
            job_doc_main = "N";
        }

        /* Check For job doc main*/
        String sql = "insert into d_job_order_header "
                + "(doc_id,doc_date,cust_id,po_no,contain_date,iso_no,country_id,lot_no,mark_sign,base_plate,base_plate_desc,base_plate_qty,detail,approve,mark_sign_desc,create_date,update_date,create_by,quality_dep,prod_dep,wh_dep,sale_confirm,quality_confirm,prod_confirm,wh_confirm,i2,deadline,stock_prod,complete_flag,job_doc_main) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getCompany_id());
            p.setString(4, dataBean.getPo_no());
            p.setString(5, dataBean.getContain_date());
            p.setString(6, dataBean.getIso_no());
            p.setString(7, dataBean.getCountry_id());
            p.setString(8, dataBean.getLot_no());
            p.setString(9, dataBean.getMark_sign());
            p.setString(10, dataBean.getBase_plate());
            p.setString(11, dataBean.getBase_plate_desc());
            p.setString(12, dataBean.getBase_plate_qty());
            p.setString(13, objuti.EncodeNewLine(dataBean.getRemark()));
            p.setString(14, dataBean.getApprove());
            p.setString(15, dataBean.getMark_sign_desc());
            p.setTimestamp(16, dataBean.getDate());
            p.setTimestamp(17, dataBean.getDate());
            p.setString(18, dataBean.getBy());
            p.setString(19, dataBean.getQuality_dep());
            p.setString(20, dataBean.getProd_dep());
            p.setString(21, dataBean.getWh_dep());
            p.setString(22, dataBean.getSale_confirm());
            p.setString(23, dataBean.getQuality_confirm());
            p.setString(24, dataBean.getProd_confirm());
            p.setString(25, dataBean.getWh_confirm());
            p.setString(26, dataBean.getI2());
            p.setString(27, dataBean.getDeadline());
            p.setString(28, dataBean.getStock_prod());
            p.setString(29, dataBean.getClose_job_status());
            p.setString(30, job_doc_main);
            Returnvalue = p.executeUpdate();

            String sql2 = "insert into d_job_order_detail (doc_id,line_no,param,method,spec,add_desc) values(?,?,?,?,?,?)";
            p = con.prepareStatement(sql2);
            while (count < ArrayBean.size()) {
                //JOptionPane.showConfirmDialog(null,ArrayBean.get(count).getParam());
                p.setString(1, dataBean.getDoc_id());
                p.setString(2, ArrayBean.get(count).getLine_no());
                p.setString(3, ArrayBean.get(count).getParam());
                p.setString(4, ArrayBean.get(count).getMethod());
                p.setString(5, ArrayBean.get(count).getSpec());

                if (count == 0) {
                    size_name = ArrayBean.get(count).getSpec();
                    System.out.println("Count = " + count + " - " + size_name);
                }

                p.setString(6, ArrayBean.get(count).getAdd_desc());
                p.addBatch();
                count++;
            }
            p.executeBatch();
            sql = "update d_job_order_detail set doc_date=?,create_date=?,create_by=? where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'";
            p.clearBatch();
            p.clearParameters();
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
            p.executeUpdate();

            // สร้าง Header Analyze สำหรับการวิเคราะห์ถ่าน
            String sql_header_analyze = "insert into d_header_analyze (doc_id,job_id,create_date,create_by,h2o,butane,iod,pass,n_pass,grade,remark,doc_type,cust_id,size_name,psd_1,psd_2,psd_3,psd_4,psd_5,psd_6) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            p = con.prepareStatement(sql_header_analyze);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_id());
            p.setTimestamp(3, dataBean.getDate());
            p.setString(4, dataBean.getBy());
            p.setString(5, "H2O (%)");
            p.setString(6, "Butane (%)");
            p.setString(7, "ไอโอดีน (mg/g)");
            p.setString(8, "ผ่าน");
            p.setString(9, "ไม่ผ่าน");
            p.setString(10, "เกรด");
            p.setString(11, "หมายเหตุ");
            p.setString(12, "1");
            p.setString(13, dataBean.getCompany_id());
            p.setString(14, size_name);
            p.setString(15, "");
            p.setString(16, "");
            p.setString(17, "");
            p.setString(18, "");
            p.setString(19, "");
            p.setString(20, "");

            Returnvalue = p.executeUpdate();
            if (Returnvalue == 1) {
                send_email(dataBean, con, ArrayBean);
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

    public int update(DataBeanD_job_order_header dataBean, ArrayList<DataBeanD_job_order_detail> ArrayBean) throws Exception {
        Returnvalue = 0;
        count = 0;
        String size_name = "";
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        UtiDatabase objuti = new UtiDatabase();
        String sql
                = "update d_job_order_header set  doc_date=?,cust_id=?,po_no=?,contain_date=?,iso_no=?,country_id=?,lot_no=?,mark_sign=?,base_plate=?,base_plate_desc=?,base_plate_qty=?,detail=?,approve=?,mark_sign_desc=?,update_date=?,update_by=?,quality_dep=?,prod_dep=?,wh_dep=?,sale_confirm=?,quality_confirm=?,prod_confirm=?,wh_confirm=?,i2=?,deadline=?,stock_prod=?,complete_flag=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getCompany_id());
            p.setString(3, dataBean.getPo_no());
            p.setString(4, dataBean.getContain_date());
            p.setString(5, dataBean.getIso_no());
            p.setString(6, dataBean.getCountry_id());
            p.setString(7, dataBean.getLot_no());
            p.setString(8, dataBean.getMark_sign());
            p.setString(9, dataBean.getBase_plate());
            p.setString(10, dataBean.getBase_plate_desc());
            p.setString(11, dataBean.getBase_plate_qty());
            p.setString(12, objuti.EncodeNewLine(dataBean.getRemark()));
            p.setString(13, dataBean.getApprove());
            p.setString(14, dataBean.getMark_sign_desc());
            p.setTimestamp(15, dataBean.getDate());
            p.setString(16, dataBean.getBy());
            p.setString(17, dataBean.getQuality_dep());
            p.setString(18, dataBean.getProd_dep());
            p.setString(19, dataBean.getWh_dep());
            p.setString(20, dataBean.getSale_confirm());
            p.setString(21, dataBean.getQuality_confirm());
            p.setString(22, dataBean.getProd_confirm());
            p.setString(23, dataBean.getWh_confirm());
            p.setString(24, dataBean.getI2());
            p.setString(25, dataBean.getDeadline());
            p.setString(26, dataBean.getStock_prod());
            p.setString(27, dataBean.getClose_job_status());
            p.setString(28, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();

            String sql2 = "update  d_job_order_detail  set "
                    + "param=?,method=?,spec=?,add_desc=? "
                    + "where doc_id = ? and line_no =? and delete_flag = 'N' and complete_flag = 'N'";
            p = con.prepareStatement(sql2);
            while (count < ArrayBean.size()) {
                p.setString(1, ArrayBean.get(count).getParam());
                p.setString(2, ArrayBean.get(count).getMethod());
                p.setString(3, ArrayBean.get(count).getSpec());

                if (count == 0) {
                    size_name = ArrayBean.get(count).getSpec();
                    System.out.println("Count = " + count + " - " + size_name);
                }

                p.setString(4, ArrayBean.get(count).getAdd_desc());
                p.setString(5, dataBean.getDoc_id());
                p.setString(6, ArrayBean.get(count).getLine_no());
                p.addBatch();
                count++;
            }
            p.executeBatch();
            p.clearBatch();
            sql = "update d_job_order_detail set doc_date=?,update_date=?,update_by=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getClose_job_status());
            p.setString(5, dataBean.getDoc_id());
            p.executeUpdate();

            // ปรับปรุง Header Analyze สำหรับการวิเคราะห์ถ่าน
            String sql_header_analyze = "update d_header_analyze set cust_id=?,size_name=?,update_date=?,update_by=? where doc_id = ? and delete_flag <> 'Y'";
            p = con.prepareStatement(sql_header_analyze);
            p.setString(1, dataBean.getCompany_id());
            p.setString(2, size_name);
            p.setTimestamp(3, dataBean.getDate());
            p.setString(4, dataBean.getBy());
            p.setString(5, dataBean.getDoc_id());
            p.executeUpdate();

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

    public int update_confirm(DataBeanD_job_order_header dataBean) throws Exception {
        Returnvalue = 0;
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p;
        String SQL;
        try {
            SQL = "update d_job_order_header SET "
                    + "approve=?,quality_dep=?,prod_dep=?,wh_dep=?,sale_confirm=?,quality_confirm=?,prod_confirm=?,wh_confirm=?,update_by=?,update_date=?,stock_prod=? "
                    + "WHERE doc_id = ? and delete_flag = 'N' and complete_flag = 'N'";
            p = con.prepareStatement(SQL);
            p.setString(1, dataBean.getApprove());
            p.setString(2, dataBean.getQuality_dep());
            p.setString(3, dataBean.getProd_dep());
            p.setString(4, dataBean.getWh_dep());
            p.setString(5, dataBean.getSale_confirm());
            p.setString(6, dataBean.getQuality_confirm());
            p.setString(7, dataBean.getProd_confirm());
            p.setString(8, dataBean.getWh_confirm());
            p.setString(9, dataBean.getBy());
            p.setTimestamp(10, dataBean.getDate());
            p.setString(11, dataBean.getStock_prod());
            p.setString(12, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
        }
        return Returnvalue;
    }

    public void UpDel(DataBeanD_job_order_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_job_order_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_job_order_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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

            // ปรับปรุง Header Analyze สำหรับการวิเคราะห์ถ่าน
            String sql_header_analyze = "update d_header_analyze set delete_flag=?,delete_date=?,delete_by=? where doc_id = ? and delete_flag <> 'Y'";
            p = con.prepareStatement(sql_header_analyze);
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
        //JOptionPane.showConfirmDialog(null, "test");
        int i = 1;
        int loopstr = 0;
        String[] strInputtxt = new String[]{"ชนิด/ขนาด", "จำนวน(ตัน)", "รหัสสินค้า(CGC)", "การบรรจุ(กระสอบ)", "น้ำหนักบรรจุ", "Butane", "CTC", "I2", "Methvlene Blue", "Moisture Content", "Ash", "pH", "Bulk Density", "Hardness"};
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL1, SQL;
        StringBuffer strOutput = new StringBuffer();
        strOutput.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>");

        strOutput.append("<tr>");
        strOutput.append("<td class=\"headergrid\" colspan=\"17\">ข้อมูลการผลิต</td>");
        strOutput.append("</tr>");

        strOutput.append("<tr>");
        strOutput.append("<td class='row3' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"7%\">ลำดับ&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"25%\">Parameter&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"25%\">Test Method&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"20%\">Specification&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"20%\">เพิ่มเติม&nbsp;</td>");
        strOutput.append("</tr>");

        System.out.println(strOutput);

        SQL1 = "Select Count(doc_id) As num from  vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y'  ";
        int a = objuti.numRowdatabase(SQL1);
        if (a != 0) {
            SQL = "Select doc_id,line_no,param,method,spec,add_desc from vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and to_number(line_no,'99') <=14 and delete_flag <> 'Y' order by runno";
            DBConnect objcon = new DBConnect();
            try (Connection con = objcon.openNewConnection()) {
                ResultSet rs;
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    strOutput.append("<tr>");
                    strOutput.append("<td class='forborder' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                    strOutput.append("<td class='forborder' width='7%'>" + rs.getString("line_no") + "</td>");//<a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,username','../SCREEN/CS_033.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\">" + rs.getString("line_no") + "</a>
                    strOutput.append("<td class='forborder' width='25%'><input name='param" + rs.getString("line_no") + "' class='inputs' type='text' class='inputs' id='param" + rs.getString("line_no") + "' value='" + rs.getString("param") + "' size=20 readonly='readonly'/></td>");
                    strOutput.append("<td class='forborder' width='25%'><input name='method" + rs.getString("line_no") + "' class='inputs' type='text' class='inputs' id='method" + rs.getString("line_no") + "' value='" + rs.getString("method") + "' size=20 /></td>");
                    strOutput.append("<td class='forborder' width='20%'><input name='spec" + rs.getString("line_no") + "' class='inputs' type='text' class='inputs' id='spec" + rs.getString("line_no") + "' value='" + rs.getString("spec") + "' size=20  " + (rs.getString("line_no").equals("1") ? "onclick=\"openBrWindow('m_carbon_size&textinput=spec1', 32, 'Search_Detail.jsp')\" readonly" : "") + "/></td>");
                    strOutput.append("<td class='forborder' width='20%'><input name='add_desc" + rs.getString("line_no") + "' class='inputs' type='text' class='inputs' id='add_desc" + rs.getString("line_no") + "' value='" + rs.getString("add_desc") + "' size=20  /></td>");
                    strOutput.append("</tr>");
                    i++;
                }
                rs.close();
            }
            strOutput.append("</table>");
        } else {

            strOutput.append("<tr>");
            strOutput.append("<td class=\"headergrid\" colspan=\"17\">ข้อมูลการผลิต</td>");
            strOutput.append("</tr>");

            strOutput.append("<tr>");
            strOutput.append("<td class='row3' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
            strOutput.append("<td class=\"row3\" width=\"7%\">ลำดับ&nbsp;</td>");
            strOutput.append("<td class=\"row3\" width=\"25%\">Parameter&nbsp;</td>");
            strOutput.append("<td class=\"row3\" width=\"25%\">Test Method&nbsp;</td>");
            strOutput.append("<td class=\"row3\" width=\"20%\">Specification&nbsp;</td>");
            strOutput.append("<td class=\"row3\" width=\"20%\">เพิ่มเติม&nbsp;</td>");
            strOutput.append("</tr>");

            while (i <= 14) {
                strOutput.append("<tr>");
                strOutput.append("<td class='forborder' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                strOutput.append("<td class='forborder' width='7%'>&nbsp;&nbsp;" + Integer.toString(i) + "&nbsp;&nbsp;</td>");
                strOutput.append("<td class='forborder' width='25%'><input name='param" + Integer.toString(i) + "' class='inputs' type='text' id='param" + Integer.toString(i) + "' value='" + strInputtxt[loopstr] + "' size=20 readonly='readonly' /></td>");
                strOutput.append("<td class='forborder' width='25%'><input name='method" + Integer.toString(i) + "' class='inputs' type='text' id='method" + Integer.toString(i) + "' value='' size=20  /></td>");
                strOutput.append("<td class='forborder' width='20%'><input name='spec" + Integer.toString(i) + "' class='inputs' type='text' id='spec" + Integer.toString(i) + "' value='' size=20  /></td>");
                strOutput.append("<td class='forborder' width='20%'><input name='add_desc" + Integer.toString(i) + "' class='inputs' type='text' id='add_desc" + Integer.toString(i) + "' value='' size=20 /></td>");
                strOutput.append("</tr>");
                i++;
                loopstr++;
            }
            strOutput.append("</table>");
        }
        return strOutput.toString();
    }

    public String showDetail2(String doc_id) throws Exception {
        //JOptionPane.showConfirmDialog(null, "test");
        int i = 1;
        int loopstr = 0;
        String[] strInputtxt = new String[]{"ชนิด/ขนาด", "จำนวน(ตัน)", "รหัสสินค้า(CGC)", "การบรรจุ(กระสอบ)", "น้ำหนักบรรจุ", "Butane", "CTC", "I2", "Methvlene Blue", "Moisture Content", "Ash", "pH", "Bulk Density", "Hardness"};
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL1, SQL;
        StringBuilder strOutput = new StringBuilder();
        strOutput.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>");
        strOutput.append("<tr>");
        strOutput.append("<td class=\"headergrid\" colspan=\"17\">ข้อมูลการผลิต</td>");
        strOutput.append("</tr>");
        strOutput.append("<tr>");
        strOutput.append("<td class='row3' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"7%\">ลำดับ&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"25%\">Parameter&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"25%\">Test Method&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"20%\">Specification&nbsp;</td>");
        strOutput.append("<td class=\"row3\" width=\"20%\">เพิ่มเติม&nbsp;</td>");
        strOutput.append("</tr>");

        SQL1 = "Select Count(doc_id) As num from  vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' ";
        int a = objuti.numRowdatabase(SQL1);
        if (a != 0) {
            SQL = "Select doc_id,line_no,param,method,spec,add_desc from vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and to_number(line_no,'999') <=14 and delete_flag <> 'Y'  order by runno";
            DBConnect objcon = new DBConnect();
            try (Connection con = objcon.openNewConnection()) {
                ResultSet rs;
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    strOutput.append("<tr>");
                    strOutput.append("<td class='forborder' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                    strOutput.append("<td class='forborder' width='7%'>" + rs.getString("line_no") + "</td>");
                    strOutput.append("<td class='forborder' width='25%'><input name='param" + rs.getString("line_no") + "' class='inputs' type='text' id='param" + rs.getString("line_no") + "' value='" + rs.getString("param") + "' size=20 readonly='readonly' /></td>");
                    strOutput.append("<td class='forborder' width='25%'><input name='method" + rs.getString("line_no") + "' class='inputs' type='text' id='method" + rs.getString("line_no") + "' value='" + rs.getString("method") + "' size=20 readonly='readonly' /></td>");
                    strOutput.append("<td class='forborder' width='20%'><input name='spec" + rs.getString("line_no") + "' class='inputs' type='text' id='spec" + rs.getString("line_no") + "' value='" + rs.getString("spec") + "' size=20 readonly='readonly' /></td>");
                    strOutput.append("<td class='forborder' width='20%'><input name='add_desc" + rs.getString("line_no") + "' class='inputs' type='text' id='add_desc" + rs.getString("line_no") + "' value='" + rs.getString("add_desc") + "' size=20 readonly='readonly' /></td>");
                    strOutput.append("</tr>");
                    //}

                }
                rs.close();
            }
            strOutput.append("</table>");
        } else {
            strOutput.append("<tr>");
            strOutput.append("<td class=\"headergrid\" colspan=\"17\">ข้อมูลการผลิต</td>");
            strOutput.append("</tr>");
            strOutput.append("<tr>");
            strOutput.append("<td class='row3' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
            strOutput.append("<td class=\"row3\" width=\"7%\">ลำดับ&nbsp;</td>");
            strOutput.append("<td class=\"row3\" width=\"25%\">Parameter&nbsp;</td>");
            strOutput.append("<td class=\"row3\" width=\"25%\">Test Method&nbsp;</td>");
            strOutput.append("<td class=\"row3\" width=\"20%\">Specification&nbsp;</td>");
            strOutput.append("<td class=\"row3\" width=\"20%\">เพิ่มเติม&nbsp;</td>");
            strOutput.append("</tr>");

            while (i <= 14) {
                strOutput.append("<tr>");
                strOutput.append("<td class='forborder' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                strOutput.append("<td class='forborder' width='7%'>&nbsp;&nbsp;" + Integer.toString(i) + "&nbsp;&nbsp;</td>");
                strOutput.append("<td class='forborder' width='25%'><input name='param" + Integer.toString(i) + "' class='inputs' type='text' id='param" + Integer.toString(i) + "' value='" + strInputtxt[loopstr] + "' size=20 readonly='readonly' /></td>");
                strOutput.append("<td class='forborder' width='25%'><input name='method" + Integer.toString(i) + "' class='inputs' type='text' id='method" + Integer.toString(i) + "' value='' size=20  /></td>");
                strOutput.append("<td class='forborder' width='20%'><input name='spec" + Integer.toString(i) + "' class='inputs' type='text' id='spec" + Integer.toString(i) + "' value='' size=20  /></td>");
                strOutput.append("<td class='forborder' width='20%'><input name='add_desc" + Integer.toString(i) + "' class='inputs' type='text' id='add_desc" + Integer.toString(i) + "' value='' size=20 /></td>");
                strOutput.append("</tr>");
                i++;
                loopstr++;
            }
            strOutput.append("</table>");
        }
        return strOutput.toString();

    }

    public void Chack_SaleorderProduct(String befor_doc_id, String after_doc_id, Connection con, PreparedStatement p) throws Exception {
        String SQL;
        try {
            if (new UtiDatabase().numRowdatabase("select count(doc_id) as num "
                    + "from d_summary_product_master "
                    + "where doc_id ='" + befor_doc_id + "' and delete_flag = 'N' and complete_flag = 'N' and doc_type = 'Y'") != 0) {
                for (int i = 0; i <= 1; i++) {
                    SQL = "update d_summary_product_master set doc_type = '" + (i == 0 ? "N" : "Y") + "' where doc_id = " + (i == 0 ? "'" + befor_doc_id + "'" : "'" + after_doc_id + "'") + " and delete_flag = 'N' and complete_flag = 'N'";
                    p = con.prepareCall(SQL);
                    p.executeUpdate();
                    p.clearParameters();
                }
            } else {
                SQL = "update d_summary_product_master set doc_type ='Y'where doc_id  = '" + after_doc_id + "' and delete_flag = 'N' and complete_flag = 'N'";
                p = con.prepareCall(SQL);
                p.executeUpdate();
                p.clearParameters();
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.clearParameters();
            }
        }
    }

    public void Close_Job_Order(DataBeanD_job_order_header dataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p;
        try {
            p = con.prepareStatement("UPDATE d_job_order_header SET "
                    + "close_job_type=?,remark_close_job_order=?,complete_flag=?,update_by=?,update_date=? "
                    + "WHERE doc_id=? AND delete_flag ='N' AND complete_flag ='N' ");
            p.setString(1, dataBean.getDoc_type());
            p.setString(2, dataBean.getRemark());
            p.setString(3, dataBean.getApprove());
            p.setString(4, dataBean.getBy());
            p.setTimestamp(5, dataBean.getDate());
            p.setString(6, dataBean.getDoc_id());
            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (con != null) {
                con.close();
            }
        }
    }

    public static String Return_Detail(DataBeanD_job_order_header beanheader, ArrayList<DataBeanD_job_order_detail> array_deatil) {
        StringBuilder return_str = new StringBuilder();
        try {
            return_str.append("รหัสเอกสาร : ").append(beanheader.getDoc_id()).append("<br>");
            return_str.append("ชื่อลูกค้า : ").append(beanheader.getCust_id_desc()).append("<br>");
            for (int i = 0; i < array_deatil.size(); i++) {
                return_str.append(array_deatil.get(i).getParam()).append(" : ").append(array_deatil.get(i).getMethod()).append(" : ").append(array_deatil.get(i).getSpec()).append(" : ").append(array_deatil.get(i).getAdd_desc()).append("<br>");
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            System.out.println("OK");
        }
        return return_str.toString();
    }

    public void send_email(DataBeanD_job_order_header dataBean, Connection con, ArrayList<DataBeanD_job_order_detail> ArrayBean) throws Exception {

        DataBeanSendMail dataBeansendmail = new SendMail(con, dataBean.getScreen_id()).Return_DataBeanSendMail();
        if (!dataBeansendmail.getEmail_from().equals("") && !dataBeansendmail.getEmail_to().equals("")
                && !dataBeansendmail.getEmail_server().equals("") && !dataBeansendmail.getEmail_port().equals("")) {

            String subject = "CGC ERP System : มีเอกสารมาใหม่ ใบแจ้งการผลิต เลขที่ : " + dataBean.getDoc_id() + " วันที่ : " + dataBean.getDoc_date();
            String message = "CGC ERP System : ใบแจ้งการผลิต เลขที่ : " + dataBean.getDoc_id() + " วันที่ : " + dataBean.getDoc_date();

            message = message + "<br>" + Return_Detail(dataBean, ArrayBean);
            message = message + "<br>";
            message = message + "<br>" + "-------------------------------------------------------------------------------------------------";
            message = message + "<br>" + "เพื่อความถูกต้องสมบูรณ์ โปรดตรวจสอบเอกสารใบแจ้งการผลิตในระบบ และเอกสารตัวจริง";
            
            String[] array_to = dataBeansendmail.getEmail_to().split(";");
            for (String array_to1 : array_to) {
                SendMail sendMail = new SendMail(dataBeansendmail.getEmail_from(), array_to1, subject, message);
                sendMail.send(dataBeansendmail.getEmail_server(), dataBeansendmail.getEmail_port());
                System.out.println(array_to1);
                System.out.println(subject);
                System.out.println(sendMail);
            }

        }
    }

}
