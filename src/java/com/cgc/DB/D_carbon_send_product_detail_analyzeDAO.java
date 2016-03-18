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

/**
 *
 * @author Pongsak
 */
public class D_carbon_send_product_detail_analyzeDAO {

    private UtiDatabase objuti = new UtiDatabase();

    public void insert(DataBeand_carbon_send_product_detail DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        try {
            p = con.prepareStatement("insert into d_carbon_send_product_detail(doc_id,doc_date,line_no,job_id,product_id,"
                    + "size_name,iodine,machine_id,pallet,product_no,bag_quatity,"
                    //+ "bag_weight,"
                    + "weight,create_by,create_date,"
                    + "update_date,fraction,job_type,doc_type) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
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
            p.executeUpdate();
        } catch (Exception e) {
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
        String SQL, lab_emp_name = "";
        ResultSet rs = null;
        int i = 1;
        try {
            SQL = "update d_carbon_send_product_detail "
                    + "set "
                    + "update_by=?,update_date=?,"
                    + "h2o=?,butane=?,iod=?,"
                    + "psd_1=?,psd_2=?,psd_3=?,psd_4=?,psd_5=?,"
                    + "psd_6=?,psd_7=?,psd_8=?,psd_9=?,psd_10=?,"
                    + "psd_11=?,psd_12=?,psd_13=?,psd_14=?,psd_15=?,"
                    + "pass=?,grade=?,remark=?,lab_analyze_flag=?,param_header_id=?,wh_iodine=?,lab_emp_id=? "
                    + "where doc_id = ? and line_no = ? and delete_flag = 'N' and complete_flag ='N' ";
            System.out.println("Update : " + SQL);
            p = con.prepareStatement(SQL);
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getH2o());
            i += 1;
            p.setString(i, DataBean.getButane());
            i += 1;
            p.setString(i, DataBean.getIod());
            i += 1;
            p.setString(i, DataBean.getPsd_1());
            i += 1;
            p.setString(i, DataBean.getPsd_2());
            i += 1;
            p.setString(i, DataBean.getPsd_3());
            i += 1;
            p.setString(i, DataBean.getPsd_4());
            i += 1;
            p.setString(i, DataBean.getPsd_5());
            i += 1;
            p.setString(i, DataBean.getPsd_6());
            i += 1;
            p.setString(i, DataBean.getPsd_7());
            i += 1;
            p.setString(i, DataBean.getPsd_8());
            i += 1;
            p.setString(i, DataBean.getPsd_9());
            i += 1;
            p.setString(i, DataBean.getPsd_10());
            i += 1;
            p.setString(i, DataBean.getPsd_11());
            i += 1;
            p.setString(i, DataBean.getPsd_12());
            i += 1;
            p.setString(i, DataBean.getPsd_13());
            i += 1;
            p.setString(i, DataBean.getPsd_14());
            i += 1;
            p.setString(i, DataBean.getPsd_15());
            i += 1;
            p.setString(i, DataBean.getPass());
            i += 1;
            p.setString(i, DataBean.getGrade());
            i += 1;
            p.setString(i, objuti.EncodeNewLine(DataBean.getRemark()));
            i += 1;
            p.setString(i, DataBean.getLab_analyze_flag());
            i += 1;
            p.setString(i, DataBean.getParam_header_id());
            i += 1;
            p.setString(i, DataBean.getWh_iodine());
            i += 1;
            p.setString(i, DataBean.getLab_emp_id());
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

            
            // หาชื่อผู้รายงานผลการวิเคราะห์ (LAB)           
            String SQL2 = "SELECT distinct(lab_emp_name) from vd_carbon_send_product_detail where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and lab_emp_name is not null"; 
            
            System.out.println("SQL2 = " + SQL2);
            rs = con.createStatement().executeQuery(SQL2);
            while (rs.next()) {
                lab_emp_name += rs.getString("lab_emp_name") + ",";
            }

            System.out.println("lab_emp_name = " + lab_emp_name);

            // Update d_carbon_send_product_header สำหรับชื่อผู้รายงานผลการวิเคราะห์ (LAB)
            p=null;
            p = con.prepareStatement("update d_carbon_send_product_header set lab_emp_name=? where doc_id =? and delete_flag = 'N'");
            p.setString(1, lab_emp_name);
            p.setString(2, DataBean.getDoc_id());            
            p.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
    }

    public void Delete_line_no(String Select_line_no, DataBeand_carbon_send_product_detail DataBean, String Table_Detail) throws Exception {
        StringBuffer old_line_no = new StringBuffer();
        String Str_old_line_no = "";
        String SQL = "";
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        PreparedStatement p = null;
        UtiDatabase objuti = new UtiDatabase();
        int numrow = 0;
        System.out.println("Delete Lineno DB");
        try {
            if (Select_line_no.length() != 0) {
                String[] Number_Line_no = Select_line_no.split(",");
                System.out.println("Delete Line No : " + Number_Line_no);
                SQL = "update " + Table_Detail + " set delete_flag='Y',delete_by=?,delete_date=? where doc_id =? and line_no = ? and complete_flag = 'N' and delete_flag = 'N'";
                System.out.println(SQL);
                p = con.prepareStatement(SQL);
                for (int loop = 0; loop < Number_Line_no.length; loop++) {
                    p.setString(1, DataBean.getBy());
                    p.setTimestamp(2, DataBean.getDate());
                    p.setString(3, DataBean.getDoc_id());
                    p.setString(4, Number_Line_no[loop]);
                    System.out.println("Doc ID : " + DataBean.getDoc_id());
                    System.out.println("Line No : " + Number_Line_no[loop]);
                    p.addBatch();
                }
                p.executeBatch();
                numrow = objuti.numRowdatabase("Select count(doc_id) as num from " + Table_Detail + " where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'");
                if (numrow != 0) {
                    rs = con.createStatement().executeQuery("SELECT line_no from " + Table_Detail + " where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N' order by runno");
                    while (rs.next()) {
                        old_line_no.append(rs.getString("line_no"));
                        old_line_no.append(",");
                    }
                    Str_old_line_no = old_line_no.toString().substring(0, old_line_no.toString().length() - 1);
                    Number_Line_no = null;
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
        } catch (Exception e) {
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
        UtiDatabase objuti = new UtiDatabase();
        try {
            String SQL = "select * From VD_carbon_send_product_detail where doc_id = '" + doc_id + "' and line_no = '" + line_no + "' and delete_flag = 'N' ";
            System.out.println(SQL);
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                DataBean.setDoc_id(objuti.NotNull(rs.getString("doc_id")));
                DataBean.setDoc_date(objuti.NotNull(rs.getString("doc_date")));
                DataBean.setLine_no(objuti.NotNull(rs.getString("line_no")));
                DataBean.setJob_id(objuti.NotNull(rs.getString("job_id")));
                DataBean.setProduct_id(objuti.NotNull(rs.getString("product_id")));
                DataBean.setSize_name(objuti.NotNull(rs.getString("size_name")));
                DataBean.setIodine(objuti.NotNull(rs.getString("iodine")));
                DataBean.setMachine_id(objuti.NotNull(rs.getString("machine_id")));
                DataBean.setPallet(objuti.NotNull(rs.getString("pallet")));
                DataBean.setProduct_no(objuti.NotNull(rs.getString("product_no")));
                DataBean.setBag_quatity(objuti.NotNull(rs.getString("bag_quatity")));
                DataBean.setBag_weight(objuti.NotNull(rs.getString("bag_weight")));
                DataBean.setWeight(objuti.NotNull(rs.getString("weight")));
                DataBean.setWh_id(objuti.NotNull(rs.getString("wh_id")));
                DataBean.setLocation_id(objuti.NotNull(rs.getString("location_id")));
                DataBean.setWh_product_id(objuti.NotNull(rs.getString("wh_product_id")));
                DataBean.setRemark(objuti.NotNull(rs.getString("remark")));
                DataBean.setLab_analyze_flag(objuti.NotNull(rs.getString("lab_analyze_flag")));
                DataBean.setFraction(objuti.NotNull(rs.getString("fraction")));
                DataBean.setJob_type(objuti.NotNull(rs.getString("job_type")));
                DataBean.setComplete_flag(objuti.NotNull(rs.getString("complete_flag")));
                DataBean.setDoc_type(objuti.NotNull(rs.getString("doc_type")));
                DataBean.setH2o(objuti.NotNull(rs.getString("h2o")));
                DataBean.setH2o_header(objuti.NotNull(rs.getString("h2o_header")));
                DataBean.setIod(objuti.NotNull(rs.getString("iod")));
                DataBean.setIod_header(objuti.NotNull(rs.getString("iod_header")));
                DataBean.setButane(objuti.NotNull(rs.getString("butane")));
                DataBean.setButane_header(objuti.NotNull(rs.getString("butane_header")));
                DataBean.setPsd_1(objuti.NotNull(rs.getString("psd_1")));
                DataBean.setPsd_2(objuti.NotNull(rs.getString("psd_2")));
                DataBean.setPsd_3(objuti.NotNull(rs.getString("psd_3")));
                DataBean.setPsd_4(objuti.NotNull(rs.getString("psd_4")));
                DataBean.setPsd_5(objuti.NotNull(rs.getString("psd_5")));
                DataBean.setPsd_6(objuti.NotNull(rs.getString("psd_6")));
                DataBean.setPsd_7(objuti.NotNull(rs.getString("psd_7")));
                DataBean.setPsd_8(objuti.NotNull(rs.getString("psd_8")));
                DataBean.setPsd_9(objuti.NotNull(rs.getString("psd_9")));
                DataBean.setPsd_10(objuti.NotNull(rs.getString("psd_10")));
                DataBean.setPsd_11(objuti.NotNull(rs.getString("psd_11")));
                DataBean.setPsd_12(objuti.NotNull(rs.getString("psd_12")));
                DataBean.setPsd_13(objuti.NotNull(rs.getString("psd_13")));
                DataBean.setPsd_14(objuti.NotNull(rs.getString("psd_14")));
                DataBean.setPsd_15(objuti.NotNull(rs.getString("psd_15")));
                DataBean.setPsd_1_header(objuti.NotNull(rs.getString("psd_1_header")));
                DataBean.setPsd_2_header(objuti.NotNull(rs.getString("psd_2_header")));
                DataBean.setPsd_3_header(objuti.NotNull(rs.getString("psd_3_header")));
                DataBean.setPsd_4_header(objuti.NotNull(rs.getString("psd_4_header")));
                DataBean.setPsd_5_header(objuti.NotNull(rs.getString("psd_5_header")));
                DataBean.setPsd_6_header(objuti.NotNull(rs.getString("psd_6_header")));
                DataBean.setPsd_7_header(objuti.NotNull(rs.getString("psd_7_header")));
                DataBean.setPsd_8_header(objuti.NotNull(rs.getString("psd_8_header")));
                DataBean.setPsd_9_header(objuti.NotNull(rs.getString("psd_9_header")));
                DataBean.setPsd_10_header(objuti.NotNull(rs.getString("psd_10_header")));
                DataBean.setPsd_11_header(objuti.NotNull(rs.getString("psd_11_header")));
                DataBean.setPsd_12_header(objuti.NotNull(rs.getString("psd_12_header")));
                DataBean.setPsd_13_header(objuti.NotNull(rs.getString("psd_13_header")));
                DataBean.setPsd_14_header(objuti.NotNull(rs.getString("psd_14_header")));
                DataBean.setPsd_15_header(objuti.NotNull(rs.getString("psd_15_header")));
                DataBean.setPass(objuti.NotNull(rs.getString("pass")));
                DataBean.setPass_header(objuti.NotNull(rs.getString("pass_header")));
                DataBean.setN_pass(objuti.NotNull(rs.getString("n_pass")));
                DataBean.setN_pass_header(objuti.NotNull(rs.getString("n_pass_header")));
                DataBean.setGrade(objuti.NotNull(rs.getString("grade")));
                DataBean.setGrade_header(objuti.NotNull(rs.getString("grade_header")));
                DataBean.setParam_header_id(objuti.NotNull(rs.getString("param_header_id")));
                DataBean.setProd_name(objuti.NotNull(rs.getString("prod_name")));
                DataBean.setWh_iodine(objuti.NotNull(rs.getString("wh_iodine")));
                DataBean.setLab_emp_id(objuti.NotNull(rs.getString("lab_emp_id")));
                DataBean.setLab_emp_name(objuti.NotNull(rs.getString("lab_emp_name")));
                System.out.println(rs.getString("lab_emp_name"));

            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            con.close();
            return DataBean;
        }
    }

    public String ShowDetail(String doc_id) throws Exception {
        StringBuffer str_return = new StringBuffer();
        UtiDatabase objuti = new UtiDatabase();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        String SQL = "select count(doc_id) as num from d_carbon_send_product_detail where doc_id = '" + doc_id + "' and delete_flag = 'N' ";
        try {
            str_return.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>");
            if (objuti.numRowdatabase(SQL) == 0) {
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
                //str_return.append("<tr ><td align='center'>ไม่พบข้อมูลที่ต้องการ</td></tr>");
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
                        + "<td class='row3''>H2O</td>\n"
                        + "<td class='row3''>Butane</td>\n"
                        + "<td class='row3''>Iodine</td>\n"
                        + "<td class='row3''>Psd1</td>\n"
                        + "</tr> ");
                //SQL = "select runno,doc_id,doc_date,line_no,job_id,product_id,size_name,iodine,machine_id,pallet,product_no,bag_quatity,bag_weight,weight from d_carbon_send_product_detail where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'N' order by to_number(line_no,'990')";
                SQL = "select * from d_carbon_send_product_detail where doc_id = '" + doc_id + "' and delete_flag = 'N' order by to_number(line_no,'990')";
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    str_return.append("<tr>");
                    str_return.append("<td class='forborder' width='2%'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>");
                    //str_return.append("<td class='forborder' width='11%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,doc_date,job_id,product_id,machine_id,iodine,size_name,pallet,product_no,bag_quatity,bag_weight,weight','../SCREEN/CS_Detail_D_carbon_send_product.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</a></td>");
                    str_return.append("<td class='forborder' width='3%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,dept_id,A_username,emp_id,emp_fullname','../SCREEN/CS_Detail_D_carbon_send_product_analyze.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</a></td>");
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
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("h2o") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("butane") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("iod") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("psd_1") + "</td>");
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
            return str_return.toString();
        }
    }
}
