/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_adjust_product_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Beckpalmx No7
 */
public class D_adjust_product_detailDAO {

    private int Returnvalue;
    UtiDatabase uti = new UtiDatabase();

    public int insert(DataBeanD_adjust_product_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        try (Connection con = objcon.openNewConnection()) {
            String sql = "insert into d_adjust_product_detail (doc_id,doc_type,doc_date,line_no,product_id,location_id,weight,create_date,create_by,wh_in) values(?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement p;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_id());
                p.setString(2, dataBean.getDoc_type());
                p.setString(3, dataBean.getDoc_date());
                p.setString(4, dataBean.getLine_no());
                p.setString(5, dataBean.getProduct_id());
                p.setString(6, dataBean.getLocation_id());
                p.setString(7, dataBean.getWeight());
                p.setTimestamp(8, dataBean.getDate());
                p.setString(9, dataBean.getBy());
                p.setString(10, dataBean.getWh_in());
                //Returnvalue = p.executeUpdate();

                String SqlCount = "Select Count(doc_id) As num from  d_adjust_product_detail where doc_id = '" + dataBean.getDoc_id() + "' and delete_flag = 'N' and line_no = '" + dataBean.getLine_no() + "' ;";
                System.out.println("SqlCount = " + SqlCount);
                if (uti.numRowdatabase(SqlCount) == 0) {
                    Returnvalue = p.executeUpdate();
                    Update_Detail_Data(dataBean.getDoc_id());
                    System.out.println("Returnvalue = " + Returnvalue);
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
        return Returnvalue;
    }

    public int update(DataBeanD_adjust_product_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        try (Connection con = dbConnect.openNewConnection()) {
            String sql
                    = "update d_adjust_product_detail set  product_id=?,location_id=?,weight=?,update_date=?,update_by=?,wh_in=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
            PreparedStatement p;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getProduct_id());
                p.setString(2, dataBean.getLocation_id());
                p.setString(3, dataBean.getWeight());
                p.setTimestamp(4, dataBean.getDate());
                p.setString(5, dataBean.getBy());
                p.setString(6, dataBean.getWh_in());
                p.setString(7, dataBean.getDoc_id());
                p.setString(8, dataBean.getLine_no());
                Returnvalue = p.executeUpdate();

                Update_Detail_Data(dataBean.getDoc_id());

            } finally {
                try {
                    //p.close();
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace(System.out);
                }

            }
        }
        return Returnvalue;

    }

    public DataBeanD_adjust_product_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_adjust_product_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        try (Connection con = dbConnect.openNewConnection()) {
            String SQL = "select d_adjust_product_detail.runno,d_adjust_product_detail.doc_id,d_adjust_product_detail.line_no,d_adjust_product_detail.product_id,d_adjust_product_detail.wh_in,"
                    + "(select vproduct.name_t from vproduct where vproduct.product_id = d_adjust_product_detail.product_id) as prod_name,"
                    + "(select vproduct.pgroup_name from vproduct where vproduct.product_id = d_adjust_product_detail.product_id) as pgroup_name,"
                    + "(select vproduct.pcat_name from vproduct where vproduct.product_id = d_adjust_product_detail.product_id) as  pcat_name,"
                    + "(select mwarehouse.name_t from mwarehouse where mwarehouse.warehouse_id = d_adjust_product_detail.wh_in) as warehouse_name,"
                    + "d_adjust_product_detail.location_id,d_adjust_product_detail.weight,"
                    + "d_adjust_product_detail.delete_flag,d_adjust_product_detail.cancel_flag,d_adjust_product_detail.complete_flag,d_adjust_product_detail.retro_flag,remark"
                    + " from d_adjust_product_detail  where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and delete_flag = 'N' ";
            //+ "and complete_flag = 'N' ";
            ResultSet rs = con.createStatement().executeQuery(SQL);
            try {
                while (rs.next()) {
                    bean.setDoc_id(rs.getString("doc_id"));
                    bean.setLine_no(rs.getString("line_no"));
                    bean.setProduct_id(rs.getString("product_id"));
                    bean.setProd_name(rs.getString("prod_name"));
                    bean.setPgroup_name(rs.getString("pgroup_name"));
                    bean.setPcat_name(rs.getString("pcat_name"));
                    bean.setLocation_id(rs.getString("location_id"));
                    bean.setWeight(rs.getString("weight"));
                    bean.setWh_in(rs.getString("wh_in"));
                    bean.setWh_out(rs.getString("warehouse_name"));
                    bean.setRemark(rs.getString("remark"));
                    System.out.println("Remark = " + rs.getString("remark"));
                }
            } finally {
                try {
                    rs.close();
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace(System.out);
                }
            }
        }
        return bean;
    }
    //ทำการลบ Line_no ตามบรรทัดที่เลื่อกแล้วทำการ update ข

    public void Delete_line_no(String Select_line_no, DataBeanD_adjust_product_detail DataBean, String Table_Detail) throws Exception {
        DBConnect objcon = new DBConnect();
        try (Connection con = objcon.openNewConnection()) {
            ResultSet rs = null;
            PreparedStatement p = null;
            int numrow;
            try {
                if (Select_line_no.length() != 0) {
                    //String[] Number_Line_no = Select_line_no.split(",");
                    System.out.println("Select_line_no = " + Select_line_no);
                    String SQL_Del = "Delete From " + Table_Detail + " Where doc_id = '" + DataBean.getDoc_id() + "' and line_no = '" + Select_line_no
                            + "' and complete_flag = 'N' and delete_flag = 'N'";
                    p = con.prepareStatement(SQL_Del);
                    p.executeUpdate();
                    p = null;

                    numrow = uti.numRowdatabase("Select count(doc_id) as num from " + Table_Detail + " where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'");
                    if (numrow != 0) {
                        rs = con.createStatement().executeQuery("SELECT * from " + Table_Detail + " where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N' order by runno ");
                        String SQL_Update_Line_NO;
                        int line_no = 1;
                        while (rs.next()) {
                            SQL_Update_Line_NO = " Update " + Table_Detail + " set line_no = '" + Integer.toString(line_no) + "' where runno = " + rs.getInt("runno");
                            p = con.prepareStatement(SQL_Update_Line_NO);
                            p.executeUpdate();
                            line_no++;
                        }
                    }
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

    public void DeleteLine_no(String inputarry, DataBeanD_adjust_product_detail bean) throws Exception {
        boolean ckclose = false;
        DBConnect dbConnect = new DBConnect();
        try (Connection con = dbConnect.openNewConnection()) {
            int count = 1;
            ResultSet rs;
            PreparedStatement p;
            String sql, sql2;
            try {
                if (inputarry.length() != 0) {
                    String[] strarry = inputarry.split(",");
                    for (String strarry1 : strarry) {
                        sql = "update d_adjust_product_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
                        p = con.prepareStatement(sql);
                        p.setString(1, "Y");
                        p.setTimestamp(2, bean.getDate());
                        p.setString(3, bean.getBy());
                        p.setString(4, bean.getDoc_id());
                        p.setString(5, strarry1);
                        p.executeUpdate();
                    }
                    if (strarry.length != -1) {
                        sql = "select count(doc_id) as num from d_adjust_product_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                        if (uti.numRowdatabase(sql) != 0) {
                            sql2 = "Select line_no from  d_adjust_product_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag ='N' order by runno ";
                            rs = con.createStatement().executeQuery(sql2);
                            while (rs.next()) {
                                sql = "update d_adjust_product_detail set line_no=? where doc_id=? and line_no=?";
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
                        //rs.close();
                        //p.close();
                        con.close();
                    }

                } catch (SQLException e) {
                    e.printStackTrace(System.out);
                }
            }
        }

    }

    public void Delete_line_no_All(DataBeanD_adjust_product_detail dataBean) throws Exception {

        DBConnect dbConnect = new DBConnect();
        try (Connection con = dbConnect.openNewConnection()) {
            String sqldetail = "update d_adjust_product_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
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
    }

    public String showDetail(String doc_id) throws Exception {
        ThaiUtil objth = new ThaiUtil();
        String SQL, SQL1, strOutput = "";
        SQL1 = "Select Count(doc_id) As num from  d_adjust_product_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag = 'N' and complete_flag ='N' ";
        int a = uti.numRowdatabase(SQL1);
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";
        SQL = "select d_adjust_product_detail.runno,d_adjust_product_detail.doc_id,d_adjust_product_detail.line_no,d_adjust_product_detail.product_id,d_adjust_product_detail.wh_in,"
                + "(select vproduct.name_t from vproduct where vproduct.product_id = d_adjust_product_detail.product_id) as prod_name,"
                + "(select vproduct.pgroup_name from vproduct where vproduct.product_id = d_adjust_product_detail.product_id) as pgroup_name,"
                + "(select mwarehouse.name_t from mwarehouse where mwarehouse.warehouse_id = d_adjust_product_detail.wh_in) as warehouse_name ,d_adjust_product_detail.location_id,d_adjust_product_detail.weight,"
                + "d_adjust_product_detail.delete_flag,d_adjust_product_detail.cancel_flag,d_adjust_product_detail.complete_flag,d_adjust_product_detail.retro_flag"
                + " from d_adjust_product_detail  where doc_id = '" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag = 'N' "
                //+ "and complete_flag = 'N' "
                + "order by runno";
        DBConnect objcon = new DBConnect();
        try (Connection con = objcon.openNewConnection()) {
            ResultSet rs;
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                strOutput += "<tr>";
                strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
                strOutput += "<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",username,doc_id','../SCREEN/CS_116.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</a></td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("product_id") + "</td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("prod_name") + "</td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("pgroup_name") + "</td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("warehouse_name") + "</td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("location_id") + "</td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("weight") + "</td>";
                strOutput += "</tr>";
            }
            rs.close();
        }
        strOutput += "</table>";
        return strOutput;
    }

    public void Update_Detail_Data(String doc_id) throws Exception {
        String sql;
        Double total_weight = 0.00;
        sql = " select sum(to_number(weight,'999999.99')) as total_weight from d_adjust_product_detail "
                + " where doc_id = '" + doc_id + "' and delete_flag = 'N' ";

        System.out.println("sql = " + sql);

        DBConnect objcon = new DBConnect();
        try (Connection con = objcon.openNewConnection()) {
            ResultSet rs;
            rs = con.createStatement().executeQuery(sql);
            while (rs.next()) {
                total_weight = rs.getDouble("total_weight");
            }

            System.out.println("doc_id = " + doc_id + " total_weight = " + total_weight);

            String sql_header = " update d_adjust_product_header set total_weight_adjust= " + total_weight
                    + " where doc_id=? and delete_flag = 'N' ";

            PreparedStatement p;

            p = con.prepareStatement(sql_header);
            p.setString(1, doc_id);
            p.executeUpdate();
        }
    }
}
