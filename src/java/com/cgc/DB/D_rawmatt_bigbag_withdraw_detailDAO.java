package com.cgc.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.cgc.bean.DataBeanD_rawmatt_bigbag_withdraw_detail;
import com.cgc.bean.DataBean_D_rawmatt_receive;
import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import java.sql.ResultSet;
import java.sql.SQLException;

public class D_rawmatt_bigbag_withdraw_detailDAO {

    private int Returnvalue;
    UtiDatabase uti = new UtiDatabase();

    public int insert(DataBeanD_rawmatt_bigbag_withdraw_detail dataBean) throws Exception {
        //Chk_T_warehouse_item objck = new Chk_T_warehouse_item();
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_rawmatt_bigbag_withdraw_detail "
                + "(doc_id,line_no,product_id,quantity,weight,cust_id,location_id,create_date,create_by,supplier_id,wh_out,wh_in,location_id2) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p;
        try {
            /*if (objck.chk_rawmat_item(dataBean.getLocation_id(), dataBean.getProduct_id(), dataBean.getWh_in(), dataBean.getWeight())) {
             Returnvalue = -1;
             } else {*/
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getProduct_id());
            p.setString(4, dataBean.getQuantity());
            p.setString(5, dataBean.getWeight());
            p.setString(6, dataBean.getCust_id());
            p.setString(7, dataBean.getLocation_id());
            p.setTimestamp(8, dataBean.getDate());
            p.setString(9, dataBean.getBy());
            p.setString(10, dataBean.getSupplier_id());
            p.setString(11, dataBean.getWh_out());
            p.setString(12, dataBean.getWh_in());
            p.setString(13, dataBean.getLocation_id_ref());

            String SqlCount = "Select Count(doc_id) As num from  d_rawmatt_bigbag_withdraw_detail where doc_id = '" + dataBean.getDoc_id() + "' and delete_flag = 'N' and line_no = '" + dataBean.getLine_no() + "' ;";
            System.out.println("SqlCount = " + SqlCount);
            if (uti.numRowdatabase(SqlCount) == 0) {
                Returnvalue = p.executeUpdate();
                System.out.println("Returnvalue = " + Returnvalue);
            }

            //}
        } finally {
            //JOptionPane.showConfirmDialog(null, "test");
            try {
                //if (!objck.chk_rawmat_item(dataBean.getLocation_id(), dataBean.getProduct_id(), dataBean.getWh_in(), dataBean.getWeight())) {
                //p.close();
                con.close();
                // }
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_rawmatt_bigbag_withdraw_detail dataBean) throws Exception {
        Returnvalue = 0;
        //Chk_T_warehouse_item objck = new Chk_T_warehouse_item();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql
                = "update d_rawmatt_bigbag_withdraw_detail set  "
                + "product_id=?,quantity=?,weight=?,cust_id=?,location_id=?,update_date=?,update_by=?,supplier_id=?,wh_out=?,wh_in=?,location_id2=? "
                + "where doc_id=? and line_no=? and runno =? and complete_flag = 'N' and delete_flag = 'N'";
        PreparedStatement p;
        try {
            /*if (objck.chk_rawmat_item(dataBean.getLocation_id(), dataBean.getProduct_id(), dataBean.getWh_in(), dataBean.getWeight())) {
             Returnvalue = -1;
             } else {*/
            p = con.prepareStatement(sql);
            //JOptionPane.showConfirmDialog(null,dataBean.getRunno());
            p.setString(1, dataBean.getProduct_id());
            p.setString(2, dataBean.getQuantity());
            p.setString(3, dataBean.getWeight());
            p.setString(4, dataBean.getCust_id());
            p.setString(5, dataBean.getLocation_id());
            p.setTimestamp(6, dataBean.getDate());
            p.setString(7, dataBean.getBy());
            p.setString(8, dataBean.getSupplier_id());
            p.setString(9, dataBean.getWh_out());
            p.setString(10, dataBean.getWh_in());
            p.setString(11, dataBean.getLocation_id_ref());
            p.setString(12, dataBean.getDoc_id());
            p.setString(13, dataBean.getLine_no());
            p.setInt(14, Integer.parseInt(dataBean.getRunno()));
            Returnvalue = p.executeUpdate();
            // }

        } finally {
            try {
                // if (!objck.chk_rawmat_item(dataBean.getLocation_id(), dataBean.getProduct_id(), dataBean.getWh_in(), dataBean.getWeight())) {
                //p.close();
                con.close();
                // }
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public int UpDel_Mark(DataBean_D_rawmatt_receive dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_rawmatt_receive set "
                + "delete_flag = ?,delete_date=?,delete_by=? "
                + "where doc_id=?  and complete_flag = 'N' and delete_flag = 'N'";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
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

    public DataBeanD_rawmatt_bigbag_withdraw_detail ReturnEdit(String runno, DataBeanD_rawmatt_bigbag_withdraw_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        //String SQL = "Select wh_in,wh_in_desc,location_id,quantity,weight,cust_id,cust_name,product_id,location_id,supplier_id,supplier_name,wh_out,wh_out_desc,prod_name from vd_rawmatt_bigbag_withdraw_detail where runno = " + Integer.parseInt(runno) + " and complete_flag = 'N' and delete_flag = 'N'";
        String SQL = "Select wh_in,wh_in_desc,location_id,quantity,weight,cust_id,cust_name,product_id,location_id,supplier_id,supplier_name,wh_out,wh_out_desc,prod_name from vd_rawmatt_bigbag_withdraw_detail where runno = " + Integer.parseInt(runno) + " and delete_flag = 'N'";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setLocation_id(rs.getString("location_id"));
                bean.setQuatity(rs.getString("quantity"));
                bean.setWeight(rs.getString("weight"));
                bean.setCust_id(rs.getString("cust_id"));
                bean.setCust_name(rs.getString("cust_name"));
                bean.setProduct_id(rs.getString("product_id"));
                bean.setProduct_name(rs.getString("prod_name"));
                bean.setLocation_id(rs.getString("location_id"));
                bean.setWh_out(rs.getString("wh_out"));
                bean.setWh_out_desc(rs.getString("wh_out_desc"));
                bean.setWh_in(rs.getString("wh_in"));
                bean.setWh_in_desc(rs.getString("wh_in_desc"));
                bean.setSupplier_id(rs.getString("supplier_id"));
                bean.setSupplier_name(rs.getString("supplier_name"));
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

    public void DeleteLine_no(String inputarry, DataBeanD_rawmatt_bigbag_withdraw_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        int count = 1;
        ResultSet rs;
        PreparedStatement p;
        String sql, sql2;
        try {
            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (String strarry1 : strarry) {
                    //JOptionPane.showConfirmDialog(null,strarry[i]);
                    sql = "update d_rawmatt_bigbag_withdraw_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and complete_flag = 'N' and delete_flag = 'N'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry1);
                    p.executeUpdate();
                }
                if (strarry.length != -1) {
                    ///strarryMem_line_no.clear();                    
                    sql2 = "Select line_no from  d_rawmatt_bigbag_withdraw_detail where doc_id ='" + bean.getDoc_id() + "' and complete_flag = 'N' and delete_flag = 'N' order by runno ";
                    rs = con.createStatement().executeQuery(sql2);
                    while (rs.next()) {
                        sql = "update d_rawmatt_bigbag_withdraw_detail set line_no=? where doc_id=? and line_no=?";
                        p = con.prepareStatement(sql);
                        p.setString(1, Integer.toString(count));
                        p.setString(2, bean.getDoc_id());
                        p.setString(3, rs.getString("line_no"));
                        p.executeUpdate();
                        count = count + 1;
                    }
                }
            }
        } finally {
            try {
                if (inputarry.length() != 0) {
                    //rs.close();
                    //p.close();
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }

    }

    public void Delete_line_no_All(DataBeanD_rawmatt_bigbag_withdraw_detail dataBean) throws Exception {

        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_rawmatt_bigbag_withdraw_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and complete_flag = 'N' and delete_flag = 'N'";
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
        strOutput += "<td class=\"row3\" width=\"3px\"><input type=\"checkbox\" id=\"chk_all\" name=\"chk_all\" value=\"chk_all\" onClick=\"javascript:ckall(this.checked);\"/></td>";
        strOutput += "<td class=\"row3\" width=\"7%\">ลำดับที่</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">ถ่าน</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">จ่ายจาก โกดัง/คลัง</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">รับเข้า โกดัง/คลัง</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">เลขกอง</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">เลขที่กระสอบ/ถุง&nbsp;</td>";
        strOutput += "<td class=\"row3\" width=\"15%\">น้ำหนัก(Kg)</td>";
        strOutput += "</tr>";

        SQL1 = "Select Count(doc_id) As num from  d_rawmatt_bigbag_withdraw_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' ";
        int a = uti.numRowdatabase(SQL1);
        //SQL = "Select runno,product_id,location_id,cust_name,quantity,weight,line_no,doc_id,wh_out,wh_out_desc,wh_in,wh_in_desc,prod_name from vd_rawmatt_bigbag_withdraw_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "'and delete_flag <> 'Y' and complete_flag <> 'Y'  order by runno";        
        SQL = "Select runno,product_id,location_id,cust_name,quantity,weight,line_no,doc_id,wh_out,wh_out_desc,wh_in,wh_in_desc,prod_name from vd_rawmatt_bigbag_withdraw_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "'and delete_flag <> 'Y'  order by runno";
        DBConnect objcon = new DBConnect();
        try (Connection con = objcon.openNewConnection()) {
            ResultSet rs;
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                strOutput += "<tr>";
                strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
                strOutput += "<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,username,runno_" + rs.getString("runno") + "','../SCREEN/CS_058.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</a></td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("product_id") + "</td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("wh_in") + "</td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("wh_out") + "</td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("location_id") + "</td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("quantity") + "</td>";
                strOutput += "<td class='forborder' width='15%'>" + rs.getString("weight") + "</td>";
                strOutput += "</tr>";
            }
            rs.close();
        }
        strOutput += "</table>";
        strOutput += "</body>";
        return strOutput;
    }

    //Under Construction 30-01-2559
    public void Update_line_no(DataBeanD_rawmatt_bigbag_withdraw_detail dataBean) throws Exception {

        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sqldetail = "update d_rawmatt_bigbag_withdraw_detail set line_no = ? where doc_id=? and complete_flag = 'N' and delete_flag = 'N'";
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
