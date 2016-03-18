/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_carbon_withdraw_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Beckpalmx No7
 */
public class D_carbon_withdraw_detailDAO {

    private int Returnvalue;
    UtiDatabase uti = new UtiDatabase();

    public int insert(DataBeanD_carbon_withdraw_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_carbon_withdraw_detail (doc_id,line_no,pcat_id,size_use,grd_io_ctc,weight,machine,job_id,remark,create_date,create_by,bag,palate_no,product_id) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getPcat_id());
            p.setString(4, dataBean.getSize_use());
            p.setString(5, dataBean.getGrd_io_ctc());
            p.setString(6, dataBean.getWeight());
            p.setString(7, dataBean.getMachine());
            p.setString(8, dataBean.getJob_id());
            p.setString(9, dataBean.getRemark());
            p.setTimestamp(10, dataBean.getDate());
            p.setString(11, dataBean.getBy());
            p.setString(12, dataBean.getBag());
            p.setString(13, dataBean.getPalate_no());
            p.setString(14, dataBean.getProduct_id());
            
            String SqlCount = "Select Count(doc_id) As num from  d_carbon_withdraw_detail where doc_id = '" + dataBean.getDoc_id() + "' and delete_flag = 'N' and line_no = '" + dataBean.getLine_no() + "' ;";
            System.out.println("SqlCount = " + SqlCount);
            if (uti.numRowdatabase(SqlCount) == 0) {
                Returnvalue = p.executeUpdate();
                System.out.println("Returnvalue = " + Returnvalue);
            }
            
        } finally {
            //JOptionPane.showConfirmDialog(null, "test");
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_carbon_withdraw_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql
                = "update d_carbon_withdraw_detail set  pcat_id=?,size_use=?,grd_io_ctc=?,weight=?,machine=?,job_id=?,remark=?,update_date=?,bag=?,update_by=?,palate_no=?,product_id=? where doc_id=? and line_no=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            //p.setString(1, dataBean.getDoc_date());
            p.setString(1, dataBean.getPcat_id());
            p.setString(2, dataBean.getSize_use());
            p.setString(3, dataBean.getGrd_io_ctc());
            p.setString(4, dataBean.getWeight());
            p.setString(5, dataBean.getMachine());
            p.setString(6, dataBean.getJob_id());
            p.setString(7, dataBean.getRemark());
            p.setTimestamp(8, dataBean.getDate());
            p.setString(9, dataBean.getBag());
            p.setString(10, dataBean.getBy());
            p.setString(11, dataBean.getPalate_no());
            p.setString(12, dataBean.getProduct_id());
            p.setString(13, dataBean.getDoc_id());
            p.setString(14, dataBean.getLine_no());
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

    public DataBeanD_carbon_withdraw_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_carbon_withdraw_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        //JOptionPane.showConfirmDialog(null, "test");
        String SQL = "Select doc_id,doc_date,line_no,pcat_id,cat_name,size_use,grd_io_ctc,weight,machine,remark,vd_carbon_withdraw_detail.job_id,bag,(select vd_job_order_header.cust_name from vd_job_order_header where vd_job_order_header.doc_id = vd_carbon_withdraw_detail.job_id) as cust_name,palate_no,product_id  from vd_carbon_withdraw_detail where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setPcat_id(rs.getString("pcat_id"));
                bean.setCat_name(rs.getString("cat_name"));
                bean.setSize_use(rs.getString("size_use"));
                bean.setGrd_io_ctc(rs.getString("grd_io_ctc"));
                bean.setWeight(rs.getString("weight"));
                bean.setMachine(rs.getString("machine"));
                bean.setRemark(rs.getString("remark"));
                bean.setJob_id(rs.getString("job_id"));
                bean.setBag(rs.getString("bag"));
                bean.setCust_name(rs.getString("cust_name"));
                bean.setPalate_no(rs.getString("palate_no"));
                bean.setProduct_id(rs.getString("product_id"));
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
    //ทำการลบ Line_no ตามบรรทัดที่เลื่อกแล้วทำการ update ข

    public void DeleteLine_no(String inputarry, DataBeanD_carbon_withdraw_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        boolean rclose = false;
        boolean pclose = false;
        int count = 1;
        ResultSet rs;
        PreparedStatement p;
        String sql, sql2;
        try {
            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (String strarry1 : strarry) {
                    sql = "update d_carbon_withdraw_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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
                    sql2 = "Select line_no from  d_carbon_withdraw_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno ";
                    rs = con.createStatement().executeQuery(sql2);
                    while (rs.next()) {
                        sql = "update d_carbon_withdraw_detail set line_no=? where doc_id=? and line_no=?";
                        p = con.prepareStatement(sql);
                        p.setString(1, Integer.toString(count));
                        p.setString(2, bean.getDoc_id());
                        p.setString(3, rs.getString("line_no"));
                        p.executeUpdate();
                        count = count + 1;
                    }
                    rclose = true;
                }
            }
        } finally {
            try {
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }

    }

    public void Delete_line_no_All(DataBeanD_carbon_withdraw_detail dataBean) throws Exception {

        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_carbon_withdraw_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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

    }

    public String showDetail(String doc_id) throws Exception {
        ThaiUtil objth = new ThaiUtil();
        String SQL1, SQL, strOutput = "";
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";

        strOutput += "<tr>";
        strOutput += "<td class=\"row3\" width=\"3%\"><input type=\"checkbox\" name=\"chk_all\" id=\"chk_all\" value=\"chk_all\" onClick=\"javascript:ckall(this.checked);\"/></td>";
        strOutput += "<td class=\"row3\" width=\"7%\">ลำดับ&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">รหัสถ่าน</td>";
        strOutput += "<td class=\"row3\" width=\"5%\">ชนิดถ่าน&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">ขนาดถ่าน&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">เกรดไอโอดีน&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">กระสอบ&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">น้ำหนัก&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"10%\">เครื่องผลิต&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"20%\">ใบแจ้งผลิต&nbsp;</td>";
        strOutput += "</tr>";

        SQL1 = "Select Count(doc_id) As num from  d_carbon_withdraw_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' and complete_flag <> 'Y' ";
        int a = uti.numRowdatabase(SQL1);
        SQL = "Select doc_id,line_no,pcat_id,size_use,grd_io_ctc,weight,machine,job_id,palate_no,bag,product_id from vd_carbon_withdraw_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno";

        System.out.println("SQL1 = " + SQL1);
        System.out.println("SQL = " + SQL);
        DBConnect objcon = new DBConnect();
        try (Connection con = objcon.openNewConnection()) {
            ResultSet rs;
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                strOutput += "<tr>";
                strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
                strOutput += "<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,username','../SCREEN/CS_035.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\">" + rs.getString("line_no") + "</a></td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("product_id") + "&nbsp;</td>";
                strOutput += "<td class='forborder' width='5%'>" + rs.getString("pcat_id") + "&nbsp;</td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("size_use") + "&nbsp;</td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("grd_io_ctc") + "&nbsp;</td>";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("bag") + "&nbsp;</td>";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("weight") + "&nbsp;</td>";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("machine") + "&nbsp;</td>";
                strOutput += "<td class='forborder' width='20%'>" + rs.getString("job_id") + "&nbsp;</td>";
                strOutput += "</tr>";
            }
            rs.close();
        }
        strOutput += "</table>";
        return strOutput;
    }

    public ArrayList<DataBeanD_carbon_withdraw_detail> selectDataSearch(String id) throws Exception {
        DataBeanD_carbon_withdraw_detail carbonBean;
        ArrayList<DataBeanD_carbon_withdraw_detail> list = new ArrayList<>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from d_carbon_withdraw_detail where delete_flag <> 'Y' and complete_flag = 'N' and doc_id=? order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, id);
            rs = p.executeQuery();

            while (rs.next()) {
                carbonBean = new DataBeanD_carbon_withdraw_detail();
                carbonBean.setJob_id(rs.getString("job_id"));
                carbonBean.setSize_use(rs.getString("size_use"));
                carbonBean.setLocation_id(rs.getString("location_id"));
                carbonBean.setPcat_id(rs.getString("pcat_id"));
                carbonBean.setGrd_io_ctc(rs.getString("grd_io_ctc"));
                carbonBean.setBag(rs.getString("bag"));
                carbonBean.setWeight(rs.getString("weight"));
                carbonBean.setMachine(rs.getString("machine"));
                carbonBean.setProduct_id(rs.getString("product_id"));
                carbonBean.setWh_id(rs.getString("wh_id"));

                list.add(carbonBean);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return list;
    }
}
