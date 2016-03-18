/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeand_carbon_send_product_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Pongsak
 */
public class D_carbon_send_product_detailDAO {

    UtiDatabase uti = new UtiDatabase();

    public void insert(DataBeand_carbon_send_product_detail DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        try {
            p = con.prepareStatement("insert into d_carbon_send_product_detail(doc_id,doc_date,line_no,job_id,product_id,"
                    + "size_name,iodine,machine_id,pallet,product_no,bag_quatity,"
                    //+ "bag_weight,"
                    + "weight,create_by,create_date,"
                    + "update_date,fraction,job_type,doc_type,param_header_id) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            p.setString(i, DataBean.getDoc_id());
            i += 1;
            p.setString(i, DataBean.getDoc_date());
            i += 1;
            p.setString(i, DataBean.getLine_no());
            i += 1;
            p.setString(i, DataBean.getJob_id());
            i += 1;
            p.setString(i, DataBean.getProduct_id());
            i += 1;
            p.setString(i, DataBean.getSize_name());
            i += 1;
            p.setString(i, DataBean.getIodine());
            i += 1;
            p.setString(i, DataBean.getMachine_id());
            i += 1;
            p.setString(i, DataBean.getPallet());
            i += 1;
            p.setString(i, DataBean.getProduct_no());
            i += 1;
            p.setString(i, DataBean.getBag_quatity());
            i += 1;
            //p.setString(i, DataBean.getBag_weight());i += 1;            
            p.setString(i, DataBean.getWeight());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getFraction());
            i += 1;
            p.setString(i, DataBean.getJob_type());
            i += 1;
            p.setString(i, DataBean.getDoc_type());
            i += 1;
            p.setString(i, DataBean.getParam_header_id());
            i += 1;
            String SqlCount = "Select Count(doc_id) As num from  d_carbon_send_product_detail where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and line_no = '" + DataBean.getLine_no() + "' ;";
            System.out.println("SqlCount = " + SqlCount);
            if (uti.numRowdatabase(SqlCount) == 0) {
                p.executeUpdate();
                System.out.println("Returnvalue = " + true);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
    }

    public void update(DataBeand_carbon_send_product_detail DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        String SQL;
        int i = 1;
        try {
            SQL = "update d_carbon_send_product_detail "
                    + "set line_no=?,job_id=?,product_id=?,size_name=?,iodine=?,machine_id=?,pallet=?,"
                    + "product_no=?,bag_quatity=?,"
                    //+ "bag_weight=?"
                    + "weight=?,"
                    + "update_by=?,update_date=?,"
                    + "wh_id=?,location_id=?,wh_product_id=?,"
                    //+ "fraction=?,job_type=?,doc_type=?,param_header_id=?,"
                    + "fraction=?,job_type=?,param_header_id=?,"
                    + "wh_warehouse_id=?,wh_location_id=?,wh_weight_final=?,wh_iodine=?,wh_iodine_real=? "
                    + "where doc_id = ? and line_no = ? and delete_flag = 'N' and complete_flag ='N' ";
            System.out.println("Update : " + SQL);
            p = con.prepareStatement(SQL);
            p.setString(i, DataBean.getLine_no());
            i += 1;
            p.setString(i, DataBean.getJob_id());
            i += 1;
            p.setString(i, DataBean.getProduct_id());
            i += 1;
            p.setString(i, DataBean.getSize_name());
            i += 1;
            p.setString(i, DataBean.getIodine());
            i += 1;
            p.setString(i, DataBean.getMachine_id());
            i += 1;
            p.setString(i, DataBean.getPallet());
            i += 1;
            p.setString(i, DataBean.getProduct_no());
            i += 1;
            p.setString(i, DataBean.getBag_quatity());
            i += 1;
            //p.setString(i, DataBean.getBag_weight());i += 1;
            p.setString(i, DataBean.getWeight());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getWh_id());
            i += 1;
            p.setString(i, DataBean.getLocation_id());
            i += 1;
            p.setString(i, DataBean.getWh_product_id());
            i += 1;
            p.setString(i, DataBean.getFraction());
            i += 1;
            p.setString(i, DataBean.getJob_type());
            i += 1;
            //p.setString(i, DataBean.getDoc_type());
            //i += 1;
            p.setString(i, DataBean.getParam_header_id());
            i += 1;
            p.setString(i, DataBean.getWh_id());
            i += 1;
            p.setString(i, DataBean.getLocation_id());
            i += 1;
            p.setString(i, DataBean.getWeight());
            i += 1;
            p.setString(i, DataBean.getWh_iodine());
            i += 1;
            p.setString(i, DataBean.getWh_iodine_real());
            i += 1;
            p.setString(i, DataBean.getDoc_id());
            i += 1;
            p.setString(i, DataBean.getLine_no());
            i += 1;
            System.out.println("Doc ID = " + DataBean.getDoc_id());
            System.out.println("Line No :  " + DataBean.getLine_no());
            System.out.println(DataBean.getJob_id());
            System.out.println(DataBean.getProduct_id());
            System.out.println(DataBean.getSize_name());
            System.out.println("getProduct_no = " + DataBean.getProduct_no());
            System.out.println("getFraction = " + DataBean.getFraction());
            System.out.println("getJob_type = " + DataBean.getJob_type());
            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
    }

    public void Delete_line_no(String Select_line_no, DataBeand_carbon_send_product_detail DataBean, String Table_Detail) throws Exception {
        StringBuilder old_line_no = new StringBuilder();
        String Str_old_line_no;
        String SQL;
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        PreparedStatement p = null;
        int numrow;
        System.out.println("Delete Lineno DB");
        try {
            if (Select_line_no.length() != 0) {
                String[] Number_Line_no = Select_line_no.split(",");
                System.out.println("Delete Line No : " + Number_Line_no);
                SQL = "update " + Table_Detail + " set delete_flag='Y',delete_by=?,delete_date=? where doc_id =? and line_no = ? and complete_flag = 'N' and delete_flag = 'N'";
                System.out.println(SQL);
                p = con.prepareStatement(SQL);
                for (String Number_Line_no1 : Number_Line_no) {
                    p.setString(1, DataBean.getBy());
                    p.setTimestamp(2, DataBean.getDate());
                    p.setString(3, DataBean.getDoc_id());
                    p.setString(4, Number_Line_no1);
                    System.out.println("Doc ID : " + DataBean.getDoc_id());
                    System.out.println("Line No : " + Number_Line_no1);
                    p.addBatch();
                }
                p.executeBatch();
                numrow = uti.numRowdatabase("Select count(doc_id) as num from " + Table_Detail + " where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'");
                if (numrow != 0) {
                    rs = con.createStatement().executeQuery("SELECT line_no from " + Table_Detail + " where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N' order by runno");
                    while (rs.next()) {
                        old_line_no.append(rs.getString("line_no"));
                        old_line_no.append(",");
                    }
                    Str_old_line_no = old_line_no.toString().substring(0, old_line_no.toString().length() - 1);
                    //Number_Line_no = null;
                    p = null;
                    Number_Line_no = Str_old_line_no.split(",");
                    p = con.prepareStatement("update " + Table_Detail + " set line_no=? where doc_id =? and line_no = ? and complete_flag = 'N' and delete_flag = 'N'");
                    for (int loop = 0; loop < Number_Line_no.length; loop++) {
                        p.setString(1, Integer.toString(loop + 1));
                        p.setString(2, DataBean.getDoc_id());
                        p.setString(3, Number_Line_no[loop]);
                        p.addBatch();
                    }
                    p.executeBatch();
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
            con.close();
        }
    }

    public void Delete_all_line_no(DataBeand_carbon_send_product_detail DataBean, String Table_Detail) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        System.out.println("Delete All Lineno DB");
        try {
            String SQL = "update " + Table_Detail + " set delete_flag='Y',delete_by=?,delete_date=? Where doc_id = ?  and delete_flag = 'N' and  complete_flag = 'N'";
            System.out.println(SQL);
            p = con.prepareStatement(SQL);
            p.setString(1, DataBean.getBy());
            p.setTimestamp(2, DataBean.getDate());
            p.setString(3, DataBean.getDoc_id());
            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
    }

    public DataBeand_carbon_send_product_detail Return_Edit(String doc_id, String line_no) throws Exception {
        DataBeand_carbon_send_product_detail DataBean = new DataBeand_carbon_send_product_detail();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        //UtiDatabase uti = new UtiDatabase();
        try {
            String SQL = "select * From VD_carbon_send_product_detail where doc_id = '" + doc_id + "' and line_no = '" + line_no + "' and delete_flag = 'N' ";
            System.out.println(SQL);
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                DataBean.setDoc_id(uti.NotNull(rs.getString("doc_id")));
                DataBean.setDoc_date(uti.NotNull(rs.getString("doc_date")));
                DataBean.setLine_no(uti.NotNull(rs.getString("line_no")));
                DataBean.setJob_id(uti.NotNull(rs.getString("job_id")));
                DataBean.setProduct_id(uti.NotNull(rs.getString("product_id")));
                DataBean.setSize_name(uti.NotNull(rs.getString("size_name")));
                DataBean.setIodine(uti.NotNull(rs.getString("iodine")));
                DataBean.setMachine_id(uti.NotNull(rs.getString("machine_id")));
                DataBean.setPallet(uti.NotNull(rs.getString("pallet")));
                DataBean.setProduct_no(uti.NotNull(rs.getString("product_no")));
                DataBean.setBag_quatity(uti.NotNull(rs.getString("bag_quatity")));
                DataBean.setBag_weight(uti.NotNull(rs.getString("bag_weight")));
                DataBean.setWeight(uti.NotNull(rs.getString("weight")));
                DataBean.setWh_id(uti.NotNull(rs.getString("wh_id")));
                DataBean.setLocation_id(uti.NotNull(rs.getString("location_id")));
                DataBean.setWh_product_id(uti.NotNull(rs.getString("wh_product_id")));
                DataBean.setRemark(uti.NotNull(rs.getString("remark")));
                DataBean.setLab_analyze_flag(uti.NotNull(rs.getString("lab_analyze_flag")));
                DataBean.setFraction(uti.NotNull(rs.getString("fraction")));
                DataBean.setJob_type(uti.NotNull(rs.getString("job_type")));
                DataBean.setComplete_flag(uti.NotNull(rs.getString("complete_flag")));
                DataBean.setDoc_type(uti.NotNull(rs.getString("doc_type")));
                DataBean.setIod(uti.NotNull(rs.getString("iod")));
                DataBean.setH2o(uti.NotNull(rs.getString("h2o")));
                DataBean.setButane(uti.NotNull(rs.getString("butane")));
                DataBean.setRemark(uti.NotNull(rs.getString("remark")));
                DataBean.setPass(uti.NotNull(rs.getString("pass")));
                DataBean.setN_pass(uti.NotNull(rs.getString("n_pass")));
                DataBean.setProd_name(uti.NotNull(rs.getString("prod_name")));
                DataBean.setGrade(uti.NotNull(rs.getString("grade")));
                DataBean.setWh_iodine(uti.NotNull(rs.getString("wh_iodine")));
                DataBean.setWh_iodine_real(uti.NotNull(rs.getString("wh_iodine_real")));
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            con.close();
        }
        return DataBean;
    }

    public String ShowDetail(String doc_id) throws Exception {
        StringBuilder str_return = new StringBuilder();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        String SQL = "select count(doc_id) as num from d_carbon_send_product_detail where doc_id = '" + doc_id + "' and delete_flag = 'N' ";
        try {
            str_return.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>");
            if (uti.numRowdatabase(SQL) == 0) {
                //str_return.append("<tr ><td align='center'>ไม่พบข้อมูลที่ต้องการ</td></tr>");
                str_return.append("<tr align='center'>\n"
                        + "<td  class='row3' width='10'>\n"
                        + "<input type='checkbox' name='chk_all' id='chk_all' value='chk_all' onClick='javascript:ckall(this.checked);'/></td>\n"
                        + "<td class='row3' >ลำดับ</td>\n"
                        + "<td class='row3' >ใบแจ้งผลิต</td>\n"
                        + "<td class='row3' >ชนิดถ่าน</td>\n"
                        + "<td class='row3' >ประเภท</td>\n"
                        + "<td class='row3' >ขนาด</td>\n"
                        + "<td class='row3' >I2</td>\n"
                        + "<td class='row3'>เครื่องผลิต</td>\n"
                        + "<td class='row3'>พาเลท/ถุง</td>\n"
                        + "<td class='row3'>รหัสผลิต</td>\n"
                        + "<td class='row3'>กระสอบ</td>\n"
                        + "<td class='row3'>เศษ</td>\n"
                        + "<td class='row3''>น้ำหนักรวม</td>\n"
                        + "</tr> ");
            } else {
                // header
                str_return.append("<tr align='center'>\n"
                        + "<td  class='row3' width='10'>\n"
                        + "<input type='checkbox' name='chk_all' id='chk_all' value='chk_all' onClick='javascript:ckall(this.checked);'/></td>\n"
                        + "<td class='row3' >ลำดับ</td>\n"
                        + "<td class='row3' >ใบแจ้งผลิต</td>\n"
                        + "<td class='row3' >ชนิดถ่าน</td>\n"
                        + "<td class='row3' >ประเภท</td>\n"
                        + "<td class='row3' >ขนาด</td>\n"
                        + "<td class='row3' >I2</td>\n"
                        + "<td class='row3'>เครื่องผลิต</td>\n"
                        + "<td class='row3'>พาเลท/ถุง</td>\n"
                        + "<td class='row3'>รหัสผลิต</td>\n"
                        + "<td class='row3'>กระสอบ</td>\n"
                        + "<td class='row3'>เศษ</td>\n"
                        + "<td class='row3''>น้ำหนักรวม</td>\n"
                        + "<td class='row3''>รหัสสินค้า</td>\n"
                        + "</tr> ");
                //SQL = "select runno,doc_id,doc_date,line_no,job_id,product_id,size_name,iodine,machine_id,pallet,product_no,bag_quatity,bag_weight,weight from d_carbon_send_product_detail where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'N' order by to_number(line_no,'990')";
                SQL = "select * from d_carbon_send_product_detail where doc_id = '" + doc_id + "' and delete_flag = 'N' order by to_number(line_no,'990')";
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    str_return.append("<tr>");
                    str_return.append("<td class='forborder' width='2%'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>");
                    //str_return.append("<td class='forborder' width='11%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,doc_date,job_id,product_id,machine_id,iodine,size_name,pallet,product_no,bag_quatity,bag_weight,weight','../SCREEN/CS_Detail_D_carbon_send_product.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</a></td>");
                    str_return.append("<td class='forborder' width='3%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,dept_id','../SCREEN/CS_Detail_D_carbon_send_product.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</a></td>");
                    str_return.append("<td class='forborder' width='100'>" + rs.getString("job_id") + "</td>");
                    str_return.append("<td class='forborder' width='70'>" + rs.getString("product_id") + "</td>");
                    str_return.append("<td class='forborder' width='5%'>" + rs.getString("job_type") + "</td>");
                    str_return.append("<td class='forborder' width='5%'>" + rs.getString("size_name") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("iodine") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("machine_id") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("pallet") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("product_no") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("bag_quatity") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("fraction") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("weight") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("wh_product_id") + "</td>");
                    str_return.append("</tr>");
                }
            }
            str_return.append("</table>");
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            con.close();
        }
        return str_return.toString();
    }
}
